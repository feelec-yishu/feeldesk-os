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
namespace Index\Controller;

use Index\Common\BasicController;

use Think\Csv;

class TicketController extends BasicController
{
    protected static $ticket_status = [];

    protected static $first_status = [];

    protected static $end_status = [];


    public function _initialize()
    {
	    parent::_initialize();

        $statusName = D('TicketStatus')->getNameByLang('status_name');

        self::$ticket_status = D('TicketStatus')->where(['company_id'=>$this->_company_id])->field("*,{$statusName}")->order('sort asc')->fetchAll();

        foreach(self::$ticket_status as $v)
        {
            if($v['is_first'] == 1) self::$first_status = $v;

            if($v['is_end'] == 1) self::$end_status = $v;
        }

        $this->assign('ticket_status',self::$ticket_status);

        $this->assign('ticketObj',D('Ticket'));
    }


    /*
    * 选择工单模板
    */
    public function template()
    {
        $ticketTemplate = D('TemplateType')->getTicketTempLate($this->_company_id,1);

        $this->assign('ticketTemplate',$ticketTemplate);

        $this->display();
    }


	/*
	* 我发布的工单
	* @param string $source 来源，当前只用于导出工单
	* @param array $where 导出工单时的查询条件
	* @param string $field 需要导出的工单字段信息
	*/
    public function myTicket($source = '',$where=[],$field = '')
    {
        $where = $source == 'export' ? $where : $this->getField($source);

        $where['member_id'] = $this->member_id;

        $list = $this->getTicketList($source,$where,$field);

        if($source == 'export') return $list;

        $this->assign('ticket',$list);

        $this->display();
    }


    /*
    * 所有工单
    * @param string $source 来源，当前只用于导出工单
    * @param array  $where  导出工单时的查询条件
    * @param string $field  需要导出的工单字段信息
    */
    public function allTicket($source = '',$where=[],$field = '')
    {
        $where = $source == 'export' ? $where : $this->getField($source);

        $list = $this->getTicketList($source,$where,$field);

        if($source == 'export') return $list;

        $this->assign('ticket',$list);

        $this->display();
    }


    /*
    * 我处理的
    * @param string $source 来源，当前只用于导出工单
    * @param array  $where  导出工单时的查询条件
    * @param string $field  需要导出的工单字段信息
    */
    public function disposeTicket($source = '',$where=[],$field = '')
    {
        $where = $source == 'export' ? $where : $this->getField($source);

        $where['dispose_id'] = $this->member_id;

        $list = $this->getTicketList($source,$where,$field);

        if($source == 'export') return $list;

        $this->assign('ticket',$list);

        $this->display();
    }


    /*
    * 我参与的
    * @param string $source 来源，当前只用于导出工单
    * $param array  $where 导出工单时的查询条件
    * $param string $field 需要导出的工单字段信息
    */
    public function partakeTicket($source = '',$where=[],$field = '')
    {
        $where = $source == 'export' ? $where : $this->getField($source);

        $partTickets = M('ticket_partake')->where(['company_id'=>$this->_company_id,'member_id'=>$this->member_id])->field('ticket_id')->select();

	    $ticketIds = $partTickets ? array_column($partTickets,'ticket_id') : '-1';

	    $where['ticket_id'] = ['in',$ticketIds];

        $list = $this->getTicketList($source,$where,$field);

        if($source == 'export') return $list;

        $this->assign('ticket',$list);

        $this->display();
    }


    /*
    * 我所在组的
    * @param string $source 来源，当前只用于导出工单
    * @param array  $where  导出工单时的查询条件
    * @param string $field  需要导出的工单字段信息
    */
    public function groupTicket($source = '',$where=[],$field = '')
    {
        $where = $source == 'export' ? $where : $this->getField($source);

        $where['group_id'] = ['in',$this->_member['group_id']];

//        $where['dispose_id'] = ['eq',0];

        $group_id = M('Group')->where(['group_id'=>['in',$this->_member['group_id']],'is_task'=>2])->getField('group_id');

        if($group_id) unset($where['group_id']);

        $list = $this->getTicketList($source,$where,$field);

        if($source == 'export') return $list;

        $this->assign('ticket',$list);

        $this->display();
    }


	/*
	* 待审核的
	*/
	public function waitAuditTicket()
	{
		$where = ['company_id'=>$this->_company_id,'audit_status'=>['in',[2,4,5,6]],'delete'=>2];

		if($keyword = I('get.keyword'))
		{
			$where['title|ticket_no'] = ['LIKE','%'.$keyword.'%'];

			$this->assign('keyword',$keyword);
		}

//		所有处于待审和被驳回的工单
		$tickets = M('ticket')->where($where)->field('ticket_id,title,ticket_no,member_id,ticket_from,create_time')->order('ticket_id asc')->select();

		foreach($tickets as $k=>$v)
		{
//	    	1. 获取当前登录人员针对工单的审核节点信息
			$progress_map = ['ticket_id'=>$v['ticket_id'],'member_id'=>$this->member_id,'audit_status'=>10];

			$progress = M('audit_progress')->where($progress_map)->order('audit_level asc')->field('id,audit_level,audit_type')->find();

//			2. 若审核节点所处的审核类型为 会审
			$nowProgress = [];

			if($progress['audit_type'] == 30)
			{
//              3. 查询本层级中是否存在未审核的上一个节点
				$now_progress_map = ['ticket_id'=>$v['ticket_id'],'audit_status'=>10,'audit_level'=>$progress['audit_level'],'id'=>['lt',$progress['id']]];

				$nowProgress = M('audit_progress')->where($now_progress_map)->field('id,member_id')->find();
			}

			if(!$nowProgress)
			{
//	    	    4. 查询是否存在上一层级未审核的节点
				$upper_reviewer_map = ['ticket_id'=>$v['ticket_id'],'audit_status'=>10,'audit_level' => ['lt',$progress['audit_level']]];

//				上一层级未审核的节点的审核人ID
				$upper_reviewer_id = M('audit_progress')->where($upper_reviewer_map)->getField('member_id');

//				不存在，但审核流程里有当前人员或者存在并且节点审核人 == 当前登录人员时有权限
				$audit_auth = !$upper_reviewer_id ? $progress['id'] : $upper_reviewer_id == $this->member_id;
			}
			else
			{
//				当审核层级类型为会审时，本层级存在未审核的上一节点时，当前人员没有审核权限
				$audit_auth = false;
			}

			if(!$audit_auth) unset($tickets[$k]);
		}

		$members = D('Member')->where(['company_id'=>$this->_company_id])->field('member_id,name')->fetchAll();

//        权限 - 删除工单
		$auth['delete'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'ticket/delete',$this->_member['role_id']);

		$this->assign('auth',$auth);

		$this->assign('tickets',$tickets);

		$this->assign('members',$members);

		$this->display();
	}


