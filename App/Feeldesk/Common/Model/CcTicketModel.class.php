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

class CcTicketModel extends BasicModel
{
	protected $pk   = 'cc_id';

	protected $tableName = 'cc_ticket';

	/*
	* 修改工单 - 更新抄送人
	* @param int   $company_id 公司ID
	* @param int   $ticket_id  工单ID
	* @param array $cc         抄送人ID
	* @param array $publish_id 发布人
	* @param int   $dispose_id 处理人
	*/
	public function updateCcByEditorTicket($company_id,$ticket_id,$cc,$publish_id,$dispose_id)
	{
		if(!empty($cc))
		{
//            更新抄送人 —— 查询原抄送人
			$oldCc = M('cc_ticket')->where(['ticket_id'=>$ticket_id])->field('member_id')->select();

//			  原抄送人
			$oldCcIds = array_column($oldCc,'member_id');

//			  过滤处理人和发布人
			$cc = array_diff($cc,[$publish_id,$dispose_id]);

//			  待删除的抄送人
			$deleteCcIds = array_diff($oldCcIds,$cc);

			if($deleteCcIds)
			{
//				  删除抄送人
				M('cc_ticket')->where(['ticket_id'=>$ticket_id,'member_id'=>['in',$deleteCcIds]])->delete();
			}

//			  新抄送人
			$addCcIds = array_diff($cc,$oldCcIds);

			$ccData = ['company_id'=>$company_id,'ticket_id'=>$ticket_id];

			foreach($addCcIds as $k=>$v)
			{
				$ccData['member_id'] = $v;

//                添加参与者
				D('TicketPartake')->createPartake($company_id,$v,$ticket_id,true);

//				  添加抄送人
				M('cc_ticket')->add($ccData);
			}

			if($addCcIds)
			{
//                通知新抄送人
				D('BuildMessage')->CcMessageByCreate($company_id,$ticket_id,array_values($addCcIds));
			}
		}
	}


	/*
	* 内部协作回复 - 更新抄送人
	* @param int   $company_id 公司ID
	* @param int   $ticket_id  工单ID
	* @param array $cc         新抄送人ID
	*/
	public function updateCcByInsideReplyTicket($company_id,$ticket_id,$cc)
	{
//        查询原有的抄送人
		$old_cc = D('CcTicket')->where(['company_id'=>$company_id,'ticket_id'=>$ticket_id])->field('member_id')->select();

		$oldCcId = array_column($old_cc,'member_id');

		$newCcId = [];

//		  新抄送人
		$new_cc = array_diff($cc,$oldCcId);

		$add = ['company_id'=>$company_id,'ticket_id'=>$ticket_id];

//		  添加抄送人
		foreach($new_cc as $k => $v)
		{
			$newCcId[] = $v;

			$add['member_id'] = $v;

			$this->add($add);
		}

		$cc_data = ['new_cc_id'=>$newCcId,'old_cc_id'=>$oldCcId];

		return $cc_data;
	}
}
