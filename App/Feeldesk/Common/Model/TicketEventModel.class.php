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
namespace Common\Model;

class TicketEventModel extends BasicModel
{
	protected $pk   = 'event_id';

	protected $tableName = 'ticket_event';

	protected $eventType = ['create','modify','reply','team_reply','status','progress_node','assign','assign_operate','receive','restart','associate',
        'cancel_associate','urge','comment','delete','recover','priority','pass','reject','resubmit_audit','follow','unfollow'];

	protected $getLangByEventType = [
        'create'            => 'RELEASE_TICKET',
        'modify'            => 'EDITOR_TICKET',
        'reply'             => 'REPLYED_TICKET',
        'team_reply'        => 'TEAM_REPLYED_TICKET',
        'status'            => 'STATE_UPDATE',
        'progress_node'     => 'PROGRESS_NODE_UPDATE',
        'receive'           => 'RECEIVE_TICKET',
        'assign'            => 'ASSIGNED_TICKET',
        'assign_operate'    => 'ASSIGN_TICKET_OPERATE',
        'restart'           => 'RESTARTED_TICKET',
        'associate'         => 'ASSOCIATED_TICKET',
        'cancel_associate'  => 'CANCEL_ASSOCIATE_TICKET',
        'urge'              => 'URGE_TICKET_EVENT',
        'comment'           => 'COMMENT_REPLY_EVENT',
        'delete'            => 'DELETE_TICKET_EVENT',
        'recover'           => 'RECOVER_TICKET_EVENT',
        'pass'              => 'PASS_TICKET_EVENT',
        'reject'            => 'REJECT_TICKET_EVENT',
        'resubmit_audit'    => 'RESUBMIT_AUDIT',
        'priority'          => 'PRIORITY_TICKET_EVENT',
        'follow'            => 'FOLLOW_TICKET_EVENT',
        'unfollow'          => 'UNFOLLOW_TICKET_EVENT',
    ];

	protected $userType = ['1'=>'USER','2'=>'MEMBER','4'=>'ONLINE_SERVICE','5'=>'VISITOR'];

    /*
    * 保存工单事件
    * @param int    $ticket_id              工单ID
    * @param string $event_type             事件类型
    * @param int    $member_id              成员ID
    * @param int    $reply_id               回复ID
    * @param int    $status_id              状态ID
    * @param int    $reply_id               回复id
    * @param int    $associated_id          关联工单ID
    * @param int    $cancel_associate_id    取消关联工单ID
    * @param int    $priority_id            优先级ID
    * @param int    $reject_id              驳回工单理由ID
    * @param int    $opinion_id             审批意见ID
    * @param int    $modify_recode_id       修改记录ID
    * @return string
    */
	public function saveEvent($eventData = [])
	{
	    $company_id = M('ticket')->where(['ticket_id'=>$eventData['ticket_id']])->getField('company_id');

		if(in_array($eventData['event_type'],$this->eventType))
		{
			$event['company_id'] = $company_id;

			$event['ticket_id'] = $eventData['ticket_id'];

            $eventField = ['event_type','member_id','reply_id','status_id','receive_id','associated_id','cancel_associate_id','priority_id','reject_id',
	            'opinion_id','modify_recode_id'];

            foreach($eventField as $efv)
            {
	            $event[$efv] = isset($eventData[$efv]) ? $eventData[$efv] : 0;
            }

			if(APP_MODE != 'cli')
			{
				$event['ip'] = Getip();

				$event['user_agent'] = $_SERVER['HTTP_USER_AGENT'] ? $_SERVER['HTTP_USER_AGENT'] : 'API';
			}
			else
			{
				$event['ip'] = 'CLI';

				$event['user_agent'] = 'CLI';
			};

			$event['create_time']   = NOW_TIME;

			$event_id = $this->add($event);

			return $event_id;
		}
	}


