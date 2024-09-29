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
namespace Index\Widget;

use Think\Controller;

class MenuWidget extends Controller
{
	protected static $company;

	protected static $member;

	public function _initialize()
	{
		self::$company = session('company');

		self::$member = session('index');
	}


    public function menu()
    {
        $lang = cookie('think_language');

	    $allMenus = D('Menu')->where(['apply'=>10,'is_show'=>1])->order('orderby asc')->fetchAll();

//        当前角色权限
	    $auth = S('menuData/ticket_role_auth_'.self::$company['company_id'].'_'.self::$member['role_id']);

        $menu = [];

        foreach($allMenus as $k=>&$v)
        {
            if($lang == 'en-us') $v['menu_name'] = $v['name_en'];

            if($lang == 'ja-jp') $v['menu_name'] = $v['name_jp'];

            if(in_array($k,$auth))
            {
                $menu[$k] = $allMenus[$k];
            }
        }

        $menuList = getMenuTree($menu);

        $groupIds = M('member')->where(['member_id'=>self::$member['member_id']])->getField('group_id');

        $groupAuth = M('group')->where(['group_id'=>['in',$groupIds]])->field('ticket_auth')->select();

        $groupTicketAuth = 0;

        foreach($groupAuth as $gv)
        {
            if($gv['ticket_auth'] == 10) $groupTicketAuth = 1;
        }

        if(self::$company['ticket_auth'] == 10 && $groupTicketAuth == 1)
        {
            session('ticket_menu'.self::$member['role_id'],$menuList);

            $this->assign('ticketAuth',1);
        }

//        组织架构权限
        $organizeAuth = D('RoleAuth')->checkRoleAuthByMenu(self::$company['company_id'],'organize/index',self::$member['role_id']);

        if($organizeAuth)
        {
            session('organize_menu'.self::$member['role_id'],$menuList[$organizeAuth]);

            $this->assign('organizeAuth',1);
        }

//        设置权限
        $settingAuth = D('RoleAuth')->checkRoleAuthByMenu(self::$company['company_id'],'setting/index',self::$member['role_id']);

        if($settingAuth)
        {
            session('setting_menu'.self::$member['role_id'],[$menuList[$settingAuth]]);

            $this->assign('settingAuth',1);
        }

//        系统消息
        $message = D('SystemMessage')
		->where(['company_id'=>self::$company['company_id'],'recipient_id'=>self::$member['member_id'],'recipient'=>1,'read_status'=>1])
        ->limit(0,99)
        ->count('msg_id');

//        登录状态
	    $login_status = M('member')->where(['member_id'=>self::$member['member_id']])->getField('login_status');

	    $this->assign('login_status',$login_status);

        $this->assign('hour',date('H',time()));

        $this->assign('countMessage',$message);

        $this->display('Widget:menu');
    }


    public function ticket()
    {
        if(session('?ticket_menu'.self::$member['role_id']))
        {
            $this->assign('ticketMenu',session('ticket_menu'.self::$member['role_id']));
        }

        $this->display('Widget:ticket');
    }


    public function organize()
    {
        if(session('?organize_menu'.self::$member['role_id']))
        {
            $this->assign('organizeMenu',session('organize_menu'.self::$member['role_id']));
        }

        $this->display('Widget:organize');
    }


    public function setting()
    {
        if(session('?setting_menu'.self::$member['role_id']))
        {
            $this->assign('settingMenu',session('setting_menu'.self::$member['role_id']));
        }

        $this->display('Widget:setting');
    }


    public function interfaces()
    {
        if(session('?interface_menu'.self::$member['role_id']))
        {
            $this->assign('interfaceMenu',session('interface_menu'.self::$member['role_id']));
        }

        $this->display('Widget:interfaces');
    }
}
