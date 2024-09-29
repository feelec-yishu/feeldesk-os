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
return [
	//后台公共文件路径
    'TMPL_PARSE_STRING'	=>  [

		'__PUBLIC__'		=> __ROOT__.'/Public',

		'INDEX_PUBLIC_CSS'	=> __ROOT__.'/Public/index/css',

        'INDEX_PUBLIC_JS'	=> __ROOT__.'/Public/index/js',

        'INDEX_IMG'         => __ROOT__.'/Public/index/img',

		'FACE_IMAGE' 		=> __ROOT__.'/Attachs/face',
    ],

	'SESSION_AUTO_START'	=> true,//session自动开关

	'TMPL_ACTION_SUCCESS'	=> 'Public:success',

	'TMPL_ACTION_ERROR'		=> 'Public:error',
];
