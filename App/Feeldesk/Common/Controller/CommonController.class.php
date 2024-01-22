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
namespace Common\Controller;

use Think\Controller;

use Think\Crypt\Driver\Crypt;

class CommonController extends Controller
{
    /* FeelDesk模块初始化
    * @param $source        来源
    * @param $user          登录用户信息
    * @param $user_id       登录用户ID
    * @param $company_id    登录用户所属公司ID
    * @param $token         唯一登录token
    * @param $lang          当前语言
    * @param $sms           短信开关
    */
    public function feelDeskInit($source,&$user,&$user_id,&$company_id,&$token,&$lang,&$company,$systemHost = '')
    {
        if(!session('?'.$source))
        {
        	$host = C('HTTP_PROTOCOL').'://'.C('HOST_DOMAIN');

	        $url = $host."/u-login";

            if(!$systemHost)
			{
				$this->redirect($url);
			}
			else
			{
				header("location:".$url);die;
			}
        }
        else
        {
            $user = session($source);

            $user_id = $user['member_id'];

            $company_id = $user['company_id'];

	        session('company_id',$company_id);

	        $company = M('company')->where(['company_id'=>$company_id])->find();

	        session('company',$company);

			// 检查是否有相应语言版本权限
            if(!$lang = checkLangAuth()) $this->_empty();

            if($source === 'index')
            {
	            D('FeelRoleAuth')->getMenuIdsByRoleId($user['role_id']);

                $groupIds = M('member')->where(['member_id'=>$user['member_id']])->getField('group_id');

                if($groupIds)
                {
               	    // 部门 - 系统权限
	                $groupAuth = M('group')->where(['group_id'=>['in',$groupIds]])->field('ticket_auth')->select();

	                $groupTicketAuth = 0;

	                foreach($groupAuth as $gv)
	                {
		                if($gv['ticket_auth'] == 10)
		                {
			                $groupTicketAuth = 1;
		                }
	                }

	                if(MODULE_NAME === 'Index')
	                {
		                $hasAuth = D('RoleAuth')->checkRoleAuthByMenu($company_id,'',$user['role_id']);
	                }
	                else
	                {
		                $hasAuth = false;
	                }

	                if(!$hasAuth)
	                {
		                if(IS_AJAX)
		                {
			                $this->ajaxReturn(['status'=>0,'msg'=>L('NO_OPERATE')]);
		                }
		                else
		                {
			                $this->error(L('NO_AUTH'));die;
		                }
	                }

	                $groupSystemAuth = ['ticket_auth'=>$groupTicketAuth];

	                session('GROUP_SYSTEM_AUTH_'.$company_id.'_'.$user['member_id'],$groupSystemAuth);

	                $this->assign('groupSystemAuth',$groupSystemAuth);
                }
            }

            $token = $company['login_token'];

            $user['firmLogo'] = $company['logo'];//公司LOGO

//            更新用户活动时间
            M('member')->where(['member_id'=>$user_id])->setField('last_active_time',time());

            session($source,$user);

            if($lang == 'zh-hans-cn') $lang = 'zh-cn';

//			微信端游客访问
	        if($source == 'wuser' && $user['member_type'] == 2)
	        {
		        if(CONTROLLER_NAME == 'Ticket')
		        {
			        $url = '/cw-query-ticket-detail/'.I('get.id');
		        }
		        else
		        {
			        $url = '/cw-faq';
		        }

		        $this->redirect($url);
	        }

            $this->assign('lang',$lang);

            $this->assign($source,$user);

            $systemName = I('get.system') ? I('get.system') : MODULE_NAME;

            $this->assign('system',$systemName);

            $this->assign('controllerAndAction','/'.MODULE_NAME.'/'.CONTROLLER_NAME.'/'.ACTION_NAME);
        }
    }


    public function _empty()
    {
        header("HTTP/1.0 404 Not Found");//使HTTP返回404状态码

        $this->display("Public:404");
    }
}
