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

class SubTicketModel extends BasicModel
{
	protected $pk   = 'ticket_id';

	protected $tableName = 'sub_ticket';

	protected $replyFilter = ['ticket_id','reply_content'];

	/*
	* 创建子工单
	* @param int   $company_id      公司ID
	* @param int   $now_member_id   当前登录用户ID
	*/
	public function createSubTicket($company_id,$now_member_id)
	{
		$title = I('post.title','');

		$id = I('post.id','');

		if(!$title)
		{
			$result = ['status'=>0,'msg'=>L('ENTER_SUB_TICKET_TITLE')];
		}
		else if(!$parent = D('Ticket')->where(['company_id'=>$company_id,'ticket_id'=>decrypt($id,'TICKET')])->field('ticket_id,dispose_id')->find())
		{
			$result = ['status'=>0,'msg'=>L('PARENT_TICKET_NOT')];
		}
		else
		{
			$subTicketData = [
				'company_id'    => $company_id,
				'ticket_no'     => D('Ticket')->getTicketNo($company_id),
				'title'         => $title,
				'parent_id'     => $parent['ticket_id'],
				'member_id'     => $now_member_id,
				'process_id'    => $parent['dispose_id'],//默认使用父级工单处理人作为子工单处理人
				'status_id'     => 10,
				'assign_time'   => $parent['dispose_id'] ? NOW_TIME : 0,
				'create_time'   => NOW_TIME
			];

			$sub_ticket_id = M('sub_ticket')->add($subTicketData);

			if($sub_ticket_id)
			{
//                存储工单事件
				D('SubEvent')->saveEvent($sub_ticket_id,'create',$now_member_id);

				if($parent['dispose_id'])
				{
//				      通知处理人
					D('BuildMessage')->assignProcessMessage($parent['dispose_id'],$sub_ticket_id);
				}

				$result = ['status'=>2,'msg'=>L('SUBMIT_SUCCESS'),'id'=>encrypt($sub_ticket_id,'SUB_TICKET')];
			}
			else
			{
				$result = ['status'=>0,'msg'=>L('SUBMIT_FAILED')];
			}
		}

		return $result;
	}


	public function editorSubTicket($company_id,$member_id,$subTicket)
	{
		$ticket = I('post.ticket',[]);

		if(!$ticket['title'])
		{
			$result = ['status'=>0,'msg'=>L('ENTER_SUB_TICKET_TITLE')];
		}
		else if(!$ticket['process_id'])
		{
			$result = ['status'=>0,'msg'=>L('SELECT_SUB_TICKET_HANDLER')];
		}
		else
		{
//            图片
			$photo = I('post.photo',[]);

			$ticket['photo'] = $photo ? serialize($photo) : '';

			$update = [
				'title'         => $ticket['title'],
				'process_id'    => $ticket['process_id'] ? $ticket['process_id'] : 0,
				'content'       => $ticket['content'],
				'photo'         => $ticket['photo'],
				'update_time'   => NOW_TIME
			];

//			子工单原本没有处理人、修改时有处理人、没有分配时间，记录工单分配时间
			if(!$subTicket['process_id'] && $update['process_id'] > 0 && !$subTicket['assign_time'])
			{
				$update['assign_time'] = NOW_TIME;

//				通知处理人
				D('BuildMessage')->assignProcessMessage($update['process_id'],$subTicket['ticket_id']);
			}

			$save = M('sub_ticket')->where(['ticket_id'=>$subTicket['ticket_id'],'company_id'=>$company_id])->save($update);

//            更新上传文件信息
			$files = isset($_POST['file']) ? I('post.file') : [];

			$delFiles = isset($_POST['delFile']) ? I('post.delFile') : [];

			D('Ticket')->updateUploadFile($files,$delFiles,0,0,$company_id,'sub_ticket',0,0,$subTicket['ticket_id']);

//            删除上传图片
			$delImages = I('post.delImage',[]);

			D('Ticket')->deleteUploadImage($delImages);

			if($save !== false)
			{
//                存储工单事件
				D('SubEvent')->saveEvent($subTicket['ticket_id'],'modify',$member_id);

				$result = ['status'=>2,'msg'=>L('UPDATE_SUCCESS'),'isReload'=>1,'url'=>U('detail',['id'=>encrypt($subTicket['ticket_id'],'SUB_TICKET')])];
			}
			else
			{
				$result = ['status'=>0,'msg'=>L('UPDATE_FAILED')];
			}
		}

		return $result;
	}


