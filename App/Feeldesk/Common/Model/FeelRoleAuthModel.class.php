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

use Think\Model;

class FeelRoleAuthModel extends Model
{
    protected $autoCheckFields = false;

	/*
	* 通过角色ID查询角色权限，存入角色权限缓存
	* @param int $role_id       角色ID
	* @param string $source     系统
	* @return array
	*/
	public function getMenuIdsByRoleId($role_id = 0,$system = 'ticket')
	{
		if(S('menuData/'.$system.'_role_auth_'.session('company_id').'_'.$role_id))
		{
			$auth = S('menuData/'.$system.'_role_auth_'.session('company_id').'_'.$role_id);
		}
		else
		{
			$roleMenuIds = M('role_auth')->where(['company_id'=>session('company_id'),'role_id'=>$role_id])->getField('menu_id');

			$auth = json_decode($roleMenuIds,true);

			S('menuData/'.$system.'_role_auth_'.session('company_id').'_'.$role_id,$auth,3600);
		}

		return $auth;
    }
}
