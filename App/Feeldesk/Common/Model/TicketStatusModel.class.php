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

class TicketStatusModel extends BasicModel
{
	protected $pk   = 'status_id';

	protected $tableName = 'ticket_status';

	protected $checkField = ['company_id','status_name','name_en','name_jp','status_color','is_stop_timing','sort'];

	/*
	* 创建工单状态
	* @param int    $company_id  公司ID
	* @param array  $requestData 请求数据
	* @param array  $langAuth    多语言权限
	* @return array
	*/
	public function createStatus($company_id = 0,$requestData = [],$langAuth = [])
	{
		$data = $this->checkRequestData($company_id,$requestData,0,$langAuth);

		if($data['status'] !== 20)
		{
			if($status_id = $this->add($data))
			{
				$this->updateEndStatusSort($company_id);

				$result = ['status'=>10,'id'=>$status_id];
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
	* 更新工单状态
	* @param int    $company_id  公司ID
	* @param array  $requestData 请求数据
	* @param int    $status_id   状态ID
	* @param array  $langAuth    多语言权限
	* @return array
	*/
	public function updateStatus($company_id = 0,$requestData = [],$status_id = 0,$langAuth = [])
	{
		$data = $this->checkRequestData($company_id,$requestData,$status_id,$langAuth);

		if($data['status'] !== 20)
		{
			$data['status_id'] = $status_id;

			$update =  $this->save($data);

			if($update !== false)
			{
				$this->updateEndStatusSort($company_id);

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
	* 校验请求参数
	* @param int    $company_id  公司ID
	* @param array  $requestData 请求数据
	* @param int    $status_id   状态ID
	* @param array  $langAuth    多语言权限
	* @return array
	*/
	private function checkRequestData($company_id = 0,$requestData = [],$status_id = 0,$langAuth = [])
	{
		$data = checkFields($requestData, $this->checkField);

		if(empty($data['status_name']))
		{
			$result = ['status'=>20,'msg'=>L('ENTER_STATUS_NAME')];
		}
		else if($langAuth['en_auth'] == 10 && empty($data['name_en']))
		{
			$result = ['status'=>20,'msg'=>L('ENTER_EN_NAME')];
		}
		else if($langAuth['jp_auth'] == 10 && empty($data['name_jp']))
		{
			$result = ['status'=>20,'msg'=>L('ENTER_JP_NAME')];
		}
		else if(empty($data['sort']) && $requestData['is_first'] != 1 && $requestData['is_end'] != 1)
		{
			$result = ['status'=>20,'msg'=>L('ENTER_STATUS_SORT'),'sort'=>1];
		}
		else if((!preg_match("/^[1-9][0-9]*$/",$data['sort']) || strlen($data['sort']) > 2) && $requestData['is_first'] != 1 && $requestData['is_end'] != 1)
		{
			$result = ['status'=>20,'msg'=>L('STATUS_SORT_ERROR'),'sort'=>1];
		}
		else if(!preg_match("/^#([0-9a-fA-F]{6}|[0-9a-fA-F]{3})$/",$data['status_color']))
		{
			$result = ['status'=>20,'msg'=>'状态颜色值输入错误','color'=>1];
		}
		else
		{
			$where = ['company_id'=>$company_id,'sort'=>$data['sort'],'is_end'=>2];

			if($status_id == 0)
			{
				$data['company_id'] = $company_id;

				$data['create_time'] = NOW_TIME;
			}
			else
			{
				$where['status_id'] = ['neq',$status_id];
			}

			if($this->isExistedByField($where))
			{
				$result = ['status'=>20,'msg'=>L('STATUS_SORT_REPEAT'),'sort_repeat'=>1];
			}
			else
			{
				$data['status_color'] = $data['status_color'] ? $data['status_color'] : '#333';

				return $data;
			}
		}

		return $result;
	}


	/*
	* 更新结束状态的排序值
	* @param int    $company_id  公司ID
	*/
	private function updateEndStatusSort($company_id = 0)
	{
		$where = ['company_id'=>$company_id];

//		当前非结束状态的最大排序值
		$now_max_sort = $this->where(array_merge($where,['is_end'=>2]))->order('sort desc')->getField('sort');

		$end_sort = $now_max_sort + 1;

		$this->where(array_merge($where,['is_end'=>1]))->setField('sort',$end_sort);
	}


	/*
	* 删除工单状态
	* @param int    $company_id  公司ID
	* @param int    $status_id   状态ID
	* @return array
	*/
	public function deleteStatus($company_id = 0,$status_id = 0)
	{
		$where = ['company_id'=>$company_id,'status_id'=>$status_id];

		if(!$status = $this->where($where)->find())
		{
			$result = ['status'=>20,'msg'=>L('TICKET_STATUS_NOT'),'exist'=>1];
		}
		else if(D('Ticket')->isExistedByField($where))
		{
			$result = ['status'=>20,'msg'=>L('DEL_STATE_FAILED'),'ticket'=>1];
		}
		else if($status['is_first'] == 1 || $status['is_end'] == 1)
		{
			$result = ['status'=>20,'msg'=>L('DELETE_STATUS_NODE'),'not'=>1];
		}
		else
		{
			if($this->where($where)->delete())
			{
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
