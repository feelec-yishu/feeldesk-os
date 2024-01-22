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

class TicketViewController extends  BasicController
{
    public function index()
	{
	    $ticketView = D('TicketView')->getTicketView($this->_company_id);

	    foreach($ticketView as &$v)
	    {
	        if($v['is_view'] == 1)
	        {
                $v['class'] = 'enable';

                $v['state_name'] = L('SHOW');

                $v['btn_name'] = L('HIDE');

                $v['is_show'] = 20;
            }
            else
            {
                $v['class'] = 'disable';

                $v['state_name'] = L('HIDE');

                $v['btn_name'] = L('SHOW');

                $v['is_show'] = 10;
            }
        }

        $this->assign('ticketView',$ticketView);

		$this->display();
    }



	public function edit()
	{
		$is_show = I("post.is_show");

		$view_id = I("post.id");

		if(!M('ticket_view')->find($view_id))
		{
            $data = ['status'=>0,'msg'=>L('ILLEGAL_ACCESS')];
		}
		else
		{
			$field = ['company_id'=>$this->_company_id,'view_id'=>$view_id];

			if(M('company_ticketview')->where($field)->find())
			{
                $result = M('company_ticketview')->where($field)->save(['is_show'=>$is_show]);
            }
            else
            {
                $field['is_show'] = $is_show;

                $result = M('company_ticketview')->add($field);
            }

			if($result !== false)
			{
			    $data = ['status'=>1,'msg'=>L('UPDATE_SUCCESS'),'url'=>U('ticketView/index')];
			}
			else
			{
                $data = ['status'=>0,'msg'=>L('UPDATE_FAILED')];
			}
		}

        $this->ajaxReturn($data);
	}
}
