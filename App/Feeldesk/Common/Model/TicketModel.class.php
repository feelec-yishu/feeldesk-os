<?php
// +----------------------------------------------------------------------
// | FeelDesk-DEV开源工单管理系统
// +----------------------------------------------------------------------
// | 欢迎阅读学习系统程序代码，您的建议反馈是我们前进的动力
// | 开源版本仅供技术交流学习，请务必保留界面版权logo
// | 商业版本务必购买商业授权，以免引起法律纠纷
// | 禁止对系统程序代码以任何目的，任何形式的再发布
// | gitee下载：https://gitee.com/feelecs/feeldesk-dev-base
// | 开源官网：https://www.feeldesk.com.cn
// | 成都菲莱克斯科技有限公司 版权所有 拥有最终解释权
// +----------------------------------------------------------------------
namespace Common\Model;

use Org\Util\ExcelAssistant;
use PHPExcel_Cell;
use PHPExcel_Exception;
use PHPExcel_IOFactory;
use PHPExcel_Reader_Exception;
use PHPExcel_RichText;
use Think\Cache\Driver\Redis;
use Think\Log;
use Think\Page;
use Think\Upload;


class TicketModel extends BasicModel
{
	protected $_filter = ['ticket_no','title','ticket_model_id','status_id','photo','priority','look','group_id','dispose_time','dispose_id',
		'mobile_discrete','email_discrete','related_id','orderby','create_time'];

	protected $replyFilter = ['ticket_id','reply_content','cc_member_id'];

	protected $pk   = 'ticket_id';

	protected $tableName = 'ticket';

	protected $commentFields = ['ticket_id','reply_id','comment_type','content'];

	protected $visitorTicketFilter = ['ticket_no','title','ticket_model_id','status_id','photo','look','dispose_time','dispose_id','related_id','orderby','create_time'];

	//查询工单数量方法
	protected static $_action = ['allTicket','myTicket','waitReplyTicket','disposeTicket','groupTicket','ccTicket','waitAuditTicket','timeoutTicket'];

	protected static $_company_id = 0;

	protected static $_template = [];

	const YB = 1;
	const JJ = 2;
	const GAO = 3;
	const DI = 4;

	const PC        = 'PC';
	const MAIL      = 'Email';
	const API       = 'API';
	const MOBILE    = 'Mobile';
	const WECHAT    = 'Wechat';
	const VISITOR   = 'Visitor';
	const SERVER    = 'Service';
	const WEBCHAT   = 'WebChat';

	const ONE_DAYS      = 1;
	const THREE_DAYS    = 3;
	const SEVEN_DAYS    = 7;
	const ONE_MONTH     = 30;
	const CUSTOM_TIME   = 'n';


	/*
    * 生成工单编号
    * @param int $company_id 公司ID
    * @return string
    */
	public function getTicketNo($company_id = 0)
	{
		// 生成token
		$ticket_no = $this->createTicketNo($company_id);

		$redis = new Redis();

		$cache_key = 'ticketNo';

		// 防重 - 检测生成的工单编号是否存在于集合中
		if($redis->sIsMember($cache_key,$ticket_no))
		{
			$this->getTicketNo($company_id);
		}
		else
		{
			// 防重 - 将已生成的工单编号存入集合
			$redis->sAdd($cache_key,$ticket_no);

			// 防重 - 若不存在工单编号集合或已过期，设置工单编号集合有效期8小时
			if($redis->ttl($cache_key) < 0)
			{
				$redis->expire($cache_key,3600 * 8);
			}
		}

		return $ticket_no;
	}


	/*
    * 生成工单编号
    * @param int $company_id 公司ID
    * @return string
    */
	private function createTicketNo($company_id = '')
	{
		return "F".date('YmdHi',time()).'-'.strtoupper(substr(md5(microtime(true).$company_id), rand(0,9), 4));
	}


	public function getCreateTicketForm($template = [],$where = [],$company = [],$member_type = 1)
	{
		$ticketForm = M('TicketForm')->where($where)->order('orderby asc')->select();

		foreach($ticketForm as &$v)
		{
			if(in_array($v['ticket_form_type'],['radio','select','checkbox']))
			{
				$v['option'] = explode('|',$v['ticket_form_option']);
			}
		}

		$createTicketFormData['ticketForm'] = $ticketForm;

		if($member_type == 1)
		{
			// 指定处理人 - 未禁用部门
			$createTicketFormData['groups'] = M('group')->where(['company_id'=>$company['company_id'],'closed'=>0,'ticket_auth'=>10])
				->field('group_id,group_name')
				->order('orderby asc')
				->select();

			$groupIds = array_column($createTicketFormData['groups'],'group_id');

//            指定处理人 - 未禁用客服
			$createTicketFormData['members'] = D('Member')
				->where(['company_id'=>$company['company_id'],'closed'=>0,'type'=>1])
				->field('member_id,account,type,name,face,group_id')
				->order('member_id asc')
				->fetchAll();

			foreach($createTicketFormData['members'] as $mk => $mv)
			{
				$group_id = explode(',',$mv['group_id']);

				$result = array_diff($group_id,$groupIds);

//                移除不在权限部门中的用户
				if($result && empty(array_diff($group_id,$result)))
				{
					unset($createTicketFormData['members'][$mk]);
				}
			}

			$createTicketFormData['jsonMembers'] = json_encode($createTicketFormData['members']);

//            抄送人
			$createTicketFormData['jsonCcMembers'] = json_encode(array_values($createTicketFormData['members']));
		}

//        地区组件
		if($template['area_discrete'] == 10)
		{
			$lang_name = $this->getNameByLang('name');

			$createTicketFormData['country'] = M('country')->field("*,".$lang_name)->select();
		}

		return $createTicketFormData;
	}


	/*
    * 发布工单 - 用户
    * @param int    $company_id         公司ID
    * @param int    $member_id          当前登录用户ID
    * @param array  $template           当前工单模板信息
    * @param int    $first_status_id    初始状态ID
    * @param string $ticket_from        工单发布渠道
    * @param string $source             提交来源，page 通过页面表单提交，import 通过导入提交
	* @param array  $importData         导入的工单数据，仅用于导入提交的工单
    * @return array
    */
	public function CreateTicketByUser($company_id = 0,$member_id = 0,$template = [],$first_status_id = 0,$ticket_from = '',$source = 'page',$importData = [])
	{
		if($ticket_from == 'WebChat')
		{
			if(!session('?webchat_customer') || !session('?webchat_seller') || !session('?webchat_logid'))
			{
				return ['status'=>0,'msg'=>'缺少参数'];
			}
		}

		$data = $this->checkCreateTicket($company_id,$member_id,'user',$template,$source,$importData);

		if(isset($data['status']) && $data['status'] == 0) return $data;

		$data['ticket']['status_id'] = $first_status_id;//初始状态

		$data['ticket']['type_id'] = $template['type_id'];//工单模板类型Id

		$data['ticket']['ticket_from'] = $ticket_from;//工单来源

		$data['ticket']['been'] = 'created';//被创建标识

//        处理人组件
		if(isset($_POST['ticket']['handle_discrete']))
		{
			if(empty($_POST['ticket']['handle_discrete']))
			{
				return ['status'=>0,'msg'=>L('SELECT_DISPOSE')];
			}
			else
			{
				$processData['recipient_id'] = $processData['dispose_id'] = $_POST['ticket']['handle_discrete'];

				$processData['assign_time'] = NOW_TIME;

				$processData['wait_assign_status'] = 1;
			}
		}
		else
		{
			$processData = [];
		}

		if($ticket_id = $this->add($data['ticket']))//创建工单
		{
//            地区
			if($data['area']['country_code'])
			{
				$data['area']['ticket_id'] = $ticket_id;

				M('ticket_area')->add($data['area']);
			}

//            储存上传文件信息
			$files = isset($_POST['file']) ? I('post.file') : [];

			$this->saveUploadFile($files,$ticket_id,0,$company_id);

//            存储工单事件
			$eventData = ['event_type'=>'create','ticket_id'=>$ticket_id,'member_id'=>$member_id];

			D('TicketEvent')->saveEvent($eventData);

//            储存工单内容
			foreach($data['detail'] as &$v)
			{
				$v['ticket_id'] = $ticket_id;

				$v['company_id'] = $company_id;

				if(is_array($v['ticket_form_content']))
				{
					$v['ticket_form_content'] = implode(',',$v['ticket_form_content']);
				}

				M('TicketDetail')->add($v);
			}

			// 完成期限组件
			if(isset($_POST['deadlines']) && I('post.deadlines'))
			{
				$deadData = [
					'company_id'=>$company_id,
					'ticket_id'=>$ticket_id,
					'deadtime'=>strtotime(I('post.deadlines'))
				];

				M('ticket_deadlines')->add($deadData);
			}

			$this->auditAfterAction($company_id,$ticket_id,$template['ticket_model_id'],$member_id,$processData,$data['cc']);

			$result = ['status'=>2,'msg'=>L('SUBMIT_SUCCESS'),'url'=>U('myTicket'),'id'=>encrypt($ticket_id,'TICKET')];
		}
		else
		{
			$result = ['status'=>0,'msg'=>L('SUBMIT_FAILED')];
		}

		return $result;
	}


	/* 获取修改工单数据
	* @param array  $ticket      工单
	* @param array  $template    工单模板
	* @param array  $company     公司信息
	* @param int  	$member_type 1 用户
	*/
	public function getEditTicketForm($ticket = [],$template = [],$company = [],$member_type = 1)
	{
		$ticketForm = D('TicketForm')->where(['ticket_model_id'=>$ticket['ticket_model_id'],'company_id'=>$company['company_id'],'closed'=>0])->order('orderby asc')->fetchAll();

		foreach($ticketForm as &$v1)
		{
			if(in_array($v1['ticket_form_type'],['radio','select','checkbox']))
			{
				$v1['option'] = explode('|',$v1['ticket_form_option']);
			}

			$v1['ticket_form_content'] = M('ticket_detail')->where(['company_id'=>$company['company_id'],'ticket_id'=>$ticket['ticket_id'],'ticket_form_id'=>$v1['ticket_form_id']])->getField('ticket_form_content');
		}

		$editTicketFormData['ticketForm'] = $ticketForm;

		if($member_type == 1)
		{
//            指定处理人 - 未禁用部门
			$groups = D('Group')->where(['company_id'=>$company['company_id'],'closed'=>0])->field('group_id,group_name')->fetchAll();

			$editTicketFormData['groups'] = $groups;

//            指定处理人 - 未禁用客服
			$members = D('Member')->where(['company_id'=>$company['company_id'],'closed'=>0,'type'=>1])->field('member_id,account,type,name,group_id')->fetchAll();

			$editTicketFormData['members'] = $members;

			$editTicketFormData['jsonCcMembers'] = json_encode(array_values($members));

//            完成期限
			$ticket['deadline'] = M('ticket_deadlines')->where(['company_id'=>$company['company_id'],'ticket_id'=>$ticket['ticket_id']])->getField('deadtime');

//            审核状态下，抄送人和处理人
			if(in_array($ticket['audit_status'],[2,4]))
			{
				$redis = new Redis();

				$ticket['ticketCc'] = $redis->get("cc_".$ticket['ticket_id'].'_data');

				$ticket['dispose_id'] = $redis->get("process_".$ticket['ticket_id'].'_data')['dispose_id'];
			}
			else
			{
				$ticketCc = M('cc_ticket')->where(['company_id'=>$company['company_id'],'ticket_id'=>$ticket['ticket_id']])->field('member_id')->select();

				$ticket['ticketCc'] = array_column($ticketCc,'member_id');
			}

			$ticket['ccIdsstr'] = implode(',',$ticket['ticketCc']);

			$ticket['ccIds'] = json_encode($ticket['ticketCc']);
		}

//        配图
		$ticket['photo'] = unserialize($ticket['photo']);

//		  工单附件
		$ticket['createFiles'] = M('upload_file')->where(['company_id'=>$company['company_id'],'ticket_id'=>$ticket['ticket_id'],'file_form'=>'ticket'])->select();

		if(is_array($ticket['photo']))
		{
			foreach($ticket['photo'] as $k=>$v)
			{
				if(!$v) unset($ticket['photo'][$k]);
			}
		}

		if($template['area_discrete'] == 10)
		{
			$lang_name = $this->getNameByLang('name');

			$area['country'] = M('country')->field("*,$lang_name")->select();

			// 区域组件
			$ticketArea = M('ticket_area')->where(['company_id'=>$company['company_id'],'ticket_id'=>$ticket['ticket_id']])->find();

			$area['province'] = M('province')->field("*,$lang_name")->select();

			$area['city'] = M('city')->field("*,$lang_name")->select();

			$editTicketFormData['area'] = $area;

			$editTicketFormData['ticketArea'] = $ticketArea;
		}

		return ['ticket'=>$ticket,'editTicketFormData'=>$editTicketFormData];
	}