	/*
	* 子工单详情
	* @param array     $subTicket  子工单信息
	* @param array     $user       当前登录人信息
	* @param string    $source     访问渠道
	* @return array
	*/
	public function getSubTicketDetail($subTicket,$user,$source = 'pc')
	{
		$subTicket['parent_ticket_title'] = M('ticket')->where(['ticket_id'=>$subTicket['parent_id']])->getField('title');

//        部门
		$subTicket['group'] = D('Group')->where(['company_id'=>$subTicket['company_id'],'group_id'=>$subTicket['group_id']])->field('group_id,group_name')->find();

//        发布人和处理人
		$subTicket['members'] = D('Member')
			->where(['company_id'=>$subTicket['company_id'],'type'=>1,'member_id'=>['in',[$subTicket['member_id'],$subTicket['process_id']]]])
			->field('member_id,name,group_id,face')
			->fetchAll();

		$subTicket['photo'] = unserialize($subTicket['photo']);

		$replySortRule = 'desc';

		if($source == 'mobileTerminal') $replySortRule = 'asc';

//		  回复内容
		$reply = M('sub_reply')
			->alias('a')
			->join('feel_member AS b ON a.member_id = b.member_id','left')
			->where(['a.company_id'=>$subTicket['company_id'],'ticket_id'=>$subTicket['ticket_id']])
			->field('reply_id,reply_content,reply_time,name,type,face')
			->order('reply_id '.$replySortRule)
			->select();

//        移动端回复内容处理
		if($source == 'mobileTerminal')
		{
			$replyByTime = $replyList = [];

			foreach($reply as $k2=>&$v2)
			{
				$v2['reply_date'] = date('Y-m-d',$v2['reply_time']);

				$replyByTime[$k2] = $v2;
			}

			foreach($reply as $v3)
			{
				foreach($replyByTime as $k4=>$v4)
				{
					if($v3['reply_date'] == $v4['reply_date'])
					{
						$replyList[$v3['reply_date']][$k4] = $v4;
					}
				}
			}

			$subTicket['reply'] = $replyList;
		}
		else
		{
			$subTicket['reply'] = $reply;
		}

//		  工单附件
		$uploadFiles = M('upload_file')->where(['company_id'=>$subTicket['company_id'],'sub_ticket_id'=>$subTicket['ticket_id']])
			->field('sub_ticket_id,sub_reply_id,file_form,file_name,file_size,file_type,file_link')
			->select();

		$createFiles = $replyFiles = [];

		foreach($uploadFiles as $k2=>$v2)
		{
			if($v2['file_form'] == 'sub_reply')
			{
				$replyFiles[$v2['sub_reply_id']][] = $v2;
			}
			else
			{
				$createFiles[] = $v2;
			}
		}

		$subTicket['attachments'] = ['createFiles'=>$createFiles,'replyFiles'=>$replyFiles];

		if($subTicket['is_delete'] == 10)
		{
//	    	修改权限
			$subTicket['editorAuth'] = D('RoleAuth')->checkRoleAuthByMenu($subTicket['company_id'],'subTicket/editor',$user['role_id']);

//	    	回复权限
			$subTicket['replyAuth'] = D('RoleAuth')->checkRoleAuthByMenu($subTicket['company_id'],'subTicket/reply',$user['role_id']);

//	    	删除权限
			$subTicket['deleteAuth'] = D('RoleAuth')->checkRoleAuthByMenu($subTicket['company_id'],'subTicket/delete',$user['role_id']);
		}

		return $subTicket;
	}


	/*
	* 回复子工单
	* @param int $company_id        公司ID
	* @param int $now_member_id     当前登录人ID
	* @return
	*/
	public function replySubTicket($company_id,$now_member_id)
	{
		$data = $this->checkReply($company_id,$now_member_id);

		if($data['status'] === 0) return $data;

		$detail = $this->where(['company_id'=>$company_id,'ticket_id'=>$data['ticket_id']])
			->field('ticket_id,status_id,member_id,process_id,process_time')
			->find();

		if(!$detail) return ['status'=>0,'msg'=>L('TICKET_NOT')];

//        检查已结束的工单是否允许回复
		if($detail['status_id'] == 20) return ['status'=>0,'msg'=>L('SUB_TICKET_END_REPLY')];

		$data['reply_content'] = str_replace("?imageMogr2/auto-orient/thumbnail/240x135!/format/png/blur/1x0/quality/100|imageslim",'',$data['reply_content']);

		if($reply_id = M('sub_reply')->add($data))
		{
//            存储工单事件
			D('SubEvent')->saveEvent($detail['ticket_id'],'reply',$now_member_id,$reply_id);

//            判断处理人
			$update = $this->JudgeProcess($detail['ticket_id'],$now_member_id);

			$this->save($update);

//            储存上传文件信息
			$files = isset($_POST['file']) ? I('post.file') : [];

			if(!empty($files)) D('Ticket')->saveUploadFile($files,0,0,$company_id,'sub_reply',0,0,$data['ticket_id'],$reply_id);

//			  通知
			D('BuildMessage')->buildSubMessage($detail['ticket_id'],$now_member_id);

			return ['status'=>1,'msg'=>L('UPDATE_SUCCESS'),'url'=>U('detail',['id'=>encrypt($data['ticket_id'],'SUB_TICKET'),'tab'=>'reply']),'value'=>$detail['ticket_id']];
		}
		else
		{
			return ['status'=> 0,'msg'=>L('UPDATE_FAILED')];
		}
	}


