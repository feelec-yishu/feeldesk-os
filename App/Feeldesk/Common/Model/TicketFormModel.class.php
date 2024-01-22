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

class TicketFormModel extends BasicModel
{
	protected $pk   = 'ticket_form_id';

	protected $tableName = 'ticket_form';

	protected $_filter = ['ticket_model_id','ticket_form_name','ticket_form_description','ticket_form_explain','ticket_form_type','ticket_form_option','is_required','closed','orderby'];

	protected $form_type = ['text','textarea','radio','checkbox','select','date'];

	/*
	* 创建模板表单
	* @param int   $company_id 公司ID
	* @param array $requestData 请求数据
	* @return array
	*/
	public function createTemplateForm($company_id=0,$requestData=[])
	{
		$data = $this->checkRequestData($company_id,$requestData);

		if($data['status'] !== 20)
		{
			$data['company_id'] = $company_id;

			if($form_id = $this->add($data))
			{
				$result = ['status'=>10,'id'=>$form_id];
			}
			else
			{
				$result = ['status'=>20,'msg'=>L('SUBMIT_FAILED')];
			}
		}
		else
		{
			$result = $data;
		}

		return $result;
	}


	/*
	* 更新模板表单
	* @param int   $company_id 公司ID
	* @param array $requestData 请求数据
	* @param int   $form_id 模板表单ID
	* @return array
	*/
	public function updateTemplateForm($company_id,$requestData,$form_id = 0)
	{
		$data = $this->checkRequestData($company_id,$requestData,$form_id);

		if($data['status'] !== 20)
		{
			$data['ticket_form_id'] = $form_id;

			$update =  $this->save($data);

			if($update !== false)
			{
				$result = ['status'=>10,'msg'=>L('UPDATE_SUCCESS')];
			}
			else
			{
				$result = ['status'=>20,'msg'=>L('UPDATE_FAILED')];
			}
		}
		else
		{
			$result = $data;
		}

		return $result;
	}


	/*
	* 校验请求数据
	* @param int   $company_id 公司ID
	* @param array $requestData 请求数据
	* @param int   $form_id 模板表单ID
	* @return array
	*/
	private function checkRequestData($company_id=0,$requestData=[],$form_id = 0)
	{
		$data = checkFields($requestData, $this->_filter);

		$data['ticket_model_id'] = (int) decrypt($data['ticket_model_id'],'TICKETMODEL');

		$data['ticket_model_id'] = D('Ticketmodel')->isExistedByField(['company_id'=>$company_id,'ticket_model_id'=>$data['ticket_model_id'],'closed'=>0]);

		if(!$data['ticket_model_id'])
		{
			$result = ['status'=>20,'msg'=>L('TEMP_NOT'),'template'=>1];
		}
		else if(!in_array($data['ticket_form_type'],$this->form_type) && !$form_id)//创建时判断，更新时忽略
		{
			$result = ['status'=>20,'msg'=>L('SELECT_FORM_TYPE'),'type'=>1];
		}
		else if(!isFormField($data['ticket_form_name']))
		{
			$result = ['status'=>20,'msg'=>L('FIELD_NAME_NOT'),'system_field'=>1];
		}
		else if(!$data['ticket_form_description'])
		{
			$result = ['status'=>20,'msg'=>L('ENTER_FORM_NAME'),'name'=>1];
		}
		else if(in_array($data['ticket_form_type'],['radio','select','checkbox']) && empty($data['ticket_form_option']))
		{
			$result = ['status'=>20,'msg'=>L('ENTER_FIELD_OPTION'),'option'=>1];
		}
		else
		{
			$where = ["ticket_model_id"=>$data['ticket_model_id'],"ticket_form_name"=>$data['ticket_form_name']];

			if($form_id > 0)
			{
				$where['ticket_form_id'] = ['neq',$form_id];
			}
			else
			{
				$data['create_time'] = NOW_TIME;

				$data['create_ip'] = get_client_ip();
			}

			if(D('TicketForm')->isExistedByField($where))
			{
				$result = ['status'=>20,'msg'=>L('FIELD_NAME_REPEAT'),'system_field_repeat'=>1];
			}
			else
			{
				$data['is_required'] = (int) $data['is_required'] == 0 ? 0 : 1;

				$data['closed'] = (int) $data['closed'] == 0 ? 0 : 1;

				return $data;
			}
		}

		return $result;
	}


	/*
	* 删除模板表单
	* @param int   $company_id  公司ID
	* @param int   $template_id 模板ID
	* @param int   $form_id     模板表单ID
	* @return array
	*/
	public function deleteTemplateForm($company_id = 0,$form_id = 0)
	{
		$where = ['company_id'=>$company_id,'ticket_form_id'=>$form_id];

		if(!$template_id = $this->where($where)->getField('ticket_model_id'))
		{
			$result = ['status'=>20,'msg'=>L('FORM_NOT'),'exist'=>1];
		}
		else if(M('ticket_detail')->where($where)->getField('ticket_id'))
		{
			$result = ['status'=>20,'msg'=>L('DEL_FORM_FAILED'),'ticket'=>1];
		}
		else
		{
			if($this->where($where)->delete())
			{
				$result = ['status'=>10,'msg'=>L('DELETE_SUCCESS'),'template_id'=>$template_id];
			}
			else
			{
				$result = ['status'=>20,'msg'=>L('DELETE_FAILED')];
			}
		}

		return $result;
	}
}
