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

namespace Index\Controller;

use Index\Common\BasicController;

class SubTicketController extends BasicController
{
	protected static $_field = ['ticket_id,title,ticket_no,member_id,process_id,status_id,create_time,end_time'];

	/*
	* 我发布的子工单
	* @param string $source 来源，当前只用于导出工单
	* @param array  $where  导出工单时的查询条件
	* @param string $field  需要导出的工单字段信息
	*/
	public function myTicket($source = '',$where = [],$field = '')
	{
		$field = $field ? $field : self::$_field;

		$where = $source == 'export' ? $where : $this->getField();

		$where['member_id'] = $this->member_id;

		$list = $this->getTicketList($source,$where,$field);

		if(IS_POST) $this->ajaxReturn($this->getTimeConsumeAndNewReply($list));

		$this->assign('subTicket',$list);

		$this->display();
	}


	/*
	* 我处理的
	* @param string $source 来源，当前只用于导出工单
	* @param array  $where  导出工单时的查询条件
	* @param string $field  需要导出的工单字段信息
	*/
	public function processTicket($source = '',$where = [],$field = '')
	{
		$field = $field ? $field : self::$_field;

		$where = $source == 'export' ? $where : $this->getField();

		$where['process_id'] = $this->member_id;

		$list = $this->getTicketList($source,$where,$field);

		if(IS_POST) $this->ajaxReturn($this->getTimeConsumeAndNewReply($list));

		$this->assign('subTicket',$list);

		$this->display();
	}


	/*
	* 获取get查询条件
	* @return array
	*/
	private function getField($source = '')
	{
		$where = [];

		$filter = [
			'keyword'           => isset($_GET['keyword']) && $_GET['keyword'] ? I('get.keyword') : '',
			'statusIds'         => I('get.status') ? explode(',',I('get.status')) : [],
			'publishIds'        => I('get.publishIds') ? explode(',',I('get.publishIds')) : [],
			'groupIds'          => I('get.group_id') ? explode(',',I('get.group_id')) : [],
			'handleIds'         => I('get.dispose_id') ? explode(',',I('get.dispose_id')) : [],
			'timeId'            => I('get.timeId',-1),
			'datetime'          => isset($_GET['datetime']) && $_GET['datetime'] ? explode('~',$_GET['datetime']) : []
		];

		if($filter['keyword'])
		{
//            发布人姓名和邮箱，手机号作为筛选条件
			if(isEmail($filter['keyword']) || isMobile($filter['keyword']))
			{
				$where['member_id'] = M('member')->where(['company_id'=>$this->_company_id,'mobile|email|account'=>$filter['keyword']])->getField('member_id');
			}
			else
			{
				$memberIds = M('member')->where(['company_id'=>$this->_company_id,'name'=>$filter['keyword']])->field('member_id')->select();

				if($memberIds)
				{
					$memberIds = array_column($memberIds,'member_id');

					$where['member_id'] = ['in',$memberIds];
				}
				else
				{
					$where['ticket_no|title'] = ['LIKE', '%' . $filter['keyword'] . '%'];
				}
			}
		}

//	    状态
		if($filter['statusIds'])
		{
			$where['status_id'] = ['in',$filter['statusIds']];
		}

//	    发布人
		if($filter['publishIds'])
		{
			$where['member_id'] = ['in',$filter['publishIds']];
		}

//	    处理人
		if($filter['handleIds'])
		{
			$where['process_id'] = ['in',$filter['handleIds']];
		}

		if($filter['datetime'])
		{
			$where['create_time'] = [['egt',strtotime(trim($filter['datetime'][0]))],['elt',strtotime(trim($filter['datetime'][1]))]];

			$this->assign('datetime', $_GET['datetime']);
		}
		else
		{
			$start_time = D('Ticket')->getStartTime($filter['timeId']);

			if($source !== 'export' && $filter['timeId'] == -1)
			{
				$create_time = 0;
			}
			else
			{
				$create_time = $start_time ? $start_time : D('Ticket')->getStartTime(30);
			}

			$where['create_time'] = [['egt',$create_time],['elt',time()]];
		}

		$where['sort'] = isset($_GET['sort']) && $_GET['sort'] ? I('get.sort') : 'desc';

		$where['order'] = isset($_GET['sort_field']) && $_GET['sort_field'] ? I('get.sort_field') : 'create_time';

		$where['company_id'] = $this->_company_id;

		$where['is_delete'] = 10;

		$createTimeFilter = [1 => L('WITHIN_24_HOURS'),3 => L('WITHIN_3_DAYS'),7 => L('WITHIN_7_DAYS'), 30 => L('WITHIN_A_MONTH'),'n' => L('CUSTOM')];

		$this->assign('createTimeFilter',$createTimeFilter);

		$this->assign('filter', $filter);

		$this->assign('sort', $where['sort']);

		$this->assign('sort_field', $where['order']);

		$this->assign('filterData', json_encode($filter));

		$this->assign('ticketStatusData',json_encode([['status_id'=>10,'status_name'=>'待处理'],['status_id'=>20,'status_name'=>'已完成']]));

		return $where;
	}