	/*
	* 我发布的待审核工单
	*/
	public function waitAuditMyTicket()
	{
		$where = ['company_id'=>$this->_company_id,'member_id'=>$this->member_id,'audit_status'=>['in',[2,4,5]],'delete'=>2];

		if($keyword = I('get.keyword'))
		{
			$where['title|ticket_no'] = ['LIKE','%'.$keyword.'%'];

			$this->assign('keyword',$keyword);
		}

		$tickets = M('ticket')->where($where)->field('ticket_id,title,ticket_no,member_id,ticket_from,create_time')->order('ticket_id asc')->select();

//        权限 - 删除工单
		$auth['delete'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'ticket/delete',$this->_member['role_id']);

		$this->assign('auth',$auth);

		$this->assign('tickets',$tickets);

		$this->display();
	}


    /*
    * 抄送给我的
    * @param string $source 来源，当前只用于导出工单
    * @param array  $where  导出工单时的查询条件
    * @param string $field  需要导出的工单字段信息
    */
    public function ccTicket($source = '',$where=[],$field = '')
    {
        $where = $source == 'export' ? $where : $this->getField($source);

        $ccTicketIds = D('CcTicket')->where(['member_id'=>$this->member_id])->field('ticket_id')->select();

	    $ticketIds = array_column($ccTicketIds,'ticket_id');

	    $ticketIds = $ticketIds ? $ticketIds : '-1';

        $where['ticket_id'] = ['in',$ticketIds];

        $list = $this->getTicketList($source,$where,$field);

        if($source == 'export') return $list;

        $this->assign('ticket',$list);

        $this->display();
    }


    /*
    * 待回复的
    * @param string $source 来源，当前只用于导出工单
    * @param array  $where  导出工单时的查询条件
    * @param string $field  需要导出的工单字段信息
    */
    public function waitReplyTicket($source = '',$where = [],$field = '')
    {
        $where = $source == 'export' ? $where : $this->getField($source);

//        当前登录人所有发布和处理的工单
        $list = $this->getTicketList($source,$where,$field,'waitReplyTicket');

        if($source == 'export') return $list;

        $this->assign('ticket',$list);

        $this->display();
    }


    /*
    * 指定成员的
    * @param string $id     成员ID
    * @param string $source 来源，当前只用于导出工单
    * @param array  $where  导出工单时的查询条件
    * @param string $field  需要导出的工单字段信息
    */
    public function memberTicket($id = '',$source='',$where=[],$field='')
    {
        if($id)
        {
            $where = $source == 'export' ? $where : $this->getField($source);

            $where['member_id|related_id'] = $id;

            $list = $this->getTicketList($source,$where,$field);

            if($source == 'export') return $list;

            $this->assign('ticket',$list);

            $this->assign('id',$id);

            $this->display();
        }
        else
        {
            $this->common->_empty();
        }
    }


    /*
    * 超时的
    * @param string $source 来源，当前只用于导出工单
    * @param array  $where  导出工单时的查询条件
    * @param string $field  需要导出的工单字段信息
    */
    public function timeoutTicket($source = '',$where=[],$field = '')
    {
        $where = $source == 'export' ? $where : $this->getField($source);

        $where['dispose_id'] = $this->member_id;

        $list = $this->getTicketList($source,$where,$field);

//        完成期限
        $deadlines  = M('ticket_deadlines')->where(['company_id'=>$this->_company_id])->select();

        $deadTimes = [];

        foreach($deadlines as $d)
        {
            $deadTimes[$d['ticket_id']] = $d;
        }

        $deadTickets = $globalTickets = [];

        foreach($list as $k=>$v)
        {
//            组件超时工单
            if($deadTimes[$v['ticket_id']])
            {
                if(checkTicketIsTimeoutByCron($deadTimes[$v['ticket_id']]['deadtime'],$v['end_time']) == true)
                {
                    $deadTickets[$v['ticket_id']] = $v;
                }
            }
            else
            {
//                全局超时工单
                if(checkTicketIsTimeoutByGlobal($v['ticket_id'],$v['create_time'],$v['end_time']))
                {
                    $globalTickets[$v['ticket_id']] = $v;
                }
            }
        }

        $tickets = $deadTickets + $globalTickets;

        krsort($tickets);

        if($source == 'export') return $tickets;

        $this->assign('ticket',$tickets);

        $this->display();
    }


    /*
    * 回收站
    * @param string $keyword 搜索关键词
    */
	public function recycle($keyword = '')
	{
		$where = ['company_id'=>$this->_company_id,'delete'=>1];

		if($keyword)
		{
			$where['title|ticket_no'] = ["like","%{$keyword}%"];

			$this->assign('keyword',$keyword);
		}

		$count = D('Ticket')->where($where)->count('ticket_id');

		$Page = new \Think\Page($count,400);

		$recycleData['tickets'] = D('Ticket')->where($where)
			->limit($Page->firstRow, $Page->listRows)
			->field('ticket_id,ticket_no,title,delete_time,delete_member_id,delete_ip')
			->order('delete_time desc')
			->select();

		$recycleData['members'] = D('Member')->where(['company_id'=>$this->_company_id,'type'=>1])->field('member_id,name')->fetchAll();

		$recycleData['completeDeleteAuth'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'ticket/complete_delete',$this->_member['role_id']);

		$recycleData['recoverTicketAuth'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'ticket/recover',$this->_member['role_id']);

		$Page->setConfig('prev',"<i class='iconfont icon-zuo'></i>");

		$Page->setConfig('next',"<i class='iconfont icon-you'></i>");

		$this->assign('page', $Page->show()); //

		$this->assign('recycleData',$recycleData);

		$this->display();
	}


	/*
	* 获取get查询条件
	* @return array
	*/
    private function getField($source = '')
    {
    	$where = array();

        $filter = [
	        'keyword'           => isset($_GET['keyword']) && $_GET['keyword'] ? I('get.keyword') : '',
	        'ticket_from'       => I('get.ticket_from',[]),
	        'priority'          => I('get.priority',[]),
	        'statusIds'         => I('get.status') ? explode(',',I('get.status')) : [],
	        'templateTypeIds'   => I('get.template_type_id') ? explode(',',I('get.template_type_id')) : [],
	        'template_id'       => I('get.template_id',0),
	        'publishIds'        => I('get.publishIds') ? explode(',',I('get.publishIds')) : [],
	        'groupIds'          => I('get.groupIds',[]),
	        'handleIds'         => I('get.handleIds',[]),
	        'timeId'            => I('get.timeId',-1),
            'datetime'          => isset($_GET['datetime']) && $_GET['datetime'] ? explode('~',urldecode($_GET['datetime'])) : []
        ];

        if($filter['keyword'])
        {
//            发布人姓名和邮箱，手机号作为筛选条件
            if(isEmail($filter['keyword']) || (strlen($filter['keyword']) == 11 &&isMobile($filter['keyword'])))
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
                    $where['ticket_no|title|related_name'] = ['LIKE', '%' . $filter['keyword'] . '%'];
                }
            }
        }