	/*
    * 修改工单 - 用户
    * @param int    $company_id         公司ID
    * @param int    $member_id          当前登录用户ID
    * @param array  $ticket             当前工单信息
    * @return array
    */
	public function EditTicketByUser($company_id = 0,$member_id = 0,$ticket = [])
	{
		$data = $this->checkEditTicket($company_id,$member_id,$ticket);

		if(isset($data['status']) && $data['status'] == 0) return $data;

		$data['ticket']['ticket_id'] = $ticket['ticket_id'];//工单ID

		$data['ticket']['been'] = 'updated';//被更新标识

		$data['ticket']['update_time'] = NOW_TIME;//更新时间

//        处理人组件
		$processData = [];

		$notifyHandler = 0;

		if(isset($_POST['ticket']['handle_discrete']))
		{
			if(empty($_POST['ticket']['handle_discrete']))
			{
				return ['status'=>0,'msg'=>L('SELECT_DISPOSE')];
			}
			else
			{
//		    	工单本身有处理人
				if($ticket['dispose_id'] > 0)
				{
					if($ticket['dispose_id'] != $_POST['ticket']['handle_discrete'])
					{
//					    工单处于发布工单 - 审核或驳回状态时，审核完成后分配处理人
						if(in_array($ticket['audit_status'],[2,4]))
						{
							$processData['dispose_id'] = $_POST['ticket']['handle_discrete'];

							$processData['wait_assign_status'] = 1;
						}
						else
						{
							$notifyHandler = 1;

							$data['ticket']['dispose_id'] = $_POST['ticket']['handle_discrete'];

							$data['ticket']['wait_assign_status'] = 1;
						}
					}
				}
//		    	工单本身没有处理人
				else
				{
//			    	工单处于发布工单 - 审核或驳回状态时，审核完成后分配处理人
					if(in_array($ticket['audit_status'],[2,4]))
					{
						$processData['recipient_id'] = $processData['dispose_id'] = $_POST['ticket']['handle_discrete'];

						$processData['assign_time'] = NOW_TIME;

						$processData['wait_assign_status'] = 1;
					}
					else
					{
						$notifyHandler = 1;

						$data['ticket']['recipient_id'] = $data['ticket']['dispose_id'] = $_POST['ticket']['handle_discrete'];

						$data['ticket']['assign_time'] = NOW_TIME;

						$data['ticket']['wait_assign_status'] = 1;
					}
				}
			}
		}

		$save = $this->save($data['ticket']);

		if($save !== false)//更新工单
		{
//			更新区域组件
			$area = D('Area')->updateTicketArea($data['area'],$ticket['ticket_id']);

//			组件修改记录
			if($area)
			{
				$data['modify']['modify_data']['area'] = $area;
			}

//            更新上传文件信息
			$files = isset($_POST['file']) ? I('post.file') : [];

			$delFiles = isset($_POST['delFile']) ? I('post.delFile') : [];

			$this->updateUploadFile($files,$delFiles,$ticket['ticket_id'],0,$company_id);

//            删除上传图片
			$delImages = isset($_POST['delImage']) ? I('post.delImage') : [];

			$this->deleteUploadImage($delImages);

			$ticketDetail = M('TicketDetail')->where(['ticket_id'=>$ticket['ticket_id']])->field('ticket_form_id,ticket_form_content')->select();

//            更新表单内容
			foreach($data['detail'] as &$v)
			{
				$where = ['ticket_id'=>$ticket['ticket_id'],'company_id'=>$company_id,'ticket_form_id'=>$v['ticket_form_id']];

				if(is_array($v['ticket_form_content']))
				{
					$v['ticket_form_content'] = implode(',',$v['ticket_form_content']);
				}

				M('TicketDetail')->where($where)->save(['ticket_form_content'=>$v['ticket_form_content']]);

//                修复修改表单BUG
				if(!M('TicketDetail')->where($where)->find())
				{
					$where['ticket_form_content'] = $v['ticket_form_content'];

					M('TicketDetail')->add($where);

					$data['modify']['modify_data']['form_'.$v['ticket_form_id']] = ['modify_before'=>'','modify_after'=>$v['ticket_form_content']];
				}

//                修改记录 - 自定义表单修改项
				foreach($ticketDetail as $td)
				{
					if($td['ticket_form_id'] == $v['ticket_form_id'] && $td['ticket_form_content'] != $v['ticket_form_content'])
					{
						$data['modify']['modify_data']['form_'.$v['ticket_form_id']] = ['modify_before'=>$td['ticket_form_content'],'modify_after'=>$v['ticket_form_content']];
					}
				}
			}

//            更新完成期限组件
			if(isset($_POST['deadlines']) && I('post.deadlines'))
			{
				$deadline = strtotime(I('post.deadlines'));

				$deadData = ['company_id'=>$company_id, 'ticket_id'=>$ticket['ticket_id']];

				if(M('ticket_deadlines')->where($deadData)->getField('deadtime'))
				{
					M('ticket_deadlines')->where($deadData)->setField(['deadtime'=>$deadline]);
				}
				else
				{
					$deadData['deadtime'] = $deadline;

					M('ticket_deadlines')->add($deadData);
				}
			}

//            当工单处于 发布工单 - 审核或驳回 状态时
			if(in_array($ticket['audit_status'],[2,4]))
			{
				$redis = new Redis();

//	              存储工单待分配处理人数据,审核完成后再分配
				if($processData['dispose_id'])
				{
					$redis->set("process_".$ticket['ticket_id'].'_data',$processData,0);
				}

//		          存储工单待抄送人数据,审核完成后再抄送
				if(!empty($data['cc']))
				{
					$redis->set("cc_".$ticket['ticket_id'].'_data',$data['cc'],0);
				}
			}
			else
			{
//	    	       工单本身没有接收人时加入工单事件
				if($data['ticket']['recipient_id'] && !$ticket['recipient_id'])
				{
					$eventData = ['event_type'=>'receive','ticket_id'=>$ticket['ticket_id'],'member_id'=>$ticket['recipient_id']];

					D('TicketEvent')->saveEvent($eventData);
				}

				if($notifyHandler == 1)
				{
//                    添加参与者
					D('TicketPartake')->createPartake($company_id,$data['ticket']['dispose_id'],$ticket['ticket_id'],true);

//                    通知处理人
					D('BuildMessage')->assignDisposeMessage($data['ticket']['dispose_id'],$ticket['ticket_id']);
				}

//			      更新抄送人
				D('CcTicket')->updateCcByEditorTicket($company_id,$ticket['ticket_id'],$data['cc'],$ticket['member_id'],$data['ticket']['dispose_id']);
			}

//            修改工单 — 通知发布人
			D('BuildMessage')->buildMessage($ticket['ticket_id'],[],[],0,$member_id ,'editor_ticket');

//            增加修改记录
			$modify_id = 0;

			if($data['modify']['modify_data'])
			{
				$data['modify']['modify_data'] = json_encode($data['modify']['modify_data']);

				$data['modify']['modify_time'] = NOW_TIME;

				$modify_id = M('modify_record')->add($data['modify']);
			}

//            存储工单事件
			$eventData = ['event_type'=>'modify','ticket_id'=>$ticket['ticket_id'],'member_id'=>$member_id,'modify_record_id'=>$modify_id];

			D('TicketEvent')->saveEvent($eventData);

			$result = ['status'=>2,'msg'=>L('UPDATE_SUCCESS'),'url'=>U('detail',['id'=>encrypt($ticket['ticket_id'],'TICKET')])];
		}
		else
		{
			$result = ['status'=>0,'msg'=>L('UPDATE_FAILED')];
		}

		return $result;
	}


	/*
    * 修改工单验证 - 用户
    * @param int    $company_id    公司ID
    * @param int    $member_id     当前登录用户ID
    * @param int    $dispose_id    原处理人ID
    * @return string
    */
	private function checkEditTicket($company_id = 0,$member_id = 0,$ticket = [])
	{
		$ticketData = checkFields(I('post.ticket'), $this->_filter);

		$cc = isset($_POST['cc']) ? I('post.cc') : [];

		$area = isset($_POST['area']) ? I('post.area') : [];

		if(!is_array($cc)) $cc = explode(',',$cc);

		$modify = ['company_id'=>$company_id,'ticket_id'=>$ticket['ticket_id'],'member_id'=>$member_id];

		if(empty($ticketData['title']))
		{
			return ['status'=>0,'msg'=>L('ENTER_TICKET_TITLE')];
		}
		else
		{
			if($ticketData['title'] != $ticket['title'])
			{
				$modify['modify_data']['title'] = ['modify_before'=>$ticket['title'],'modify_after'=>$ticketData['title']];
			}
		}

		if($ticketData['priority'] != $ticket['priority'])
		{
			$modify['modify_data']['priority'] = ['modify_before'=>$ticket['priority'],'modify_after'=>$ticketData['priority']];
		}

//        手机组件
		if(isset($_POST['ticket']['mobile']))
		{
			$mobile = $_POST['ticket']['mobile'];

			if(!$mobile)
			{
				return ['status'=>0,'msg'=>L('ENTER_MOBILE')];
			}
			else if(!isMobile($mobile) && !isInternationalMobile($mobile))
			{
				return ['status'=>0,'msg'=>L('MOBILE_FORMAT_ERROR',['mobile'=>$mobile])];
			}
			else
			{
				$ticketData['mobile_discrete'] = $mobile;

				if($ticketData['mobile_discrete'] != $ticket['mobile_discrete'])
				{
					$modify['modify_data']['mobile_discrete'] = ['modify_before'=>$ticket['mobile_discrete'],'modify_after'=>$ticketData['mobile_discrete']];
				}
			}
		}

//        邮箱组件
		if(isset($_POST['ticket']['email']))
		{
			$email = $_POST['ticket']['email'];

			if(!$email)
			{
				return ['status'=>0,'msg'=>L('ENTER_EMAIL')];
			}
			else if(!isEmail($email))
			{
				return ['status'=>0,'msg'=>L('EMAIL_FORMAT_ERROR',['email'=>$email])];
			}
			else
			{
				$ticketData['mail_discrete'] = $email;

				if($ticketData['mail_discrete'] != $ticket['mail_discrete'])
				{
					$modify['modify_data']['mail_discrete'] = ['modify_before'=>$ticket['mail_discrete'],'modify_after'=>$ticketData['mail_discrete']];
				}
			}
		}

//        模板表单
		$ticket_form = I('post.ticket_form');

		$ticket_detail = [];

		$require = D('TicketForm')->where(['ticket_model_id'=>$ticketData['ticket_model_id'],'closed'=>0])->order('orderby asc')->fetchAll();

		foreach($require as $v)
		{
			if($v['is_required'] == 0)
			{
				if(!$ticket_form[$v['ticket_form_name']])
				{
					return ['status'=>0,'msg'=>$v['ticket_form_description'].' '.L('IS_REQUIRED')];
				}
			}

			$ticket_detail[$v['ticket_form_name']]['ticket_form_id'] = $v['ticket_form_id'];

			$ticket_detail[$v['ticket_form_name']]['ticket_form_content'] = $ticket_form[$v['ticket_form_name']];
		}

//        图片
		if(isset($_POST['photo']) && $_POST['photo'])
		{
			$ticketData['photo'] = serialize($_POST['photo']);
		}
		else
		{
			$ticketData['photo'] = '';
		}

		return ['ticket'=>$ticketData,'detail'=>$ticket_detail,'modify'=>$modify,'cc'=>$cc,'area'=>$area];
	}


