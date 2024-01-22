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

class SatisfactionController extends  BasicController
{
	public function index()
	{
		$lang_name = D('Satisfaction')->getNameByLang('satisfy_name');

		$satisfaction = M('satisfaction')->where(['company_id'=>$this->_company_id])->order('satisfy_id desc')->field("satisfy_id,{$lang_name}")->select();

		$this->assign('satisfaction',$satisfaction);

		$this->display();
	}


	public function editor_satisfy($satisfy_id,$name)
	{
		if(IS_POST)
		{
			if(!$satisfy_id = M('satisfaction')->where(['company_id'=>$this->_company_id,'satisfy_id'=>$satisfy_id])->getField('satisfy_id'))
			{
				$result = ['code'=>1,'msg'=>L('SATISFACTION_NOT')];
			}
			else if(!$name)
			{
				$result = ['code'=>1,'msg'=>L('ENTER_SATISFY_NAME')];
			}
			else
			{
				$satisfyData = ['company_id'=>$this->_company_id,'satisfy_id'=>$satisfy_id,'satisfy_name'=>$name];

				if(M('satisfaction')->save($satisfyData) !== false)
				{
					$result = ['code'=>0,'msg'=>L('UPDATE_SUCCESS'),'satisfy_id'=>$satisfy_id];
				}
				else
				{
					$result = ['code'=>1,'msg'=>L('UPDATE_FAILED')];
				}
			}

			$this->ajaxReturn($result);
		}
		else
		{
			$this->returnError(L('ILLEGAL_ACCESS'),U('Index/welcome'));
		}
	}


	public function label_list($satisfy_id)
	{
		if(IS_POST)
		{
			if($satisfy_id)
			{
				$label = M('satisfy_label')->where(['company_id'=>$this->_company_id,'satisfy_id'=>$satisfy_id])->select();

				$result = ['code'=>0,'msg'=>'ok','data'=>$label];
			}
			else
			{
				$result = ['code'=>1,'msg'=>L('ILLEGAL_ACCESS')];
			}

			$this->ajaxReturn($result);
		}
		else
		{
			$this->returnError(L('ILLEGAL_ACCESS'),U('Index/welcome'));
		}
	}


	public function create_label($name = '',$satisfy_id = '')
	{
		if(IS_POST)
		{
			if(!$satisfy_id = M('satisfaction')->where(['company_id'=>$this->_company_id,'satisfy_id'=>$satisfy_id])->getField('satisfy_id'))
			{
				$result = ['code'=>1,'msg'=>L('SELECT_SATISFACTION')];
			}
			else if(!$name)
			{
				$result = ['code'=>1,'msg'=>L('ENTER_LABEL_NAME')];
			}
			else
			{
				$labelData = ['company_id'=>$this->_company_id,'satisfy_id'=>$satisfy_id,'label_name'=>$name];

				if($label_id = M('satisfy_label')->add($labelData))
				{
					$result = ['code'=>0,'msg'=>L('SUBMIT_SUCCESS'),'label_id'=>$label_id];
				}
				else
				{
					$result = ['code'=>1,'msg'=>L('SUBMIT_FAILED')];
				}
			}

			$this->ajaxReturn($result);
		}
		else
		{
			$this->returnError(L('ILLEGAL_ACCESS'),U('Index/welcome'));
		}
	}


	public function editor_label($label_id,$name='')
	{
		if(IS_POST)
		{
			if(!$label_id = M('satisfy_label')->where(['company_id'=>$this->_company_id,'label_id'=>$label_id])->getField('label_id'))
			{
				$result = ['code'=>1,'msg'=>L('LABEL_NOT')];
			}
			else if(!$name)
			{
				$result = ['code'=>1,'msg'=>L('ENTER_LABEL_NAME')];
			}
			else
			{
				$labelData = ['company_id'=>$this->_company_id,'label_id'=>$label_id,'label_name'=>$name];

				if(M('satisfy_label')->save($labelData) !== false)
				{
					$result = ['code'=>0,'msg'=>L('SUBMIT_SUCCESS'),'label_id'=>$label_id];
				}
				else
				{
					$result = ['code'=>1,'msg'=>L('SUBMIT_FAILED')];
				}
			}

			$this->ajaxReturn($result);
		}
		else
		{
			$this->returnError(L('ILLEGAL_ACCESS'),U('Index/welcome'));
		}
	}


	public function delete_label($label_id = 0)
	{
		if(IS_POST)
		{
			if(!$label_id = M('satisfy_label')->where(['company_id'=>$this->_company_id,'label_id'=>$label_id])->getField('label_id'))
			{
				$result = ['code'=>1,'msg'=>L('LABEL_NOT')];
			}
			else
			{
				$labelData = ['company_id'=>$this->_company_id,'label_id'=>$label_id];

				if(M('satisfy_label')->where($labelData)->delete())
				{
					$result = ['code'=>0,'msg'=>L('DELETE_SUCCESS')];
				}
				else
				{
					$result = ['code'=>1,'msg'=>L('DELETE_FAILED')];
				}
			}

			$this->ajaxReturn($result);
		}
		else
		{
			$this->returnError(L('ILLEGAL_ACCESS'),U('Index/welcome'));
		}
	}
}
