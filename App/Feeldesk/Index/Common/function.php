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
function getPercentage($total = 0,$num = 0)
{
	if($num == 0)
	{
		return '0%';
	}
	else
	{
		return round(($num/$total)*100).'%';
	}
}


function getViewName()
{
	$url = CONTROLLER_NAME.'/'.ACTION_NAME;

	$viewName = D('Menu')->getNameByLang('menu_name');

	$view_name = M('menu')->where(['menu_action'=>$url,'apply'=>10])->getField("{$viewName}");

	return $view_name;
}


//检测是否为整数
function isInteger($value)
{
	return  is_numeric($value) && is_int($value+0);
}


/**
 * 方法二: 获取指定日期段内每一天的日期
 * @date 2017-02-23 14:50:29
 *
 * @param $start
 * @param $end
 *
 * @return array
 */
function getDateRange($start, $end)
{
	$range = [];

	for ($i = 0; strtotime($start . '+' . $i . ' days') <= strtotime($end); $i++)
	{
		$time = strtotime($start . '+' . $i . ' days');
		$range[] = date('Y-m-d', $time);
	}

	return $range;
}


//获取group名称组成的字符串
function getMemberGroupName($groups,$memberGroupIds)
{
	$groupName = [];

	foreach($groups as $v)
	{
		if(in_array($v['group_id'],explode(',',$memberGroupIds)))
		{
			$groupName[] = $v['group_name'];
		}
	}

	return implode('、',$groupName);
}
