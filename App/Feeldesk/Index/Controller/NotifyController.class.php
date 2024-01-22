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

namespace Index\Controller;

use Index\Common\BasicController;

class NotifyController extends BasicController
{
    protected $_filter = ['create_notify_publish','editor_notify_publish','end_notify_publish','assign_notify_handle','ticket_cc_notify',
	    'reply_notify_publish','reply_notify_handler','reply_notify_cc','internal_notify_handle','internal_notify_cc','status_notify_publish',
	    'restart_ticket_notify','comment_reply_notify','ticket_timeout_notify','end_notify_follow','reply_notify_follow','internal_notify_follow',
	    'status_notify_follow','restart_notify_follow'
    ];

	public function config()
	{
		$company = M('company')->where(['company_id'=>$this->_company_id])->find();

		$config = M('notify_config')->where(['company_id'=>$this->_company_id])->find();

        if(IS_POST)
		{
            $result = false;

			if($company['ticket_auth'] == 10)
			{
				$data = checkFields(I('post.config'),$this->_filter);

				foreach($this->_filter as $k2=>$v2)
				{
					if(!in_array($v2,array_keys($data)))
					{
						$data[$v2] = 20;
					}
					else
					{
						$data[$v2] = 10;
					}
				}

				if($config)
				{
					$result = M('notify_config')->where(['company_id'=>$this->_company_id])->save($data);
				}
				else
				{
					$data['company_id'] = $this->_company_id;

					$result = M('notify_config')->add($data);
				}
			}

            if($result === false)
            {
                $this->ajaxReturn(['status'=>0,'msg'=>L('UPDATE_FAILED')]);
            }
            else
            {
                $this->ajaxReturn(['status'=>2,'msg'=>L('UPDATE_SUCCESS'),'url'=>U('config')]);
            }
		}
		else
		{
			$members = M('member')->where(['company_id'=>$this->_company_id,'type'=>1])->field('name,member_id,is_first')->select();

			foreach($members as $key=>&$val)
			{
				$val['id'] = $val['member_id'];
			}

			$this->assign('members',json_encode($members));

			$this->assign('config',$config);

			$this->assign('ticketAuth',$this->_company['ticket_auth']);

			$this->display();
		}
	}
}