//	    来源
	    if($filter['ticket_from'])
	    {
		    $where['ticket_from'] = ['in',$filter['ticket_from']];
	    }

//	    优先级
	    if($filter['priority'])
	    {
		    $where['priority'] = ['in',$filter['priority']];
	    }

//	    状态
        if($filter['statusIds'])
        {
            $where['status_id'] = ['in',$filter['statusIds']];
        }

//	    模板类型
	    if($filter['templateTypeIds'])
	    {
		    $where['type_id'] = ['in',$filter['templateTypeIds']];
	    }

//	    模板
        if($filter['template_id'])
        {
            $where['ticket_model_id'] = ['in',$filter['template_id']];

	        $ticket_form = M('ticket_form')->where(['ticket_model_id'=>$filter['template_id'],'closed'=>0])
		        ->field('ticket_form_id as id,ticket_form_description as name,orderby')
		        ->order('orderby asc')->select();

	        $this->assign('ticketForm',$ticket_form);
        }

//	    发布人
	    if($filter['publishIds'])
	    {
		    $where['member_id'] = ['in',$filter['publishIds']];
	    }

//	    处理人
	    if($filter['handleIds'])
	    {
		    $where['dispose_id'] = ['in',$filter['handleIds']];
	    }

        if($filter['datetime'])
        {
            $where['create_time'] = [['egt',strtotime(trim($filter['datetime'][0]))],['elt',strtotime(trim($filter['datetime'][1]))]];

            $this->assign('datetime', urldecode($_GET['datetime']));
        }
        else
        {
            if($source !== 'export' && $filter['timeId'] == -1)
            {
                $create_time = D('Ticket')->getStartTime(30);

				$filter['timeId'] = 30;
            }
            else
            {
	            $start_time = D('Ticket')->getStartTime($filter['timeId']);

                $create_time = $start_time ? $start_time : D('Ticket')->getStartTime(30);
            }

            $where['create_time'] = [['egt',$create_time],['elt',time()]];
        }

        $where['sort'] = isset($_GET['sort']) && $_GET['sort'] ? I('get.sort') : 'desc';

        $where['order'] = isset($_GET['sort_field']) && $_GET['sort_field'] ? I('get.sort_field') : 'ticket_id';

        $where['company_id'] = $this->_company_id;

        $where['audit_status'] = ['in','1,3'];

        $where['delete'] = 2;

	    $this->assign('filter', $filter);

        $this->assign('sort', $where['sort']);

        $this->assign('sort_field', $where['order']);

        $this->assign('end_status',self::$end_status);

	    $this->assign('filterData', json_encode($filter));

	    session('TicketExportWhere',$where);

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

        $show_end_ticket = cookie('show_end_ticket_'.$this->_company_id.'_'.$this->member_id);

        $show_end_ticket = $show_end_ticket ? $show_end_ticket : 'show';

        if(!in_array($view_source,['minimalist','list']))
        {
            $view_source = 'minimalist';
        }

	    $template_map = ['company_id'=>$this->_company_id];

        if($where)
        {
	        if(isset($where['type_id']) && $where['type_id'])
	        {
		        $template_map['type_id'] = $where['type_id'];
	        }

            if(isset($where['order']) && $where['order'])
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
                $order = "ticket_id ".$where['sort'];
            }

            unset($where['order'],$where['sort']);

            if($show_end_ticket != 'show' && (!isset($where['status_id']) || !$where['status_id']))
            {
                $where['status_id'] = ['neq',self::$end_status['status_id']];
            }

            if($source == 'export')
            {
            	if($action == 'waitReplyTicket')
            	{
		            $field = $field === '*' ? 'ticket_id,title,member_id,ticket_no,look,create_time,end_time,recipient_id,dispose_id,status_id,ticket_from,priority' : $field;

		            $param = [
			            'company_id'    => $this->_company_id,
			            'member_id'     => $this->member_id,
			            'field'         => $field
		            ];

		            $result = D('Ticket')->getWaitReplyTicketData($param,$where);

		            $list = fetchAll($result['tickets'],'ticket_id');
	            }
            	else
                {
	                $list = D('Ticket')->where($where)->order($order)->field($field)->fetchAll();
                }

	            return $list;
            }
            else
            {
//                设置默认工单显示方式
                D('Ticket')->updateSourceView($view_source,$this->member_id);

	            if($action == 'waitReplyTicket')
	            {
		            $param = [
			            'company_id'    => $this->_company_id,
			            'member_id'     => $this->member_id,
			            'field'         => 'ticket_id,title,member_id,ticket_no,look,create_time,recipient_id,dispose_id,status_id,ticket_from,priority'
		            ];

		            $param['page'] = 1;

		            $result = D('Ticket')->getWaitReplyTicketData($param,$where);

		            $list = $result['tickets'];

		            $this->assign('page', $result['page']); //赋值分页输出

		            session('TicketExportWhere',$result['exportWhere']);
	            }
                else
                {
                    $count = D('Ticket')->where($where)->count('ticket_id');

                    $Page = new \Think\Page($count,100);

	                $field = 'ticket_id,title,ticket_from,ticket_no,priority,member_id,recipient_id,dispose_id,type_id,ticket_model_id,status_id,create_time
	                    ,end_time,look';

                    $list = D('Ticket')->where($where)->limit($Page->firstRow, $Page->listRows)->order($order)->field($field)->fetchAll();

                    $Page->setConfig('prev',"<i class='iconfont icon-zuo'></i>");

                    $Page->setConfig('next',"<i class='iconfont icon-you'></i>");

                    $this->assign('page', $Page->show()); //赋值分页输出
                }
            }

            session('getNewTicketWhere',$where);

//	         我关注的工单
	        $follow = M('ticket_follow')->where(['company_id'=>$this->_company_id,'member_id'=>$this->member_id])->field('ticket_id')->select();

	        $followTicket = $follow ? array_column($follow,'ticket_id') : [];

            foreach($list as $k=>&$v)
            {
//                最新回复数
                $where = ['ticket_id'=>$v['ticket_id'],'look'=>1,'member_id'=>['neq',$this->member_id]];

                $v['newReplyNum'] = D('TicketReply')->where($where)->count('reply_id');

//                结束状态
                $v['end_status_id'] = self::$end_status['status_id'];

//	              获取工单耗时
	            $takeTime = D('Ticket')->getTicketTakeTime($this->_company_id,$v['ticket_id'],$v['create_time'],$v['end_time']);

//	              已耗时
	            $v['taking'] = $takeTime['taking'];

//	              总耗时
	            $v['ztaking'] = $takeTime['ztaking'];

//                是否挂起
                $suspendWhere = ['company_id'=>$this->_company_id,'ticket_id'=>$v['ticket_id'],'start_time'=>['gt',0],'close_time'=>0];

                $v['is_suspend'] = M('ticket_suspend')->where($suspendWhere)->getField('id');

                if(in_array($v['ticket_id'],$followTicket))
                {
                	$v['is_follow'] = 1;
                }
            }
        }