	/*
	* 获取工单列表
	* @param array $field 条件字段
	* @return array
	*/
	public function getTicketList($source='',$where = [],$field='*',$action = '')
	{
		$list = [];$order = '';

		$cookie_view_source = cookie('ticket_view_source_'.$this->_company_id.'_'.$this->member_id);

		$view_source = isset($_GET['view_source']) && $_GET['view_source'] ? I('get.view_source') : ($cookie_view_source ? $cookie_view_source : 'list');

		$show_end_ticket = cookie('show_end_sub_ticket_'.$this->_company_id.'_'.$this->member_id);

		$show_end_ticket = $show_end_ticket ? $show_end_ticket : 'show';

		if(!in_array($view_source,['minimalist','list']))
		{
			$view_source = 'list';
		}

		if($where)
		{
			if($where['order'])
			{
				if(is_array($where['order']))
				{
					foreach($where['order'] as $v) $order .= $v." ". $where['sort'].",";

					$order = rtrim($order,',');
				}
				else
				{
					$order = $where['order']." ".$where['sort'];
				}
			}
			else
			{
				$order = "create_time ".$where['sort'];
			}

			unset($where['order'],$where['sort']);

			if($show_end_ticket != 'show' && !$where['status_id'])
			{
				$where['status_id'] = ['neq',20];
			}

			if($source == 'export')
			{
				$list = D('SubTicket')->where($where)->order($order)->field($field)->fetchAll();
			}
			else
			{
//                设置默认工单显示方式
				D('Ticket')->updateSourceView($view_source,$this->member_id);

				$count = D('SubTicket')->where($where)->count();

				$Page = new \Think\Page($count,100);

				$list = D('SubTicket')->where($where)->limit($Page->firstRow, $Page->listRows)->order($order)->field($field)->fetchAll();

				$Page->setConfig('prev',"<i class='iconfont icon-zuo'></i>");

				$Page->setConfig('next',"<i class='iconfont icon-you'></i>");

				$this->assign('page', $Page->show()); //赋值分页输出
			}

			foreach($list as $k=>&$v)
			{
				$time = getTakingTime($v['create_time'],NOW_TIME);

//                已耗时
				$v['taking'] = $time;

//                总耗时
				if($v['end_time']) $v['ztaking'] = getTakingTime($v['create_time'],$v['end_time']);

//                最新回复数
				$where = ['ticket_id'=>$v['ticket_id'],'look'=>1,'member_id'=>['neq',$this->member_id]];

				$v['newReplyNum'] = M('sub_reply')->where($where)->count();
			}
		}

		$group = D('Group')->where(['company_id'=>$this->_company_id,'closed'=>0,'ticket_auth'=>10])
			->field('group_id,group_name')
			->order('orderby asc')
			->fetchAll();

		$members = D('Member')->where(['company_id'=>$this->_company_id,'type'=>1])
			->field('name,member_id,face,type,group_id')
			->fetchAll();

		$this->assign('groups',$group);

		$this->assign('members',$members);

		$this->assign('view_source',$view_source);

		$this->assign('show_end_ticket',$show_end_ticket);

		$this->assign('source','ticket');

//        删除子工单权限
		$deleteTicketAuth = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'subTicket/delete',$this->_member['role_id']);

		$this->assign('isDeleteAuth',$deleteTicketAuth);

		$this->assign('memberData',json_encode(array_values($members)));