	/*
    * 工单详情 - 用户
    * @param array  $ticket         工单信息
    * @param int    $company_id     公司ID
    * @param array  $now_member     当前登录人信息
    * @param array  $ticket_status  工单状态
    * @param array  $source         终端
    * @return array
    */
	public function getTicketDetailData(&$ticket,$company_id,$now_member,$ticket_status,$source)
	{
//	      计算工单耗时
		$takeTime = $this->getTicketTakeTime($company_id,$ticket['ticket_id'],$ticket['create_time'],$ticket['end_time']);

		$ticket['taking'] = $takeTime['taking'];

		$ticket['ztaking'] = $takeTime['ztaking'];

//        更新工单查看状态
		if($now_member['member_id'] == $ticket['dispose_id'] && $ticket['look'] == 1)
		{
			$ticket['look'] = 2;

			$this->where(['ticket_id'=>$ticket['ticket_id']])->setField('look',2);
		}

//        配图
		$ticket['photo'] = unserialize($ticket['photo']);

		if(is_array($ticket['photo']))
		{
			foreach($ticket['photo'] as $k=>$v)
			{
				if(!$v) unset($ticket['photo'][$k]);
			}
		}

//        工单所属部门的管理员
		$ticket['group_manager_id'] = M('group')->where(['group_id'=>$ticket['group_id']])->getField('manager_id');

		$group = D('Group')->where(['company_id'=>$company_id,'closed'=>0,'ticket_auth'=>10])->order('orderby asc')->select();

		$group = fetchAll($group,'group_id');

		$insideData = [];

//        表单详情
		$ticketForm = M('ticket_form')->alias('a')->join('feel_ticket_detail as b on a.ticket_form_id = b.ticket_form_id')
			->where(['ticket_id'=>$ticket['ticket_id'],'a.company_id'=>$company_id])
			->field('a.ticket_form_id,ticket_form_description,ticket_form_type,ticket_form_content')
			->order('orderby asc')
			->select();

		foreach($ticketForm as $k1 => &$v1)
		{
			if($v1['ticket_form_type'] == 'textarea')
			{
				$ticket['textarea'][$k1]['title'] = $v1['ticket_form_description'];

				$ticket['textarea'][$k1]['content'] = $v1['ticket_form_content'];

				if($source == 'mobileTerminal') unset($ticketForm[$k1]);
			}
		}

		$replySortRule = 'desc';

		if($source == 'mobileTerminal') $replySortRule = 'asc';

//        工单配置
		$ticketConfig = M('ticket_config')->where(['company_id'=>$company_id])->find();

//		  回复内容
		$reply = M('ticket_reply')
			->alias('a')
			->join('feel_member AS b ON a.member_id = b.member_id','left')
			->where(['a.company_id'=>$company_id,'ticket_id'=>$ticket['ticket_id']])
			->field('reply_id,reply_content,reply_time,name,type,face')
			->order('reply_id '.$replySortRule)
			->select();

//        内部协作回复权限
		$teamReplyAuth = D('RoleAuth')->checkRoleAuthByMenu($company_id,'ticket/teamReply',$now_member['role_id']);

		$teamReply = [];

		if($teamReplyAuth)
		{
//            内部协作内容
			$teamReply = M('team_reply')
				->alias('a')
				->join('feel_member AS b ON a.member_id = b.member_id','left')
				->where(['a.company_id'=>$company_id,'ticket_id'=>$ticket['ticket_id']])
				->field('reply_id,reply_content,cc_member_id,reply_time,name,type,face')
				->order('reply_id '.$replySortRule)
				->select();

			$insideData = ['isTeamAuth'=>$teamReplyAuth, 'teamReplyList'=>$teamReply];
		}

		$comment = M('reply_comment')->where(['company_id'=>$company_id,'ticket_id'=>$ticket['ticket_id']])->order('create_time desc')
			->field('reply_id,member_id,content,create_time,comment_type')->select();

		$replyComment = [];

//        移动端回复内容处理
		if($source == 'mobileTerminal')
		{
			$replyByTime = $replyList = [];

			foreach($reply as $k2=>&$v2)
			{
				$v2['reply_date'] = date('Y-m-d',$v2['reply_time']);

				$replyByTime[$k2] = $v2;
			}

			foreach($reply as $v3)
			{
				foreach($replyByTime as $k4=>$v4)
				{
					if($v3['reply_date'] == $v4['reply_date'])
					{
						$replyList[$v3['reply_date']][$k4] = $v4;
					}
				}
			}

			$reply = $replyList;

			$teamReplyByTime = $teamReplys = [];

			foreach($teamReply as $k=>&$v5)
			{
				$v5['reply_date'] = date('Y-m-d',$v5['reply_time']);

				$teamReplyByTime[$k] = $v5;
			}

			foreach($teamReply as $v6)
			{
				foreach($teamReplyByTime as $k7=>$v7)
				{
					if($v6['reply_date'] == $v7['reply_date'])
					{
						$teamReplys[$v6['reply_date']][$k7] = $v7;
					}
				}
			}

			$insideData['teamReplyList'] = $teamReplys;

			foreach($comment as $co)
			{
				if($co['comment_type'] == 'reply')
				{
					$replyComment['reply'][$co['reply_id']][] = $co;
				}
				else
				{
					$replyComment['inside'][$co['reply_id']][] = $co;
				}
			}
		}
		else
		{
			$replyComment = $comment;
		}

//		  工单附件
		$uploadFiles = M('upload_file')->where(['company_id'=>$company_id,'ticket_id'=>$ticket['ticket_id']])
			->field('ticket_id,reply_id,team_reply_id,file_form,file_name,file_size,file_type,file_link')
			->select();

		$createFiles = $replyFiles = $teamReplyFiles = [];

		unset($v2);

		foreach($uploadFiles as $v2)
		{
			if($v2['file_form'] == 'reply')
			{
				$replyFiles[$v2['reply_id']][] = $v2;
			}
			else if(($v2['file_form'] == 'team_reply') && $teamReplyAuth)
			{
				$teamReplyFiles[$v2['team_reply_id']][] = $v2;
			}
			else
			{
				$createFiles[] = $v2;
			}
		}

		$ticketAttach = ['createFiles'=>$createFiles,'teamReplyFiles'=>$teamReplyFiles,'replyFiles'=>$replyFiles];

//        工单抄送人
		$cc = D('CcTicket')->alias('a')->join('feel_member AS b ON a.member_id = b.member_id','left')
			->where(['a.company_id'=>$company_id,'ticket_id'=>$ticket['ticket_id']])
			->field('a.member_id,employee_id,name,face')->select();

//        工单发布人信息
		$ticket['publish'] = M('member')->where(['member_id'=>$ticket['member_id']])->field('member_id,employee_id,name,mobile,email,type,face')->find();

		$ticket['publish']['firm_name'] = M('Company')->where(['company_id'=>$company_id])->getField('name');

		$members = D('Member')->where(['company_id'=>$company_id])
			->field('company_id,member_id,employee_id,group_id,type,account,name,mobile,type,role_id,nickname,face,closed')
			->fetchAll();

		$groupIds = array_column($group,'group_id');

		$ccJsonMembers = [];

		foreach($members as $mk => $mv)
		{
			$group_id = explode(',',$mv['group_id']);

			$result = array_diff($group_id,$groupIds);

//            移除不在权限部门中的用户
			if($mv['type'] == 1)
			{
				if($result && empty(array_diff($group_id,$result)))
				{
					unset($members[$mk]);
				}
				else
				{
					$ccJsonMembers[] = $mv;
				}
			}
		}

//        满意度
		$ticketSatisfyData = M('ticket_satisfy')->where(['ticket_id'=>$ticket['ticket_id']])->find();

//	    满意度评价权限 = 工单已结束、未放入回收站、当前用户是工单发布人、未评价
		if($ticket['status_id'] == $ticket['end_status_id'] && $ticket['delete'] == 2 && $ticket['member_id'] == $now_member['member_id'] && !$ticketSatisfyData)
		{
			$ticket['satisfy_auth'] = 1;
		}

		$satisfyData = [];

		$satisfy_lang_name = D('Satisfaction')->getNameByLang('satisfy_name');

		if(!$ticketSatisfyData)
		{
			$satisfaction = M('satisfaction')->alias('a')
				->join('feel_satisfy_label as b on a.satisfy_id = b.satisfy_id','left')
				->where(['a.company_id'=>$company_id,'b.company_id'=>$company_id])
				->field("a.satisfy_id,label_id,score,label_name,a.".$satisfy_lang_name)
				->order('score')
				->select();

			foreach($satisfaction as $s)
			{
				$satisfyData['satisfy'][$s['satisfy_id']]['satisfy_id'] = $s['satisfy_id'];

				$satisfyData['satisfy'][$s['satisfy_id']]['lang_name'] = $s['lang_name'];

				$satisfyData['satisfy'][$s['satisfy_id']]['score'] = $s['score'];

				$satisfyData['labels'][$s['satisfy_id']][] = $s;
			}

			$satisfyData['satisfy'] = array_values($satisfyData['satisfy']);
		}
		else
		{
			$ticketSatisfyData['lang_name'] = M('satisfaction')->where(['company_id' => $company_id, 'satisfy_id' => $ticketSatisfyData['satisfy_id']])->getField($satisfy_lang_name);

			$ticketSatisfyData['labels'] = M('satisfy_label')->where(['company_id' => $company_id, 'label_id' => ['in', $ticketSatisfyData['label_id']]])
				->order('label_id asc')->field('label_name')->select();

			$ticketSatisfyData['labels'] = array_column($ticketSatisfyData['labels'],'label_name');
		}

		$ccMembers = [];

		foreach($cc as $tc)
		{
			$ccMembers[] = $tc['member_id'];
		}

//        工单操作权限(非处理人或参与人时可对工单进行操作)
		$ticket['ticket_operate_auth'] = D('RoleAuth')->checkRoleAuthByMenu($company_id,'ticket/operation_auth',$now_member['role_id']);

//        快捷回复权限
		$fast_reply_auth = D('RoleAuth')->checkRoleAuthByMenu($company_id,'fastReplyType/index',$now_member['role_id']);

		$fastReplyAuth = 0;

		$fastReplyType = [];

		if($fast_reply_auth && $ticket['delete'] == 2)
		{
			$fastReplyAuth = 1;

			$fast_type = D('FastReplyType')->where(['company_id'=>$company_id])->fetchAll();

			foreach($fast_type as $k=>&$v)
			{
				$v['fastreply'] = M('fastreply')->where(['fast_type_id'=>$k])->select();

				foreach($v['fastreply'] as &$v1)
				{
					$v1['fast_content'] = html_entity_decode($v1['fast_content']);
				}

				if(count($v['fastreply']) > 0)
				{
					$fastReplyType[$k] = $v;
				}
			}
		}

//        子工单权限
		$subTicketAuth['detail'] = D('RoleAuth')->checkRoleAuthByMenu($company_id,'subTicket/detail',$now_member['role_id']);

//		评价回复权限
		$commentReplyAuth = 0;

//	      工单未结束、未放入回收站时、非待审
		if($ticket['end_status_id'] != $ticket['status_id'] && $ticket['delete'] == 2)
		{
			if(in_array($ticket['audit_status'],[1,3]))
			{
//              评价回复权限
				$commentReplyAuth = D('RoleAuth')->checkRoleAuthByMenu($company_id,'ticket/commentReply',$now_member['role_id']);

//		          更新优先级权限 - 条件:当前用户时工单发布人或处理人 或者 具有工单操作权限
				if(in_array($now_member['member_id'],[$ticket['dispose_id'],$ticket['member_id']]) || $ticket['ticket_operate_auth'])
				{
					$ticket['update_priority_auth'] = 1;
				}

//		          分配工单权限 - 条件：当前用户是工单所属部门的管理员 或 工单处理人 或者 具有工单操作权限
				if(in_array($now_member['member_id'],[$ticket['dispose_id'],$ticket['group_manager_id']]) || $ticket['ticket_operate_auth'])
				{
					$ticket['assign_ticket_auth'] = 1;
				}

//	              挂起工单开关 - 条件:当前用户是工单处理人 或者 当前用户具有工单操作权限
				if($now_member['member_id'] == $ticket['dispose_id'] || $ticket['ticket_operate_auth'])
				{
					$ticket['suspend_ticket_btn'] = 1;
				}

//                催促工单 - 条件:具有催单的权限
				$ticket['show_urge_btn'] = D('RoleAuth')->checkRoleAuthByMenu($company_id,'ticket/urgeTicket',$now_member['role_id']);

//		          工单参与人 - 包含发布人、处理人、抄送人
				$participant = array_merge([$ticket['member_id'],$ticket['dispose_id']],$ccMembers);

//		          回复工单 - 条件：当前用户是工单发布人、处理人、抄送人、或者 工单没有处理人 或者 当前用户具有工单操作权限
				if(in_array($now_member['member_id'],$participant) || $ticket['dispose_id'] == 0 || $ticket['ticket_operate_auth'])
				{
					$ticket['allow_reply'] = 1;
				}

//                结束工单 - 条件：当前用户是工单处理人并且已配置处理人结束工单 或者 当前用户是工单发布人并且已配置发布人结束工单 或者 当前用户有操作权限
				if(($ticketConfig['handler_closed'] == 10 && $ticket['dispose_id'] == $now_member['member_id']) ||
					($ticketConfig['publisher_closed'] == 10 && $ticket['member_id'] == $now_member['member_id']) || $ticket['ticket_operate_auth'])
				{
					$ticket['open_end_status'] = 1;
				}

//                子工单权限
				$subTicketAuth['create'] = D('RoleAuth')->checkRoleAuthByMenu($company_id,'subTicket/create',$now_member['role_id']);

				$subTicketAuth['editor'] = D('RoleAuth')->checkRoleAuthByMenu($company_id,'subTicket/editor',$now_member['role_id']);

				$subTicketAuth['delete'] = D('RoleAuth')->checkRoleAuthByMenu($company_id,'subTicket/delete',$now_member['role_id']);
			}

//		      修改工单 - 条件:具有修改工单的权限并且当前登录客服是工单发布人或处理人
			$editTicketAuth = D('RoleAuth')->checkRoleAuthByMenu($company_id,'ticket/edit',$now_member['role_id']);

			if($editTicketAuth && in_array($now_member['member_id'],[$ticket['member_id'],$ticket['dispose_id']]) && $ticket['audit_status'] != 5)
			{
				$ticket['editor_ticket_btn'] = 1;
			}
		}

//        重启工单开关 - 条件：工单已结束，未进入回收站、重启配置已开启、当前用户是工单处理人或者具有工单操作权限
		if($ticket['status_id'] == $ticket['end_status_id'] && $ticket['delete'] == 2  && $ticketConfig['end_operate'] == 10 &&
			($ticket['ticket_operate_auth'] || $ticket['dispose_id'] == $now_member['member_id']))
		{
			$ticket['show_restart_btn'] = 1;
		}

		$model_lang_name = D('Ticketmodel')->getNameByLang('ticket_model_name');

		$ticket['template_name'] = M('ticket_model')->where(['ticket_model_id'=>$ticket['ticket_model_id']])->getField($model_lang_name);

		$ticketStatus = $handlerTicketStatus = $publisherTicketStatus = [];

//        工单状态回退判断
		if($ticketConfig['status_go_back'] == 10)
		{
			if($ticketConfig['handler_go_back'] == 10)
			{
				foreach($ticket_status as $sv)
				{
					$handlerTicketStatus[$sv['status_id']] = $sv;
				}
			}
			else
			{
//                工单状态过滤
				foreach($ticket_status as $sv)
				{
					//根据排序值来判断状态的前后顺序
					if($sv['sort'] >= $ticket_status[$ticket['status_id']]['sort'])
					{
						$handlerTicketStatus[$sv['status_id']] = $sv;
					}
				}
			}

			if($ticketConfig['publisher_go_back'] == 10)
			{
				$publisherTicketStatus = $ticket_status;
			}
			else
			{
//                工单状态过滤
				foreach($ticket_status as $sv)
				{
					//根据排序值来判断状态的前后顺序
					if($sv['sort'] >= $ticket_status[$ticket['status_id']]['sort'])
					{
						$publisherTicketStatus[$sv['status_id']] = $sv;
					}
				}
			}
		}
		else
		{
//            工单状态过滤
			foreach($ticket_status as $sv)
			{
				//根据排序值来判断状态的前后顺序
				if($sv['sort'] >= $ticket_status[$ticket['status_id']]['sort'])
				{
					$handlerTicketStatus[$sv['status_id']] = $publisherTicketStatus[$sv['status_id']] = $ticketStatus[$sv['status_id']] = $sv;
				}
			}
		}

		$transferTicketAuth = $cloningTicketAuth = $associateTicketAuth = 0;

		if(in_array($ticket['audit_status'],[1,3]))
		{
//            转移工单权限
			$transferTicketAuth = D('RoleAuth')->checkRoleAuthByMenu($company_id,'ticket/transfer',$now_member['role_id']);

//            克隆工单权限
			$cloningTicketAuth = D('RoleAuth')->checkRoleAuthByMenu($company_id,'ticket/cloning',$now_member['role_id']);

//            关联工单权限
			$associateTicketAuth = D('RoleAuth')->checkRoleAuthByMenu($company_id,'ticket/associate',$now_member['role_id']);
		}

//        关联工单 —— 主动关联的工单
		$associated_ticket = M('associate_ticket')
			->alias('a')
			->join('feel_ticket as b ON a.associated_ticket_id = b.ticket_id')
			->where(['associate_ticket_id'=>$ticket['ticket_id'],'a.company_id'=>$company_id])
			->field('ticket_id,title')->find();

//        关联工单 —— 被动关联的工单
		$associated = M('associate_ticket')->where(['associated_ticket_id'=>$ticket['ticket_id'],'company_id'=>$company_id])
			->field('associate_ticket_id')->select();

		$associateTickets = [];

		if($associated_ticket)
		{
			$associateTickets[0] = $associated_ticket;
		}

		$i = 1;

		foreach($associated as $a)
		{
			$associateTickets[$i] = $this->where(['ticket_id'=>$a['associate_ticket_id']])->field('ticket_id,title')->find();

			$i++;
		}

//        完成期限
		$ticket['deadtime'] = M('ticket_deadlines')->where(['company_id'=>$company_id,'ticket_id'=>$ticket['ticket_id']])->getField('deadtime');

//        地区
		$area = M('ticket_area')->where(['ticket_id'=>$ticket['ticket_id']])->find();

		$ticketArea = [];

		if($area)
		{
			$lang_name = $this->getNameByLang('name');

			if($area['country_code'])
			{
				$ticketArea['country'] = M('country')->where(['code'=>$area['country_code']])->getField($lang_name);
			}

			if($area['province_code'])
			{
				$where = ['country_code'=>$area['country_code'],'code'=>$area['province_code']];

				$ticketArea['province'] = M('province')->where($where)->getField($lang_name);
			}

			if($area['city_code'])
			{
				$where = ['country_code'=>$area['country_code'],'province_code'=>$area['province_code'],'code'=>$area['city_code']];

				$ticketArea['city'] = M('city')->where($where)->getField($lang_name);
			}

			if($area['region_code'])
			{
				$where = ['country_code'=>$area['country_code'],'province_code'=>$area['province_code'],'city_code'=>$area['city_code'],'code'=>$area['region_code']];

				$ticketArea['region'] = M('region')->where($where)->getField($lang_name);
			}
		}

//	      工单是否挂起
		$suspendMap = ['company_id'=>$company_id,'ticket_id'=>$ticket['ticket_id'],'start_time'=>['gt',0],'close_time'=>0];

		$is_suspend = M('ticket_suspend')->where($suspendMap)->getField('id');

//	      子工单
		$subTickets = M('sub_ticket')->where(['company_id'=>$company_id,'parent_id'=>$ticket['ticket_id'],'is_delete'=>10])->field('ticket_id,title,status_id')->select();

		$groupTreeHtml = $this->getDepartmentTreeHtml($group,0,'group_id',1,$ticket['group_id']);

		return [
			'insideData'            => $insideData,
			'ticketAttach'          => $ticketAttach,
			'ticketCC'              => $cc,
			'isFastReplyAuth'       => $fastReplyAuth,
			'fastReplyType'         => $fastReplyType,
			'ticketSatisfyData'     => $ticketSatisfyData,
			'satisfyData'           => json_encode($satisfyData),
			'replyList'             => $reply,
			'replyComment'          => $replyComment,
			'isCommentAuth'         => $commentReplyAuth,
			'ticketStatus'          => $ticketStatus,
			'handlerTicketStatus'   => $handlerTicketStatus,
			'publisherTicketStatus' => $publisherTicketStatus,
			'ticket_status'         => $ticket_status,
			'ticketForm'            => $ticketForm,
			'groupList'             => $group,
			'groupTreeHtml'         => $groupTreeHtml,
			'members'               => $members,
			'jsonMembers'           => json_encode(array_values($members)),
			'ccJsonMembers'         => json_encode(array_values($ccJsonMembers)),
			'jsonRestartStatus'     => json_encode(array_values($ticket_status)),
			'associateTickets'      => $associateTickets,
			'area'                  => $ticketArea,
			'isSuspend'             => $is_suspend,
			'isTransferAuth'        => $transferTicketAuth,
			'isCloningAuth'         => $cloningTicketAuth,
			'isAssociateAuth'       => $associateTicketAuth,
			'subTickets'            => $subTickets,
			'subTicketAuth'         => $subTicketAuth
		];
	}


	function getDepartmentTreeHtml($data,$parent_id,$pk,$level = 1,$value=0)
	{
		$html = '';

		foreach($data as $v)
		{
			if(getTreeChild($data,$v['group_id']))
			{
				$padding = $level == 1 ? 10 : (($level - 1) * 20) + 10;

				$i = "<i class='iconfont icon-dir-open'></i>";
			}
			else
			{
				$i = "<i class='iconfont icon-dir-close color-ffe792'></i>";

				$padding = $level == 1 ? 10 : (($level - 1) * 20) + 10;
			}

			$class = $value == $v['group_id'] ? 'group-selected' : '';

			if($v['parent_id'] == $parent_id)
			{
				$html .= "<li class='department-item ".$class."' data-id='{$v['group_id']}' data-pid='".$parent_id."' style='padding-left:{$padding}px'>";

				$html .= "$i<span>{$v['group_name']}</span>";

				$html .= $this->getDepartmentTreeHtml($data,$v[$pk],$pk,$level+1,$value);

				$html .= "</li>";
			}
		}

		return $html;
	}

