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


class ForgetModel extends BasicModel
{
	protected $autoCheckFields = false;

	protected static $_temp;

	public function _initialize()
	{
		parent::_initialize();

		if(cookie('think_language') == 'en-us')
		{
			self::$_temp = C('TEMP_EN');
		}
		else if(cookie('think_language') == 'ja-jp')
		{
			self::$_temp = C('TEMP_JP');
		}
		else
		{
			self::$_temp = C('TEMP_CN');
		}
	}


	/**
	* 找回密码 - 发送验证码
	* @param int $type 用户类型
	* @return array
	*/
	public function sendVerifyCode($type)
	{
		$data = I('post.');

		$code = rand(1000,9999);

		session('reset_code',$code);

		session('reset_code_lifetime',NOW_TIME);//生成时间

		if(!$data['username'])
		{
			$result = ['status'=>0,'msg'=>L('ENTER_ACCOUNT')];
		}
		else if(!$member = M('Member')->where(['account|email|mobile'=>$data['username'],'type'=>$type])->field('email,mobile,company_id')->find())
		{
			$msg = $data['way'] == 'email' ? L('EMAIL_NOT') : L('MOBILE_NOT');

			$result = ['status'=>0,'msg'=>$msg];
		}
		else
		{
			session('reset_account',$data['username']);

			if($data['way'] == 'email')
			{
				$title = self::$_temp['MAIL']['FORGET_MAIL_TEMP']['title'];

				$content = str_replace(['{{user_name}}','{{code}}'],[$member['email'],$code],self::$_temp['MAIL']['FORGET_MAIL_TEMP']['content']);

				$mail = M('Mail')->where(['company_id'=>$member['company_id']])->find();

				if($mail)
				{
					$result = D('Mail')->sendMail($member['email'],$member['name'],$title,$content,'',$mail);

					if($result === true)
					{
						$result = ['status'=>2,'msg'=>L('SEND_EMAIL_CODE_SUCCESS')];
					}
					else
					{
						$result = ['status'=>0,'msg'=>L('SENDEMAIL_CODE_FALSE').','.$result];
					}
				}
				else
				{
					$result = ['status'=>0,'msg'=>L('SYSTEM_MAIL_NOT')];
				}
			}
			else if($data['way'] == 'phone')
			{
				$sms = M('sms')->where(['company_id'=>$member['company_id']])->find();

				if($sms)
				{
					$msg = L('CODE_SMS',['code'=>$code]);

					$result = D('Sms')->sendSMS($sms,$member['mobile'],$msg,'verify',['code'=>$code]);

					$row = D('Sms')->execSendResult($result,$sms['sms_from']);

					if($row['code'] == 0)
					{
						$result = ['status'=>2,'msg'=>L('SEND_SMS_CODE_SUCCESS')];
					}
					else
					{
						$result = ['status'=>0,'msg'=>$row['msg']];
					}
				}
				else
				{
					$result = ['status'=>0,'msg'=>L('SYSTEM_SMS_NOT')];
				}
			}
			else
			{
				$result = ['status'=>0,'msg'=>L('ENTER_ACCOUNT')];
			}
		}

		return $result;
	}


	/*
	* 重置密码
	* @param int    $type   用户类型
	* @return array
	*/
	public function resetPassword($type)
	{
		$data = I('post.');

		$reset_code = session('reset_code');

		$lifetime = session('reset_code_lifetime');

		$expired = intval((NOW_TIME - $lifetime)/60);

		if(!$data['code'])
		{
			$result = ['status'=>0,'msg'=>L('ENTER_IMAGE_CODE')];
		}
		else if($expired > 30)
		{
			$result = ['status'=>0,'msg'=>L('CODE_EXPIRED')];
		}
		else if($data['code'] != $reset_code)
		{
			$result = ['status'=>0,'msg'=>L('CODE_INCORRECT')];
		}
		else if(!$data['password'])
		{
			$result = ['status'=>0,'msg'=>L('ENTER_PASSWORD')];
		}
		else if(!$data['sure_password'])
		{
			$result = ['status'=>0,'msg'=>L('ENTER_SURE_PASSWORD')];
		}
		else if($data['password'] != $data['sure_password'])
		{
			$result = ['status'=>0,'msg'=>L('TWO_PASSWORD')];
		}
		else
		{
			$save = M('Member')->where(['account|mobile|email'=>session('reset_account'),'type'=>$type])->setField('password',md5($data['password']));

			if($save !== false)
			{
				session('reset_code',null);

				session('reset_code_lifetime',null);

				session('reset_account',null);

				$url = $type == 1 ? '/u-reset-success' : '/c-reset-success';

				$result = ['status'=>2,'msg'=>L('UPDATE_SUCCESS'),'url'=>$url];
			}
			else
			{
				$result = ['status'=>0,'msg'=>L('UPDATE_FAILED')];
			}
		}

		return $result;
	}
}
