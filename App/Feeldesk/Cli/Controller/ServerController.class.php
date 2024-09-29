<?php
// +----------------------------------------------------------------------
// | FeelDesk-DEV开源工单管理系统
// +----------------------------------------------------------------------
// | 欢迎阅读学习系统程序代码，您的建议反馈是我们前进的动力
// | 开源版本仅供技术交流学习，请务必保留界面版权logo
// | 商业版本务必购买商业授权，以免引起法律纠纷
// | 禁止对系统程序代码以任何目的，任何形式的再发布
// | gitee下载：https://gitee.com/feelecs/feeldesk-os
// | 开源官网：https://www.feeldesk.com.cn
// | 成都菲莱克斯科技有限公司 版权所有 拥有最终解释权
// +----------------------------------------------------------------------
namespace Cli\Controller;

require_once VENDOR_PATH . "WebMsgSender/vendor/autoload.php";

use PHPSocketIO\SocketIO;

use Think\Cache\Driver\Redis;

use Think\Controller;

use Think\Log;

use Workerman\Worker;

use Workerman\MySQL\Connection;

class ServerController extends Controller
{
	// 全局数组保存uid在线数据
	public static $_uidConnectionMap = [];

	public function index()
	{
		global $io;

		if(C('HTTP_PROTOCOL') == 'https')
		{
			$io = new SocketIO(C('SOCKET_PORT'),C('CONTEXT'));
		}
		else
		{
			$io = new SocketIO(C('SOCKET_PORT'));
		}

//		白名单，限制连接域名
		$origins = implode(' ',C('WHITE_LIST'));

		$io->origins($origins);

//		客户端发起连接事件时，设置连接socket的各种事件回调
//		$socket  - 当前连接
//		$socket->id  - 当前连接的sid
//		$io  - 全局
//		$db  - 数据库连接
		$io->on('connection', function($socket)
		{
//			当客户端发来登录事件时触发
			$socket->on('login', function ($data)use($socket)
			{
				global $io,$db;

//				已经登录过了
				if(isset($socket->uid)) return;

//				更新对应sid的在线数据
				if(!isset(self::$_uidConnectionMap[$data['uid']]))
				{
					self::$_uidConnectionMap[$data['uid']] = 0;
				}

//				这个uid有++$uidConnectionMap[$uid]个socket连接
				++self::$_uidConnectionMap[$data['uid']];

//				将这个连接加入到uid分组，方便针对uid推送数据
				$socket->join($data['uid']);

				$socket->uid = $data['uid'];
/*
				试着缓存Socket连接对象，没成功！
				if(!isset($socketIoMap[$socket->uid]))
				{
					$socketIoMap[$socket->uid] = $socket;

					$apcu = apcu_store('SocketIoMap',123,28800);

					var_dump($apcu);//返回了false
				}
*/

//				更新登录数据
				$db->update('feel_member')
					->cols(['login_status','last_login_time','last_active_time'])
					->where("member_id = $socket->uid")
					->bindValues(['login_status'=>1,'last_login_time'=>time(),'last_active_time'=>time()])
					->query();

//				var_dump($db->lastSQL());

//				查询用户数据
				$member = $db->select('company_id,type,group_id')
					->from('feel_member')
					->where('member_id= :member_id')
					->bindValues(['member_id'=>$socket->uid])
					->row();

				if($member['type'] == 1)
				{
					$redis = new Redis();

					$groupIds = explode(',',$member['group_id']);

					foreach($groupIds as $v)
					{
						$key = $member['company_id'].'_'.$v.'_route_offline';

						if($redis->lLen($key) > 0)
						{
							// 将登录的客服从离线队列中删除
							$redis->lRem($key,$socket->uid,0);

				            // 将登录的客服从待分配队列中删除
							$redis->lRem($member['company_id'].'_'.$v.'_route_mail_disposeId',$socket->uid,0);

				            // 将登录的客服重新加入到待分配处理人队列
							$redis->rPush($member['company_id'].'_'.$v.'_route_mail_disposeId',$socket->uid);
						}
					}
				}

				// 返回登录状态
				$socket->emit('connect_status','Login success');

				// App - 返回登录状态
				if(isset($data['isApp']))
				{
					$io->to($data['uid'])->emit('listion_app_login','ok!');
				}
			});

			// 当客户端断开连接时触发（一般是关闭网页或者跳转刷新导致）
			$socket->on('disconnect', function () use($socket)
			{
				if(!isset($socket->uid)) return;

				try
				{
					global $db;

//				    更新用户离线数据
					$member = $db->select('company_id,member_id,type,last_active_time')
						->from('feel_member')
						->where('member_id= :member_id')
						->bindValues(['member_id'=>$socket->uid])
						->row();

					if($member['type'] == 1)
					{
						D('Login')->removeDisposeInRedis($member,'index',false);
					}

					$db->update('feel_member')
						->cols(['login_status','offline_time'])
						->where("member_id = $socket->uid")
						->bindValues(['login_status'=>0,'offline_time'=>time()])
						->query();

					// 将uid的在线socket数减一
					if(--self::$_uidConnectionMap[$socket->uid] <= 0)
					{
						unset(self::$_uidConnectionMap[$socket->uid]);
					}
				}
				catch (\Exception $e)
				{
					$content = "\r\n记录时间：".date('H:i:s')."\r\n错误编号：".$e->getCode()."\r\n错误信息：".M('member')->getDbError();

					$path = LOG_PATH.'Socket/Mysql-'.date('Y-m-d').'.log';

//			        存储日志
					Log::write($content,'Mysql','File',$path);
				}
			});

			// App - 登录成功后，向App获取用户APP端的ClientId
			$socket->on('get_app_client_id',function($data)
			{
				global $io;

				$io->to($data['uid'])->emit('get_app_clientid',$data);
			});

			// App - 接收App返回的clientId,并保存用户APP端的ClientId
			$socket->on('save_app_client',function($data)
			{
				global $io,$db;

				/*$update = ['member_id'=>$data['uid'],'app_client_id'=>$data['clientid']];

				M('member')->save($update);*/

				$db->update('feel_member')
					->cols(['app_client_id'])
					->where("member_id = ".$data['uid'])
					->bindValues(['app_client_id'=>$data['clientid']])
					->query();

				$io->to($data['uid'])->emit('login_complete','ok');
			});

			// App - PC端获取APP指定用户的位置（暂未使用）
			$socket->on('get_app_location',function($data)
			{
				global $io;

				$io->to($data['uid'])->emit('get_location',json_encode($data));
			});

			// App - 返回获取APP指定用户的位置（暂未使用）
			$socket->on('set_location',function($data)
			{
				global $io;

				$io->to($data['mid'])->emit('set_app_location',$data);
			});

			// App - APP客户端退出登录
			$socket->on('app_disconnect',function($data) use($socket)
			{
				global $io;

				$io->to($data['uid'])->emit('app_exit_login','offline');

				$socket->emit('logout_complete','ok');
			});
		});

        // 当$io启动后监听一个http端口，通过这个端口可以给任意uid或者所有uid推送数据
		$io->on('workerStart', function()
		{
			global $db;

			$db = new Connection(C('DB_HOST'),C('DB_PORT'),C('DB_USER'),C('DB_PWD'),C('DB_NAME'));

//			监听一个http端口（服务端通过curl方式访问http端口）
			if(C('HTTP_PROTOCOL') == 'https')
			{
				$worker = new Worker('http://0.0.0.0:'.C('HTTP_PORT'),C('CONTEXT'));

				$worker->transport = 'ssl';
			}
			else
			{
				$worker = new Worker('http://0.0.0.0:'.C('HTTP_PORT'));
			}

//			当http客户端发来数据时触发
			$worker->onMessage = function($connection,$request)
			{
				global $io;

				$data = $request['post'];

				// 推送数据的url格式 type=$data['type']&to=$to&content=$content
				switch(@$data['type'])
				{
//					新消息推送
					case 'systemMsg':

						$to = @$data['to'];

						$content = @$data['content'];

						// 有指定uid则向uid所在socket组发送数据
						if($to)
						{
							$io->to($to)->emit('new_msg',$content);
						}
//						扩展 - 则向所有uid推送数据 $io->emit('new_msg',$content);

						// http接口返回，如果用户离线socket返回fail
						if($to && !isset(self::$_uidConnectionMap[$to]))
						{
							return $connection->send('Offline');
						}
						else
						{
							return $connection->send('Success');
						}
					break;

//					新工单推送 - 仅支持推送处理人
					case 'newTicket':

						$to = $data['to'];

						$content = $this->getTicketHtml($data['param'],'newTicket');

						// 有指定uid则向uid所在socket组发送数据
						if($to)
						{
							$io->to($to)->emit('new_ticket',$content);
						}

						break;

//					新回复推送
					case 'newReply':

						$to = @$data['to'];

						$param = json_decode($data['param'],true);

						$ticket_no = $param['ticket_no'];

//						推送 - 增加待回复数
						$content = json_encode(['ticket_no'=>$ticket_no,'new_reply_num'=>1]);

						$io->to($to)->emit('new_reply',$content);

//						推送 - 待回复工单
						$content = $this->getTicketHtml($data['param'],'new_wait_reply');

						$io->to($to)->emit('new_wait_reply',$content);

						// http接口返回，如果用户离线socket返回fail
						if($to && !isset(self::$_uidConnectionMap[$to]))
						{
							return $connection->send('Offline');
						}
						else
						{
							return $connection->send('Success');
						}

					break;

//                  检查待办事项数量
					case 'scheduleNum':

						$to = @$data['to'];

						$param = json_decode($data['param'],true);

						$action = $param['action'];

						$content = json_encode(['action'=>$action]);

						$io->to($to)->emit('scheduleNum',$content);

						// http接口返回，如果用户离线socket返回fail
						if($to && !isset(self::$_uidConnectionMap[$to]))
						{
							return $connection->send('Offline');
						}
						else
						{
							return $connection->send('Success');
						}

					break;
				}

				return $connection->send('Send Failed');
			};

			// 执行监听
			$worker->listen();
		});

		Worker::runAll();
	}


