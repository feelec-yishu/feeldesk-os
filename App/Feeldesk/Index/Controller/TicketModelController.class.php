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
use Think\Page;

class TicketModelController extends BasicController
{
    protected $templateType = [];

	public function _initialize()
	{
		parent::_initialize();

        $typeName = D('TemplateType')->getNameByLang('type_name');

        $this->templateType = $templateTypes = D('TemplateType')->where($this->condition)->order('sort')->field("type_id,apply,{$typeName}")->fetchAll();

        $this->assign('templateTypes',$templateTypes);
	}


    public function index()
	{
		$field= [];

		if($keyword = I('get.keyword'))
		{
			$field['ticket_model_name|name_en|name_jp'] = ['LIKE', '%' . $keyword . '%'];

			$this->assign('keyword', $keyword);
		}

        $templateName = D('Ticketmodel')->getNameByLang('ticket_model_name');

		$field['company_id'] = $this->_company_id;

		$count =  M('TicketModel')->where($field)->count();

		$page = new Page($count, 100);

		$template = M('TicketModel')->where($field)->limit($page->firstRow, $page->listRows)->order('sort')->field("*,{$templateName}")->select();

		$token = '';

        foreach($template as &$v)
        {
	        if(in_array($this->templateType[$v['type_id']]['apply'],['currency','external']))
	        {
		        $v['member_user_url'] = C('HTTP_PROTOCOL')."://".C('HOST_DOMAIN')."/c-faq-template/{$v['ticket_model_id']}{$token}";

		        $v['muser_user_url'] = C('HTTP_PROTOCOL')."://".C('HOST_DOMAIN')."/cm-faq-visitor-ticket/{$v['ticket_model_id']}{$token}";

		        $v['wuser_user_url'] = C('HTTP_PROTOCOL')."://".C('HOST_DOMAIN')."/cw-faq-visitor-ticket/{$v['ticket_model_id']}{$token}";
	        }
        }

//        权限 - 创建模板
	    $auth['create'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'ticketModel/create',$this->_member['role_id']);

//        权限 - 修改模板
	    $auth['editor'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'ticketModel/editor',$this->_member['role_id']);

//        权限 - 删除模板
	    $auth['delete'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'ticketModel/delete',$this->_member['role_id']);

//        权限 - 模板表单
	    $auth['form'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'ticketForm/index',$this->_member['role_id']);

	    $data = ['template'=>$template,'templateJson'=>json_encode($template),'auth'=>$auth,'page'=>$page->show()];

		$this->assign('data',$data);

        $this->display();
    }


	public function create()
	{
        $where = ['company_id'=>$this->_company_id];

		if(IS_POST)
		{
			$result = D('Ticketmodel')->createTemplate($this->_company_id,I('post.ticket_model'),$this->_langAuth);

			if($result['status'] == 20)
			{
				$result = ['status'=>0,'msg'=>$result['msg']];
			}
			else
			{
				$result = ['status'=>2,'msg'=>L('SUBMIT_SUCCESS'),'reloadType'=>'parent'];
			}

            $this->ajaxReturn($result);
		}
		else
		{
            $typeName = D('TemplateType')->getNameByLang('type_name');

            $category = D('TemplateType')->where(array_merge($where,['closed'=>0]))->order('sort')->field("type_id,{$typeName}")->fetchAll();

            $this->assign('category',$category);

			$this->display();
		}
	}


	public function editor($id = '')
	{
        $ticket_model_id = decrypt($id,'TICKETMODEL');

        $where = ['company_id'=>$this->_company_id];

        $detail =  M('TicketModel')->where(array_merge($where,['ticket_model_id'=>$ticket_model_id]))->find();

		if(!$detail) $this->common->_empty();

		if(IS_POST)
		{
			$result = D('Ticketmodel')->updateTemplate($this->_company_id,I('post.ticket_model'),$ticket_model_id,$this->_langAuth);

			if($result['status'] == 20)
			{
				$result = ['status'=>0,'msg'=>$result['msg']];
			}
			else
			{
				$result = ['status'=>2,'msg'=>L('UPDATE_SUCCESS'),'reloadType'=>'parent'];
			}

			$this->ajaxReturn($result);
		}
		else
		{
            $typeName = D('TemplateType')->getNameByLang('type_name');

            $category = D('TemplateType')->where(array_merge($where,['closed'=>0]))->order('sort')->field("type_id,{$typeName}")->fetchAll();

            $this->assign('category',$category);

			$this->assign('detail',$detail);

			$this->display();
		}
	}


    public function delete($id = '')
	{
		$ticket_model_id = decrypt($id,'TICKETMODEL');

        $result = D('Ticketmodel')->deleteTemplate($this->_company_id,$ticket_model_id);

        if($result['status'] == 20)
        {
	        $result = ['status'=>0,'msg'=>$result['msg']];
        }
        else
        {
	        $result = ['status'=>1,'msg'=>L('DELETE_SUCCESS'),'url'=>U('TicketModel/index')];
        }

        $this->ajaxReturn($result);
    }
}
