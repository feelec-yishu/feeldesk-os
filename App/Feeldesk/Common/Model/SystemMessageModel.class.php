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

use Think\Page;

class SystemMessageModel extends BasicModel
{
	protected $pk   = 'msg_id';

	protected $tableName = 'system_message';

	/*
	* PC端获取系统消息
	* @param int $company_id 公司ID
	* @param int $recipient_id 接受者ID
	* @param int $recipient 接受者类型 1 用户 2 会员、游客
	* @param int $rollPage 页码数量
	* @param int $listRows 每页显示数量
	* @return array
	*/
	public function getMessage($company_id = 0,$recipient_id = 0,$recipient = 0,$rollPage = 11,$listRows = 14)
	{
		$field = ['company_id'=>$company_id,'recipient_id'=>$recipient_id,'recipient'=>$recipient];

		$msg_id = I('get.msg_id');

		$types = I('get.types');

		if($types == 'unread') $field['read_status'] = 1;

		if($types == 'read') $field['read_status'] = 2;

		if($msg_id)
		{
			$field['msg_id'] = $msg_id;

			$detail = $this->where($field)->find();

			$result = ['code'=>1,'detail'=>$detail];

			$this->where(['msg_id'=>$msg_id])->setField('read_status',2);
		}
		else
		{
			$count = $this->where($field)->count('msg_id');

			$Page = new Page($count,$listRows);

			$message = $this->where($field)->limit($Page->firstRow, $Page->listRows)->order('msg_id desc')->fetchAll();

			$Page->rollPage = $rollPage;

			$Page->setConfig('theme', '%UP_PAGE% %LINK_PAGE% %DOWN_PAGE%');

			$result = ['code'=>2,'page'=>$Page->show(),'message'=>$message];
		}

		$result['types'] = $types;

		$result['from'] = I('get.from');

		return $result;
	}


	/*
	* PC端删除系统消息
	* @param int $company_id 公司ID
	* @param int $recipient_id 接受者ID
	* @param int $recipient 接受者类型 1 用户 2 会员、游客
	* @return array
	*/
	public function deleteMessage($company_id = 0,$recipient_id = 0,$recipient = 0)
	{
		$ids = I('post.ids');

		$type = I('post.type') ? I('post.type') : I('get.type');

		if(!$ids) $ids = explode(',',I('get.ids'));

		if(count($ids) > 0)
		{
			$result = $this->where(['company_id'=>$company_id,'recipient_id'=>$recipient_id,'recipient'=>$recipient,'msg_id'=>['in',$ids]])->delete();

			if($result)
			{
				$result = ['status'=>2,'msg'=>L('DELETE_SUCCESS'),'url'=>U('getMessage',['types'=>$type])];
			}
			else
			{
				$result = ['status'=>0,'msg'=>L('DELETE_FAILED')];
			}
		}
		else
		{
			$result = ['status'=>0,'msg'=>L('ILLEGAL_ACCESS')];
		}

		return $result;
	}


	/*
	* PC端更新系统消息
	* @param int    $company_id 公司ID
	* @param int    $recipient_id 接受者ID
	* @param int    $recipient 接受者类型 1 用户 2 会员、游客
	* @param string $source 读取标签 read_all 全部已读
	* @return array
	*/
	public function updateMessageStatus($company_id = 0,$recipient_id = 0,$recipient = 0,$source = '')
	{
		$where = ['company_id'=>$company_id,'recipient_id'=>$recipient_id,'recipient'=>$recipient];

		if($source != 'read_all')
		{
			$ids = I('post.ids');

			if(!$ids) $ids = explode(',',I('get.ids'));

			if(count($ids) > 0)
			{
				$where['msg_id'] = ['in',$ids];
			}
		}

		$result = $this->where($where)->setField('read_status',2);

		$type = I('post.type') ? I('post.type') : I('get.type');

		if($result !== false)
		{
			$result = ['status'=>2,'msg'=>L('UPDATE_SUCCESS'),'url'=>U('getMessage',['types'=>$type])];
		}
		else
		{
			$result = ['status'=>0,'msg'=>L('ILLEGAL_ACCESS')];
		}

		return $result;
	}
}