	/*
    * 回复工单 - 用户
    * @param int    $company_id     公司ID
    * @param array  $now_member_id  回复人ID
    * @param array  $end_status_id  工单结束状态
    * @return array
    */
	public function ticketReplyByUser($company_id = 0,$now_member_id = 0,$end_status_id = 0)
	{
//        重启工单
		if(isset($_POST['restart']) && I('post.restart'))
		{
			$restart = I('post.restart');

			$restart['update_time'] = NOW_TIME;

			$restart['end_time'] = 0;

			$result = $this->save($restart);

			if($result)
			{
				if($restart['dispose_id'] != $now_member_id)
				{
//                    当前客服不是处理人，重启工单通知处理人
					D('BuildMessage')->buildMessage($restart['ticket_id'],[],[],0,$now_member_id,'restart_ticket');
				}

//                储存重启记录
				M('ticket_restart')->add(['company_id'=>$company_id,'ticket_id'=>$restart['ticket_id'],'restart_time'=>NOW_TIME]);

//                存储工单事件
				$eventData = ['event_type'=>'restart','ticket_id'=>$restart['ticket_id'],'member_id'=>$now_member_id];

				D('TicketEvent')->saveEvent($eventData);

				return ['errcode'=>0,'msg'=>L('UPDATE_SUCCESS')];
			}
			else
			{
				return ['errcode'=>1,'msg'=>L('UPDATE_FAILED')];
			}
		}

//        关联工单
		if(isset($_POST['associate']) && I('post.associate'))
		{
			$associate = I('post.associate');

			return $this->associateTicket($associate,$company_id,$now_member_id);
		}

//        取消关联工单
		if(isset($_POST['cancel_associate_id']) && I('post.cancel_associate_id'))
		{
			$associate['associate_id'] = I('post.cancel_associate_id');

			$associate['ticket_id'] = I('post.ticket_id');

			return $this->cancelAssociateTicket($associate,$company_id,$now_member_id);
		}

		$data = $this->checkReply($company_id,$now_member_id);

		if($data['status'] === 0) return $data;

		$detail = $this->where(['company_id'=>$company_id,'ticket_id'=>$data['ticket_id']])
			->field('ticket_id,ticket_no,status_id,dispose_id,member_id')
			->find();

		if(!$detail) return ['status'=>0,'msg'=>L('TICKET_NOT')];

//        检查已结束的工单是否允许回复
		if($detail['status_id'] == $end_status_id)
		{
			$ticketEndOperate = M('ticket_config')->where(['company_id'=>$company_id])->getField('end_operate');

			if($ticketEndOperate != 10) return ['status'=>0,'msg'=>'请先重启工单后进行回复'];
		}

		$ticket = I('post.ticket');

		$data['reply_content'] = str_replace("?imageMogr2/auto-orient/thumbnail/240x135!/format/png/blur/1x0/quality/100|imageslim",'',$data['reply_content']);

		if($reply_id = M('TicketReply')->add($data))
		{
//            存储工单事件
			$eventData = ['event_type'=>'reply','ticket_id'=>$detail['ticket_id'],'member_id'=>$now_member_id,'reply_id'=>$reply_id];

			D('TicketEvent')->saveEvent($eventData);

//            更新回复内容查看状态
			M('TicketReply')->where(['ticket_id'=>$data['ticket_id'],'look'=>1,'member_id'=>['neq',$now_member_id]])->setField('look',2);

//            储存上传文件信息
			$files = isset($_POST['file']) ? I('post.file') : [];

			if(!empty($files)) $this->saveUploadFile($files,$data['ticket_id'],$reply_id,$company_id,'reply');

//            判断接收人和处理人
			$update = $this->JudgeAcceptance($detail['ticket_id'],$reply_id,$now_member_id);

//            查询抄送人
			$cc = D('CcTicket')->where(['company_id'=>$company_id,'ticket_id'=>$data['ticket_id']])->field('member_id')->select();

			$oldCcId = array_column($cc,'member_id');

			if($ticket['cc_id']) $update['cclook'] = 1;

//            更新工单信息
			$this->save($update);

			if($update['dispose_id'] > 0)
			{
//                添加参与者
				D('TicketPartake')->createPartake($company_id,$update['dispose_id'],$data['ticket_id'],true);
			}

//			  通知
			D('BuildMessage')->buildMessage($detail['ticket_id'],[],$oldCcId,$detail['status_id'],$now_member_id);

			return ['status'=>1,'msg'=>L('UPDATE_SUCCESS'),'url'=>U('detail',['id'=>encrypt($data['ticket_id'],'TICKET')]),'value'=>$detail['ticket_id'],'ticket_no'=>$detail['ticket_no']];
		}
		else
		{
			return ['status'=> 0,'msg'=>L('UPDATE_FAILED')];
		}
	}


	/*
    * 内部协作回复 - 用户
    * @param int    $company_id     公司ID
    * @param array  $now_member_id  回复人ID
    * @param array  $end_status_id  工单结束状态
    * @return array
    */
	public function insideReplyByUser($company_id = 0,$now_member_id = 0,$end_status_id = 0)
	{
		$data = $this->checkTeamReply($company_id,$now_member_id);

		if($data['status'] === 0) return $data;

		$ticket = isset($_POST['ticket']) ? I('post.ticket') : [];

		$detail = $this->where(['company_id'=>$company_id,'ticket_id'=>$data['ticket_id']])
			->field('ticket_id,ticket_no,member_id,dispose_id,group_id,status_id,title')
			->find();

//        如果工单处理人在抄送人中，删除抄送人中的处理人ID
		if($ticket['cc_id'])
		{
			foreach($ticket['cc_id'] as $k=>$v)
			{
				if(in_array($v,[$detail['member_id'],$detail['dispose_id']])) unset($ticket['cc_id'][$k]);
			}
		}

//         检查已结束的工单是否允许回复
		if($detail['status_id'] == $end_status_id)
		{
			$ticketEndOperate = M('ticket_config')->where(['company_id'=>$company_id])->getField('end_operate');

			if($ticketEndOperate != 10) return ['status'=>0,'msg'=>'请先重启工单后进行回复'];
		}

		$data['reply_content'] = str_replace("?imageMogr2/auto-orient/thumbnail/240x135!/format/png/blur/1x0/quality/100|imageslim",'',$data['reply_content']);

		if($team_reply_id = M('team_reply')->add($data))
		{
//            存储工单事件
			$eventData = ['event_type'=>'team_reply','ticket_id'=>$detail['ticket_id'],'member_id'=>$now_member_id,'reply_id'=>$team_reply_id];

			D('TicketEvent')->saveEvent($eventData);

//            更新回复内容查看状态
			M('team_reply')->where(['ticket_id'=>$data['ticket_id'],'look'=>1,'member_id'=>['neq',$now_member_id]])->setField('look',2);

//            储存上传文件信息
			$files = isset($_POST['file']) ? I('post.file') : [];

			if(!empty($files)) $this->saveUploadFile($files,$data['ticket_id'],0,$company_id,'team_reply',$team_reply_id);

//            查询原有的抄送人
			$oldCopy = D('CcTicket')->where(['company_id'=>$company_id,'ticket_id'=>$data['ticket_id']])->field('member_id')->select();

			$newCcId = $oldCcId = [];

			$add_cc = ['company_id'=>$company_id,'ticket_id'=>$data['ticket_id']];

//            查询原有的抄送人是否和传递的抄送人一致
			$ocids = [];

			if($oldCopy)
			{
				$deleteCcIds = [];

				foreach($oldCopy as $o)
				{
					$ocids[] = $o['member_id'];

//                        如果原有的抄送人仍在传递的抄送人中
					if(in_array($o['member_id'],$ticket['cc_id']))
					{
						$oldCcId[] = $o['member_id'];
					}
					else
					{
						$deleteCcIds[] = $o['member_id'];
					}
				}

//                删除该工单下所有不在传递参数中的抄送人
				if($deleteCcIds)
				{
					$add_cc['member_id'] = ['in',$deleteCcIds];

					M('cc_ticket')->where($add_cc)->delete();
				}
			}

//			  传递的参数中的抄送人是否和原有的抄送人一致
			foreach($ticket['cc_id'] as $cc)
			{
//                如果传递的抄送人不在原有的抄送人中那么就新增
				if(!in_array($cc,$ocids))
				{
					$newCcId[] = $cc;

					$add_cc['member_id'] = $cc;

					M('cc_ticket')->add($add_cc);

//                   添加参与者
					D('TicketPartake')->createPartake($company_id,$cc,$data['ticket_id'],true);
				}
			}

//			  通知
			D('BuildMessage')->buildMessage($detail['ticket_id'],$newCcId,$oldCcId,$detail['status_id'],$now_member_id,'team_reply');

			return ['status'=>1,'msg'=>L('UPDATE_SUCCESS'),'url'=> U('detail',['id'=>encrypt($data['ticket_id'],'TICKET'),'reply_tab'=>'inside_reply'])];
		}
		else
		{
			return ['status'=> 0,'msg'=>L('UPDATE_FAILED')];
		}
	}


	/*
	* 发布工单验证
	* @param int    $company_id    公司ID
	* @param int    $user_id       当前登录用户ID
	* @param string $create_source 工单发布用户类型
	* @param array  $template      工单模板
	* @param string $source        提交来源，page 通过页面表单提交，import 通过导入提交
	* @param array  $importData    导入的工单数据，仅用于导入提交的工单
	* @return string
	*/
	private function checkCreateTicket($company_id = 0,$user_id = 0,$create_source = 'user',$template = [],$source = 'page',$importData = [])
	{
		if($source == 'import')
		{
			$ticket = checkFields($importData['ticket'], $this->_filter);

//          模板表单
			$ticket_form = $importData['ticket_form'];
		}
		else
		{
			$ticket = checkFields(I('post.ticket'), $this->_filter);

//          模板表单
			$ticket_form = I('post.ticket_form');
		}

		$cc = isset($_POST['cc']) ? I('post.cc') : [];

		if($cc && !is_array($cc)) $cc = explode(',',$cc);

		$area = isset($_POST['area']) ? I('post.area') : [];

		if(empty($ticket['title']))
		{
			return ['status'=>0,'msg'=>L('ENTER_TICKET_TITLE')];
		}

//        手机组件
		if(isset($_POST['ticket']['mobile']))
		{
			$mobile = $_POST['ticket']['mobile'];

			if($template['mobile_required'] == 10)
			{
				if(!$mobile)
				{
					return ['status'=>0,'msg'=>L('ENTER_MOBILE')];
				}
				else if(!isMobile($mobile) && !isInternationalMobile($mobile))
				{
					return ['status'=>0,'msg'=>L('MOBILE_FORMAT_ERROR',['mobile'=>$mobile])];
				}
				else
				{
					$ticket['mobile_discrete'] = $mobile;
				}
			}
			else
			{
				$ticket['mobile_discrete'] = $mobile ?: '';
			}
		}

//        邮箱组件
		if(isset($_POST['ticket']['email']))
		{
			$email = $_POST['ticket']['email'];

			if($template['mail_required'] == 10)
			{
				if(!$email)
				{
					return ['status'=>0,'msg'=>L('ENTER_EMAIL')];
				}
				else if(!isEmail($_POST['ticket']['email']))
				{
					return ['status'=>0,'msg'=>L('MAIL_FORMAT_ERROR',['email'=>$email])];
				}
				else
				{
					$ticket['mail_discrete'] = $email;
				}
			}
			else
			{
				$ticket['mail_discrete'] = $email ?: '';
			}
		}

		$ticket_detail = [];

		$require = D('TicketForm')->where(['ticket_model_id'=>$ticket['ticket_model_id'],'closed'=>0])->order('orderby asc')->fetchAll();

		foreach($require as $v)
		{
			if($v['is_required'] == 0)
			{
//            	!strip_tags(html_entity_decode($ticket_form[$v['ticket_form_name']]))用于防止移动端多文本框中的空标签提交时被识别为有值
				if(!$ticket_form[$v['ticket_form_name']] || ($v['ticket_form_type'] == 'textarea' && !strip_tags(html_entity_decode($ticket_form[$v['ticket_form_name']]))))
				{
					return ['status'=>0,'msg'=>$v['ticket_form_description'].' '.L('IS_REQUIRED')];
				}
			}

			$ticket_detail[$v['ticket_form_name']]['ticket_form_id'] = $v['ticket_form_id'];

			$ticket_detail[$v['ticket_form_name']]['ticket_form_content'] = $ticket_form[$v['ticket_form_name']];
		}

//        上传图片
		if(isset($_POST['photo']) && $_POST['photo'])
		{
			$ticket['photo'] = serialize($_POST['photo']);
		}

		$ticket['ticket_no'] = $this->getTicketNo($company_id);

		$ticket['company_id'] = $company_id;//工单所属公司ID

		$ticket['member_id'] = $user_id;//工单发布人

		$ticket['create_time'] = NOW_TIME;

		$ticket['create_ip'] = get_client_ip();

		return ['ticket' =>$ticket, 'detail' =>$ticket_detail, 'cc' =>$cc, 'area' =>$area];
	}


	/*
	* 回复工单验证
	* @param int    $company_id     公司ID
	* @param array  $now_member_id  回复人ID
	* @return array
	*/
	protected function checkReply($company_id = 0,$now_member_id = 0)
	{
		$data = checkFields(I('post.reply'), $this->replyFilter);

		if(!$data['reply_content'])
		{
			return ['status'=>0,'msg'=>L('ENTER_REPLY')];
		}

		$data['company_id'] =  $company_id;

		$data['member_id'] =  $now_member_id;//回复人

		$data['reply_time'] = NOW_TIME;

		$data['reply_ip'] = get_client_ip();

		return $data;
	}


	/*
    * 内部协作验证
    * @param int    $company_id     公司ID
    * @param array  $now_member_id  回复人ID
    * @return array
    */
	protected function checkTeamReply($company_id = 0,$now_member_id = 0)
	{
		$data = checkFields(I('post.team_reply'), $this->replyFilter);

		if(!$this->isExistedByField(['company_id'=>$company_id,'ticket_id'=>$data['ticket_id']]))
		{
			return ['status'=>0,'msg'=>L('TICKET_NOT')];
		}

		if((!$data['reply_content']) || ($data['reply_content'] == '&lt;br&gt;')) return ['status'=>0,'msg'=>L('ENTER_REPLY')];

		if($data['cc_member_id'])
		{
			$data['cc_member_id'] = implode(',',$data['cc_member_id']);
		}

		$data['company_id'] =  $company_id;

		$data['member_id'] =  $now_member_id;//回复人

		$data['reply_time'] = NOW_TIME;

		$data['reply_ip'] = get_client_ip();

		return $data;
	}


	public function getPriority($priority_id = 0)
	{
		$priority = [self::YB  => L('PRIORITY_GENERAL'), self::JJ  => L('PRIORITY_URGENT'), self::GAO => L('PRIORITY_HIGH'), self::DI  => L('PRIORITY_LOW')];

		if($priority_id > 0)
		{
			return $priority[$priority_id];
		}

		return $priority;
	}


	public function getPriorityColor($priority_id = 0)
	{
		$priority = [self::YB  => 'general', self::JJ  => 'urgent', self::GAO => 'high', self::DI  => 'low'];

		if($priority_id > 0)
		{
			return $priority[$priority_id];
		}

		return $priority;
	}


	public function getTicketFrom($from = '')
	{
		$ticket_from = [
			self::PC            => L('WEB_FORM'),
			self::MAIL          => L('MAIL'),
			self::API           => L('API'),
			self::MOBILE        => L('MOBILE_TERMINAL'),
			self::WECHAT        => L('WECHAT'),
			self::VISITOR       => L('VISITOR'),
			self::SERVER        => L('ONLINE_SERVICE'),
			self::WEBCHAT       => 'WebChat',
		];

		if($from)
		{
			return $ticket_from[$from];
		}

		return $ticket_from;
	}


	public function getTicketFromIcon($from = null)
	{
		$icon = [
			self::PC            => 'icon-pc',
			self::MAIL          => 'icon-mail',
			self::API           => 'icon-api',
			self::MOBILE        => 'icon-mobile',
			self::WECHAT        => 'icon-weixin',
			self::VISITOR       => 'icon-visitor',
			self::SERVER        => 'icon-service',
			self::WEBCHAT       => 'icon-kefu1',
		];

		return $icon[$from];
	}


	public function getChannelIcon($from = null)
	{
		$icon = [
			self::PC            => 'diannao',
			self::MAIL          => 'email',
			self::API           => 'api1',
			self::MOBILE        => 'phone',
			self::WECHAT        => 'wechat1',
			self::VISITOR       => 'yonghu',
			self::SERVER        => 'service',
			self::WEBCHAT       => 'webchat',
		];

		if($from !== null)
		{
			return $icon[$from];
		}

		return $icon;
	}


	public function getStartTime($time_id = '-1')
	{
		$timestamp = [
			self::ONE_DAYS   => strtotime('-1 day'),
			self::THREE_DAYS => strtotime('-3 day'),
			self::SEVEN_DAYS => strtotime('-7 day'),
			self::ONE_MONTH  => strtotime('-1 month')
		];

		if($time_id != '-1')
		{
			return $timestamp[$time_id];
		}

		return $timestamp;
	}


	public function getCreateTime($time_id = null)
	{
		$create_time = [
			self::ONE_DAYS    => L('WITHIN_24_HOURS'),
			self::THREE_DAYS  => L('WITHIN_3_DAYS'),
			self::SEVEN_DAYS  => L('WITHIN_7_DAYS'),
			self::ONE_MONTH   => L('WITHIN_A_MONTH'),
			self::CUSTOM_TIME => L('CUSTOM')
		];

		if($time_id !== null)
		{
			return $create_time[$time_id];
		}
		else
		{
			return $create_time;
		}
	}


