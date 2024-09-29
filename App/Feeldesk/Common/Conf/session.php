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

//    SESSION配置
	'SESSION_AUTO_START'    => true, // 是否自动开启Session

	'SESSION_PREFIX'        => 'Ticket-V3:OS:Session:', //session前缀

	'SESSION_TYPE'          => 'Redis', //session类型

	'SESSION_PERSISTENT'    => 1, //是否长连接(对于php来说0和1都一样)

	'SESSION_CACHE_TIME'    => 1, //连接超时时间(秒)

	'SESSION_REDIS_DB'      => 0, //session使用的redis数据库

	'SESSION_EXPIRE'        => 28800, //session有效期(单位:秒) 0表示永久缓存
];
