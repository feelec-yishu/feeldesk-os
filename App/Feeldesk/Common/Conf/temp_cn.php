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
return
[
    'TEMP_CN' =>
    [
//       系统通知模板
	    'SYSTEM'=>
	    [
		    'TICKET_STATUS_MSG' => [
			    'title'     => '工单 {{title}} 状态修改通知',
			    'content'   => '您好，您发布的工单 {{title}} 状态已改变，处理状态由 {{oldStatus}} 变为 {{newStatus}}，请知悉!',
		    ],

		    'EDITOR_SYSTEM_MSG' => [
			    'title'     => '工单 {{title}} 修改成功',
			    'content'   => '您好，您发布的工单 {{title}} 已经修改成功，请知悉!',
		    ],

		    'END_SYSTEM_MSG' => [
			    'title'     => '工单 {{title}} 处理完毕',
			    'content'   => '您好，您发布的工单 {{title}} 已经处理完毕，请知悉!',
		    ],

		    'ASSIGN_SYSTEM_MSG' => [
			    'title'     => '工单 {{title}} 分配通知',
			    'content'   => '您好，您分配到一个新的工单 {{title}}，请尽快处理，谢谢!',
		    ],

		    'REPLY_SYSTEM_MSG'  => [
			    'title'     => '工单 {{title}} 回复通知',
			    'content'   => '您好，您提交的工单 {{title}} 有新的回复，请知悉!',
		    ],

		    'FOLLOW_REPLY_TICKET'  => [
			    'title'     => '关注的工单 {{title}} 回复通知',
			    'content'   => '您好，您关注的工单 {{title}} 有新的回复，请知悉!',
		    ],

		    'HANDLE_SYSTEM_MSG' => [
			    'title'     => '处理的工单 {{title}} 回复通知',
			    'content'   => '您好，您处理的工单 {{title}} 有新的回复，请知悉!',
		    ],

		    'TEAM_SYSTEM_MSG'   => [
			    'title'     => '处理的工单 {{title}} 内部协作回复通知',
			    'content'   => '您好，您处理的工单 {{title}} 内部协作有新的回复，请知悉!',
		    ],

		    'FOLLOW_TEAM_REPLY'   => [
			    'title'     => '关注的工单 {{title}} 内部协作回复通知',
			    'content'   => '您好，您关注的工单 {{title}} 内部协作有新的回复，请知悉!',
		    ],

		    'CC_SYSTEM_MSG'   => [
			    'title'     => '工单 {{title}} 抄送通知',
			    'content'   => '您好，工单 {{title}} 已经抄送给您，请知悉!',
		    ],

		    'CC_REPLY_SYSTEM_MSG'   => [
			    'title'     => '抄送的工单 {{title}} 回复通知',
			    'content'   => '您好，抄送给您的工单 {{title}} 有新的回复，请知悉!',
		    ],

		    'CC_TEAM_SYSTEM_MSG'   => [
			    'title'     => '抄送的工单 {{title}} 内部协作回复通知',
			    'content'   => '您好，抄送给您的工单 {{title}} 内部协作有新的回复，请知悉!',
		    ],

		    'GROUP_SYSTEM_MSG' => [
			    'title'     => '{{group_name}}分配到一个新工单 {{title}} ',
			    'content'   => '您好，{{group_name}}分配到一个新的工单 {{title}}，请尽快分配处理人，谢谢!',
		    ],

		    'RESTART_TICKET_MSG' => [
			    'title'     => '处理的工单 {{title}} 重启通知',
			    'content'   => '您好，您处理的工单 {{title}} 已被重新开启，请尽快处理，谢谢!',
		    ],

		    'COMMENT_REPLY_MSG' => [
			    'title'     => '工单 {{title}} 回复评论通知',
			    'content'   => '您好，您参与的工单 {{title}} 的回复有新的评论，请知悉!',
		    ],

		    'TIMEOUT_TICKET_MSG' => [
			    'title'     => '您有 <span style="color:#FF5722">{{timeoutNum}}</span> 条工单已超时',
			    'content'   => "您好，您有 <span style='color:#FF5722''>{{timeoutNum}}</span> 条工单已超时，请尽快处理，谢谢，<a href='/index/base?redirect_url={{url}}' style='color:#FF5722'>点击查看</a>",
		    ],

		    'URGE_TICKET_MSG' => [
			    'title'     => '您有一个催办工单需要处理',
		    ],

		    'AUDIT_CREATE_TICKET_MSG' => [
			    'title'     => '发布工单 {{title}} 审核通知',
			    'content'   => '您好，工单 {{title}} 需要您审核，请尽快处理!',
		    ],

		    'AUDIT_END_TICKET_MSG' => [
			    'title'     => '结束工单 {{title}} 审核通知',
			    'content'   => '您好，{{member_name}}提交了结束工单 {{title}} 的审核申请，请尽快处理!',
		    ],

		    'REJECT_CREATE_TICKET_MSG' => [
			    'title'     => '发布工单 {{title}} 驳回通知',
			    'content'   => '您好，您发布的工单 {{title}} 未通过审核，驳回原因：{{content}}',
		    ],

		    'REJECT_END_TICKET_MSG' => [
			    'title'     => '结束工单 {{title}} 驳回通知',
			    'content'   => '您好，您提交的结束工单 {{title}} 的申请未通过审核，驳回原因：{{content}}',
		    ],

		    'FOLLOW_RESTART_TICKET' => [
			    'title'     => '关注的工单 {{title}} 重启通知',
			    'content'   => '您好，您关注的工单 {{title}} 已被重启，请知悉!',
		    ],

		    'FOLLOW_EDITOR_STATUS' => [
			    'title'     => '关注的工单 {{title}} 状态修改通知',
			    'content'   => '您好，您关注的工单 {{title}} 状态已改变，处理状态由 {{oldStatus}} 变为 {{newStatus}}，请知悉!',
		    ],

		    'FOLLOW_END_TICKET' => [
			    'title'     => '关注的工单 {{title}} 结束通知',
			    'content'   => '您好，您关注的工单 {{title}} 已经处理完毕，请知悉!',
		    ],
	    ],
    ]
];