//		  模板
        $templateName = D('Ticketmodel')->getNameByLang('ticket_model_name');

//        模板类型
        $templateTypeName = D('TemplateType')->getNameByLang('type_name');

        $condition = ['company_id' => $this->_company_id];

//        完成期限
        $deadlines  = M('ticket_deadlines')->where(['company_id'=>$this->_company_id])->select();

        $deadTimes = [];

        foreach($deadlines as $d)
        {
            $deadTimes[$d['ticket_id']] = $d;
        }

	    $group = D('Group')->where(['company_id'=>$this->_company_id,'closed'=>0,'ticket_auth'=>10])
		    ->field('group_id,group_name,parent_id')
		    ->order('orderby asc')->select();

	    $members = D('Member')->where(['company_id'=>$this->_company_id])
		    ->field('name,member_id,face,type,group_id')
		    ->fetchAll();

//        权限 - 导入工单
	    $auth['import'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'ticket/import',$this->_member['role_id']);

//        权限 - 导出工单
	    $auth['export'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'ticket/export',$this->_member['role_id']);

//        权限 - 删除工单
	    $auth['delete'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'ticket/delete',$this->_member['role_id']);

//        权限 - 关注工单
	    $auth['follow'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'ticket/follow',$this->_member['role_id']);

//        模板类型
	    $template_type = D('TemplateType')->where($condition)->field("type_id,{$templateTypeName}")->fetchAll();

