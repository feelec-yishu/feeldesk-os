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
	# Socket端口
	'SOCKET_PORT'      => 5050,
	# 消息推送端口
	'HTTP_PORT'        => 5051,
	# Socket Url
	'SOCKET_IO_URL'    => C('HOST_DOMAIN').':5050',
	# 推送服务地址
    'PUSH_URL'         => C('HOST_DOMAIN').':5051',
	# Socket白名单
	'WHITE_LIST'       => C('HOST_DOMAIN'),
	# SSL 上下文
	'CONTEXT' => [
		'ssl' => [
			'local_cert'  => '/www/server/nginx/ssl/ticket.pem', # 证书绝对路径
			'local_pk'    => '/www/server/nginx/ssl/ticket.key', # 证书密钥绝对路径
			'verify_peer' => false,
		]
	],
];


