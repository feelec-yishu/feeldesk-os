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

class TicketFormController extends  BasicController
{
    public function index($tid = "")
	{
        $ticket_model_id = decrypt($tid,'TICKETMODEL');

		$field = array();

		$field['ticket_model_id'] = $ticket_model_id;

		if($keyword = I('get.keyword'))
		{
			$field['ticket_form_name|ticket_form_description|ticket_form_type'] = array('LIKE', '%' . $keyword . '%');

			$this->assign('keyword', $keyword);
		}

		$field['conpany_id'] = $this->_company_id;

		$count = M('TicketForm')->where($field)->count();

		$page = new \Think\Page($count, 10);

		$list = M('TicketForm')->where($field)->limit($page->firstRow, $page->listRows)->order('orderby')->select();

		$this->assign('ticket_model_id',$ticket_model_id);

		$this->assign('page', $page->show());

		$this->assign('ticketform',$list);

		$this->assign('ticketFormJson',json_encode($list));

        $this->display();
    }


	public function create($tid = "")
	{
        $ticket_model_id = decrypt($tid,'TICKETMODEL');

		if(IS_POST)
		{
			$result = D('TicketForm')->createTemplateForm($this->_company_id,I('post.ticket_form'));

			if($result['status'] == 20)
			{
				$result = ['status'=>0,'msg'=>$result['msg']];
			}
			else
			{
				$result = ['status'=>2,'msg'=>L('SUBMIT_SUCCESS'),'url'=>U('TicketForm/index',['tid'=>encrypt($ticket_model_id,'TICKETMODEL')])];
			}

			$this->ajaxReturn($result);
		}
		else
		{
			$this->assign('ticket_model_id',$ticket_model_id);

			$this->display();
		}
	}


	public function edit($id='',$tid='')
	{
        $ticket_form_id  = decrypt($id,'TICKETFORM');

        $ticket_model_id = decrypt($tid,'TICKETMODEL');

		$where = ['company_id'=>$this->_company_id,'ticket_model_id'=>$ticket_model_id,'ticket_form_id'=>$ticket_form_id];

		if(!$detail = M('TicketForm')->where($where)->find())
		{
			$this->returnError(L('FORM_NOT'),U('Index/welcome'));
		}

		if(IS_POST)
		{
			$result = D('TicketForm')->updateTemplateForm($this->_company_id,I('post.ticket_form'),$ticket_form_id);

			if($result['status'] == 20)
			{
				$result = ['status'=>0,'msg'=>$result['msg']];
			}
			else
			{
				$result = ['status'=>2,'msg'=>L('UPDATE_SUCCESS'),'url'=>U('TicketForm/index',['tid'=>encrypt($ticket_model_id,'TICKETMODEL')])];
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
		$ticket_form_id  = decrypt($id,'TICKETFORM');

		$result = D('TicketForm')->deleteTemplateForm($this->_company_id,$ticket_form_id);

		if($result['status'] == 20)
		{
			$result = ['status'=>0,'msg'=>$result['msg']];
		}
		else
		{
			$result = ['status'=>1,'msg'=>L('DELETE_SUCCESS'),'url'=>U('ticketForm/index',['tid'=>encrypt($result['template_id'],'TICKETMODEL')])];
		}

		$this->ajaxReturn($result);
	}
}