//	      工单模板
	    $template = D('Ticketmodel')->where($template_map)->field("ticket_model_id,{$templateName}")->fetchAll();

	    $this->assign('auth',$auth);

	    $this->assign('groups',fetchAll($group,'group_id'));

	    $department = getSubjectTree($group,'group_id','parent_id','children',0);

	    $this->assign('jsonDepartmentData',json_encode($department));

	    $this->assign('members',$members);

	    $this->assign('deadTimes',$deadTimes);

	    $this->assign('view_source',$view_source);

	    $this->assign('show_end_ticket',$show_end_ticket);

	    $this->assign('source','ticket');

	    $this->assign('exportList',C('EXPORT'));

	    $this->assign('ticketView',D('TicketView')->getTicketView($this->_company_id));

	    $this->assign('templateType',$template_type);

	    $this->assign('template',$template);

	    $this->assign('ticket_status',self::$ticket_status);

	    $this->assign('createTimeFilter',D('Ticket')->getCreateTime());

	    $this->assign('ticketFromFilter',D('Ticket')->getTicketFrom());

	    $this->assign('priorityFilter',D('Ticket')->getPriority());

	    $this->assign('ticketStatusData',json_encode(array_values(self::$ticket_status)));

	    $this->assign('templateTypeFilter',json_encode(array_values($template_type)));

	    $this->assign('memberData',json_encode(array_values($members)));

        return $list;
    }


    /*
    * 创建工单
    * @param string $id         模板ID
    * @param string $request    请求类型
    */
    public function create($id = '',$request = '')
    {
	    $templateName = D('Ticketmodel')->getNameByLang('ticket_model_name');

        $where = ['company_id'=>$this->_company_id,'ticket_model_id'=>decrypt($id,'modelID'),'closed' => 0];

        if(!$template = M('TicketModel')->where($where)->field("*,{$templateName}")->find())
        {
	        $this->returnError(L('TEMP_NOT'),U('Index/welcome'));
        }

        if(IS_POST)
        {
            if($request == 'area')
            {
                $data = D('Ticket')->getAreaData();
            }
            else
            {
	            $data = D('Ticket')->CreateTicketByUser($this->_company_id,$this->member_id,$template,self::$first_status['status_id'],'PC');
            }

	        $this->ajaxReturn($data);
        }
        else
        {
            $createTicketFormData = D('Ticket')->getCreateTicketForm($template,$where,$this->_company);

            $this->assign('template',$template);

            $this->assign('createTicketFormData',$createTicketFormData);

            $this->assign('source','create');

            $this->display();
        }
    }


    /*
    * 修改工单
    * @param string $id         工单ID
    */
    public function edit($id = '')
    {
		$ticket_id = decrypt($id,'TICKET');

        $field['company_id'] = $this->_company_id;

        $field['ticket_id'] = $ticket_id;

        if(!$ticket = M('Ticket')->where($field)->find())
        {
	        $this->returnError(L('TICKET_NOT'),U('Index/welcome'));
        }

        if(IS_POST)
        {
            $data = D('Ticket')->EditTicketByUser($this->_company_id,$this->member_id,$ticket);

            $this->ajaxReturn($data);
        }
        else
        {
            $templateName = D('Ticketmodel')->getNameByLang('ticket_model_name');

            $where = ['company_id'=>$this->_company_id,'ticket_model_id'=>$ticket['ticket_model_id'],'closed' => 0];

            if(!$template = M('TicketModel')->where($where)->field("*,{$templateName}")->find())
            {
	            $this->returnError(L('TEMP_NOT'),U('Index/welcome'));
            }

			$editTicket = D('Ticket')->getEditTicketForm($ticket,$template,$this->_company);

			$ticket = $editTicket['ticket'];

			$editTicketFormData = $editTicket['editTicketFormData'];

			$this->assign('editTicketFormData',$editTicketFormData);

            $this->assign('ticket_model_id',$ticket['ticket_model_id']);

            $this->assign('template',$template);

            $this->assign('ticket',$ticket);

            $this->assign('source','create');

            $this->display();
        }
    }


    /*
    * 克隆工单
    * @param string $id                 工单ID
    * @param string $ticket_model_id    模板ID
    * @param string $request            请求类型
    */
	public function cloning($id = '',$ticket_model_id = '',$request = '')
	{
		$ticket_id = decrypt($id,'TICKET');

		$field['company_id'] = $this->_company_id;

		$field['ticket_id'] = $ticket_id;

		if(!$ticket = M('Ticket')->where($field)->find())
		{
			$this->returnError(L('TICKET_NOT'),U('Index/welcome'));
		}

		if(IS_POST)
		{
			if($request == 'area')
			{
				$data = D('Ticket')->getAreaData();
			}
			else
			{
				$templateName = D('Ticketmodel')->getNameByLang('ticket_model_name');

				$where = ['company_id'=>$this->_company_id,'ticket_model_id'=>$ticket_model_id,'closed' => 0];

				if(!$template = M('TicketModel')->where($where)->field("*,{$templateName}")->find())
				{
					$this->returnError(L('TEMP_NOT'),U('Index/welcome'));
				}

				$data = D('Ticket')->CreateTicketByUser($this->_company_id,$this->member_id,$template,self::$first_status['status_id'],'PC');

				$data['url'] = U('detail',['id'=>$data['id']]);
			}

			$this->ajaxReturn($data);
		}
		else
		{
			$templateName = D('Ticketmodel')->getNameByLang('ticket_model_name');

			$where = ['company_id'=>$this->_company_id,'ticket_model_id'=>$ticket['ticket_model_id'],'closed' => 0];

			if(!$template = M('TicketModel')->where($where)->field("*,{$templateName}")->find())
			{
				$this->returnError(L('TEMP_NOT'),U('Index/welcome'));
			}

			$cloneTicket = D('Ticket')->getEditTicketForm($ticket,$template,$this->_company);

			$ticket = $cloneTicket['ticket'];

			$cloneTicketFormData = $cloneTicket['editTicketFormData'];

			$this->assign('cloneTicketFormData',$cloneTicketFormData);

			$this->assign('ticket_model_id',$ticket['ticket_model_id']);

			$this->assign('template',$template);

			$this->assign('ticket',$ticket);

			$this->assign('source','create');

			$this->display();
		}
	}


    /*
    * 工单详情
    * @param string $id                 工单ID
    * @param string $request            请求类型
    * @param string $reply_tab          tab类型 ticket_reply,team_reply,ticket_event
    */
    public function detail($id=0,$request = '',$reply_tab = 'ticket_reply')
    {
        $ticket_id = decrypt($id,'TICKET');

        $field = $look = $reply = $member = [];

//        查询工单信息
        $field['company_id'] = $this->_company_id;

        $field['ticket_id'] = $ticket_id;

        if(!$ticket = M('Ticket')->where($field)->find())
        {
	        $this->returnError(L('TICKET_NOT'),U('Index/welcome'));
        }

        $ticket['end_status_id'] = self::$end_status['status_id'];

        $ticket['first_status_id'] = self::$first_status['status_id'];

        if(IS_POST) $this->ajaxReturn(D('Ticket')->ajaxRequestByDetail($this->_company_id,$this->member_id,$ticket,$request));

        $detailData = D('Ticket')->getTicketDetailData($ticket,$this->_company_id,$this->_member,self::$ticket_status,'pcTerminal');

        $this->assign('ticket',$ticket);

        $this->assign('detailData',$detailData);

        $this->assign('nowTime',date('Y-m-d',time()));

        $this->assign('yesTime',date('Y-m-d',strtotime('-1 day')));

        $this->assign('reply_tab',$reply_tab);

        $this->display();
    }


    public function reply()
    {
        if(IS_POST)
        {
            $result = D('Ticket')->ticketReplyByUser($this->_company_id,$this->member_id,self::$end_status['status_id']);

            $this->ajaxReturn($result);
        }
        else
        {
            $this->common->_empty();
        }
    }


    public function teamReply()
    {
        if(IS_AJAX)
        {
            $result = D('Ticket')->insideReplyByUser($this->_company_id,$this->member_id,self::$end_status['status_id']);

            $this->ajaxReturn($result);
        }
        else
        {
            $this->common->_empty();
        }
    }


    public function satisfy($id = null)
    {
        $ticket = M('Ticket')->where(['ticket_id'=>decrypt($id,'TICKET')])->field('company_id,ticket_id,dispose_id')->find();

        if(!$ticket) $this->ajaxReturn(['status'=>0,'msg'=>L('TICKET_NOT')]);

        if(IS_POST) $this->ajaxReturn(D('TicketSatisfy')->CreateSatisfy($ticket));
    }


    public function config()
    {
        $config = M('ticket_config')->where(['company_id'=>$this->_company_id])->find();

        if(IS_POST)
        {
            $configData = I('post.config');

            if(isset($configData['timeout']) && !isInteger($configData['timeout'])) $this->ajaxReturn(['status'=>0,'msg'=>L('TIME_OUT_NOTE')]);

            $data = [
                'handler_closed'    => $configData['handler'] == 'on'  ? 10 : 20,
                'publisher_closed'  => $configData['publisher'] == 'on'  ? 10 : 20,
                'feedback'          => $configData['msg_feedback'] ?? 20,
                'end_operate'       => $configData['end_ticket'],
                'status_go_back'    => $configData['status_go_back'],
                'handler_go_back'   => $configData['handler_go_back'] == 'on'  ? 10 : 20,
                'publisher_go_back' => $configData['publisher_go_back'] == 'on'  ? 10 : 20,
                'overtime'          => $configData['timeout'],
            ];

            if($configData['status_go_back'] == 10 && $data['handler_go_back'] == 20 && $data['publisher_go_back'] == 20)
            {
                $this->ajaxReturn(['status'=>0,'msg'=>L('SELECT_GO_BACK_ROLE')]);
            }

            if($config)
            {
                $data['id'] = $config['id'];

                $result = M('ticket_config')->save($data);
            }
            else
            {
                $data['company_id'] = $this->_company_id;

                $result = M('ticket_config')->add($data);
            }

            if($result === false)
            {
                $data = ['status'=>0,'msg'=>L('UPDATE_FAILED')];
            }
            else
            {
                $data = ['status'=>2,'msg'=>L('UPDATE_SUCCESS'),'url'=>U('config')];
            }

            $this->ajaxReturn($data);
        }

        $this->assign('config',$config);

        $this->display();
    }


    public function urgeTicket()
    {
        if(IS_POST)
        {
            $result = D('Ticket')->urgeTicket($this->_company_id,$this->member_id);

            $this->ajaxReturn($result);
        }
        else
        {
            $this->common->empty();
        }
    }


    public function commentReply()
    {
        $result = D('Ticket')->commentReply($this->_company_id,$this->member_id);

        $this->ajaxReturn($result);
    }


    protected function getMemberByGroupId($group_id = 0)
    {
        $where = ['company_id' => $this->_company_id, 'closed' => 0,'type' => 1, "find_in_set('{$group_id}',group_id)"];

        $task = D('Member')->where($where)->field('member_id,name')->fetchAll();

        $json = [];

        foreach($task as $k=>$v)
        {
            $json[] = $v;
        }

        return $json;
    }


//    关注工单
	public function follow($request = '')
	{
		$ids = I('post.ticket_ids');

		$result = D('Ticket')->followTicket($this->_company_id,$this->member_id,$ids,$request);

		$this->ajaxReturn($result);
	}


