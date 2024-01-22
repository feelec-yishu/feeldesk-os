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

class SubEventModel extends BasicModel
{
	protected $pk   = 'event_id';

	protected $tableName = 'sub_event';

	protected static $eventType = ['create','modify','reply','status','assign','urge','delete','recover'];

	protected static $getLangByEventType = [
        'create'            => 'SUBMITTED_SUB_TICKET',
        'modify'            => 'MODIFIED_SUB_TICKET',
        'reply'             => 'REPLY_SUB_TICKET',
        'status'            => 'SUB_STATE_UPDATE',
        'assign'            => 'ASSIGNED_SUB_TICKET',
        'delete'            => 'DELETE_SUB_TICKET',
        'recover'           => 'RECOVER_SUB_TICKET',
    ];

	protected static $statusName = ['1'=>'待处理','2'=>'已完成'];

    /*
    * 保存工单事件
    * @param int    $ticket_id              工单ID
    * @param string $event_type             事件类型
    * @param int    $member_id              成员ID
    * @param int    $reply_id               回复ID
    * @param int    $status_id              状态ID
    * @param int    $dispose_id             处理人ID
    * @param int    $reply_id               回复id
    * @return string
    */
	public function saveEvent($ticket_id=0,$event_type='',$member_id=0,$reply_id=0,$status_id=0,$dispose_id=0)
	{
	    $company_id = M('sub_ticket')->where(['ticket_id'=>$ticket_id])->getField('company_id');

		if(in_array($event_type,self::$eventType))
		{
			$event['company_id'] = $company_id;

			$event['ticket_id'] = $ticket_id;

			$event['ip'] = Getip();

			$event['user_agent'] = $_SERVER['HTTP_USER_AGENT'] ? $_SERVER['HTTP_USER_AGENT'] : 'API';

            $event['event_type']    = $event_type;

            $event['member_id']     = $member_id;

			$event['reply_id']      = $reply_id;

			$event['status_id']     = $status_id;

			$event['dispose_id']    = $dispose_id;

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
            ->count();

        $Page = new \Think\Page($count, $page);

        $event = $this->alias('a')
            ->join('feel_ticket as b on a.ticket_id = b.ticket_id')
            ->join('feel_member as c on a.member_id = c.member_id')
            ->field('event_type,title,a.ticket_id,a.create_time,a.member_id,a.status_id,c.name,c.type,associated_id,cancel_associate_id,priority_id,reject_id')
            ->where($where)
            ->limit($Page->firstRow, $Page->listRows)
            ->order('a.create_time desc')
            ->select();

        $events = [];

        foreach($event as $k=>$v)
        {
            $v['ticket_id'] = encrypt($v['ticket_id'],'TICKET');

            if($v['event_type'] == 'status')
            {
                $param = ['title'=>" <a href='javascript:' class='ellipsis' mini='ticketDetail' data-id='{$v['ticket_id']}'>{$v['title']}</a> ",'status_name'=>self::$statusName[$v['status_id']]];

                $v['eventTypeLang'] = L(self::$getLangByEventType[$v['event_type']],$param);
            }
            else if($v['event_type'] == 'delete')
            {
	            $v['eventTypeLang'] = L(self::$getLangByEventType[$v['event_type']],['title'=>" <a href='javascript:' class='ellipsis' mini='ticketDetail' data-id='{$v['ticket_id']}'>{$v['title']}</a> "]);
            }
            else
            {
                $v['eventTypeLang'] = L(self::$getLangByEventType[$v['event_type']]);
            }

            $v['create_at'] = date('H:i',$v['create_time']);

            $events[date('Y-m-d',$v['create_time'])][] = $v;
        }

        return ['events'=>$events,'pages'=>ceil($count/$page)];
    }


    public function getEventByTicketId($where=[],$page=10)
    {
        $count = $this->alias('a')
            ->join('feel_sub_ticket as b on a.ticket_id = b.ticket_id')
            ->join('feel_member as c on a.member_id = c.member_id')
            ->field('event_type,title,a.ticket_id,a.create_time,a.member_id,a.status_id,c.name')
            ->where($where)
            ->count();

        $Page = new \Think\Page($count, $page);

        $event = $this->alias('a')
            ->join('feel_sub_ticket as b on a.ticket_id = b.ticket_id')
            ->join('feel_member as c on a.member_id = c.member_id')
            ->field('event_type,title,a.ticket_id,a.create_time,a.member_id,a.status_id,c.name')
            ->where($where)
            ->limit($Page->firstRow, $Page->listRows)
            ->order('a.create_time desc')
            ->select();

        $events = [];

        foreach($event as $k=>$v)
        {
            $v['ticket_id'] = encrypt($v['ticket_id'],'SUB_TICKET');

            if($v['event_type'] == 'status')
            {
                $param = ['title'=>'','status_name'=>self::$statusName[$v['status_id']]];

                $v['eventTypeLang'] = L(self::$getLangByEventType[$v['event_type']],$param);
            }
            else
            {
                $v['eventTypeLang'] = L(self::$getLangByEventType[$v['event_type']]);
            }

            $v['create_at'] = date('H:i',$v['create_time']);

            $events[date('Y-m-d',$v['create_time'])][] = $v;
        }

        return ['events'=>$events,'pages'=>ceil($count/$page)];
    }
}
