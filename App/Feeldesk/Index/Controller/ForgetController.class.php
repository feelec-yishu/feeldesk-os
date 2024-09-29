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

use  Think\Controller;

class ForgetController extends Controller
{
	public function index()
	{
		$this->display();
	}


	public function sendVerifyCode()
	{
		$result = D('Forget')->sendVerifyCode(1);

		$this->ajaxReturn($result);
	}


	public function resetPassword($way = '')
	{
		if(IS_POST)
		{
			$result = D('Forget')->resetPassword(1);

			$this->ajaxReturn($result);
		}
		else
		{
			if(!$way) $this->error(L('SELECT_FIND_WAY'));

			$this->assign('way',$way);

			$this->display();
		}
	}


	public function reset_success()
	{
		$this->display();
	}
}