//    删除工单
    public function delete()
    {
        $ids = I('post.ticket_ids');

        $where['company_id'] = $this->_company_id;

        if(count($ids) > 0)
        {
            $ticket_ids = [];

            foreach($ids as $k=>$v)
            {
                if($v !== 'on')
                {
	                $ticket_ids[$k] = decrypt($v,'TICKET');
                }
            }

	        $where['ticket_id'] = ['in',implode(',',$ticket_ids)];

            $result = M('ticket')->where($where)->setField(['delete'=>1,'delete_member_id'=>$this->member_id,'delete_time'=>NOW_TIME,'delete_ip'=>get_client_ip()]);

	        foreach($ticket_ids as $v)
	        {
//                存储工单事件
		        $eventData = ['event_type'=>'delete','ticket_id'=>$v,'member_id'=>$this->member_id];

		        D('TicketEvent')->saveEvent($eventData);
	        }

	        if($result > 0)
	        {
		        $result = ['status'=>2,'msg'=>L('DELETE_SUCCESS'),'isReload'=>1];
	        }
	        else
	        {
		        $result = ['status'=>0,'msg'=>L('DELETE_TICKET_REMIND')];
	        }
        }
        else
        {
            $result = ['status'=>0,'msg'=>L('DELETE_TICKET_REMIND')];
        }

        $this->ajaxReturn($result);
    }


//    完全删除工单
	public function complete_delete()
	{
		if(IS_POST)
		{
			$ids = I('post.ticket_ids');
		}
		else
		{
			$ids = explode(',',I('get.ticket_ids'));
		}

		$field['company_id'] = $this->_company_id;

		$result = [];

		if(count($ids) > 0)
		{
			$ticket_ids = [];

			foreach($ids as $k=>$v)
			{
				if($v !== 'on')
				{
					$ticket_ids[$k] = decrypt($v,'TICKET');
				}
			}

			$field['ticket_id'] = ['in',implode(',',$ticket_ids)];

			$tickets = D('Ticket')->where($field)->field('ticket_id')->select();

			foreach($tickets as $v)
			{
				$result = D('Ticket')->deleteTicket($this->_company_id,$v['ticket_id']);

				$result['url'] = 'recycle';

				if(!$result['status'])
				{
					break;
				}
			}
		}
		else
		{
			$result = ['status'=>0,'msg'=>L('DELETE_TICKET_REMIND')];
		}

		$this->ajaxReturn($result);
	}


//    恢复工单
	public function recover()
	{
		if(IS_POST)
		{
			$ids = I('post.ticket_ids');
		}
		else
		{
			$ids = explode(',',I('get.ticket_ids'));
		}

		$field['company_id'] = $this->_company_id;

		if(count($ids) > 0)
		{
			$ticket_ids = [];

			foreach($ids as $k=>$v)
			{
				$ticket_ids[$k] = decrypt($v,'TICKET');
			}

			$field['ticket_id'] = ['in',implode(',',$ticket_ids)];

			$result = D('Ticket')->where($field)->setField(['delete'=>2]);

			foreach($ticket_ids as $v)
			{
//                存储工单事件
				$eventData = ['event_type'=>'recover','ticket_id'=>$v,'member_id'=>$this->member_id];

				D('TicketEvent')->saveEvent($eventData);
			}

			if($result > 0)
			{
				$result = ['status'=>2,'msg'=>L('UPDATE_SUCCESS'),'isReload'=>1];
			}
			else
			{
				$result = ['status'=>0,'msg'=>L('UPDATE_FAILED')];
			}
		}
		else
		{
			$result = ['status'=>0,'msg'=>L('RECOVER_TICKET_NOTE')];
		}

		$this->ajaxReturn($result);
	}


