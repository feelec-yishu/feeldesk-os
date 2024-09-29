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

class TicketViewModel extends BasicModel
{
	protected $pk   = 'view_id';

	protected $tableName = 'ticket_view';


	public function getTicketView($company_id = 0)
    {
        $viewName = $this->getNameByLang('view_name');

        $ticketView = $this->order('view_id asc')->field("view_id,{$viewName},field_name,field_icon")->order('orderby asc')->select();

        $companyViews = M('company_ticketview')->where(['company_id' => $company_id,'is_show'=>10])->order('view_id asc')->select();

        $companyViewIds = [];

        foreach($companyViews as $cv)
        {
            $companyViewIds[] = $cv['view_id'];
        }

        $ticketViews = [];

        foreach($ticketView as &$tv)
        {
            if(in_array($tv['view_id'],$companyViewIds))
            {
                $tv['is_view'] = 1;
            }

            $ticketViews[$tv['view_id']] = $tv;
        }

        return $ticketViews;
    }
}
