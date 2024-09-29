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

use Think\Model;

class BasicModel extends Model
{
	protected $pk   = '';

    protected $tableName =  '';


	/**
	* @return array
	*/
    public function fetchAll()
	{
		$result = $this->select();

		$data = [];

		foreach($result as $v)
		{
			$data[$v[$this->pk]] = $v;
		}

        return $data;
	}


	public function isExistedByField($where = [])
	{
		$pk = $this->where($where)->getField($this->pk);

		return $pk;
	}


    public function checkFields($data=[], $fields=[])
    {
        foreach ($data as $k => $val )
        {
            if (!in_array($k, $fields))
            {
                unset($data[$k]);
            }
        }

        return $data;
    }


    public function getFieldInfo($table,$where,$field,$isLangName = 0)
    {
        $lang = cookie('think_language');

        if($isLangName == 1)
        {
            if($lang == 'en-us') $field = 'name_en';

            if($lang == 'ja-jp') $field = 'name_en';
        }

        return M($table)->where($where)->getField($field);
    }


	/*
	* 通过当前语言变量返回要读取的语言字段
	* @param String $fieldName 字段名
	* @return String
	*/
    public function getNameByLang($fieldName)
    {
        $lang = cookie('think_language');

        $name = $fieldName.' as lang_name';

        if($lang == 'en-us') $name = 'name_en as lang_name';

        if($lang == 'ja-jp') $name = 'name_jp as lang_name';

        return $name;
    }
}