	public function getEvent($where=[],$page = 15)
    {
        $count = $this->alias('a')
            ->join('feel_ticket as b on a.ticket_id = b.ticket_id')
            ->join('feel_member as c on a.member_id = c.member_id')
            ->field('event_type,title,a.ticket_id,a.create_time,a.member_id,a.status_id,c.name')
            ->where($where)
            ->count('event_id');

        $Page = new \Think\Page($count, $page);

        $event = $this->alias('a')
            ->join('feel_ticket as b on a.ticket_id = b.ticket_id')
            ->join('feel_member as c on a.member_id = c.member_id')
            ->field('event_type,title,a.ticket_id,a.create_time,a.member_id,a.status_id,c.name,c.type,associated_id,cancel_associate_id,priority_id,reject_id,opinion_id,modify_record_id')
            ->where($where)
            ->limit($Page->firstRow, $Page->listRows)
            ->order('a.create_time desc')
            ->select();

        $events = [];

        $statusName = D('TicketStatus')->getNameByLang('status_name');

        $ticketStatus = D('TicketStatus')->where(['company_id'=>session('company_id')])->field("*,{$statusName}")->fetchAll();

        foreach($event as $k=>$v)
        {
            $v['userTypeName'] = L($this->userType[$v['type']]);

            $v['ticket_id'] = encrypt($v['ticket_id'],'TICKET');

	        if($v['event_type'] == 'modify')
	        {
		        $param = ['title'=>" <a href='javascript:' class='ellipsis' mini='ticketDetail' data-id='{$v['ticket_id']}'>{$v['title']}</a> "];

		        if($v['modify_record_id'])
		        {
			        $str = L('MODIFY_RECORD',['ticket_id'=>$v['ticket_id'],'modify_id'=>$v['modify_record_id']]);

			        $v['eventTypeLang'] = L($this->getLangByEventType[$v['event_type']],$param).$str;
		        }
		        else
		        {
			        $v['eventTypeLang'] = L($this->getLangByEventType[$v['event_type']],$param);
		        }
	        }
            else if($v['event_type'] == 'status')
            {
                $param = ['title'=>" <a href='javascript:' class='ellipsis' mini='ticketDetail' data-id='{$v['ticket_id']}'>{$v['title']}</a> ",'color'=>$ticketStatus[$v['status_id']]['status_color'],'status_name'=>$ticketStatus[$v['status_id']]['lang_name']];

                $v['eventTypeLang'] = L($this->getLangByEventType[$v['event_type']],$param);
            }
            else if($v['event_type'] == 'team_reply')
            {
                $v['eventTypeLang'] = L($this->getLangByEventType[$v['event_type']],['title'=>" <a href='javascript:' class='ellipsis' mini='ticketDetail' data-id='{$v['ticket_id']}'>{$v['title']}</a> "]);
            }
            else if($v['event_type'] == 'restart')
            {
                $v['eventTypeLang'] = L($this->getLangByEventType[$v['event_type']],['title'=>" <a href='javascript:' class='ellipsis' mini='ticketDetail' data-id='{$v['ticket_id']}'>{$v['title']}</a> "]);
            }
            else if($v['event_type'] == 'associate')
            {
                $title = M('ticket')->where(['ticket_id'=>$v['associated_id']])->getField('title');

                $param = ['title1'=>"<a href='javascript:' class='ellipsis' mini='ticketDetail' data-id='{$v['ticket_id']}' data-type='associate'>{$v['title']}</a>",'title2'=>"<a href='javascript:' class='ellipsis' mini='ticketDetail' data-id='".encrypt($v['associated_id'],'TICKET')."'>{$title}</a>"];

                $v['eventTypeLang'] = L($this->getLangByEventType[$v['event_type']],$param);
            }
            else if($v['event_type'] == 'cancel_associate')
            {
                $title = M('ticket')->where(['ticket_id'=>$v['cancel_associate_id']])->getField('title');

                $param = ['title1'=>"<a href='javascript:' class='ellipsis' mini='ticketDetail' data-id='{$v['ticket_id']}' data-type='associate'>{$v['title']}</a>",'title2'=>"<a href='javascript:' class='ellipsis' mini='ticketDetail' data-id='".encrypt($v['cancel_associate_id'],'TICKET')."'>{$title}</a>"];

                $v['eventTypeLang'] = L($this->getLangByEventType[$v['event_type']],$param);
            }
            else if($v['event_type'] == 'delete')
            {
	            $v['eventTypeLang'] = L($this->getLangByEventType[$v['event_type']],['title'=>" <a href='javascript:' class='ellipsis' mini='ticketDetail' data-id='{$v['ticket_id']}'>{$v['title']}</a> "]);
            }
            else if($v['event_type'] == 'recover')
            {
	            $v['eventTypeLang'] = L($this->getLangByEventType[$v['event_type']],['title'=>" <a href='javascript:' class='ellipsis' mini='ticketDetail' data-id='{$v['ticket_id']}'>{$v['title']}</a> "]);
            }
            else if($v['event_type'] == 'priority')
            {
	            $priority_name = D('Ticket')->getPriority($v['priority_id']);

	            $priority_class = D('Ticket')->getPriorityColor($v['priority_id']);

	            $param = [
		            'title'  => "<a href='javascript:' class='ellipsis' mini='ticketDetail' data-id='{$v['ticket_id']}'>{$v['title']}</a>",
		            'priority_class'=>$priority_class,
		            'priority_name'=>$priority_name,
	            ];

	            $v['eventTypeLang'] = L($this->getLangByEventType[$v['event_type']],$param);
            }
            else
            {
                $v['eventTypeLang'] = L($this->getLangByEventType[$v['event_type']]);
            }

            $v['create_at'] = date('H:i',$v['create_time']);

            $events[date('Y-m-d',$v['create_time'])][] = $v;
        }

        return ['events'=>$events,'pages'=>ceil($count/$page)];
    }