	/*
	* 关注|取消关注工单
	* @param int    $company_id     公司ID
	* @param int    $now_member_id  当前登录用户
	* @param array  $id             需要关注的工单ID
	* @param array  $request        请求类型，follow - 关注、unfollow - 取消关注
	* return array
	*/
	public function followTicket($company_id = 0,$now_member_id = 0,$id = [],$request = '')
	{
		foreach($id as $v)
		{
			$ticket_id = decrypt($v,'TICKET');

			$map = ['company_id'=>$company_id,'member_id'=>$now_member_id,'ticket_id'=>$ticket_id];

//			关注
			if($request == 'follow')
			{
				if(!M('ticket_follow')->where($map)->getField('id'))
				{
					$map['create_time'] = NOW_TIME;

					M('ticket_follow')->add($map);

//                    存储工单事件
					$eventData = ['event_type'=>'follow','ticket_id'=>$ticket_id,'member_id'=>$now_member_id];

					D('TicketEvent')->saveEvent($eventData);
				}
			}
//			取消关注
			else
			{
				M('ticket_follow')->where($map)->delete();

//                存储工单事件
				$eventData = ['event_type'=>'unfollow','ticket_id'=>$ticket_id,'member_id'=>$now_member_id];

				D('TicketEvent')->saveEvent($eventData);
			}
		}

		return ['status'=>2,'msg'=>L('UPDATE_SUCCESS')];
	}

	/*
	* 删除工单及相关数据
	* @param int    $company_id     公司ID
	* @param int    $ticket_id      工单ID
	* @return array
	*/
	public function deleteTicket($company_id,$ticket_id)
	{
		$where = ['company_id'=>$company_id,'ticket_id'=>$ticket_id];

		$detail = $this->where($where)->field('ticket_id,photo')->find();

		if(!$detail)
		{
			$data = ['status'=>0,'msg'=>L('TICKET_NOT')];
		}
		else
		{
			if($this->where($where)->delete())
			{
//                删除工单详情和内容图片
				$contents = M('ticket_detail')->where($where)->field('ticket_form_content')->select();

				if(M('ticket_detail')->where($where)->delete())
				{
					foreach($contents as $c)
					{
						$content = str_replace('?imageMogr2/auto-orient/thumbnail/240x135!/format/png/blur/1x0/quality/100|imageslim','',
							getHtml($c['ticket_form_content']));

						$pattern = "/<[img|IMG].*?src=[\'|\"](.*?(?:[\.gif|\.jpg|\.png]))[\'|\"].*?[\/]?>/";

						preg_match_all($pattern,$content,$detail_img);

						if($detail_img[1])
						{
							foreach($detail_img[1] as $v1)
							{
								$result = D('Upload')->deleteUploadFile($v1);

								if($result['status'] == 1)
								{
									Log::write('工单内容图片删除失败--'.$result['msg'],'INFO',RUNTIME_PATH.'Logs/delFileLogs.txt');
								}
							}
						}
					}
				}

//                删除工单配图
				if($detail['photo'])
				{
					$result = D('Upload')->deleteTicketFile($detail['photo']);

					if($result['status'] == 1)
					{
						Log::write('工单配图删除失败--'.$result['msg'],'INFO','',RUNTIME_PATH.'Logs/delFileLogs.txt');
					}
				}

//	              删除工单附件
				$files = M('upload_file')->where($where)->field('save_name')->select();

				$upload_result = M('upload_file')->where($where)->delete();

				if($upload_result)
				{
					foreach($files as $f)
					{
						$result = D('Upload')->deleteUploadFile($f['save_name']);

						if($result['status'] == 1)
						{
							Log::write('工单附件删除失败--'.$result['msg'],'INFO','',RUNTIME_PATH.'Logs/delFileLogs.txt');
						}
					}
				}

//                删除回复内容中的图片
				$reply = M('ticket_reply')->where($where)->field('reply_content')->select();

				$reply_result = M('ticket_reply')->where($where)->delete();

				if($reply_result)
				{
					foreach($reply as $r)
					{
						//删除回复图片
						$reply_content = str_replace('?imageMogr2/auto-orient/thumbnail/240x135!/format/png/blur/1x0/quality/100|imageslim','',
							html_entity_decode($r['reply_content']));

						$pattern = "/<[img|IMG].*?src=[\'|\"](.*?(?:[\.gif|\.jpg|\.png]))[\'|\"].*?[\/]?>/";

						preg_match_all($pattern,$reply_content,$reply_img);

						foreach($reply_img[1] as $r2)
						{
							$result = D('Upload')->deleteUploadFile($r2);

							if($result['status'] == 1)
							{
								Log::write('工单回复图片删除失败--'.$result['msg'],'INFO','',RUNTIME_PATH.'Logs/delFileLogs.txt');
							}
						}
					}
				}

//	              删除内部协作回复内容中的图片
				$inside_reply = M('team_reply')->where($where)->field('reply_content')->select();

				$inside_reply_result = M('team_reply')->where($where)->delete();

				if($inside_reply_result)
				{
					foreach($inside_reply as $ir)
					{
						$inside_reply_content = str_replace('?imageMogr2/auto-orient/thumbnail/240x135!/format/png/blur/1x0/quality/100|imageslim','',
							html_entity_decode($ir['reply_content']));

						$pattern = "/<[img|IMG].*?src=[\'|\"](.*?(?:[\.gif|\.jpg|\.png]))[\'|\"].*?[\/]?>/";

						preg_match_all($pattern,$inside_reply_content,$inside_reply_img);

						foreach($inside_reply_img[1] as $ir2)
						{
							$result = D('Upload')->deleteUploadFile($ir2);

							if($result['status'] == 1)
							{
								Log::write('工单内部协作回复图片删除失败--'.$result['msg'],'INFO','',RUNTIME_PATH.'Logs/delFileLogs.txt');
							}
						}
					}
				}

//                删除子工单
				$sub_ticket = M('sub_ticket')->where(['parent_id'=>$ticket_id])->field('ticket_id')->select();

				$subTicketIds = array_column($sub_ticket,'ticket_id');

				if($subTicketIds)
				{
					M('sub_ticket')->where(['ticket_id'=>['in',$subTicketIds]])->delete();

					M('sub_reply')->where(['ticket_id'=>['in',$subTicketIds]])->delete();

					M('sub_event')->where(['ticket_id'=>['in',$subTicketIds]])->delete();
				}

//                关联工单
				M('associate_ticket')->where(['company_id'=>$company_id,'associate_ticket_id|associated_ticket_id'=>$ticket_id])->delete();

//	              回复评论、抄送人、工单事件、超时记录、系统消息、满意度评价、工单区域、参与工单、重启记录、挂起记录、群聊、关注记录
				$table = ['reply_comment','cc_ticket','ticket_event','ticket_deadlines','system_message',
					'ticket_area','ticket_partake','ticket_restart','ticket_suspend','ticket_follow'];

				foreach($table as $t)
				{
					M($t)->where($where)->delete();
				}

				$data = ['status'=>2,'msg'=>L('DELETE_SUCCESS'),'url'=>U('index/index')];
			}
			else
			{
				$data = ['status'=>0,'msg'=>L('DELETE_FAILED')];
			}
		}

		return $data;
	}


	/*
    * 工单详情中的Ajax请求
    * @param int    $company_id     公司ID
    * @param int    $now_member_id  当前用户ID
    * @param int    $sms            短信通知开关
    * @param array  ticket          工单信息
    * @param string request         请求类型
    * @return array
    */
	public function ajaxRequestByDetail($company_id = 0,$now_member_id = 0,$ticket = [],$request = '')
	{
		if(isset($_POST['fast_type_id']) && I("post.fast_type_id"))// 获取快捷回复
		{
			return $this->getFastTypeInfo($company_id);
		}

		if(isset($_POST['source']))
		{
			$source = trim(I('post.source'));

			$value = isset($_POST['value']) ? I('post.value') : 0;

			if(!$ticket)
			{
				return ['status'=>0,'msg'=>L('TICKET_NOT')];
			}

//            设置工单状态
			if($source == 'setStatus')
			{
				return $this->updateTicketStatus($company_id,$ticket,$value,$ticket['end_status_id'],$now_member_id);
			}

//            设置优先级
			if($source == 'setPriority')
			{
				$priority_id = I('post.priority');

				$save = $this->save(['ticket_id'=>$ticket['ticket_id'],'priority'=>$priority_id]);

				if($save === false)
				{
					$result = ['errcode'=>1,'msg'=>L('UPDATE_FAILED')];
				}
				else
				{
//                   存储工单事件
					$eventData = ['event_type'=>'priority','ticket_id'=>$ticket['ticket_id'],'member_id'=>$now_member_id,'priority_id'=>$priority_id];

					D('TicketEvent')->saveEvent($eventData);

					$result = [
						'errcode'       => 0,
						'msg'           => L('UPDATE_SUCCESS'),
						'url'           => U('detail',['id'=>encrypt($ticket['ticket_id'],'TICKET')]),
						'ticket_no'     => $ticket['ticket_no'],
						'priority'      => $this->getPriority(I('post.priority')),
						'priorityColor' => $this->getPriorityColor(I('post.priority'))
					];
				}

				return $result;
			}

//            分配处理人
			if($source == 'assignProcessor')
			{
				$group_id  = isset($_POST['groupId']) ? I('post.groupId') : 0;

				$member_id = isset($_POST['userId']) ? I('post.userId') : 0;

				if($group_id <= 0)
				{
					$result = ['errcode'=>1,'msg'=>L('SELECT_EXCL_SECTOR')];
				}
				else if($member_id <= 0 && $member_id !== 'auto')
				{
					$result = ['errcode'=>1,'msg'=>L('SELECT_EXCL_SERVICE')];
				}
				else
				{
					if($member_id != 'auto')
					{
						if($member_id != $ticket['dispose_id'])
						{
							$update = ['ticket_id'=>$ticket['ticket_id'],'group_id'=>$group_id,'dispose_id'=>$member_id,'wait_assign_status'=>1,'assign_time'=>NOW_TIME,'look'=>1,'been'=>'updated'];

//                            没有接收人 - 设置接收人
							if(!$ticket['recipient_id'])
							{
								$update['recipient_id'] = $member_id;
							}

							$save = $this->save($update);

							if($save !== false)
							{
//                                添加参与者
								D('TicketPartake')->createPartake($company_id,$member_id,$ticket['ticket_id'],true);

//			                	  存储工单事件 —— 分配工单操作人
								$eventData = ['event_type'=>'assign_operate','ticket_id'=>$ticket['ticket_id'],'member_id'=>$now_member_id];

								D('TicketEvent')->saveEvent($eventData);

//                                存储工单事件 —— 接收人
								if(!$ticket['recipient_id'])
								{
									$eventData = ['event_type'=>'receive','ticket_id'=>$ticket['ticket_id'],'member_id'=>$member_id];

									D('TicketEvent')->saveEvent($eventData);
								}

//                                通知处理人及记录事件
								D('BuildMessage')->assignDisposeMessage($member_id,$ticket['ticket_id']);

								$result = ['errcode'=>0,'msg'=>L('UPDATE_SUCCESS'),'url'=>U('detail',['id'=>encrypt($ticket['ticket_id'],'TICKET')]),'ticket_no'=>$ticket['ticket_no']];
							}
							else
							{
								$result = ['errcode'=>1,'msg'=>L('UPDATE_FAILED')];
							}
						}
						else
						{
							$update = ['ticket_id'=>$ticket['ticket_id'],'group_id'=>$group_id,'wait_assign_status'=>1,'been'=>'updated'];

							$save = $this->save($update);

							if($save !== false)
							{
								$result = ['errcode'=>0,'msg'=>L('UPDATE_SUCCESS'),'url'=>U('detail',['id'=>encrypt($ticket['ticket_id'],'TICKET')]),'ticket_no'=>$ticket['ticket_no']];
							}
							else
							{
								$result = ['errcode'=>1,'msg'=>L('UPDATE_FAILED')];
							}
						}
					}
					else
					{
//                        获取自动分配的处理信息
						$defaultHandle = D('Group')->assignDisposeByGroupId($company_id,0,$group_id);

//                        当前有用户在线时，自动分配处理人
						if($defaultHandle['dispose_id'] > 0)
						{
							$update = ['ticket_id'=>$ticket['ticket_id'],'group_id'=>$group_id,'dispose_id'=>$defaultHandle['dispose_id'],'wait_assign_status'=>1,'assign_time'=>NOW_TIME,'been'=>'updated'];

//                            没有接收人 - 设置接收人
							if(!$ticket['recipient_id'])
							{
								$update['recipient_id'] = $defaultHandle['dispose_id'];
							}

							$save = $this->save($update);

							if($save === false)
							{
								$result = ['errcode'=>1,'msg'=>L('UPDATE_FAILED')];
							}
							else
							{
//                                如果自动分配的处理人不是当前处理人时，存储工单事件并通知处理人
								if($defaultHandle['dispose_id'] != $ticket['dispose_id'])
								{
//                                    添加参与者
									D('TicketPartake')->createPartake($company_id,$defaultHandle['dispose_id'],$ticket['ticket_id'],true);

//			                	      存储工单事件 —— 分配操作人记录事件
									$eventData = ['event_type'=>'assign_operate','ticket_id'=>$ticket['ticket_id'],'member_id'=>$now_member_id];

									D('TicketEvent')->saveEvent($eventData);

//                                    存储工单事件 —— 接收人
									if(!$ticket['recipient_id'])
									{
										$eventData = ['event_type'=>'receive','ticket_id'=>$ticket['ticket_id'],'member_id'=>$defaultHandle['dispose_id']];

										D('TicketEvent')->saveEvent($eventData);
									}

//                                    通知处理人及处理人事件
									D('BuildMessage')->assignDisposeMessage($defaultHandle['dispose_id'],$ticket['ticket_id']);
								}

								$result = ['errcode'=>0,'msg'=>L('UPDATE_SUCCESS'),'url'=>U('detail',['id'=>encrypt($ticket['ticket_id'],'TICKET')])];
							}
						}
						else//当前没有用户在线时，进入待分配状态
						{
							$update = ['ticket_id'=>$ticket['ticket_id'],'group_id'=>$group_id,'dispose_id'=>0,'wait_assign_status'=>0,'assign_time'=>0,'been'=>'updated'];

//                            通知部门管理员
							D('BuildMessage')->NotifyToGroupManager($group_id,$ticket['ticket_id']);

							$save = $this->save($update);

							if($save === false)
							{
								$result = ['errcode'=>1,'msg'=>L('UPDATE_FAILED')];
							}
							else
							{
//			                	  存储工单事件 —— 分配操作人记录事件
								$eventData = ['event_type'=>'assign_operate','ticket_id'=>$ticket['ticket_id'],'member_id'=>$now_member_id];

								D('TicketEvent')->saveEvent($eventData);

								$result = ['errcode'=>0,'msg'=>L('UPDATE_SUCCESS'),'url'=>U('detail',['id'=>encrypt($ticket['ticket_id'],'TICKET')])];
							}
						}
					}
				}

				return $result;
			}

//	          挂起工单
			if($source == 'suspend')
			{
				$suspendWhere = [
					'company_id'=>$company_id,
					'ticket_id'=>$ticket['ticket_id'],
					'start_time'=>['gt',0],
					'close_time'=>0
				];

				$suspend_id = M('ticket_suspend')->where($suspendWhere)->getField('id');

				if($suspend_id > 0)
				{
					$suspendUpdate = ['id'=>$suspend_id,'close_time'=>NOW_TIME];

					$suspendSave = M('ticket_suspend')->save($suspendUpdate);

					if($suspendSave)
					{
						$result = ['errcode'=>0,'msg'=>L('UPDATE_SUCCESS'),'isReload'=>1];
					}
					else
					{
						$result = ['errcode'=>1,'msg'=>L('UPDATE_FAILED')];
					}
				}
				else
				{
					$suspendData = [
						'company_id' => $company_id,
						'ticket_id' => $ticket['ticket_id'],
						'start_time' => NOW_TIME
					];

					$suspend_id = M('ticket_suspend')->add($suspendData);

					if($suspend_id)
					{
						$result = ['errcode'=>0,'msg'=>L('UPDATE_SUCCESS'),'isReload'=>1];
					}
					else
					{
						$result = ['errcode'=>1,'msg'=>L('UPDATE_FAILED')];
					}
				}

				return $result;
			}
		}

//        工单事件
		if($request == 'flow')
		{
			$eventList = D('TicketEvent')->getEventByTicketId(['a.ticket_id'=>decrypt(I('get.id'),'TICKET')]);

			return ['data'=>$eventList['events'],'pages'=>$eventList['pages']];
		}

//        通过关键词查询需要关联的工单
		if($request == 'associate')
		{
			$keyword = I('post.keyword');

			$where = ['company_id'=>$company_id,'audit_status'=>['in',[1,3]],'delete'=>2];

			if($keyword)
			{
				$where['title|ticket_no'] = ['like','%'.$keyword.'%'];

				$ticket = $this->where($where)->order('ticket_id asc')->field('ticket_id,ticket_no,title')->select();

				return ['data'=>$ticket];
			}
			else
			{
				return ['data'=>''];
			}
		}

//        修改记录
		if($request == 'modify_record')
		{
			$modify_record_id = I('post.modify_id',0);

			$where = ['company_id'=>$company_id,'ticket_id'=>$ticket['ticket_id']];

			if($modify_record_id) $where['id'] = $modify_record_id;

			$records = M('modify_record')->where($where)->order('modify_time asc')->select();

			foreach($records as &$v)
			{
				$v['modify_data'] = json_decode($v['modify_data'],true);

				$v['user_name'] = M('member')->where(['member_id'=>$v['member_id']])->getField('name');

				$v['modify_time'] = date('Y-m-d H:i',$v['modify_time']);

				foreach($v['modify_data'] as $k1=>&$v1)
				{
					if($k1 == 'title')
					{
						$v1['field_name'] = L('TICKET_TITLE');
					}
					else if($k1 == 'priority')
					{
						$v1['field_name'] = L('PRIORITY');

						$v1['modify_before'] = $this->getPriority($v1['modify_before']);

						$v1['modify_after'] = $this->getPriority($v1['modify_after']);
					}
					else if($k1 == 'mobile_discrete')
					{
						$v1['field_name'] = L('MOBILE');
					}
					else if($k1 == 'mail_discrete')
					{
						$v1['field_name'] = L('EMAIL');
					}
					else if($k1 == 'area')
					{
						$v1['field_name'] = L('AREA');
					}
					else
					{
						$k1 = explode('_',$k1);

						if($k1[0] == 'form' && $k1[1] > 0)
						{
							$v1['field_name'] = M('ticket_form')->where(['ticket_form_id'=>$k1[1]])->getField('ticket_form_description');
						}

						$v1['modify_before'] = getHtml($v1['modify_before']);

						$v1['modify_after'] = getHtml($v1['modify_after']);
					}
				}
			}

			return $records;
		}

		return ['data'=>''];
	}


