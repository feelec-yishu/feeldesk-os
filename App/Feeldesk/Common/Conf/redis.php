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
	# 缓存前缀
    'DATA_CACHE_PREFIX'     => 'Ticket-V3:OS:Cache:',
	# 默认动态缓存为Redis
    'DATA_CACHE_TYPE'       => 'Redis',
	# Redis读写分离 true 开启
    'REDIS_RW_SEPARATE'     => false,
	# 超时时间
    'REDIS_TIMEOUT'         => '300',
	# 是否长连接 false=短连接
    'REDIS_PERSISTENT'      => false,
	# redis服务器ip，多台用逗号隔开；读写分离开启时，第一台负责写，其它[随机]负责读；
    'REDIS_HOST'            => '127.0.0.1',
	# 端口号
    'REDIS_PORT'            => '6379',
	# AUTH认证密码
    'REDIS_AUTH'            => '000000',
	# Redis储存数据库编号
    'REDIS_DBINDEX'         => 0,
	# 数据缓存有效期 0表示永久缓存
    'DATA_CACHE_TIME'       => 10800,
];