//	  服务报告
	public function service_report($id = '')
	{
		$ticket_id = decrypt($id,'TICKET');

		$ticket = M('ticket')->where(['ticket_id'=>$ticket_id])->find();

		if(!$ticket)
		{
			$this->error(L('DATA_NOT_EXIST'));
		}

//        发布人
		$publish = M('member')->where(['member_id'=>$ticket['member_id']])->getField('name');

//        处理人
		$handler = M('member')->where(['member_id'=>$ticket['dispose_id']])->getField('name');

//        工单状态
		$statusName = D('TicketStatus')->getNameByLang('status_name');

		$status_name = M('ticket_status')->where(['status_id'=>$ticket['status_id']])->getField($statusName);

//        优先级
		$priority = D('Ticket')->getPriority($ticket['priority']);

//	      计算工单耗时
		$takeTime = D('Ticket')->getTicketTakeTime($this->_company_id,$ticket['ticket_id'],$ticket['create_time'],$ticket['end_time']);

		$take_time = $ticket['end_time'] ? $takeTime['ztaking'] : $takeTime['taking'];//总耗时

		if($take_time['day']) $ticket['take_time'] .= $take_time['day'].L('DAYS');

		if($take_time['hour']) $ticket['take_time'] .= $take_time['hour'].L('HOURS');

		if($take_time['min']) $ticket['take_time'] .= $take_time['min'].L('MINUTES');

//        计算是否超时
		$deadtime = M('ticket_deadlines')->where(['company_id'=>$this->_company_id,'ticket_id'=>$ticket['ticket_id']])->getField('deadtime');

//		组件
		if($deadtime > 0)
		{
//			完成期限
			$ticket['deadtime'] = getDates($deadtime);

//			是否超时
			$ticket['is_timeout'] = checkTicketIsTimeout($ticket['deadtime'],$ticket['end_time']);

//			超时时长
			$ticket['timeout'] = checkTicketIsTimeout($ticket['deadtime'],$ticket['end_time'],1);
		}
//		全局
		else
		{
//			全局完成期限
			$overtime = M('ticket_config')->where(['company_id'=>$this->_company_id])->getField('overtime');

			$ticket['deadtime'] = getDates(intval($ticket['create_time'] + $overtime * 3600));

//			是否超时
			$ticket['is_timeout'] = checkIsTimeout($ticket['ticket_id'],$ticket['create_time'],$ticket['end_time']);

//			超时时长
			$ticket['timeout'] = checkIsTimeout($ticket['ticket_id'],$ticket['create_time'],$ticket['end_time'],1);
		}


//        表单详情
		$ticketForm = M('ticket_form')->alias('a')
			->join('feel_ticket_detail as b on a.ticket_form_id = b.ticket_form_id')
			->where(['ticket_id'=>$ticket_id,'a.company_id'=>$ticket['company_id']])
			->field('a.ticket_form_id,ticket_form_description,ticket_form_type,ticket_form_content')
			->order('orderby asc')
			->select();

		$ticketFormHtml = '';

		foreach($ticketForm as $k1 => $tf)
		{
			if($tf['ticket_form_type'] != 'textarea')
			{
				$ticketFormHtml .= "<li>
				<div class='item-div1'>{$tf['ticket_form_description']}</div>
				<div class='item-div2'>".getHtml($tf['ticket_form_content'])."</div>
				</li>";
			}
			else
			{
				$ticketFormHtml .= "<li class='textarea-form'>
		            <div class='ticket-form-title'>{$tf['ticket_form_description']}</div>
		            <div class='ticket-form-content'>".getHtml($tf['ticket_form_content'])."</div>
		            </li>";
			}
		}

//        通过邮件发送的工单内容
		if($ticket['ticket_from'] == 'Email' && $ticket['content'])
		{
			$ticketFormHtml .= "<li class='textarea-form'>
                <div class='ticket-form-title'>".L('TICKET_CONTENT')."</div>
                <div class='ticket-form-content'>".getHtml($ticket['content'])."</div>
                </li>";
		}

//	      发布工单的附件
		$createFiles = M('upload_file')->where(['ticket_id'=>$ticket_id,'file_form'=>'ticket'])->select();

		$createAttachItems = '';

		foreach($createFiles as $ct)
		{
			$createAttachItems .= "<div class='attach-item'><a href='{$ct['file_link']}'>{$ct['file_name']}</a><span>（".getFileSize($ct['file_size'])."）</span></div>";
		}

		if($createAttachItems)
		{
			$ticketFormHtml .= "<li class='textarea-form'><div class='ticket-form-title'>".L('ATTACHMENT')."</div><div class='ticket-form-content create-attach'>{$createAttachItems}</div></li>";
		}

//        工单图片
		if($ticket['photo'])
		{
			$img = 1;

			$photo = unserialize($ticket['photo']);

			$ticketFormHtml .= "<li class='ticket-image clearfix'>";

			foreach($photo as $tp)
			{
				$mr = '';

				if(judgeParity($img) == 2) $mr = 'mr0';

				$ticketFormHtml .= "<div class='upload-img {$mr}'><img src='{$tp}' alt='' style='margin-right:15px'></div>";

				$img++;
			}

			$ticketFormHtml .= "</li>";
		}

//		  PDF模板
		$pdfTemplate = C('PDF_TEMP')['template'];

//		  详情模板
		$detailTemplate = C('PDF_TEMP')['detail'];

		$detailKeySearch = ['{{title}}','{{status}}','{{priority}}','{{publish}}','{{handler}}','{{create_time}}','{{dispose_time}}','{{end_time}}','{{take_time}}',
			'{{deadtime}}','{{is_timeout}}','{{timeout}}'];

		$detailKeyReplace = [L('TICKET_TITLE'),L('TICKET_STATUS'),L('PRIORITY'),L('PUBLISHER'),L('HANDLER'),L('RELEASE_TIME'),L('PROCESS_TIME'),L('COMPLETION_TIME'),
			L('TIME_CONSUMING') ,L('DEADLINES_COMPONENTS'),L('WHETHER_TIMEOUT'),L('TIMEOUT'),];

		$detailValueSearch = [
			'{{ticket.title}}',
			'{{ticket.status}}',
			'{{ticket.priority}}',
			'{{ticket.publish}}',
			'{{ticket.handler}}',
			'{{ticket.create_time}}',
			'{{ticket.dispose_time}}',
			'{{ticket.end_time}}',
			'{{ticket.take_time}}',
			'{{ticket.deadtime}}',
			'{{ticket.is_timeout}}',
			'{{ticket.timeout}}',
			'{{ticket.ticket_form}}'
		];

		$detailValueReplace = [
			$ticket['title'],
			$status_name,
			$priority,
			$publish,
			$handler ? $handler : 'none',
			getDates($ticket['create_time']),
			$ticket['dispose_time'] ? getDates($ticket['dispose_time']) : 'none',
			$ticket['end_time'] ? getDates($ticket['end_time']) : 'none',
			$ticket['take_time'],
			$ticket['deadtime'],
			$ticket['is_timeout'],
			$ticket['timeout'],
			$ticketFormHtml
		];

		$detailTemplate = str_replace($detailKeySearch,$detailKeyReplace,$detailTemplate);

		$detailTemplate = str_replace($detailValueSearch,$detailValueReplace,$detailTemplate);

//		工单回复
		$reply = D("TicketReply")
			->alias('a')
			->join('feel_member AS b ON a.member_id = b.member_id','left')
			->where(["ticket_id"=>$ticket_id])
			->field('reply_id,ticket_id,reply_content,reply_time,b.face,b.name')
			->order("reply_id asc")
			->fetchAll();

		$replyContent = '';

		foreach($reply as &$rv1)
		{
			if(!$rv1['face']) $rv1['face'] = C('HTTP_PROTOCOL')."://".C('HOST_DOMAIN')."/Attachs/face/default.jpg";

			$attachments = M('upload_file')->where(['reply_id'=>$rv1['reply_id']])->select();

			$attachItem = '';

			foreach($attachments as $at)
			{
				$attachItem .= "<div class='attach-item'><a href='{$at['file_link']}'>{$at['file_name']}</a><span>（".getFileSize($at['file_size'])."）</span></div>";
			}

			$replyTemplate = C('PDF_TEMP')['reply'];

			$replyTemplate = str_replace(
				["{{face}}","{name}","{{reply_time}}","{{reply_content}}","{{reply_attach}}"],
				[$rv1['face'],$rv1['name'],date('Y-m-d H:i',$rv1['reply_time']),htmlspecialchars_decode($rv1['reply_content']),$attachItem],
				$replyTemplate
			);

			$replyContent .= $replyTemplate;
		}

		$stylesheet = file_get_contents('./Public/css/pdf.css');

		$pdfTemplate .= "<style>{$stylesheet}</style>";

		$replyContent = "<div class='feeldesk-reply-content'><div class='reply-title'>".L('REPLY_LIST')."</div>{$replyContent}</div>";

		Vendor('mpdf.mpdf');

//		文件名称
		$filename = "{$ticket['title']} ".L('SERVICE_REPORT');

		$pdfTemplate = str_replace(['{{header}}','{{detail_content}}','{{reply_content}}'],[$filename,$detailTemplate,$replyContent],$pdfTemplate);

//		语言 | 纸张格式 | 默认字体大小 | 默认字体 | 左边距 | 右边距 | 上边距 | 下边距
		$mpdf = new \mPDF('zh-cn','A4', 0, '宋体', 0, 0,0,0);

		$mpdf->useAdobeCJK = true;

//echo $pdfTemplate;die;

//		设置标题
		$mpdf->SetTitle($filename.".pdf");

//		写入css内容
		$mpdf->WriteHTML($stylesheet,1);

//		写入文件内容
		$mpdf->WriteHTML($pdfTemplate);

//		$mpdf->Output($filename,true);

//		$mpdf->Output($filename,'d');直接下载

		$mpdf->Output($filename.".pdf",'I');

		$mpdf->Output();
	}


//    导入工单
	public function import()
	{
		$result = D('Ticket')->importTicket($this->_company_id,$this->member_id,self::$first_status['status_id']);

		$this->ajaxReturn($result);
	}