	protected function getFastTypeInfo($company_id)
	{
		$fast_type_id = I('post.fast_type_id');

		$map['company_id'] = $company_id;

		$map['fast_type_id'] = $fast_type_id;

		$task = M('fastreply')->where($map)->select();

		$json = array();

		foreach($task as &$v)
		{
			$v['fast_content'] = htmlspecialchars_decode($v['fast_content']);

			$json[$v['fast_id']] = $v;
		}

		return $json;
	}


	/*
    * 储存上传文件
    * @param array  $files       上传文件数组
    * @param int    $ticket_id   工单ID
    * @param int    $reply_id    回复ID
    * @param int    $company_id  公司ID
    * @param string $source      文件来源 ticket 发布工单，reply回复工单,library知识库，faq
    * @param string $team_reply_id 内部协作回复ID
    * @param string $problem_id   问题ID
    */
	public function saveUploadFile($files = [],$ticket_id=0,$reply_id=0,$company_id=0,$source = 'ticket',$team_reply_id=0,$problem_id=0,$sub_ticket_id = 0,$sub_reply_id = 0)
	{
		if(!empty($files))
		{
			$file = [];

			foreach($files['links'] as $k=>$v)
			{
				$file[$k]['company_id'] = $company_id;

				$file[$k]['ticket_id']  = $ticket_id;

				$file[$k]['reply_id']   = $reply_id;

				$file[$k]['team_reply_id']   = $team_reply_id;

				$file[$k]['problem_id']   = $problem_id;

				$file[$k]['sub_ticket_id']   = $sub_ticket_id;

				$file[$k]['sub_reply_id']   = $sub_reply_id;

				$file[$k]['file_form']  = $source;

				$file[$k]['save_name']  = $files['saves'][$k];

				$file[$k]['file_name']  = $files['names'][$k];

				$file[$k]['file_size']  = $files['sizes'][$k];

				$file[$k]['file_type']  = $files['types'][$k];

				$file[$k]['file_link']  = $v;

				$file[$k]['create_time'] = NOW_TIME;
			}

			M('upload_file')->addAll($file);
		}
	}


	/*
	* 储存上传文件
	* @param array  $files       上传文件数组
	* @param array  $delFiles    删除文件数组
	* @param int    $ticket_id   工单ID
	* @param int    $reply_id    回复ID
	* @param int    $company_id  公司ID
	* @param string $source      文件来源 ticket 发布工单，reply回复工单,library知识库，faq
	* @param string $team_reply_id 内部协作回复ID
	* @param string $problem_id   问题ID
	*/
	public function updateUploadFile($files = [],$delFiles = [],$ticket_id=0,$reply_id=0,$company_id=0,$source='ticket',$team_reply_id=0,$problem_id=0,$sub_ticket_id=0)
	{
		if($source == 'ticket')
		{
			M('upload_file')->where(['file_form'=>'ticket','ticket_id'=>$ticket_id])->delete();
		}
		else
		{
			M('upload_file')->where(['file_form'=>$source,'problem_id'=>$problem_id])->delete();
		}

		if(!empty($files))
		{
			$file = [];

			foreach($files['links'] as $k=>$v)
			{
				$file[$k]['company_id']     = $company_id;

				$file[$k]['ticket_id']      = $ticket_id;

				$file[$k]['reply_id']       = $reply_id;

				$file[$k]['team_reply_id']  = $team_reply_id;

				$file[$k]['problem_id']     = $problem_id;

				$file[$k]['sub_ticket_id']  = $sub_ticket_id;

				$file[$k]['file_form']      = $source;

				$file[$k]['save_name']      = $files['saves'][$k];

				$file[$k]['file_name']      = $files['names'][$k];

				$file[$k]['file_size']      = $files['sizes'][$k];

				$file[$k]['file_type']      = $files['types'][$k];

				$file[$k]['file_link']      = $v;

				$file[$k]['create_time']    = NOW_TIME;
			}

			M('upload_file')->addAll($file);
		}

		if(!empty($delFiles))
		{
			foreach($delFiles as $v)
			{
				D('Upload')->deleteUploadFile($v);
			}
		}
	}


	/*
    * 删除上传图片
    * @param array  $files       上传文件数组
    * @param int    $ticket_id   工单ID
    * @param int    $reply_id    回复ID
    * @param int    $company_id  公司ID
    * @param string $from  文件来源 ticket 发布工单，reply回复工单
    */
	public function deleteUploadImage($delImages = [])
	{
		if(!empty($delImages))
		{
			foreach($delImages as $v)
			{
				D('Upload')->deleteUploadFile($v);
			}
		}
	}


	/*
    * 判断接收人和处理人
    * @param int  $ticket_id      工单ID
    * @param int  $reply_id       回复ID
    * @param int  $status_id      回复时提交的工单状态
    * @param int  $first_id       初始状态
    * @param int  $member_id      当前登录人ID
    * @return array $update       待更新的工单数据
    */
	public function JudgeAcceptance($ticket_id=0,$reply_id=0,$member_id=0)
	{
		$ticket = $this->where(['ticket_id'=>$ticket_id])->field('member_id,recipient_id,dispose_id,dispose_time')->find();

		$isRelease = $ticket['member_id'] == $member_id;//工单是否为当前登录人发布

//        工单没有接收人，工单不是当前登录人发布，首次回复的客服自动成为接收人和处理人
		if((!$ticket['recipient_id']) && (!$isRelease))
		{
			$update = ['recipient_id'=>$member_id,'dispose_id'=>$member_id,'dispose_time'=>NOW_TIME,'assign_time'=>NOW_TIME];

			M('Member')->where(['member_id'=>$member_id])->setInc('receive_num');

//            存储工单事件
			$eventData = ['event_type'=>'receive','ticket_id'=>$ticket_id,'member_id'=>$member_id,'reply_id'=>$reply_id];

			D('TicketEvent')->saveEvent($eventData);
		}

//        工单有接收人但没有处理人，工单不是当前登录客服发布，当前回复的客服自动成为处理人
		if($ticket['recipient_id'] && (!$ticket['dispose_id']) && (!$isRelease))
		{
			$update = ['dispose_id'=>$member_id];

			M('Member')->where(['member_id'=>$member_id])->setInc('receive_num');

			if(!$ticket['dispose_time']) $update['dispose_time'] = NOW_TIME;

			$update['assign_time'] = NOW_TIME;
		}

//        工单有接收人和处理人，当前回复人是处理人，没有处理时间
		if($ticket['recipient_id'] && $ticket['dispose_id'] == $member_id && !$ticket['dispose_time'])
		{
			$update['dispose_time'] = NOW_TIME;
		}

		$update['ticket_id'] = $ticket_id;//工单ID

		$update['update_time'] = NOW_TIME;//更新时间

		$update['been'] = 'updated';//被更新

		return $update;
	}


	/*
	* 获取工单数量
	* @param array  $param                  参数
	* @param int    $param['company_id']    公司ID
	* @param int    $param['member_id']     当前登录用户ID
	*/
	public function getTicketNumber($param = [])
	{
		if(!in_array($param['source'],self::$_action))
		{
			$count = 0;
		}
		else
		{
			$where = [];

//		      结束状态ID
			$end_status_id = M('ticket_status')->where(['company_id'=>$param['company_id'],'is_end'=>1])->getField('status_id');

//    	    查询条件 - 所有工单（不包含 - 已删除的工单、待审的工单）
			if($param['source'] == 'allTicket')
			{
				$where = ['company_id'=>$param['company_id'],'delete'=>2,'audit_status'=>['in',[1,3]],'end_time'=>['eq',0]];
			}

//    	    查询条件 - 我发布的（不包含 - 已删除的工单、待审的工单）
			if($param['source'] == 'myTicket')
			{
				$where = ['company_id'=>$param['company_id'],'delete'=>2,'audit_status'=>['in',[1,3]],'member_id'=>$param['member_id']];
			}

//    	    查询条件 - 我处理的（不包含 - 已删除的工单、已结束的工单、待审的工单）
			if($param['source'] == 'disposeTicket')
			{
				$where = ['company_id'=>$param['company_id'],'status_id'=>['neq',$end_status_id],'delete'=>2,'audit_status'=>['in',[1,3]],'dispose_id'=>$param['member_id']];
			}

//    	    查询条件 - 我所在组的（不包含 - 已删除的工单、已结束的工单、待审的工单）
			if($param['source'] == 'groupTicket')
			{
				$group_id = M('member')->where(['member_id'=>$param['member_id']])->getField('group_id');

				$where = ['company_id'=>$param['company_id'],'status_id'=>['neq',$end_status_id],'delete'=>2,'audit_status'=>['in',[1,3]],'group_id'=>['in',$group_id]];
			}

//          查询条件 - 抄送给我的（不包含 - 已删除的工单、已结束的工单、待审的工单）
			if($param['source'] == 'ccTicket')
			{
				$ticketIds = D('CcTicket')->where(['member_id'=>$param['member_id']])->field('ticket_id')->select();

				$ticket_ids = $ticketIds ? array_column($ticketIds,'ticket_id') : [-1];

				$where = ['company_id'=>$param['company_id'],'status_id'=>['neq',$end_status_id],'delete'=>2,'audit_status'=>['in',[1,3]],'ticket_id'=>['in',$ticket_ids]];
			}

//		    查询结果 - 已超时的（不包含 - 已删除的工单、已结束的工单、待审的工单）
			if($param['source'] == 'timeoutTicket')
			{
				$where = ['company_id'=>$param['company_id'],'status_id'=>['neq',$end_status_id],'delete'=>2,'audit_status'=>['in',[1,3]],'dispose_id'=>$param['member_id']];

				$tickets = $this->where($where)->field('ticket_id,create_time,end_time')->select();

//                模板组件 - 完成期限
				$deadlines  = M('ticket_deadlines')->where(['company_id'=>$param['company_id']])->select();

				$deadTimes = [];

				foreach($deadlines as $d)
				{
					$deadTimes[$d['ticket_id']] = $d;
				}

				$count = 0;

				foreach($tickets as $v)
				{
//                    模板组件超时工单
					if($deadTimes[$v['ticket_id']])
					{
						if(checkTicketIsTimeoutByCron($deadTimes[$v['ticket_id']]['deadtime'],$v['end_time']) == true)
						{
							$count++;
						}
					}
//                    全局配置超时工单
					else
					{
						if(checkTicketIsTimeoutByGlobal($v['ticket_id'],$v['create_time'],$v['end_time']))
						{
							$count++;
						}
					}
				}

				return $count;
			}

//    	    查询结果 - 待回复的工单（不包含 - 已删除的工单、已结束的工单、待审的工单）
			if($param['source'] == 'waitReplyTicket')
			{
				$param['field'] = 'ticket_id';

				$result = $this->getWaitReplyTicketData($param);

				return $result['number'];
			}

//		    查询结果 - 待审核的（不包含 - 已删除的工单）
			if($param['source'] == 'waitAuditTicket')
			{
				$where = ['company_id'=>$param['company_id'],'delete'=>2,'audit_status'=>['in',[2,4,5,6]]];

//		        所有处于待审状态和被驳回状态的工单
				$tickets = M('ticket')->where($where)->field('ticket_id,member_id')->select();

				foreach($tickets as $k=>$v)
				{
//	    	            1. 获取当前登录人员针对工单的审核节点信息
					$progress_map = ['ticket_id'=>$v['ticket_id'],'member_id'=>$param['member_id'],'audit_status'=>10];

					$progress = M('audit_progress')->where($progress_map)->order('audit_level asc')->field('id,audit_level,audit_type')->find();

//			            2. 若审核节点所处的审核类型为 会审
					$nowProgress = [];

					if($progress['audit_type'] == 30)
					{
//                          3. 查询本层级中是否存在未审核的上一个节点
						$now_progress_map = ['ticket_id'=>$v['ticket_id'],'audit_status'=>10,'audit_level'=>$progress['audit_level'],'id'=>['lt',$progress['id']]];

						$nowProgress = M('audit_progress')->where($now_progress_map)->field('id,member_id')->find();
					}

					if(!$nowProgress)
					{
//	    	                4. 查询是否存在上一层级未审核的节点
						$upper_reviewer_map = ['ticket_id'=>$v['ticket_id'],'audit_status'=>10,'audit_level' => ['lt',$progress['audit_level']]];

//				            上一层级未审核的节点的审核人ID
						$upper_reviewer_id = M('audit_progress')->where($upper_reviewer_map)->getField('member_id');

//				            不存在或者存在并且节点审核人 == 当前登录人员时有权限
						$audit_auth = !$upper_reviewer_id || $upper_reviewer_id == $param['member_id'];
					}
					else
					{
//				            当审核层级类型为会审时，本层级存在未审核的上一节点时，当前人员没有审核权限
						$audit_auth = false;
					}

					if(!$audit_auth) unset($tickets[$k]);
				}

				return count($tickets);

			}

			$count = $this->where($where)->count('ticket_id');
		}

		return $count;
	}


