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

class TemplateTypeController extends  BasicController
{
    public function index()
	{
        $where = [];

        if($keyword = I('get.keyword'))
		{
			$where['type_name|name_en'] = ['LIKE', '%' . $keyword . '%'];

			$this->assign('keyword', $keyword);
		}

        $typeName = D('TemplateType')->getNameByLang('type_name');

		$where['company_id'] = $this->_company_id;

		$count = M('template_type')->where($where)->count('type_id');

		$page = new \Think\Page($count, 100);

		$list = M('template_type')->where($where)->limit($page->firstRow, $page->listRows)->order('sort')->field("*,{$typeName}")->select();

//        权限 - 创建模板类型
	    $auth['create'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'templateType/create',$this->_member['role_id']);

//        权限 - 修改模板类型
	    $auth['editor'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'templateType/editor',$this->_member['role_id']);

//        权限 - 删除模板类型
	    $auth['delete'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'templateType/delete',$this->_member['role_id']);

	    $data = ['templateType'=>$list,'auth'=>$auth,'page'=>$page->show()];

	    $this->assign('data',$data);

        $this->display();
    }


	public function create()
	{
		if(IS_POST)
		{
			$result = D('TemplateType')->createTemplateType($this->_company_id,I('post.template_type'),$this->_langAuth);

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
			$this->display();
		}

	}


	public function editor($id = '')
	{
        $type_id = decrypt($id,'TEMPLATETYPE');

        $where = ['company_id'=>$this->_company_id];

        $detail = M('template_type')->where(array_merge($where,['type_id'=>$type_id]))->find();

		if(!$detail) $this->common->_empty();

		if(IS_POST)
		{
			$result = D('TemplateType')->updateTemplateType($this->_company_id,I('post.template_type'),$type_id,$this->_langAuth);

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
			$this->assign('detail',$detail);

			$this->display();
		}
	}


    public function delete($id='')
	{
		$type_id = decrypt($id,'TEMPLATETYPE');

		$result = D('TemplateType')->deleteTemplateType($this->_company_id,$type_id);

		if($result['status'] == 20)
		{
			$result = ['status'=>0,'msg'=>$result['msg']];
		}
		else
		{
			$result = ['status'=>1,'msg'=>L('DELETE_SUCCESS'),'url'=>U('TemplateType/index')];
		}

		$this->ajaxReturn($result);
    }
}
