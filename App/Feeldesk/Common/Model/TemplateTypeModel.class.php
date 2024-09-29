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

class TemplateTypeModel extends BasicModel
{
	protected $pk   = 'type_id';

	protected $tableName = 'template_type';

	protected $checkFields = ['type_name','name_en','name_jp','member_id','apply','sort','closed'];

	protected $apply = [10=>'external',20=>'inside',30=>'currency'];

    /*
    * 获取模板类型与模板
    * @param int    $company_id 公司ID
    * @param int    $type 用户类型 1 用户 2 会员、游客
    * @return array
	*/
    public function getTicketTempLate($company_id,$type)
    {
        $apply = $type == 1 ? 'inside' : 'external';

        $templateTypeName = D('TemplateType')->getNameByLang('type_name');

        $templateTypeName = str_replace(
            ['type_name as lang_name','name_en as lang_name','name_jp as lang_name'],
            ['a.type_name as type_lang_name','a.name_en as type_lang_name','a.name_jp as type_lang_name'],
            $templateTypeName
        );

        $templateName = D('Ticketmodel')->getNameByLang('ticket_model_name');

        $templateName = str_replace(
            ['name_en as lang_name','name_jp as lang_name'],
            ['b.name_en as lang_name','b.name_jp as lang_name'],
            $templateName
        );

        $where = ['a.company_id'=>$company_id,'a.apply'=>['in',[$apply,'currency']],'a.closed'=>0,'b.company_id'=>$company_id,'b.closed'=>0];

        if($type == 'all')
        {
			unset($where['a.apply']);
        }

	    $ticketTemplateAndType1 = $ticketTemplateAndType2 = D('TemplateType')->alias('a')
		    ->join('feel_ticket_model as b ON a.type_id=b.type_id','left')
		    ->where($where)
		    ->field("a.type_id,{$templateTypeName},ticket_model_id,{$templateName}")
		    ->order('a.sort asc,b.sort asc,a.type_id asc,b.ticket_model_id asc')
		    ->select();

        $ticketTemplate = [];

        foreach($ticketTemplateAndType1 as $k1=>$v1)
        {
            foreach($ticketTemplateAndType2 as $k2=>$v2)
            {
                if($v1['type_id'] == $v2['type_id'])
                {
                    $ticketTemplate[$v1['type_id']]['type_lang_name'] = $v1['type_lang_name'];

                    $ticketTemplate[$v1['type_id']]['template'][$k2] = $v2;
                }
            }
        }

        return $ticketTemplate;
    }


	/*
	* 创建模板类型
	* @param int $company_id 公司ID
	* @param array $requestData 请求参数
	* @param array $langAuth 多语言权限
	* @return array
	*/
    public function createTemplateType($company_id = 0,$requestData = [],$langAuth = [])
    {
		$data = $this->checkRequestData($company_id,$requestData,0,$langAuth);

	    if($data['status'] !== 20)
	    {
		    $data['company_id'] = $company_id;

		    if($category_id = $this->add($data))
		    {
			    $result = ['status'=>10,'id'=>$category_id];
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
	* 更新模板类型
	* @param int    $company_id 公司ID
	* @param array  $requestData 请求参数
	* @param int    $category_id 模板类型ID
	* @param array  $langAuth 多语言权限
	* @return array
	*/
	public function updateTemplateType($company_id,$requestData,$category_id = 0,$langAuth = [])
	{
		$data = $this->checkRequestData($company_id,$requestData,$category_id,$langAuth);

		if($data['status'] !== 20)
		{
			$data['type_id'] = $category_id;

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
	* 验证请求参数
	* @param int    $company_id 公司ID
	* @param array  $requestData 请求参数
	* @param int    $category_id 模板类型ID
	* @param array  $langAuth 多语言权限
	* @return array
	*/
	private function checkRequestData($company_id = 0,$requestData = [],$category_id = 0,$langAuth = [])
	{
		$data = checkFields($requestData, $this->checkFields);

		if(empty($data['type_name']))
		{
			$result = ['status'=>20,'msg'=>L('ENTER_TYPE_NAME')];
		}
		else if($langAuth['en_auth'] == 10 && empty($data['name_en']))
		{
			$result = ['status'=>20,'msg'=>L('ENTER_EN_NAME')];
		}
		else if($langAuth['jp_auth'] == 10 && empty($data['name_jp']))
		{
			$result = ['status'=>20,'msg'=>L('ENTER_JP_NAME')];
		}
		else
		{
			$data['apply'] = $this->apply[$data['apply']] ? $this->apply[$data['apply']] : 'currency';

			$where = ['company_id'=>$company_id,'type_name'=>$data['type_name']];

			if($category_id > 0)
			{
				$where['type_id'] = ['neq',$category_id];
			}
			else
			{
				$data['create_time'] = NOW_TIME;

				$data['create_ip'] = get_client_ip();
			}

			if($this->isExistedByField($where))
			{
				$result = ['status'=>20,'msg'=>L('TYPE_NAME_EXISTS'),'repeat'=>1];
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
	* 删除模板类型
	* @param int    $company_id 公司ID
	* @param int    $category_id 模板类型ID
	* @return array
	*/
	public function deleteTemplateType($company_id = 0,$category_id = 0)
	{
		$categoryWhere = $where = ['company_id'=>$company_id,'type_id'=>$category_id];

		$categoryWhere['closed'] = 1;

		if(!$this->where($categoryWhere)->getField('type_id'))
		{
			$result = ['status'=>20,'msg'=>L('TICKET_TYPE_NOT'),'exist'=>1];
		}
		else if(M('ticket_model')->where($where)->getField('ticket_model_id'))
		{
			$result = ['status'=>20,'msg'=>L('DELETE_TYPE_NOTE'),'template'=>1];
		}
		else
		{
			if($this->where($categoryWhere)->delete())
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
