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

class TicketPartakeModel extends BasicModel
{
	protected $pk   = 'id';

	protected $tableName = 'ticket_partake';

	/*
	* 添加工单参与人
	* @param int $company_id 公司ID
	* @param int $member_id 参与人ID
	* @param int $ticket_id 工单ID
	* @param bool $isChecked 是否查重
	*/
	public function createPartake($company_id = 0,$member_id = 0,$ticket_id = 0,$isChecked = false)
	{
		$partakeData = [
			'company_id' => $company_id,
			'member_id'  => $member_id,
			'ticket_id'  => $ticket_id
		];

		if($isChecked)
		{
			$id = M('ticket_partake')->where($partakeData)->getField('id');

			if(!$id)
			{
				$partakeData['create_time'] = NOW_TIME;

				$this->add($partakeData);
			}
		}
		else
		{
			$partakeData['create_time'] = NOW_TIME;

			$this->add($partakeData);
		}
	}
}