	/*
	* 回复工单校验
	* @param int    $company_id     公司ID
	* @param array  $now_member_id  回复人ID
	* @return array
	*/
	protected function checkReply($company_id = 0,$now_member_id = 0)
	{
		$data = checkFields(I('post.reply'), $this->replyFilter);

		if(!$data['reply_content'])
		{
			return ['status'=>0,'msg'=>L('ENTER_REPLY')];
		}

		$data['company_id'] =  $company_id;

		$data['member_id'] =  $now_member_id;//回复人

		$data['reply_time'] = NOW_TIME;

		return $data;
	}


	/*
	* 删除子工单
	* @param int    $id     子工单ID
	* @return array
	*/
	public function deleteSubTicket($id,$member_id,$type = 1)
	{
		if($type == 2)
		{
			$subTickets = [];

			$id = is_array($id) ? $id : explode(',',$id);

			foreach($id as &$v)
			{
				$v = decrypt($v,'SUB_TICKET');

				$subTickets[] = $this->where(['ticket_id'=>$v])->field('photo,content')->find();
			}

			$where = ['ticket_id'=>['in',$id]];

			$delete = $this->where($where)->delete();

			if($delete)
			{
//			     删除工单事件
				M('sub_event')->where($where)->delete();

//			     删除系统消息
				M('system_message')->where($where)->delete();

				foreach($subTickets as $s)
				{
					if($s['content'])
					{
//			             删除工单内容图片
						$content = str_replace('?imageMogr2/auto-orient/thumbnail/240x135!/format/png/blur/1x0/quality/100|imageslim','',getHtml($s['content']));

						$pattern = "/<[img|IMG].*?src=[\'|\"](.*?(?:[\.gif|\.jpg|\.png]))[\'|\"].*?[\/]?>/";

						preg_match_all($pattern,$content,$detail_img);

						if($detail_img[1])
						{
							foreach($detail_img[1] as $v1)
							{
								D('Upload')->deleteUploadFile($v1);
							}
						}
					}

//			         删除工单配图
					if($s['photo'])
					{
						D('Upload')->deleteTicketFile($s['photo']);
					}
				}

//			     删除工单回复、回复内容、附件和图片
				$sub_reply = M('sub_reply')->where($where)->select();

				if(M('sub_reply')->where($where)->delete())
				{
					foreach($sub_reply as $r)
					{
						//删除回复图片
						$reply_content = str_replace('?imageMogr2/auto-orient/thumbnail/240x135!/format/png/blur/1x0/quality/100|imageslim','',html_entity_decode($r['reply_content']));

						$pattern = "/<[img|IMG].*?src=[\'|\"](.*?(?:[\.gif|\.jpg|\.png]))[\'|\"].*?[\/]?>/";

						preg_match_all($pattern,$reply_content,$reply_img);

						if($reply_img[1])
						{
							foreach($reply_img[1] as $v2)
							{
								D('Upload')->deleteUploadFile($v2);
							}
						}
					}
				}

//			     删除工单附件
				$files = M('upload_file')->where(['sub_ticket_id'=>['in',$id]])->field('save_name')->select();

				if(M('upload_file')->where(['sub_ticket_id'=>['in',$id]])->delete())
				{
					if($files)
					{
						foreach($files as $f)
						{
							D('Upload')->deleteUploadFile($f['save_name']);
						}
					}
				}

				$result = ['status'=>2,'msg'=>L('DELETE_SUCCESS'),'isReload'=>1];
			}
			else
			{
				$result = ['status'=>0,'msg'=>L('DELETE_FAILED')];
			}
		}
		else
		{
			$id = is_array($id) ? $id : explode(',',$id);

			foreach($id as &$v)
			{
				$v = decrypt($v,'SUB_TICKET');

				$data = ['ticket_id'=>$v,'delete_time'=>NOW_TIME,'delete_member_id'=>$member_id,'is_delete'=>20,'delete_ip'=>get_client_ip()];

				$update = $this->save($data);

				if($update)
				{
//                   存储工单事件
					D('SubEvent')->saveEvent($v,'delete',$member_id);
				}
			}

			$result = ['status'=>2,'msg'=>L('DELETE_SUCCESS')];
		}

		return $result;
	}



