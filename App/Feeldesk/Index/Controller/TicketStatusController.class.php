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

class TicketStatusController extends BasicController
{
    public function index()
	{
		$where = [];

		if($keyword = I('get.keyword'))
		{
			$where['status_name|name_en'] = array('LIKE', '%' . $keyword . '%');

			$this->assign('keyword', $keyword);
		}

		$where['company_id'] = $this->_company_id;

        $statusName = D('TicketStatus')->getNameByLang('status_name');

		$count = M('ticket_status')->where($where)->count('status_id');

		$page = new \Think\Page($count, 100);

		$list = M('ticket_status')->where($where)->limit($page->firstRow, $page->listRows)->field("*,{$statusName}")->order('sort asc')->select();

//        权限 - 创建工单状态
	    $auth['create'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'ticketStatus/create',$this->_member['role_id']);

//        权限 - 修改工单状态
	    $auth['editor'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'ticketStatus/editor',$this->_member['role_id']);

//        权限 - 删除工单状态
	    $auth['delete'] = D('RoleAuth')->checkRoleAuthByMenu($this->_company_id,'ticketStatus/delete',$this->_member['role_id']);

	    $data = ['ticketStatus'=>$list,'auth'=>$auth,'page'=>$page->show()];

		$this->assign('data',$data);

        $this->display();
    }


	public function create()
	{
		if(IS_POST)
		{
			$result = D('TicketStatus')->createStatus($this->_company_id,I('post.ticket_status'),$this->_langAuth);

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
        $status_id = decrypt($id,'STATUS');

        $where = ['company_id'=>$this->_company_id,'status_id'=>$status_id];

		if(!$detail = M('ticket_status')->where($where)->find())
		{
			$this->returnError(L('STATUS_NOT'),U('Index/welcome'));
		}

		if(IS_POST)
		{
			$data = I('post.ticket_status',[]);

			$data['is_first'] = $detail['is_first'];

			$data['is_end'] = $detail['is_end'];

			$result = D('TicketStatus')->updateStatus($this->_company_id,$data,$status_id,$this->_langAuth);

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


    public function delete($id = '')
	{
        $status_id = decrypt($id,'STATUS');

        $result = D('TicketStatus')->deleteStatus($this->_company_id,$status_id);

		if($result['status'] == 20)
		{
			$result = ['status'=>0,'msg'=>$result['msg']];
		}
		else
		{
			$result = ['status'=>1,'msg'=>L('DELETE_SUCCESS'),'url'=>U('index')];
		}

		$this->ajaxReturn($result);
    }
}