	/*
	* 获取待回复工单数据
	* @param array  $param                  参数
	* @param int    $param['company_id']    公司ID
	* @param int    $param['member_id']     当前登录用户ID
	* @param string $param['field']         工单查询字段,
	* @param string $param['page']          是否分页, 1 - 是 0 -否
	* @param array  $filter                 筛选条件
	*/
	public function getWaitReplyTicketData($param,$filter = [])
	{
//		  结束状态ID
		$end_status_id = M('ticket_status')->where(['company_id'=>$param['company_id'],'is_end'=>1])->getField('status_id');

		$where1 = ['company_id'=>$param['company_id'],'status_id'=>['neq',$end_status_id],'delete'=>2,'audit_status'=>['in',[1,3]]];

//       当前用户发布或处理的所有工单
		$where1 = array_merge($where1,['member_id|dispose_id'=>$param['member_id']]);

		if($filter)
		{
			$where1 = array_merge($where1,$filter);
		}

		$count = 0;

		$show = '';//分页html字符串

		if(isset($param['page']) && $param['page'] == 1)
		{
			$listRow = $param['listRow'] ?: 100;

			$count = $this->where($where1)->field($param['field'])->count('ticket_id');

			$Page = new Page($count, $listRow);

			$tickets = $this->where($where1)->limit($Page->firstRow, $Page->listRows)->order('create_time desc')->field($param['field'])->fetchAll();

			$Page->setConfig('prev',"<i class='iconfont icon-zuo'></i>");

			$Page->setConfig('next',"<i class='iconfont icon-you'></i>");

			$show = $Page->show();
		}
		else
		{
			$tickets = $this->where($where1)->field($param['field'])->select();
		}

		$number = 0;

		foreach($tickets as $k=>&$v)
		{
			$where2 = ['company_id'=>$param['company_id'],'ticket_id'=>$v['ticket_id']];

//			工单最后一次回复的回复人ID
			$reply_member_id = M('ticket_reply')->where($where2)->order('reply_id desc')->getField('member_id');

//		    获取数量
			if($reply_member_id && $reply_member_id != $param['member_id'])
			{
				$number += 1;
			}
			else
			{
				unset($tickets[$k]);
			}
		}

		return ['number'=>$number,'tickets'=>$tickets,'page'=>$show,'total'=>$count,'exportWhere'=>$where1];
	}


	/*
    * 更新工单显示方式
    * @param string $view_source 显示方式 minimalist 极简，list 列表，board 面板
    */
	public function updateSourceView($view_source = '',$member_id = 0)
	{
		cookie('ticket_view_source_'.session('company_id').'_'.$member_id,$view_source,3600 * 24 * 365);
	}


	/*
	* 更新工单状态
	* @param int    $company_id     公司ID
	* @param array  $ticket         工单信息
	* @param int    $status_id      新状态ID
	* @param int    $end_status_id  结束状态ID
	* @param int    $now_member_id  当前登录用户ID
	* @param int    $type           用户类型 1 用户
	* return array
	*/
	public function updateTicketStatus($company_id,$ticket,$status_id,$end_status_id,$now_member_id,$type = 1)
	{
		$ticketConfig = M('ticket_config')->where(['company_id'=>$company_id])->field('handler_closed,publisher_closed,status_go_back')->find();

//	      当前状态信息
		$now_status = M('ticket_status')->where(['status_id'=>$ticket['status_id']])->find();

//	      新状态信息
		$new_status = M('ticket_status')->where(['status_id'=>$status_id,'closed'=>1])->find();

//        检查状态是否是合法状态
		if(!D('TicketStatus')->isExistedByField(['company_id'=>$company_id,'status_id'=>$status_id]))
		{
			return ['errcode'=>1,'msg'=>L('STATUS_NOT')];
		}
		else if($ticketConfig['status_go_back'] == 20 && $new_status['sort'] < $now_status['sort'])
		{
			return ['errcode'=>1,'msg'=>L('NO_OPEN_STATUS_BACK')];
		}
		else if($now_status['status_id'] == $new_status['status_id'] && $status_id != $end_status_id)
		{
			return ['errcode'=>0,'msg'=>L('UPDATE_SUCCESS'),'url'=>U('detail',['id'=>encrypt($ticket['ticket_id'],'TICKET')])];
		}
		else
		{
			$data = ['status_id'=>$status_id,'ticket_id'=>$ticket['ticket_id'],'been'=>'updated','update_time'=>NOW_TIME];

			$now_audit_status = $this->where(['ticket_id'=>$ticket['ticket_id']])->getField('audit_status');

			if(in_array($now_audit_status,[2,4,5,6]))
			{
				return ['errcode'=>1,'msg'=>'更新失败，工单正在审核中'];
			}

//             状态为结束状态时
			if($data['status_id'] == $end_status_id)
			{
//	              检查当前登录人是否拥有关闭工单权限，工单发布人不是工单处理人时
				if($ticket['member_id'] != $ticket['dispose_id'])
				{
//                    当前登录人是处理人，但无关闭工单权限
					if($ticket['dispose_id'] == $now_member_id && $ticketConfig['handler_closed'] != 10)
					{
						return ['errcode'=>1,'msg'=>L('NO_END_TICKET_AUTH1')];
					}

//                    当前登录人是发布人，但无关闭工单权限
					if($ticket['member_id'] == $now_member_id && $ticketConfig['publisher_closed'] != 10)
					{
						return ['errcode'=>1,'msg'=>L('NO_END_TICKET_AUTH2')];
					}
				}

//	              是否存在未完成的子工单
				$hasSubTicket = M('sub_ticket')->where(['parent_id'=>$ticket['ticket_id'],'status_id'=>10])->getField('ticket_id');

				if($hasSubTicket)
				{
					return ['errcode'=>1,'msg'=>L('HAS_SUB_TICKET')];
				}

				$data['end_time'] = NOW_TIME;
			}

			if($type == 1)
			{
//                设置接收人
				if(!$ticket['recipient_id'])
				{
					$data['recipient_id'] = $now_member_id;

//                    存储工单事件
					$eventData = ['event_type'=>'receive','ticket_id'=>$ticket['ticket_id'],'member_id'=>$now_member_id];

					D('TicketEvent')->saveEvent($eventData);
				}

//                设置处理人
				if(!$ticket['dispose_id'])
				{
					$data['dispose_id'] = $now_member_id;

//					$data['dispose_time'] = $data['assign_time'] = NOW_TIME;
					$data['assign_time'] = NOW_TIME;

//                    添加参与者
					D('TicketPartake')->createPartake($company_id,$data['dispose_id'],$ticket['ticket_id'],true);
				}
			}

//            有处理人但没有开始处理时，改变状态记录处理时间
//			if($ticket['dispose_id'] > 0 && !$ticket['dispose_time'])
//			{
//				$data['dispose_time'] = NOW_TIME;
//			}

			session('trigger_status_id',$ticket['status_id']);

			$isEnd = 'no';

			$update_status = $this->save($data);

			if($update_status !== false)
			{
				$satisfy_id =  M('ticket_satisfy')->where(['ticket_id'=>$ticket['ticket_id']])->getField('id');

				if($data['status_id'] == $end_status_id && (!$satisfy_id))
				{
					$publish = M('member')->where(['member_id'=>$ticket['member_id']])->field('member_id,name,email')->find();

					if($publish['email'])
					{
						D('TicketSatisfy')->createSatisfyEmail($company_id,$publish,$ticket);
					}

					if($ticket['member_id'] == $now_member_id) $isEnd = 'yes';
				}

//                查询旧状态是否存在停止计时记录
				$stopWhere = [
					'company_id'    => $company_id,
					'ticket_id'     => $ticket['ticket_id'],
					'status_id'     => $now_status['status_id'],
					'start_time'    => ['gt',0],
					'close_time'    => 0
				];

				$stop_id = M('stop_timing')->where($stopWhere)->getField('id');

				if($stop_id > 0)
				{
					M('stop_timing')->save(['id'=>$stop_id,'close_time'=>NOW_TIME]);
				}

//                如果新状态需要停止计时 - 添加停止计时记录
				if($new_status['is_stop_timing'] == 10)
				{
					$stopData = [
						'company_id'    => $company_id,
						'ticket_id'     => $ticket['ticket_id'],
						'status_id'     => $new_status['status_id'],
						'start_time'    => NOW_TIME
					];

					M('stop_timing')->add($stopData);
				}

//				  状态改变/结束工单 — 通知发布人
				D('BuildMessage')->buildMessage($ticket['ticket_id'],[],[],$ticket['status_id'],$now_member_id,'update_status');

//                存储工单事件
				if($data['status_id'] != $ticket['status_id'])
				{
					$eventData = ['event_type'=>'status','ticket_id'=>$ticket['ticket_id'],'member_id'=>$now_member_id,'status_id'=>$data['status_id']];

					D('TicketEvent')->saveEvent($eventData);
				}

				$refresh = 0;

				if($data['dispose_id'] || $data['recipient_id'] || $type == 2) $refresh = 1;

				$result = [
					'errcode'   => 0,
					'msg'       => L('UPDATE_SUCCESS'),
					'ticket_no' => $ticket['ticket_no'],
					'url'       => U('detail',['id'=>encrypt($ticket['ticket_id'],'TICKET')]),
					'is_end'    => $isEnd,
					'id'        => encrypt($ticket['ticket_id'],'TICKET'),
					'refresh'   => $refresh,
				];
			}
			else
			{
				$result = ['errcode'=>1,'msg'=>L('UPDATE_FAILED')];
			}

			return $result;
		}
	}


	/*
	* 催单
	* @param int    $company_id     公司ID
	* @param int    $now_member_id  当前登录用户ID
	* @param string $source  催单来源：user - 用户
	* return array
	*/
	public function urgeTicket($company_id = 0,$now_member_id = 0,$source = 'user')
	{
		$urgeData = I('post.urge');

		if(empty($urgeData['members']))
		{
			return ['errcode'=>1,'msg'=>L('SELECT_URGE_PERSON')];
		}
		else if(empty($urgeData['content']))
		{
			return ['errcode'=>1,'msg'=>L('ENTER_URGE_CONTENT')];
		}
		else
		{
			$urgeData['content'] = str_replace(['{{ticket_title}}','{{ticket_no}}'],[$urgeData['title'],$urgeData['ticket_no']],getHtml($urgeData['content']));

			$members = M('member')->where(['company_id'=>$company_id,'member_id'=>['in',$urgeData['members']]])->field('member_id,type,name,email,mobile')->select();

			foreach($members as $v)
			{
//                系统
				D('BuildMessage')->buildSystemMessage('urge_ticket',$v['type'],$v['member_id'],$urgeData['ticket_id'],'',0,
					$urgeData['content'],$now_member_id);
			}

//            储存事件
			$eventData = ['event_type'=>'urge','ticket_id'=>$urgeData['ticket_id'],'member_id'=>$now_member_id];

			D('TicketEvent')->saveEvent($eventData);

			if($source == 'user')
			{
//              新增内部协作记录
				$teamReplyData = ['company_id'=>$company_id,'member_id'=>$now_member_id,'ticket_id'=>$urgeData['ticket_id'],
				                  'reply_content'=>L('URGE_CONTENT').$urgeData['content'],'reply_ip'=>get_client_ip(),'reply_time'=>NOW_TIME];

				M('team_reply')->add($teamReplyData);
			}
			else
			{
//              新增工单回复记录
				$replyData = ['company_id'=>$company_id,'member_id'=>$now_member_id,'ticket_id'=>$urgeData['ticket_id'],
				              'reply_content'=>L('URGE_CONTENT').$urgeData['content'],'reply_ip'=>get_client_ip(),'reply_time'=>NOW_TIME];

				M('ticket_reply')->add($replyData);
			}

			return ['errcode'=>0,'msg'=>L('SEND_SUCCESS')];
		}
	}


	/*
	* 评论工单回复
	* @param int    $company_id     公司ID
	* @param int    $now_member_id  当前登录用户ID
	* return array
	*/
	public function commentReply($company_id = 0,$now_member_id = 0)
	{
		$comment = $this->checkComment($company_id,$now_member_id);

		if($comment['errcode'] == 1) return $comment;

		$reply_member_id = $comment['reply_member_id'];

		unset($comment['reply_member_id']);

		if(M('reply_comment')->add($comment))
		{
			if($now_member_id !== $reply_member_id)
			{
//			      通知
				D('BuildMessage')->buildMessage($comment['ticket_id'],[],[],0,$reply_member_id,'comment');
			}

//            储存事件
			$eventData = ['event_type'=>'comment','ticket_id'=>$comment['ticket_id'],'member_id'=>$now_member_id];

			D('TicketEvent')->saveEvent($eventData);

			$result = ['errcode'=>0,'msg'=>L('COMMENT_SUCCESS')];
		}
		else
		{
			$result = ['errcode'=>1,'msg'=>L('COMMENT_FAILED')];
		}

		return $result;
	}


	private function checkComment($company_id = 0,$now_member_id = 0)
	{
		$data = checkFields(I('post.comment'),$this->commentFields);

		$where = ['company_id'=>$company_id,'reply_id'=>$data['reply_id'],'ticket_id'=>decrypt($data['ticket_id'],'TICKET')];

		$reply_member_id = 0;

		if($data['comment_type'] == 'reply' && !$reply_member_id = M('ticket_reply')->where($where)->getField('member_id'))
		{
			return ['errcode'=>1,'msg'=>L('TICKET_REPLY_NOT')];
		}
		elseif($data['comment_type'] == 'inside' && !$reply_member_id = M('team_reply')->where($where)->getField('member_id'))
		{
			return ['errcode'=>1,'msg'=>L('INSIDE_REPLY_NOT')];
		}
		elseif(empty(trim($data['content'])))
		{
			return ['errcode'=>1,'msg'=>L('ENTER_COMMENT_CONTENT')];
		}
		else
		{
			$data['company_id'] = $company_id;

			$data['member_id'] = $now_member_id;

			$data['ticket_id'] = decrypt($data['ticket_id'],'TICKET');

			$data['create_time'] = NOW_TIME;

			$data['reply_member_id'] = $reply_member_id;

			$data['content'] = trim($data['content']);
		}

		return $data;
	}


	/*
	* 关联工单
	* @param int    $associate      关联数据
	* @param int    $company_id     公司ID
	* @param int    $now_member_id  当前登录用户ID
	* return array
	*/
	public function associateTicket($associate,$company_id,$now_member_id)
	{
//        $associated_ticket_id 待关联的工单ID
//        $ticket_id 主动关联的工单ID

		if(!$associate['associate_id'])
		{
			$result = ['errcode'=>1,'msg'=>L('ASSOCIATE_NOTE')];
		}
		else if(!$ticket_id = $this->where(['company_id'=>$company_id,'ticket_id'=>$associate['ticket_id']])->getField('ticket_id'))
		{
			$result = ['errcode'=>1,'msg'=>L('TICKET_NOT')];
		}
		else if(!$associated_ticket_id = $this->where(['company_id'=>$company_id,'ticket_id'=>$associate['associate_id']])->getField('ticket_id'))
		{
			$result = ['errcode'=>1,'msg'=>L('TICKET_NOT')];
		}
		else if($associated_ticket_id == $ticket_id)
		{
			$result = ['errcode'=>1,'msg'=>L('ASSOCIATE_NOTE1')];
		}
		else if(M('associate_ticket')->where(['company_id'=>$company_id,'associate_ticket_id'=>$associated_ticket_id,'associated_ticket_id'=>$ticket_id])->getField('id'))
		{
			$result = ['errcode'=>1,'msg'=>L('ASSOCIATE_NOTE2')];
		}
		else
		{
			$associateData = ['company_id'=>$company_id,'associate_ticket_id'=>$ticket_id,'associated_ticket_id'=>$associated_ticket_id,'create_time'=>NOW_TIME];

			if(M('associate_ticket')->add($associateData) > 0)
			{
//                存储工单事件
				$eventData = ['event_type'=>'associate','ticket_id'=>$associate['ticket_id'],'member_id'=>$now_member_id,'associate_id'=>$associate['associate_id']];

				D('TicketEvent')->saveEvent($eventData);

				$result = ['errcode'=>0,'msg'=>L('UPDATE_SUCCESS')];
			}
			else
			{
				$result = ['errcode'=>1,'msg'=>L('UPDATE_FAILED')];
			}
		}

		return $result;
	}