	/*
	* 工单详情中的Ajax请求
	* @param int    $company_id     公司ID
	* @param int    $now_member_id  当前用户ID
	* @param array  ticket          工单信息
	* @param string request         请求类型
	* @return array
	*/
	public function ajaxRequestByDetail($subTicket = [],$request = '')
	{
		if(isset($_POST['source']))
		{
			$source = trim(I('post.source'));

			$value = isset($_POST['value']) ? I('post.value') : 0;

			if(!$subTicket)
			{
				return ['status'=>0,'msg'=>L('TICKET_NOT')];
			}

//			  设置工单状态
			if($source == 'setStatus')
			{
				return $this->updateTicketStatus($subTicket,$value);
			}
		}

		if($request == 'flow')// 工单事件列表
		{
			$eventList = D('SubEvent')->getEventByTicketId(['a.ticket_id'=>decrypt(I('get.id'),'SUB_TICKET')]);

			return ['data'=>$eventList['events'],'pages'=>$eventList['pages']];
		}
	}


	/*
	* 更新工单状态
	* @param int    $company_id     公司ID
	* @param array  $ticket         工单信息
	* @param int    $status_id      状态ID
	* @param int    $end_status_id  结束状态ID
	* @param int    $now_member_id  当前登录用户ID
	* @param int    $type           用户类型 1 用户 2 会员
	* return array
	*/
	public function updateTicketStatus($subTicket,$status_id,$end_status_id = 20)
	{
		if($status_id == $subTicket['status_id'])
		{
			return ['errcode'=>0,'msg'=>L('UPDATE_SUCCESS'),'url'=>U('detail',['id'=>encrypt($subTicket['ticket_id'],'SUB_TICKET')])];
		}
		else
		{
			$data = ['status_id'=>$status_id,'ticket_id'=>$subTicket['ticket_id'],'been'=>'updated','update_time'=>NOW_TIME];

			if($data['status_id'] == $end_status_id)
			{
				$data['end_time'] = NOW_TIME;
			}

//            有处理人但没有开始处理时，改变状态记录处理时间
			if($subTicket['process_id'] > 0 && !$subTicket['process_time'])
			{
				$data['process_time'] = NOW_TIME;
			}

			$update_status = $this->save($data);

			if($update_status !== false)
			{
				$refresh = 0;

				if($data['process_id']) $refresh = 1;

				$result = ['errcode'   => 0,
					'msg'       => L('UPDATE_SUCCESS'),
					'url'       => U('detail',['id'=>encrypt($subTicket['ticket_id'],'SUB_TICKET')]),
					'id'        => encrypt($subTicket['ticket_id'],'SUB_TICKET'),
					'ticket_no' => $subTicket['ticket_no'],
					'refresh'   => $refresh,
				];
			}
			else
			{
				$result = ['errcode'=>1,'msg'=>L('UPDATE_FAILED')];
			}

			return $result;
		}
	}


	/*
	* 判断处理人
	* @param int  $ticket_id      工单ID
	* @param int  $reply_id       回复ID
	* @param int  $status_id      回复时提交的工单状态
	* @param int  $first_id       初始状态
	* @param int  $member_id      当前登录人ID
	* @return array $update       待更新的工单数据
	*/
	public function JudgeProcess($ticket_id=0,$member_id=0)
	{
		$ticket = $this->where(['ticket_id'=>$ticket_id])->field('member_id,process_id,process_time')->find();

		$isRelease = (bool)($ticket['member_id'] == $member_id);//工单是否为当前登录人发布

//        工单没有处理人并且不是当前登录客服发布，当前回复的客服自动成为处理人
		if((!$ticket['process_id']) && (!$isRelease))
		{
			$update = ['process_id'=>$member_id,'assign_time'=>NOW_TIME,'process_time'=>NOW_TIME];
		}

//        当前登录用户为处理人，没有处理时间
		if($member_id == $ticket['process_id'] && !$ticket['process_time'])
		{
			$update['process_time'] = NOW_TIME;
		}

		$update['ticket_id'] = $ticket_id;//工单ID

		$update['update_time'] = NOW_TIME;//更新时间

		$update['been'] = 'updated';//被更新

		return $update;
	}
}