//    导出工单
	public function export($action = '')
	{
		if(IS_AJAX)
		{
			$export = C('EXPORT');

			$where = session('TicketExportWhere');

			$data = I('get.exportList');

			$member_id = I('get.id');

			if(!$data) $this->ajaxReturn(['msg'=>L('SELECT_EXPORT')]);

			$exportList = $tableHeader = $letter = $excelData = [];

			$field = ['ticket_id'];

			foreach($export as $k=>$v)
			{
				if(in_array($v['identity'],$data))
				{
					$exportList[$k] = $v['identity'];

					array_push($field,$v['identity']);

					$tableHeader[] = $v['name'];
				}
			}

//			过滤非ticket数据表字段
			$field = implode(',',array_diff($field,['timeout','timeout_period','reply_content']));

			if($member_id > 0)
			{
				$tickets = $this->$action($member_id,'export',$where,$field);
			}
			else
			{
				$tickets = $this->$action('export',$where,$field);
			}

//			模板自定义表单
			if($data['form'])
			{
				foreach($data['form']['name'] as $nv)
				{
					array_push($tableHeader,$nv);
				}

//			    将 回复内容 移到表最后一列
				if(in_array('reply_content',$data))
				{
					$key = array_search('reply_content',$data);

					array_push($tableHeader,$tableHeader[$key]);

					unset($tableHeader[$key]);

					$tableHeader = array_values($tableHeader);
				}
			}

//            整合表格数据，列内容
			foreach($tickets as $k=>$v)
			{
				foreach($v as $k1=>&$v1)
				{
					if(!in_array($k1,$exportList) && $k1 != 'ticket_id') unset($v[$k1]);
				}

				$excelData[] = $v;
			}

//			交集 - 存在发布人、处理人、回复则查询用户表
			if(array_intersect($data,['member_id','dispose_id','reply_content']))
			{
				$members = D('Member')->where(['company_id'=>$this->_company_id])->field('member_id,name')->fetchAll();
			}
			else
			{
				$members = [];
			}

            $excelData = $this->feelecYieldToArray($excelData);

            $yieldData = [];

			foreach($excelData as $k=>$v)
			{
			    $yieldData[$k] = $v;

				if($v['ticket_from']) $yieldData[$k]['ticket_from'] = D('Ticket')->getTicketFrom($v['ticket_from']);

				if($v['status_id']) $yieldData[$k]['status_id'] = D('Ticket')->getFieldInfo('ticket_status',['status_id'=>$v['status_id']],'status_name',1);

				if($v['ticket_model_id']) $yieldData[$k]['ticket_model_id'] = D('Ticket')->getFieldInfo('ticket_model',['ticket_model_id'=>$v['ticket_model_id']],'ticket_model_name',1);

				if($v['priority']) $yieldData[$k]['priority'] = D('Ticket')->getPriority($v['priority']);

				if($v['member_id']) $yieldData[$k]['member_id'] = $members[$v['member_id']]['name'];

				if($v['dispose_id']) $yieldData[$k]['dispose_id'] = $members[$v['dispose_id']]['name'];

				if($v['create_time']) $yieldData[$k]['create_time'] = "\t".getDates($v['create_time']);

				if($v['end_time']) $yieldData[$k]['end_time'] = "\t".getDates($v['end_time']);

//				  是否超时
				if(in_array('timeout',$data))
				{
//                    完成期限
					$deadTime  = M('ticket_deadlines')->where(['company_id'=>$this->_company_id,'ticket_id'=>$v['ticket_id']])->getField('deadtime');

					if($deadTime)
					{
						$timeout = checkTicketIsTimeoutByCron($deadTime,$tickets[$v['ticket_id']]['end_time']);
					}
					else
					{
						$timeout = checkIsTimeout($v['ticket_id'],$tickets[$v['ticket_id']]['create_time'],$tickets[$v['ticket_id']]['end_time']);
					}

					$yieldData[$k]['timeout'] = strip_tags($timeout);
				}

//				  超时时长
				if(in_array('timeout_period',$data))
				{
//                    完成期限
					$deadTime  = M('ticket_deadlines')->where(['company_id'=>$this->_company_id,'ticket_id'=>$v['ticket_id']])->getField('deadtime');

					if($deadTime)
					{
						$timeout_period = checkTicketIsTimeoutByCron($deadTime,$tickets[$v['ticket_id']]['end_time']);
					}
					else
					{
						$timeout_period = checkIsTimeout($v['ticket_id'],$tickets[$v['ticket_id']]['create_time'],$tickets[$v['ticket_id']]['end_time'],true);
					}

					$yieldData[$k]['timeout_period'] = strip_tags($timeout_period);

				}

//				  模板自定义表单值
				if($data['form'])
				{
					foreach($data['form']['id'] as $dv)
					{
						$content = D('Ticket')->getFieldInfo('ticket_detail',['ticket_id'=>$v['ticket_id'], 'ticket_form_id'=>$dv],'ticket_form_content');

						$yieldData[$k][] = "\t".strip_tags(getHtml($content));
					}
				}

//				  回复内容
				if(in_array('reply_content',$data))
				{
					$replys = M('ticket_reply')
						->where(['ticket_id'=>$v['ticket_id'],'company_id'=>$this->_company_id])
						->field('member_id,reply_content,reply_time')
						->order('reply_id asc')
						->select();

                    $replys = $this->feelecYieldToArray($replys);

					foreach($replys as $r)
					{
						$content = strip_tags(getHtml($r['reply_content']));

						$reply_content[] = "【回复人：{$members[$r['member_id']]['name']}，回复时间：".getDates($r['reply_time'])."，回复内容：{$content}】";
					}

					if(isset($reply_content) && $reply_content)
					{
						$yieldData[$k]['reply_content'] = str_replace(["\r","\n"],'',implode(' | ',$reply_content));//去除换行，防止单元格内容换行
					}
					else
					{
						$yieldData[$k]['reply_content'] = '';
					}

					unset($reply_content,$replys);
				}

				unset($yieldData[$k]['ticket_id']);
			}

			$excel = ['header' => $tableHeader,'excelData' => $yieldData];

			session('TicketExcelData',$excel);

			$this->ajaxReturn(['msg'=>'success','url'=>U('Ticket/export'),'download'=>true]);
		}
		else
		{
			$tableHeader = session('TicketExcelData')['header'];

			$excelData   = session('TicketExcelData')['excelData'];

			$filename = 'Ticket-'.date('YmdHis').'.csv';

			$csv = new Csv();

			$csv->exportCsv($excelData,$tableHeader,$filename);
		}
	}


    /**
    * Yield生成器处理
    * @param array $data 需要处理的数据
    * @return Generator
    */
    public function feelecYieldToArray($data)
    {
    	foreach ($data as $value)
    	{
    		yield $value;
    	}
    }
}
