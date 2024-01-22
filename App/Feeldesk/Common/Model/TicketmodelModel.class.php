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

class TicketmodelModel extends BasicModel
{
	protected $pk   = 'ticket_model_id';

	protected $tableName = 'ticket_model';

	protected $checkField = ['ticket_model_name','name_en','name_jp','type_id','sort','user_discrete','cc_discrete','mobile_discrete','mobile_required',
		'mail_discrete','mail_required','deadlines_discrete','handle_discrete','area_discrete', 'closed'];


	/*
	* 创建模板
	* @param int    $company_id  公司ID
	* @param array  $requestData 请求数据
	* @param int    $langAuth    多语言权限
	* @return array
	*/
    public function createTemplate($company_id,$requestData = [],$langAuth = [])
    {
	    $data = $this->checkRequestData($company_id,$requestData,0,$langAuth);

	    if($data['status'] !== 20)
	    {
		    $data['company_id'] = $company_id;

		    if($template_id = $this->add($data))
		    {
			    $result = ['status'=>10,'id'=>$template_id];
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
	* 更新模板
	* @param int    $company_id  公司ID
	* @param array  $requestData 请求数据
	* @param int    $template_id 模板ID
	* @param array  $langAuth    多语言权限
	* @return array
	*/
	public function updateTemplate($company_id,$requestData,$template_id = 0,$langAuth = [])
	{
		$data = $this->checkRequestData($company_id,$requestData,$template_id,$langAuth);

		if($data['status'] !== 20)
		{
			$data['ticket_model_id'] = $template_id;

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
	* @param int    $company_id  公司ID
	* @param array  $requestData 请求数据
	* @param int    $template_id 模板ID
	* @param array  $langAuth    多语言权限
	* @return array
	*/
	private function checkRequestData($company_id,$requestData = [],$template_id = 0,$langAuth = [])
	{
		$data = checkFields($requestData, $this->checkField);

		if(empty($data['ticket_model_name']))
		{
			$result = ['status'=>20,'msg'=>L('ENTER_TEMPLATE_NAME')];
		}
		elseif($langAuth['en_auth'] == 10 && empty($data['name_en']))
		{
			$result = ['status'=>20,'msg'=>L('ENTER_EN_NAME')];
		}
		elseif($langAuth['jp_auth'] == 10 && empty($data['name_jp']))
		{
			$result = ['status'=>20,'msg'=>L('ENTER_JP_NAME')];
		}
		elseif(!$data['type_id'])
		{
			$result = ['status'=>20,'msg'=>L('SELECT_TEMP_TYPE')];
		}
		else
		{
			$where = ['company_id'=>$company_id,'ticket_model_name'=>$data['ticket_model_name']];

			if($template_id > 0)
			{
				$where['ticket_model_id'] = ['neq',$template_id];
			}
			else
			{
				$data['create_time'] = NOW_TIME;

				$data['create_ip'] = get_client_ip();
			}

			if($this->isExistedByField($where))
			{
				$result = ['status'=>20,'msg'=>L('TEMPLATE_NAME_EXISTS'),'repeat'=>1];
			}
			else
			{
				$data['closed'] = $data['closed'] == 'on' ? 0 : 1;

				return $data;
			}
		}

		return $result;
	}


	/*
	* 删除模板
	* @param int    $company_id  公司ID
	* @param int    $template_id 模板ID
	* @return array
	*/
	public function deleteTemplate($company_id = 0,$template_id = 0)
	{
		$templateWhere = $where = ['company_id'=>$company_id,'ticket_model_id'=>$template_id];

		$templateWhere['closed'] = 1;

		if(!$this->where($templateWhere)->getField('ticket_model_id'))
		{
			$result = ['status'=>20,'msg'=>L('TICKET_TEMP_NOT'),'exist'=>1];
		}
		else if(M('ticket')->where($where)->getField('ticket_id'))
		{
			$result = ['status'=>20,'msg'=>L('DELETE_TEMP_NOTE'),'ticket'=>1];
		}
		else
		{
			if($this->where($templateWhere)->delete())
			{
//				  删除模板相关表单项
				M('ticket_form')->where($where)->delete();

//				  删除相关路由
				M('route')->where(['company_id'=>$company_id,'channel'=>'template','route_value'=>$template_id])->delete();

				$result = ['status'=>10,'msg'=>L('DELETE_SUCCESS')];
			}
			else
			{
				$result = ['status'=>20,'msg'=>L('DELETE_FAILED')];
			}
		}

		return $result;
	}
}
