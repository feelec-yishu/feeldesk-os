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

use Think\Cache\Driver\Redis;

class GroupModel extends BasicModel
{
	protected $pk   = 'group_id';

	protected $tableName = 'group';

//	获取工单处理部门管理员,目前仅适用于审核工单的审核人为部门主管的情况
	public function getProcessGroupManager($company_id = 0,$template_id = 0,$group_id = 0)
	{
		if(!$group_id)
		{
//            默认处理部门
			$handle_group_id = M('group')->where(['company_id'=>$company_id,'is_default'=>20,'ticket_auth'=>10])->getField('group_id');

			if($template_id > 0)
			{
				$where = ['company_id'=>$company_id,'channel'=>'template','route_value'=>$template_id];
			}
			else
			{
				$where = ['company_id'=>$company_id,'channel'=>'mail'];
			}

//		      路由处理部门
			$route_group_id = M('route')->where($where)->getField('group_id');

			$group_id = $route_group_id ? $route_group_id : $handle_group_id;
		}

		return $this->where(['group_id' =>$group_id])->getField('manager_id');
	}


	public function assignDisposeByGroupId($company_id,$template_id = 0,$group_id = 0)
    {
        if($group_id > 0)
        {
            $handle_group_id = $group_id;
        }
        else
        {
            if($template_id > 0)
            {
                $where = ['company_id'=>$company_id,'channel'=>'template','route_value'=>$template_id];
            }
            else
            {
                $where = ['company_id'=>$company_id,'channel'=>'mail'];
            }

            $group_id = M('route')->where($where)->getField('group_id');

            if($group_id > 0)
            {
	            $handle_group_id = $group_id;
            }
            else
            {
//                默认处理部门
	            $handle_group_id = M('group')->where(['company_id'=>$company_id,'is_default'=>20,'ticket_auth'=>10])->getField('group_id');
            }
        }

        $redis = new Redis();

//        部门下当前在线的客服
        if($redis->lLen($company_id.'_'.$handle_group_id.'_route_mail_disposeId') == 0)
        {
            $groupMemberWhere = [
                'company_id'        =>$company_id,
                "find_in_set('{$handle_group_id}',group_id)",
                'type'              =>1,
                'login_status'      =>1,//当前登录状态，1在线 2；
                'closed'            =>0,
            ];

            $groupMembers = M('member')->where($groupMemberWhere)->order('member_id asc')->field('member_id')->select();

	        if(!empty($groupMembers))
            {
                foreach($groupMembers as $m)
                {
                    $redis->rPush($company_id.'_'.$handle_group_id.'_route_mail_disposeId',$m['member_id']);
                }

//                缓存有效期2小时
	            $redis->expire($company_id.'_'.$handle_group_id.'_route_mail_disposeId',2*3600);
            }
        }

        $data = ['group_id'=>$handle_group_id,'wait_assign_status'=>0];

//        按客服ID轮流分配处理人
        $dispose_id = $redis->lpop($company_id.'_'.$handle_group_id.'_route_mail_disposeId');

        if($dispose_id > 0)
        {
            $data['recipient_id'] = $data['dispose_id'] = $dispose_id;

            $data['assign_time'] = NOW_TIME;

            $data['wait_assign_status'] = 1;
        }

        return $data;
    }


    /*
	* @param int $company_id 公司ID
	* @param array $deleteGroup 待删除的部门信息
	* @param int $transfer_group_id 转移数据的部门ID
	* @return array
	*/
    public function deleteGroup($company_id,$deleteGroup,$transfer_group_id)
    {
	    $where = ['company_id'=>$company_id,'group_id'=>$deleteGroup['group_id']];

	    $delete = M('group')->where($where)->delete();

	    if($delete)
	    {
//            如果删除的部门是默认部门，则将转移的部门设为默认部门
		    if($deleteGroup['is_default'] == 20)
		    {
			    $this->where(['company_id'=>$company_id,'group_id'=>$transfer_group_id])->setField('is_default',20);
		    }

//            更新相关用户部门信息
		    $waitUpdateMembers = M('member')->where(['company_id'=>$company_id,'type'=>1,"find_in_set('{$deleteGroup['group_id']}',group_id)"])->field('member_id,group_id')->select();

		    foreach($waitUpdateMembers as $k1=>&$v1)
		    {
			    $groupIds = explode(',',$v1['group_id']);

			    $v1['group_id'] = implode(',',array_unique(array_merge(array_diff($groupIds, [$deleteGroup['group_id']]),[$transfer_group_id])));

			    M('member')->save($v1);
		    }

		    $where = ['company_id'=>$company_id,'group_id'=>$deleteGroup['group_id']];

//		      更新工单数据
		    $hasTicket = M('ticket')->where($where)->getField('ticket_id');

		    if($hasTicket)
		    {
			    M('ticket')->where($where)->save(['group_id'=>$transfer_group_id]);
		    }

//		      更新路由数据
		    $hasRoute = M('route')->where($where)->getField('route_id');

		    if($hasRoute)
		    {
			    M('route')->where($where)->save(['group_id'=>$transfer_group_id]);
		    }

		    $result = ['errcode'=>0,'msg'=>L('DELETE_SUCCESS')];
	    }
	    else
        {
            $result = ['errcode'=>1,'msg'=>L('DELETE_FAILED')];
	    }

	    return $result;
    }
}