	/*
	* 取消关联工单
	* @param int    $associate      关联数据
	* @param int    $company_id     公司ID
	* @param int    $now_member_id  当前登录用户ID
	* return array
	*/
	public function cancelAssociateTicket($associate = [],$company_id = 0,$now_member_id = 0)
	{
		$result =  M('associate_ticket')->where(
			[
				[
					[
						'associate_ticket_id'=>$associate['associate_id'],
						'associated_ticket_id'=>$associate['ticket_id']
					],
					[
						'associate_ticket_id'=>$associate['ticket_id'],
						'associated_ticket_id'=>$associate['associate_id']
					],
					'_logic'=>'or'
				],
				'company_id'=>$company_id
			]
		)->delete();

		if($result > 0)
		{
//            储存工单事件
			$eventData = ['event_type'=>'cancel_associate','ticket_id'=>$associate['ticket_id'],'member_id'=>$now_member_id,'cancel_associate_id'=>$associate['associate_id']];

			D('TicketEvent')->saveEvent($eventData);

			$data = ['errcode'=>0,'msg'=>L('UPDATE_SUCCESS')];
		}
		else
		{
			$data = ['errcode'=>0,'msg'=>L('UPDATE_FAILED')];
		}

		return $data;
	}


	/*
	* 获取区域
	* return array
	*/
	public function getAreaData()
	{
		$data = I('post.');

		$lang_name = $this->getNameByLang('name');

		if($data['type'] == 'province')
		{
			$where = ['country_code'=>$data['country_id']];

			$province = M('province')->where($where)->field("*,".$lang_name)->select();

			return ['code'=>0,'data'=>$province];
		}
		else if($data['type'] == 'city')
		{
			$where = ['country_code'=>$data['country_id'],'province_code'=>$data['province_id']];

			$city = M('city')->where($where)->field("*,".$lang_name)->select();

			return ['code'=>0,'data'=>$city];
		}
		else
		{
			return ['code'=>1,'data'=>[]];
		}
	}


	/*
    * 审核完成后或者无需审核时执行的动作
    * @param int    $company_id    公司ID
    * @param int    $ticket_id     工单ID
    * @param int    $template_id   工单模板ID
    * @param int    $member_id     工单发布人ID
    * @param array  $processData   工单处理人数据
    * @param array  $ccData        工单抄送人数据
    * @param array  $status        工单审核状态，1 无需审核，2 发布工单审核通过，5 结束工单审核通过
    */
	public function auditAfterAction($company_id,$ticket_id,$template_id,$member_id,$processData = [],$ccData = [],$status = 1)
	{
		$redis = new Redis();

//    	  发布工单的审核通过或者无需审核时
		if(in_array($status,[1,2]))
		{
			$processData = $processData ?: $redis->get("process_".$ticket_id.'_data');

			$ccData = $ccData ?: $redis->get("cc_".$ticket_id.'_data');

			if(!$processData['dispose_id'])
			{
//                获取自动轮流分配处理信息
				$processData = D('Group')->assignDisposeByGroupId($company_id,$template_id);
			}
			else
			{
				$processData['assign_time'] = NOW_TIME;
			}

			$processData['ticket_id'] = $ticket_id;

			$this->save($processData);

//            没有处理人，通知部门管理员
			if($processData['dispose_id'] <= 0)
			{
				D('BuildMessage')->NotifyToGroupManager($processData['group_id'],$ticket_id);
			}
			else
			{
//               添加参与者
				D('TicketPartake')->createPartake($company_id,$processData['dispose_id'],$ticket_id);
			}

			if($processData['recipient_id'])
			{
//	    	      工单事件
				$eventData = ['event_type'=>'receive','ticket_id'=>$ticket_id,'member_id'=>$processData['recipient_id']];

				D('TicketEvent')->saveEvent($eventData);
			}

//	          通知处理人
//		    D('BuildMessage')->assignDisposeMessage($processData['dispose_id'],$ticket_id,'create');

//            添加抄送人
			if(!empty($ccData))
			{
				$cc = ['company_id'=>$company_id,'ticket_id'=>$ticket_id];

//               工单发布人和处理人不能成为抄送人
				foreach($ccData as $k=>$v)
				{
					if(!in_array($v,[$member_id,$processData['dispose_id']]))
					{
						$cc['member_id'] = $v;

//                    添加参与者
						D('TicketPartake')->createPartake($company_id,$v,$ticket_id,true);

						M('cc_ticket')->add($cc);
					}
					else
					{
						unset($ccData[$k]);
					}
				}

				if(!empty($ccData))
				{
//                    通知抄送人
					D('BuildMessage')->CcMessageByCreate($company_id,$ticket_id,$ccData);
				}
			}

			$redis->delete(["process_".$ticket_id."_data","cc_".$ticket_id."_data"]);

//            通知发布人、处理人
			D('BuildMessage')->createTicketMessage($ticket_id);
		}

//    	  非发布工单的审核通过，目前仅用于结束工单的审核通过
		if($status == 5)
		{
			$end_status_id = D('TicketStatus')->where(['company_id'=>$company_id,'is_end'=>1])->getField('status_id');

			$update = $this->where(['ticket_id'=>$ticket_id])->setField(['status_id'=>$end_status_id,'end_time'=>NOW_TIME]);

			if($update)
			{
				session('trigger_status_id',$end_status_id);

				$ticket = $this->where(['ticket_id'=>$ticket_id])->field('ticket_id,ticket_no,title,member_id')->find();

//			    判断是否进行过满意度评价
				$satisfy_id =  M('ticket_satisfy')->where(['ticket_id'=>$ticket_id])->getField('id');

				if(!$satisfy_id)
				{
					$publish = M('member')->where(['member_id'=>$ticket['member_id']])->field('member_id,name,email')->find();

					if($publish['email'])
					{
						D('TicketSatisfy')->createSatisfyEmail($company_id,$publish,$ticket);
					}
				}

//                查询是否存在停止计时记录
				$stopWhere = [
					'company_id'    => $company_id,
					'ticket_id'     => $ticket['ticket_id'],
					'start_time'    => ['gt',0],
					'close_time'    => 0
				];

				$stop_id = M('stop_timing')->where($stopWhere)->getField('id');

				if($stop_id > 0)
				{
					M('stop_timing')->save(['id'=>$stop_id,'close_time'=>NOW_TIME]);
				}

//				  状态改变 — 通知发布人
				D('BuildMessage')->buildMessage($ticket_id,[],[],$ticket['status_id'],$ticket['member_id'],'update_status');

//                获取审核提交人，存储工单事件
				$event_member_id = $redis->get('end_ticket_'.$ticket_id.'_apply_member');

				$eventData = ['event_type'=>'status','ticket_id'=>$ticket_id,'member_id'=>$event_member_id,'status_id'=>$end_status_id];

				D('TicketEvent')->saveEvent($eventData);

				$redis->delete('end_ticket_'.$ticket_id.'_apply_member');
			}
		}
	}


	/*
	* 计算工单耗时
	* @param int $company_id   公司ID
	* @param int $ticket_id    工单ID
	* @param int $create_time  工单创建时间
	* @param int $end_time     工单结束时间
	* @return array
	*/
	public function getTicketTakeTime($company_id,$ticket_id,$create_time,$end_time)
	{
//	      查询工单停止计时记录
		$stopTiming = M('stop_timing')->where(['company_id'=>$company_id,'ticket_id'=>$ticket_id])->select();

		$stop_timing_sec = 0;

		foreach($stopTiming as $st)
		{
			$close_time = $st['close_time'] ?: NOW_TIME;

			$stop_timing_sec += $close_time - $st['start_time'];
		}

		$taking_sec = NOW_TIME - $create_time - $stop_timing_sec;

//	      工单已耗时
		$data['taking'] = getTakingTimeBySec($taking_sec);

//	      工单总耗时
		if($end_time)
		{
			$taking_sec = $end_time - $create_time;

			if($stop_timing_sec)
			{
				$taking_sec = $taking_sec - $stop_timing_sec;
			}

			$data['ztaking'] = getTakingTimeBySec($taking_sec);
		}
		else
		{
			$data['ztaking'] = '';
		}

		return $data;
	}


	/*
	* 移动端首页获取工单权限及数量
	* @param int $company_id   公司ID
	* @param int $member_id    用户ID
	* @param int $role_id      用户角色ID
	* @param int $member_type  登录人类型，用户
	* @return array
	*/
	public function getTicketAuthByMobile($company_id,$member_id,$role_id,$member_type = 1)
	{
		$auth_menu = [
			['source' => 'allTicket',       'action' => 'ticket/allTicket',         'icon' => 'icon-all-ticket',    'name' => L('ALL_TICKET')],
			['source' => 'waitReplyTicket', 'action' => 'ticket/waitReplyTicket',   'icon' => 'icon-reply-ticket',  'name' => L('WAIT_TICKET')],
			['source' => 'myTicket',        'action' => 'ticket/myTicket',          'icon' => 'icon-release-ticket','name' => L('MY_TICKET')],
			['source' => 'disposeTicket',   'action' => 'ticket/disposeTicket',     'icon' => 'icon-handle-ticket', 'name' => L('DEAL_TICKET')],
			['source' => 'groupTicket',     'action' => 'ticket/groupTicket',       'icon' => 'icon-group-ticket',  'name' => L('GROUP_TICKET')],
			['source' => 'waitAuditTicket', 'action' => 'ticket/waitAuditTicket',   'icon' => 'icon-no-audit',      'name' => L('WAIT_AUDIT_TICKET')],
			['source' => 'ccTicket',        'action' => 'ticket/ccTicket',          'icon' => 'icon-cc-ticket',     'name' => L('CC_TICKET')],
			['source' => 'timeoutTicket',   'action' => 'ticket/timeoutTicket',     'icon' => 'icon-date',          'name' => L('TIMEOUT_TICKET')],
		];

		$ticket = [];

		$param = ['company_id'=>$company_id,'member_id'=>$member_id];

		foreach($auth_menu as $k=>$m)
		{
			$auth = D('RoleAuth')->checkRoleAuthByMenu($company_id,$m['action'],$role_id);

			if($auth)
			{
				$ticket[$k]['auth'] = $auth;

				$ticket[$k]['action'] = U($m['action']);

				$ticket[$k]['icon'] = $m['icon'];

				$ticket[$k]['name']   = $m['name'];

				$param['source'] = $m['source'];

				$ticket[$k]['number'] = $this->getTicketNumber($param);
			}
		}

		return $ticket;
	}


	/*
	* 导入工单
	* @param int    $company_id        公司ID
	* @param int    $member_id         用户ID
	* @param int    $first_status_id   初始状态ID
	* @return array
	*/
	public function importTicket($company_id,$member_id,$first_status_id)
	{
		//文件上传设置
		$config = [
			'maxSize'    =>    20 * 1024 * 1024,    // 设置附件上传大小
			'rootPath'   =>    './Attachs/',        // 文件上传的保存路径
			'savePath'   =>    'excel/',            // 文件上传的保存路径
			'saveName'   =>    ['uniqid',''],
			'exts'       =>    ['xlsx', 'xls'],     // 设置附件上传类型
			'autoSub'    =>    true,
			'subName'    =>    ['date','Ymd'],
		];

		$template_id = I('post.template_id');

		if(!$template_id)
		{
			return ['status'=>0,'msg'=>L('SELECT_TEMP')];
		}
		else
		{
			$Upload = new Upload($config);

			$info = $Upload->uploadOne($_FILES['excel']);

			if(!$info)
			{
				return ['status'=>0,'msg'=>$Upload->getError()];
			}
			else
			{
				$file = $config['rootPath'].$info['savepath'].$info['savename'];

//		        检查Excel文件是否存在
				if(!file_exists($file))
				{
					return ['status'=>0,'msg'=>L('FILE_DOES_NOT_EXIST')];
				}
				else
				{
					import('Org.Util.PHPExcel');

					try
					{
//			              加载excel文件
						$PHPExcel = PHPExcel_IOFactory::load($file);

//			    	      第2个工作薄
						$sheet = $PHPExcel->getSheet(1);

//			              获取Excel行数
						$rows = $sheet->getHighestRow();

//		                  获取已有数据的列数
						$columnNumber = PHPExcel_Cell::columnIndexFromString($sheet->getHighestDataColumn());

//	                      根据列数获取已使用的列头数组
						$ExcelAssistant = new ExcelAssistant();

						$columns = $ExcelAssistant->GetExcelTit($columnNumber);

//		                  获取模板表单
						$ticketForm = M('ticket_form')->where(['company_id'=>$company_id,'ticket_model_id'=>$template_id])
							->field('ticket_form_name,ticket_form_description,ticket_form_type,ticket_form_option,is_required')->select();

						$ticketIndex = 0;

						$formName = [];

//                        第一行是表头，这里从第一行开始取读取数据，循环行数，获取数据
						for ($rowIndex = 1;$rowIndex<=$rows;$rowIndex++)
						{
							$formData = [];

//							判断行是否为空白
							$judgeRowEmpty = [];

							foreach($columns as $colIndex)
							{
//				                  获取单元格内容
								$value = $sheet->getCell($colIndex . $rowIndex)->getValue();

//				                  富文本转换字符串
								if ($value instanceof PHPExcel_RichText)
								{
									$value = $value->__toString();
								}

								if($value) $judgeRowEmpty[] = $value;

//				                  第一行表头数据，整合字段名称
								if($rowIndex == 1)
								{
									if($colIndex == 'A')
									{
										$formName[$colIndex] = 'title';
									}
									else
									{
//										  自定义表单字段名称
										foreach($ticketForm as $tf)
										{
											if($tf['ticket_form_description'] == $value)
											{
												$formName[$colIndex]['type'] = $tf['ticket_form_type'];

												$formName[$colIndex]['name'] = $tf['ticket_form_name'];

//												设定的表单选项值
												if(in_array($tf['ticket_form_type'],['radio','select','checkbox']))
												{
													$formName[$colIndex]['option'] = explode('|',$tf['ticket_form_option']);
												}
											}
										}
									}
								}
								else
								{
//				                        字段内容
									$formData[$colIndex] = $value ?: '';
								}
							}

//							当行未空白时，跳出当前for循环
							if(!$judgeRowEmpty) continue;

//							  Excel表数据
							if($formData)
							{
								$ticketData = [];

								foreach($formName as $fk => $fv)
								{
									if($fk == 'A')
									{
										$ticketData['ticket']['title'] = $formData['A'];//工单标题数据，'title'=>'工单标题内容'

										$ticketData['ticket']['ticket_model_id'] = $template_id;
									}
									else
									{
										if(in_array($fv['type'],['select','radio','checkbox']))
										{
//											单元格数据
											$cellData = explode('|',$formData[$fk]);

//											单元格中内容中与表单设定的选项不一致的内容
											$cellDiffValue = array_diff($cellData,$fv['option']);

											if($cellDiffValue)
											{
												@unlink($file);

												$cellDiffValue = "<span class='red'>".implode('|',$cellDiffValue)."</span>";

												return [
													'status'=>0,
													'msg'=>"第 ".$rowIndex." 行数据导入失败，在第 ".$rowIndex." 行 ".$fk." 列单元格内容（".$cellDiffValue."）不在表单
													选项范围内，请按表单设定的选项值导入数据"
												];
											}
										}

										$ticketData['ticket_form'][$fv['name']] = $formData[$fk];//自定义字段数据，字段名称 => 字段内容
									}
								}

								$template = M('ticket_model')->where(['ticket_model_id'=>$template_id])->find();

								// 用户 - 创建工单
								$result = D('Ticket')->CreateTicketByUser($company_id,$member_id,$template,$first_status_id,'PC',
									'import',$ticketData);

								if($result['status'] == 0)
								{
									@unlink($file);

									return ['status'=>0,'msg'=>"第{$rowIndex}行数据导入失败，{$result['msg']}"];
								}
								else
								{
									$ticketIndex++;//创建成功，序号加一
								}
							}
						}

						@unlink($file);

						D('Upload')->deleteDir(dirname($file));

						if($ticketIndex > 0)
						{
							return ['status'=>1,'msg'=>L('IMPORT_SUCCESS'),'isReload'=>1];
						}
						else
						{
							return ['status'=>0,'msg'=>"Excel文件没有数据或数据格式不正确，请严格按照“导入须知”进行导入"];
						}
					}
					catch (PHPExcel_Reader_Exception | PHPExcel_Exception $e)
					{
						@unlink($file);

						return ['status'=>0,'msg'=>$e->getMessage()];
					}
				}
			}
		}
	}
}
