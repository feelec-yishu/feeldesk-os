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

class FastReplyController extends  BasicController
{
	protected $insertField = ['fast_type_id','fast_title','fast_content','activity'];

	protected $updateField = ['fast_id','fast_type_id','fast_title','fast_content','activity'];

	protected $fastType;

	public function _initialize()
	{
		parent::_initialize();

		$this->fastType = D('FastReplyType')->where(['company_id'=>$this->_company_id])->fetchAll();

		$this->assign('fastReplyType',$this->fastType);
	}



	public function index()
	{
		$where = [];

		if($keyword = I('get.keyword'))
		{
			$where['fast_title|fast_content'] = ['LIKE','%'.$keyword.'%'];

			$this->assign('keyword', $keyword);
		}

		$where['company_id'] = $this->_company_id;

		$count = M('fastreply')->where($where)->count();

		$page = new \Think\Page($count, 100);

		$list = M('fastreply')->where($where)->limit($page->firstRow, $page->listRows)->select();

//        权限 - 创建快捷回复
		$auth['create'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'fastReply/create',$this->_member['role_id']);

//        权限 - 修改快捷回复
		$auth['editor'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'fastReply/editor',$this->_member['role_id']);

//        权限 - 删除快捷回复
		$auth['delete'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'fastReply/delete',$this->_member['role_id']);

		$data = ['fastReply'=>$list,'auth'=>$auth,'page'=>$page->show()];

		$this->assign('data',$data);

        $this->display();
    }


	public function create()
	{
		if(IS_POST)
		{
			$fast_reply = $this->checkCreate();

			$fast_reply['company_id'] = $this->_company_id;

			if(M('fastreply')->add($fast_reply))
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
		$data = checkFields(I('post.fast_reply'), $this->insertField);

		if(empty($data['fast_title']))
		{
			$this->ajaxReturn(['status'=>0,'msg'=>L('ENTER_TITLE')]);
		}
		else if(empty($data['fast_type_id']))
		{
			$this->ajaxReturn(['status'=>0,'msg'=>L('SELECT_GROUP')]);
		}
		else if(empty($data['fast_content']))
		{
			$this->ajaxReturn(['status'=>0,'msg'=>L('ENTER_CONTENT')]);
		}

		$data['activity'] = $data['activity'] == 'on' ? 2 : 1;

		$data['create_time'] = NOW_TIME;

		return $data;
	}



	public function editor($id = '')
	{
        $fast_id = decrypt($id,'FASTREPLY');

		if(!$detail = M('fastreply')->where(['company_id'=>$this->_company_id,'fast_id'=>$fast_id])->find())
		{
			$this->returnError(L('QUICK_NOT'),U('Index/welcome'));
		}

		if(IS_POST)
		{
			$fast_reply = $this->checkEdit();

			$fast_reply['fast_id'] = $fast_id;

			$save = M('fastreply')->save($fast_reply);

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


	private function checkEdit()
	{
		$data = checkFields(I('post.fast_reply'), $this->updateField);

		if(empty($data['fast_title']))
		{
			$this->ajaxReturn(['status'=>0,'msg'=>L('ENTER_TITLE')]);
		}
		else if(empty($data['fast_type_id']))
		{
			$this->ajaxReturn(['status'=>0,'msg'=>L('SELECT_GROUP')]);
		}
		else if(empty($data['fast_content']))
		{
			$this->ajaxReturn(['status'=>0,'msg'=>L('ENTER_CONTENT')]);
		}

        $data['activity'] = $data['activity'] == 'on' ? 2 : 1;

		return $data;
	}


    public function delete($id = '')
	{
		$fast_id = decrypt($id,'FASTREPLY');

        $model = M('fastreply');

        $field['company_id'] = $this->_company_id;

        $field['fast_id'] = $fast_id;

        if($fast_reply = $model->where($field)->find())
        {
            if($model->where($field)->delete())
            {
                $result = ['status'=>1,'msg'=>L('DELETE_SUCCESS'),'url'=>U('FastReply/index')];
            }
            else
            {
                $result = ['status'=>0,'msg'=>L('DELETE_FAILED')];
            }
        }
        else
        {
            $result = ['status'=>0,'msg'=>L('QUICK_NOT')];
        }

        $this->ajaxReturn($result);
    }
}