	public function getTicketHtml($param,$type)
	{
		$param = json_decode($param,true);

		$ticket_id = $param['ticket_id'];

		$company_id = $param['company_id'];

		$field = 'ticket_id,member_id,recipient_id,dispose_id,status_id,type_id,ticket_model_id,title,look,ticket_from,
						priority,create_time,ticket_no,dispose_time,group_id';

		$where = ['company_id'=>$company_id,'ticket_id'=>$ticket_id];

		$ticket = M('ticket')->where($where)->field($field)->find();

		$statusName = D('TicketStatus')->getNameByLang('status_name');

		$ticketStatus = D('TicketStatus')->where(['company_id'=>$company_id])->field("status_id,status_color,{$statusName}")->fetchAll();

//        模板
		$templateName = D('Ticketmodel')->getNameByLang('ticket_model_name');

		$template = D('Ticketmodel')->where(['company_id'=>$company_id])->field("ticket_model_id,{$templateName}")->fetchAll();

//        模板类型
		$templateTypeName = D('TemplateType')->getNameByLang('type_name');

		$templateType = D('TemplateType')->where(['company_id'=>$company_id])->field("type_id,{$templateTypeName}")->fetchAll();

//        完成期限
		$deadlines  = M('ticket_deadlines')->where(['company_id'=>$company_id])->select();

		$deadTimes = [];

		foreach($deadlines as $d)
		{
			$deadTimes[$d['ticket_id']] = $d;
		}

		$priority = D('Ticket')->getPriority($ticket['priority']);

		if($ticket['look'] == 2)
		{
			$ticketReadState = 'ticket-read';
		}
		else
		{
			$ticketReadState = 'ticket-unread';
		}

		$priorityColor = D('Ticket')->getPriorityColor($ticket['priority']);

		$publish = M('member')->where(['member_id'=>$ticket['member_id']])->field('name,face')->find();

		$publishFace = $publish['face'] ? $publish['face'] : '/Attachs/face/default.jpg';

		$ticketView = D('TicketView')->getTicketView($company_id);

//        极简
		$html['minimalist'] = "<div class='ticket-list clearfix' mini='ticket' data-id='".encrypt($ticket['ticket_id'],'TICKET')."' data-value='{$ticket['ticket_no']}'>";

		$html['minimalist'] .= "<span class='ticket-list-right fr'><span title='".L('PUBLISHER')."'><span>{$publish['name']}</span><img src='{$publishFace}' class='face' alt=''></span></span>";

		$html['minimalist'] .= "<input type='checkbox' name='del[]' lay-skin='primary' value='".encrypt($ticket['ticket_id'],'TICKET')."' class='fl' />";

		$html['minimalist'] .= "<i class='iconfont icon-new'></i><span class='ticket-suspend'></span>";

		$html['minimalist'] .= "<div class='status' data-value='status{$ticket['ticket_no']}' style='background-color:{$ticketStatus[$ticket['status_id']]['status_color']};'>{$ticketStatus[$ticket['status_id']]['lang_name']}</div>";

		$html['minimalist'] .= "<a href='javascript:' class='ticket-title' >{$ticket['title']}</a>";

		$html['minimalist'] .= "<label class='ticket-priority {$priorityColor}'>{$priority}</label></div>";

//        列表
		$html['list'] = "<tr data-id='".encrypt($ticket['ticket_id'],'TICKET')."' data-value='{$ticket['ticket_no']}'>";

		$html['list'] .= "<td class='checkbox relative'><i class='iconfont icon-new absolute'></i><input type='checkbox' name='del[]' lay-skin='primary' value=" . encrypt($ticket['ticket_id'], 'TICKET') . "></td>";

		if ($ticketView[1]['is_view'])
		{
			$html['list'] .= "<td class='ellipsis ticket-title' mini='ticket'><span class='ticket-read-state ".$ticketReadState."'></span> <span class='w200'>" . $ticket['title'] . "</span>";
		}

		if ($ticketView[2]['is_view'] > 0)
		{
			$html['list'] .= "<td class='ticket-source' mini='ticket'><span class='iconfont " . D('Ticket')->getTicketFromIcon($ticket['ticket_from']) . "'></span></td>";
		}

		if ($ticketView[3]['is_view'] > 0)
		{
			$number = $type == 'new_wait_reply' ? 1 : 0;

			$html['list'] .= "<td mini='ticket'><span class='unreadreply' id='newReplyNum".$ticket['ticket_no']."'>{$number}</span></td>";
		}

		if ($ticketView[4]['is_view'] > 0)
		{
			$html['list'] .= "<td mini='ticket' id='item-status{$ticket['ticket_no']}'><span class='list-status' data-value='status{$ticket['ticket_no']}' style='background-color:{$ticketStatus[$ticket['status_id']]['status_color']}'>{$ticketStatus[$ticket['status_id']]['lang_name']}</span></td>";
		}


		if($ticketView[5]['is_view'] > 0)
		{
			$html['list'] .= "<td mini='ticket'><span class='ticket-priority {$priorityColor}'>{$priority}</span></td>";
		}

		if($ticketView[6]['is_view'] > 0)
		{
			$html['list'] .= "<td mini='ticket'>{$publish['name']}</td>";
		}

		if($ticketView[7]['is_view'] > 0)
		{
			$recipient = M('member')->where(['member_id'=>$ticket['recipient_id']])->getField('name');

			$recipient = $recipient ? $recipient : "<span class='iconfont icon-nothing gray3'></span>";

			$html['list'] .= "<td mini='ticket'>{$recipient}</td>";
		}

		if($ticketView[8]['is_view'] > 0)
		{
			$dispose = M('member')->where(['member_id'=>$ticket['dispose_id']])->getField('name');

			$dispose = $dispose ? $dispose : "<span class='iconfont icon-nothing gray3'></span>";

			$html['list'] .= "<td mini='ticket'>{$dispose}</td>";
		}

		if($ticketView[15]['is_view'] > 0)
		{
			$html['list'] .= "<td mini='ticket'>{$templateType[$ticket['type_id']]['lang_name']}</td>";
		}

		if($ticketView[16]['is_view'] > 0)
		{
			$html['list'] .= "<td mini='ticket'>{$template[$ticket['ticket_model_id']]['lang_name']}</td>";
		}

		if($ticketView[9]['is_view'] > 0)
		{
			$html['list'] .= "<td mini='ticket'>".getDates($ticket['create_time'])."</td>";
		}

		if($ticketView[10]['is_view'] > 0)
		{
			$html['list'] .= "<td id='time{$ticket['ticket_id']}' class='istime orange4' mini='ticket'>0</td>";
		}

		if($ticketView[11]['is_view'] > 0)
		{
			$html['list'] .= "<td mini='ticket'>{$ticket['ticket_no']}</td>";
		}

		if($ticketView[12]['is_view'] > 0)
		{
			$html['list'] .= "<td mini='ticket'>".checkTicketIsTimeout($deadTimes[$ticket['ticket_id']]['deadtime'],$ticket['end_time'])."</td>";
		}

		if($ticketView[13]['is_view'] > 0)
		{
			$html['list'] .= "<td mini='ticket'>".checkTicketIsTimeout($deadTimes[$ticket['ticket_id']]['deadtime'],$ticket['end_time'],1)."</td>";
		}

		$html['list'] .= "</tr>";

		$html['ticket_no'] = $ticket['ticket_no'];

		return json_encode($html);
	}


	public function test()
	{
		global $io;

		var_dump($io);
	}
}
