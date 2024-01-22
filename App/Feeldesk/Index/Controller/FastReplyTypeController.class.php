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

class FastReplyTypeController extends  BasicController
{
	protected $insertField = ['type_name'];

	protected $updateField = ['fast_type_id','type_name'];

    public function index()
	{
		$where = [];

		if($keyword = I('get.keyword'))
		{
			$where['type_name'] = ['LIKE', '%' . $keyword . '%'];

			$this->assign('keyword', $keyword);
		}

		$where['company_id'] = $this->_company_id;

		$count = M('fastreply_type')->where($where)->count();

		$page = new \Think\Page($count, 100);

		$list = M('fastreply_type')->where($where)->limit($page->firstRow, $page->listRows)->select();

//        权限 - 创建快捷分组
	    $auth['create'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'fastReplyType/create',$this->_member['role_id']);

//        权限 - 修改快捷分组
	    $auth['editor'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'fastReplyType/editor',$this->_member['role_id']);

//        权限 - 删除快捷分组
	    $auth['delete'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'fastReplyType/delete',$this->_member['role_id']);

	    $data = ['fastReplyType'=>$list,'auth'=>$auth,'page'=>$page->show()];

	    $this->assign('data',$data);

        $this->display();
    }



	public function create()
	{
		if(IS_POST)
		{
			$fast_type = $this->checkCreate();			

			$fast_type['company_id'] = $this->_company_id;

			if($add = M('fastreply_type')->add($fast_type))
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
			$this->display();
		}
	}


	private function checkCreate()
	{
		$data = checkFields(I('post.fast_type'), $this->insertField);

		if(empty($data['type_name']))
		{
			$this->ajaxReturn(['status'=>0,'msg'=>L('ENTER_GROUP_NAME')]);
		}

		$data['closed'] = $data['closed'] == 'on' ? 0 : 1;

		$where = ['type_name'=>$data['type_name'],'company_id'=>$this->_company_id];

		if(M('fastreply_type')->where($where)->getField('fast_type_id'))
		{
			$this->ajaxReturn(['status'=>0,'msg'=>L('GROUP_NAME_REPEAT')]);
		}

		$data['create_time'] = NOW_TIME;

		return $data;
	}


	public function editor($id = '')
	{
        $fast_type_id = decrypt($id,'FASTREPLYTYPE');

		if(!$detail = M('fastreply_type')->where(['company_id'=>$this->_company_id,'fast_type_id'=>$fast_type_id])->find())
		{
			$this->returnError(L('GROUP_NOT'),U('Index/welcome'));
		}

		if(IS_POST)
		{
			$fasttype = $this->checkEdit($fast_type_id);

			$fasttype['fast_type_id'] = $fast_type_id;

			$save = M('fastreply_type')->save($fasttype);

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
			$this->assign('detail',$detail);

			$this->display();
		}
	}



	private function checkEdit($fast_type_id = '')
	{
		$data = checkFields(I('post.fast_type'), $this->updateField);

		if(empty($data['type_name']))
		{
			$this->ajaxReturn(['status'=>0,'msg'=>L('ENTER_GROUP_NAME')]);
		}

		$where = ['type_name'=>$data['type_name'],'company_id'=>$this->_company_id];

		if($type_id = M('fastreply_type')->where($where)->getField('fast_type_id'))
		{
			if($type_id != $fast_type_id)
			{
				$this->ajaxReturn(['status'=>0,'msg'=>L('GROUP_NAME_REPEAT')]);
			}
		}

		return $data;
	}



	//删除分组
    public function delete($id = '')
	{
        $fast_type_id = decrypt($id,'FASTREPLYTYPE');

        $model = M('fastreply_type');

        $where = ['fast_type_id'=>$fast_type_id,'company_id'=>$this->_company_id];

        if($model->where($where)->getField('fast_type_id'))
        {
            $fast_id = M('fastreply')->where($where)->getField('fast_id');

            if($fast_id > 0)
            {
                $result = ['status'=>0,'msg'=>L('DEL_GROUP_FAILED')];
            }
            else
            {
                if($model->where(["fast_type_id" => $fast_type_id])->delete())
                {
                    $result = ['status'=>1,'msg'=>L('DELETE_SUCCESS'),'url'=>U('fastReplyType/index')];
                }
                else
                {
                    $result = ['status'=>0,'msg'=>L('DELETE_FAILED')];
                }
            }
        }
        else
        {
            $result = ['status'=>0,'msg'=>L('GROUP_NOT')];
        }

        $this->ajaxReturn($result);
    }
}
