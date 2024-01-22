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
return array
(
	'MODULE_ALLOW_LIST'		=> ['Index'],

	'DEFAULT_MODULE'		=> 'Index',

	'LOAD_EXT_CONFIG'		=> 'define,route,socket,orderby,database,redis,session,temp_cn',

    'ERROR_PAGE'            => '/Public/error.html',

    'DEFAULT_APP'           => 'Feeldesk',

	# Cookie前缀 避免冲突
    'COOKIE_PREFIX'         => 'feel_',

    'COOKIE_HTTPONLY'       => 1,

	# 是否线上环境
	'ONLINE'                => false,

	# SQL解析缓存
    'DB_SQL_BUILD_CACHE'    => true,

    'DB_SQL_BUILD_LENGTH'   => 50,

	# TRACE信息
	'SHOW_PAGE_TRACE'       => false,

	# URL设置
    'URL_MODEL'             => 2,

    'URL_HTML_SUFFIX'       => '',

	# url是否区分大小写
    'URL_CASE_INSENSITIVE'  => false,

	# 缓存设置，使用子目录缓存 (自动根据缓存名称的哈希值创建子目录)
	'DATA_CACHE_SUBDIR'     => false,

	# 开启日志记录
    'LOG_RECORD'            => true,

	# 只记录EMERG ALERT ERR 错误
    'LOG_LEVEL'             =>'EMERG,ALERT,ERR',

	# 在关闭Debug后，仍然在页面显示错误信息
	'SHOW_ERROR_MSG'        => true,

	'WEB_SOURCE'            => 'FeelDesk',

	'WEB_TITLE'             => 'FeelDesk（OS）开源版',

	'LOGIN_TITLE'           => '工单，让工作更简单',

	'PC_ICON_HTTP'          => '/Public/css/iconfont/iconfont.css',

	'REPLACE_LOGO'          => []
);
