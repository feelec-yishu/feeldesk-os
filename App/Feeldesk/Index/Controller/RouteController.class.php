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

class RouteController extends BasicController
{
    protected $_filter = ['route_name','channel','route_value','group_id'];

    public function _initialize()
    {
        parent::_initialize();

        $templateName = D('Ticketmodel')->getNameByLang('ticket_model_name');

        $templates = D('Ticketmodel')->where(['company_id'=>$this->_company_id])->field("*,{$templateName}")->fetchAll();

        $this->assign('templates',$templates);
    }


    public function index()
    {
	    $routes = M('route')->where(['company_id'=>$this->_company_id])->select();

//			部门
	    $department = M('Group')->where(['company_id'=>$this->_company_id,'closed'=>0,'ticket_auth'=>10])
		    ->field('group_id,group_name,parent_id,level,is_default')
		    ->select();

	    $default_id = D('Group')->where(['company_id'=>$this->_company_id,'closed'=>0,'ticket_auth'=>10,'is_default'=>20])->getField('group_id');

	    $departmentData = getSubjectTree($department,'group_id','parent_id','children');

//        权限 - 创建工单状态
	    $auth['create'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'Route/create',$this->_member['role_id']);

//        权限 - 修改工单状态
	    $auth['editor'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'Route/editor',$this->_member['role_id']);

//        权限 - 删除工单状态
	    $auth['delete'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'Route/delete',$this->_member['role_id']);

	    $data = ['routes'=>$routes,'jsonDepartmentData'=>json_encode($departmentData),'groups'=>fetchAll($department,'group_id'),'auth'=>$auth,'default_id'=>$default_id];

	    $this->assign('data',$data);

        $this->display();
    }


    public function create()
    {
        if(IS_POST)
        {
            $data = $this->checkCreate();

            if($route_id = M('route')->add($data))
            {
                $result = ['status'=>2,'msg'=>L('SUBMIT_SUCCESS'),'reloadType'=>'parent'];
            }
            else
            {
                $result = ['status'=>0,'msg'=>L('SUBMIT_FAILED')];
            }

            $this->ajaxReturn($result);
        }
        else
        {
//			部门
	        $department = M('Group')->where(['company_id'=>$this->_company_id,'closed'=>0,'ticket_auth'=>10])
		        ->field('group_id,group_name,parent_id,level')
		        ->select();

	        $departmentData = getSubjectTree($department,'group_id','parent_id','child');

	        $this->assign('jsonDepartmentData',json_encode($departmentData));

            $this->display();
        }
    }


    private function checkCreate()
    {
        $route = checkFields(I('post.route'),$this->_filter);

	    $route['group_id'] = I('post.group_id');

        if(!$route['route_name'])
        {
            $this->ajaxReturn(['status'=>0,'msg'=>L('ENTER_ROUTE_NAME')]);
        }
        else if(!$route['channel'])
        {
            $this->ajaxReturn(['status'=>0,'msg'=>L('PLEASE_SELECT').L('ROUTE_RULE')]);
        }
        else
        {
            if($route['channel'] == 'mail')
            {
                $route['route_value'] = 'mail';
            }
            else if(strpos($route['channel'],'template_') !== false)
            {
                $route['route_value'] = (int) str_replace('template_','',$route['channel']);

                $route['channel'] = 'template';
            }
        }

        if(D('Route')->isExistedByField(['company_id'=>$this->_company_id,'channel'=>$route['channel'],'route_value'=>$route['route_value']]))
        {
            $this->ajaxReturn(['status'=>0,'msg'=>L('ROUTE_RULE_EXIST')]);
        }
        else if(!D('Group')->isExistedByField(['company_id'=>$this->_company_id,'group_id'=>$route['group_id'],'ticket_auth'=>10]))
        {
            $this->ajaxReturn(['status'=>0,'msg'=>L('PLEASE_SELECT').L('HANDLE_GROUP')]);
        }
        else
        {
            $route['company_id'] = $this->_company_id;

            $route['create_time'] = NOW_TIME;

            return $route;
        }
    }


    public function editor($id = '')
    {
        $route_id = decrypt($id,'ROUTE');

        $route  = M('route')->where(['company_id'=>$this->_company_id,'route_id'=>$route_id])->find();

	    if(!$route) $this->returnError(L('ROUTE_NOT_EXIST'),U('Index/welcome'));

        if(IS_POST)
        {
            $data = $this->checkEditor($route_id);

            $save = M('route')->save($data);

            if($save === false)
            {
                $result = ['status'=>0,'msg'=>L('UPDATE_FAILED')];
            }
            else
            {
                $result = ['status'=>2,'msg'=>L('UPDATE_SUCCESS'),'reloadType'=>'parent'];
            }

            $this->ajaxReturn($result);
        }
        else
        {
//			部门
	        $department = M('Group')->where(['company_id'=>$this->_company_id,'closed'=>0,'ticket_auth'=>10])
		        ->field('group_id,group_name,parent_id,level')
		        ->select();

	        $departmentData = getSubjectTree($department,'group_id','parent_id','child');

	        $this->assign('jsonDepartmentData',json_encode($departmentData));

            $this->assign('route',$route);

            $this->display();
        }
    }


    private function checkEditor($route_id = 0)
    {
        $route = checkFields(I('post.route'),$this->_filter);

	    $route['group_id'] = I('post.group_id');

        if(!$route['route_name'])
        {
            $this->ajaxReturn(['status'=>0,'msg'=>L('ENTER_ROUTE_NAME')]);
        }
        else if(!$route['channel'])
        {
            $this->ajaxReturn(['status'=>0,'msg'=>L('PLEASE_SELECT').L('ROUTE_RULE')]);
        }
        else
        {
            $where = ['company_id'=>$this->_company_id,'route_id'=>['neq',$route_id]];

            $channel = $route_value = '';

            if($route['channel'] == 'mail')
            {
                $where['route_value'] = $route_value = 'mail';

                $where['channel'] = $channel = 'mail';
            }
            else if(strpos($route['channel'],'template_') !== false)
            {
                $where['route_value'] = $route_value = (int) str_replace('template_','',$route['channel']);

                $where['channel'] = $channel = 'template';
            }

            if(D('Route')->isExistedByField($where))
            {
                $this->ajaxReturn(['status'=>0,'msg'=>L('ROUTE_RULE_EXIST')]);
            }
            else
            {
                $route['channel'] = $channel;

                $route['route_value'] = $route_value;
            }
        }

        if(!D('Group')->isExistedByField(['company_id'=>$this->_company_id,'group_id'=>$route['group_id'],'ticket_auth'=>10]))
        {
            $this->ajaxReturn(['status'=>0,'msg'=>L('PLEASE_SELECT').L('HANDLE_GROUP')]);
        }
        else
        {
            $route['route_id'] = $route_id;

            return $route;
        }
    }


//    删除
    public function delete($id = '')
    {
        $route_id = decrypt($id,'ROUTE');

        $where = ['company_id'=>$this->_company_id,'route_id'=>$route_id];

        if(!D('Route')->isExistedByField($where))
        {
            $result = ['status'=>0,'msg'=>L('ROUTE_NOT_EXIST')];
        }
        else
        {
            if(M("route")->where($where)->delete())
            {
                $result = ['status'=>1,'msg'=>L('DELETE_SUCCESS'),'url'=>U('index')];
            }
            else
            {
                $result = ['status'=>0,'msg'=>L('DELETE_FAILED')];
            }
        }

        $this->ajaxReturn($result);
    }
}