    public function getEventByTicketId($where=[],$page=10)
    {
        $count = $this->alias('a')
            ->join('feel_ticket as b on a.ticket_id = b.ticket_id')
            ->join('feel_member as c on a.member_id = c.member_id')
            ->where($where)
            ->count('event_id');

        $Page = new \Think\Page($count, $page);

        $event = $this->alias('a')
            ->join('feel_ticket as b on a.ticket_id = b.ticket_id')
            ->join('feel_member as c on a.member_id = c.member_id')
            ->field('event_type,title,a.ticket_id,a.create_time,a.member_id,a.status_id,c.name,c.type,associated_id,cancel_associate_id,
            priority_id,reject_id,opinion_id,modify_record_id')
            ->where($where)
            ->limit($Page->firstRow, $Page->listRows)
            ->order('a.create_time desc')
            ->select();

        $events = [];

        $statusName = D('TicketStatus')->getNameByLang('status_name');

        $ticketStatus = D('TicketStatus')->where(['company_id'=>session('company_id')])->field("*,{$statusName}")->fetchAll();

        foreach($event as $k=>$v)
        {
            $v['userTypeName'] = L($this->userType[$v['type']]);

            $v['ticket_id'] = encrypt($v['ticket_id'],'TICKET');

	        if($v['event_type'] == 'modify')
	        {
		        if($v['modify_record_id'])
		        {
			        $str = L('MODIFY_RECORD',['ticket_id'=>$v['ticket_id'],'modify_id'=>$v['modify_record_id']]);

			        $v['eventTypeLang'] = L($this->getLangByEventType[$v['event_type']],['title'=>'']).$str;
		        }
		        else
		        {
			        $v['eventTypeLang'] = L($this->getLangByEventType[$v['event_type']],['title'=>'']);
		        }
	        }
	        else if($v['event_type'] == 'status')
            {
                $param = ['title'=>'','color'=>$ticketStatus[$v['status_id']]['status_color'],'status_name'=>$ticketStatus[$v['status_id']]['lang_name']];

                $v['eventTypeLang'] = L($this->getLangByEventType[$v['event_type']],$param);
            }
            else if($v['event_type'] == 'team_reply')
            {
                $v['eventTypeLang'] = L($this->getLangByEventType[$v['event_type']],['title'=>'']);
            }
            else if($v['event_type'] == 'associate')
            {
                $title = M('ticket')->where(['ticket_id'=>$v['associated_id']])->getField('title');

                $param = ['title1'=>"<a href='javascript:' class='ellipsis' mini='ticketDetail' data-id='{$v['ticket_id']}' data-type='associate'>{$v['title']}</a>",'title2'=>"<a href='javascript:' class='ellipsis' mini='ticketDetail' data-id='".encrypt($v['associated_id'],'TICKET')."'>{$title}</a>"];

                $v['eventTypeLang'] = L($this->getLangByEventType[$v['event_type']],$param);
            }
            else if($v['event_type'] == 'cancel_associate')
            {
                $title = M('ticket')->where(['ticket_id'=>$v['cancel_associate_id']])->getField('title');

                $param = ['title1'=>"<a href='javascript:' class='ellipsis' mini='ticketDetail' data-id='{$v['ticket_id']}' data-type='associate'>{$v['title']}</a>",'title2'=>"<a href='javascript:' class='ellipsis' mini='ticketDetail' data-id='".encrypt($v['cancel_associate_id'],'TICKET')."'>{$title}</a>"];

                $v['eventTypeLang'] = L($this->getLangByEventType[$v['event_type']],$param);
            }
            else if($v['event_type'] == 'comment')
            {
                $v['eventTypeLang'] = L($this->getLangByEventType[$v['event_type']],['title'=>'']);
            }
            else if($v['event_type'] == 'priority')
            {
	            $priority_name = D('Ticket')->getPriority($v['priority_id']);

	            $priority_class = D('Ticket')->getPriorityColor($v['priority_id']);

	            $param = [
		            'title'  => '',
		            'priority_class'=>$priority_class,
		            'priority_name'=>$priority_name,
	            ];

	            $v['eventTypeLang'] = L($this->getLangByEventType[$v['event_type']],$param);
            }
            else
            {
                $v['eventTypeLang'] = L($this->getLangByEventType[$v['event_type']]);
            }

            $v['create_at'] = date('H:i',$v['create_time']);

            $events[date('Y-m-d',$v['create_time'])][] = $v;
        }

        return ['events'=>$events,'pages'=>ceil($count/$page)];
    }
}
