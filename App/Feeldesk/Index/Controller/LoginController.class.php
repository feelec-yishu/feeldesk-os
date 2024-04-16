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

class LoginController extends Controller
{
	public function index()
	{
		if(session('?index'))
		{
			redirect('/u-home');
		}
		else
		{
			$login = cookie('user_login_cache');

            $this->assign('lang',strtolower(cookie('think_language')));

            $this->assign('login',$login);

			$this->display();
		}
	}


//    登录
	public function loging()
	{
		$result = D('Login')->login('index', 1);

		$this->ajaxReturn($result);
	}


//	  退出登录
    public function logout()
	{
		D('Login')->removeDisposeInRedis(session('index'),'index',true);

        $this->success(L('LOGIN_OUT_SUCCESS'),'/u-login');
    }
}