		return $list;
	}

	/*
	* 获取工单耗时和最新回复数
	* @param array $data 工单集合
	* @return array
	*/
	private function getTimeConsumeAndNewReply($data = array())
	{
		$result = [];

		foreach($data as $k=>$v)
		{
			if($v['status_id'] != 20)
			{
				$result[$k]['ticket_no'] = $v['ticket_no'];

				$where = ['ticket_id'=>$v['ticket_id'],'look'=>1,'member_id'=>['neq',$this->member_id]];

				$result[$k]['newReplyNum'] = M('sub_reply')->where($where)->count();
			}
		}

		return $result;
	}


	//创建子工单
	public function create()
	{
		if(IS_POST)
		{
			$result = D('SubTicket')->createSubTicket($this->_company_id,$this->member_id);

			$this->ajaxReturn($result);
		}
	}


	public function editor($id = '')
	{
		$id = decrypt($id,'SUB_TICKET');

		$subTicket = M('sub_ticket')->where(['company_id'=>$this->_company_id,'ticket_id'=>$id])->field('ticket_id,title,process_id,content,photo,assign_time')->find();

		if(!$subTicket)
		{
			$this->returnError(L('TICKET_NOT'),U('Index/welcome'));
		}

		if(IS_POST)
		{
			$result = D('SubTicket')->editorSubTicket($this->_company_id,$this->member_id,$subTicket);

			$this->ajaxReturn($result);
		}
		else
		{
//            指定处理人 - 未禁用客服
			$subTicket['members'] = D('Member')->where(['company_id'=>$this->_company_id,'closed'=>0,'type'=>1])->field('member_id,name')->fetchAll();

			$subTicket['photo'] = unserialize($subTicket['photo']);

			$subTicket['attachments'] = M('upload_file')->where(['sub_ticket_id'=>$id,'file_form'=>'sub_ticket'])->select();

			$this->assign('ticket',$subTicket);

			$this->display();
		}
	}


	public function detail($id = '',$request = '')
	{
		$id = decrypt($id,'SUB_TICKET');

		$subTicket = M('sub_ticket')->where(['company_id'=>$this->_company_id,'ticket_id'=>$id])->find();

		if(!$subTicket)
		{
			$this->returnError(L('TICKET_NOT'),U('Index/welcome'),'errcode');
		}
		else
		{
			if(IS_POST)
			{
				$result = D('SubTicket')->ajaxRequestByDetail($subTicket,$request);

				$this->ajaxReturn($result);
			}

			$subTicket = D('SubTicket')->getSubTicketDetail($subTicket,$this->_member);

			$this->assign('ticket',$subTicket);

			$this->assign('nowTime',date('Y-m-d',time()));

			$this->assign('yesTime',date('Y-m-d',strtotime('-1 day')));

			$this->display();
		}
	}


	public function reply()
	{
		if(IS_POST)
		{
			$result = D('SubTicket')->replySubTicket($this->_company_id,$this->member_id);

			$this->ajaxReturn($result);
		}
		else
		{
			$this->common->_empty();
		}
	}


	/*
	* 回收站
	* @param string $keyword 搜索关键词
	*/
	public function recycle($keyword = '')
	{
		$where = ['company_id'=>$this->_company_id,'is_delete'=>20];

		if($keyword)
		{
			$where['title|ticket_no'] = ["like","%{$keyword}%"];

			$this->assign('keyword',$keyword);
		}

		$count = D('subTicket')->where($where)->count('ticket_id');

		$Page = new \Think\Page($count,1000);

		$recycleData['subTickets'] = M('subTicket')->where($where)
			->limit($Page->firstRow, $Page->listRows)
			->field('ticket_id,ticket_no,title,delete_time,delete_member_id,delete_ip')
			->order('delete_time desc')
			->select();

		$recycleData['members'] = D('Member')->where(['company_id'=>$this->_company_id,'type'=>1])->field('member_id,name')->fetchAll();

		$recycleData['completeDeleteAuth'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'subTicket/complete_delete',$this->_member['role_id']);

		$recycleData['recoverTicketAuth'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'subTicket/recover',$this->_member['role_id']);

		$Page->setConfig('prev',"<i class='iconfont icon-zuo'></i>");

		$Page->setConfig('next',"<i class='iconfont icon-you'></i>");

		$this->assign('page', $Page->show()); //

		$this->assign('recycleData',$recycleData);

		$this->display();
	}


	public function delete($id = '')
	{
		$id = $id ? $id : I('post.ticket_ids');

		$result = D('SubTicket')->deleteSubTicket($id,$this->member_id);

		$this->ajaxReturn($result);
	}


	public function complete_delete($id = '')
	{
		$id = $id ? $id : I('post.ticket_ids');

		$result = D('SubTicket')->deleteSubTicket($id,$this->member_id,2);

		$this->ajaxReturn($result);
	}


	public function recover($id = '')
	{
		$id = $id ? $id : I('post.ticket_ids');

		$id = is_array($id) ? $id : explode(',',$id);

		foreach($id as &$v)
		{
			$v = decrypt($v,'SUB_TICKET');

			$data = ['ticket_id'=>$v,'is_delete'=>10];

			M('sub_ticket')->save($data);

//           存储工单事件
			D('SubEvent')->saveEvent($v,'recover',$this->member_id);
		}

		$result = ['status'=>2,'msg'=>L('UPDATE_SUCCESS'),'isReload'=>1];

		$this->ajaxReturn($result);
	}
}
