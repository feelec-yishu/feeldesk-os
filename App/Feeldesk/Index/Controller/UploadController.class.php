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

use PHPExcel_Exception;

use PHPExcel_Reader_Exception;

use PHPExcel_RichText;

use Think\Controller;

class UploadController extends Controller
{
//    上传文件
    public function UploadTicketFile()
    {
        $result = D('Upload')->uploadAttachment();

        $this->ajaxReturn($result);
    }


//    上传图片
    public function uploadImageFile($type = '',$name = '')
    {
        $result = D('Upload')->UploadImageFile($type,$name);

        $this->ajaxReturn($result);
    }


//    上传头像
    public function uploadHeadFile($type = '')
    {
        $result = D('Upload')->UploadHeadFile($type);

        $this->ajaxReturn($result);
    }


//    删除上传文件和图片
    public function deleteUploadFile($filename='',$from = '')
    {
        $file_name = I('post.file_name') ? I('post.file_name') : $filename;

        $result = D('Upload')->deleteUploadFile($file_name,$from);

        $this->ajaxReturn($result);
    }


//    导入Excel
    public function importExcel()
    {
        //文件上传设置
        $config = [
        	'maxSize'  => 20 * 1024 * 1024, // 设置附件上传大小
            'rootPath' => './Attachs/',     // 文件上传的保存路径
            'savePath' => 'excel/',         // 文件上传的保存路径
            'saveName' => ['uniqid',''],
            'exts'     => ['xlsx','xls'],   // 设置附件上传类型
            'autoSub'  => true,
            'subName'  => ['date','Ymd'],
        ];

	    $source = I('post.source') ? I('post.source') : I('get.source');

        $Upload = new \Think\Upload($config);

        $info = $Upload->uploadOne($_FILES['excel']);

        if(!$info)
        {
            $data = ['status'=>0,'msg'=>$Upload->getError()];
        }
        else
        {
            $file = $config['rootPath'].$info['savepath'].$info['savename'];

            $data = $this->HandleImport($file,$source);
        }

        $this->ajaxReturn($data);
    }


    /*
	* 处理导入的Excel文件
	* @param string $file   Excel文件路径
	* @param string $source 导入类型，library：知识库；faq：FAQ；customer：会员；member：用户
	*/
    private function HandleImport($file,$source='')
    {
//        检查Excel文件是否存在
        if(!file_exists($file))
        {
            return ['error'=>0,'msg'=>L('FILE_DOES_NOT_EXIST')];
        }
        else
        {
	        $company_id = session('company_id');

	        import('Org.Util.PHPExcel');//手动加载第三方插件

	        try
	        {
//                加载excel文件
		        $objPHPExcel = \PHPExcel_IOFactory::load($file);

//		          第一个工作薄
		        $sheet = $objPHPExcel->getSheet(0);

//		          获取Excel有效行数
		        $rows = $sheet->getHighestRow();

//                Execl表结构
		        if($source == 'member')
		        {
			        $cols = ['A'=>'name','B'=>'account','C'=>'mobile','D'=>'email','E'=>'group_id','F'=>'role_id'];

			        $url = U('Member/index');
		        }
		        else
		        {
			        $cols = ['A'=>'type_name','B'=>'fast_title','C'=>'fast_content'];

			        $url = U('FastReply/index');
		        }

		        $j = 0;

//		        第一行是导入须知，第二行是表头，这里从第三行开始取读取数据，循环行数，获取数据
		        for ($i=3; $i<=$rows; ++$i)
		        {
			        $add = $member = [];

			        $add['create_time'] = NOW_TIME;

			        foreach ($cols as $k => $v)
			        {
				        $value = $sheet->getCell($k.$i)->getValue();

				        if ($value instanceof PHPExcel_RichText)
				        {
					        $value = $value->__toString();
				        }

				        $add[$v] = $value;

				        $count[$i][$v] = $value ? $value : '';

				        if($source == 'member')
				        {
					        $add['type'] = 1;

					        $add['password'] = md5('123456');

					        $add['create_ip'] = get_client_ip();

					        if($v == 'account' && $value)
					        {
						        if(!isMobile($value) && !isEmail($value))
						        {
							        $this->ajaxReturn(['error'=>0,'msg'=>L('ACCOUNT_FORMAT_ERROR',['account'=>$value]),'url'=>$url]);
						        }
						        else
						        {
							        $member = M('member')->where(['mobile|email|account'=>$value])->field('member_id,mobile,email')->find();
						        }
					        }
					        else if($v == 'mobile' && $value)
					        {
						        if(!isMobile($value))
						        {
							        $this->ajaxReturn(['error'=>0,'msg'=>L('MOBILE_FORMAT_ERROR',['mobile'=>$value]),'url'=>$url]);
						        }
						        else
						        {
							        $member = M('member')->where(['mobile|account'=>$value])->field('member_id,mobile,email')->find();
						        }
					        }
					        else if($v == 'email' && $value)
					        {
						        if(!isEmail($value))
						        {
							        $this->ajaxReturn(['error'=>0,'msg'=>L('MAIL_FORMAT_ERROR',['email'=>$value]),'url'=>$url]);
						        }
						        else
						        {
							        $member = M('member')->where(['email|account'=>$value])->field('member_id,mobile,email')->find();
						        }
					        }
					        else if($v == 'group_id' && $value)
					        {
						        $group_id = M('group')->where(['company_id'=>$company_id,'group_name'=>$value])->getField('group_id');

						        if(!$group_id)
						        {
							        $addGroup = ['company_id'=>$company_id,'group_name'=>$value,'ticket_auth'=>10,'client_ip'=>get_client_ip(),'create_time'=>NOW_TIME];

							        if($group_id = M('group')->add($addGroup))
							        {
								        saveFeelDeskEncodeId($company_id,$group_id,'Group');

								        $add['group_id'] = $group_id;
							        }
							        else
							        {
								        $this->ajaxReturn(['error'=>0,'msg'=>'部门'.$value.L('IMPORT_FAILED'),'url'=>$url]);
							        }
						        }
						        else
						        {
							        $add['group_id'] = $group_id;
						        }
					        }
					        else if($v == 'role_id' && $value)
					        {
						        $role_id = M('role')->where(['company_id'=>$company_id,'role_name'=>$value])->getField('role_id');

						        if(!$role_id)
						        {
							        $addRole = ['company_id'=>$company_id,'role_name'=>$value,'client_ip'=>get_client_ip(),'create_time'=>NOW_TIME];

							        if($role_id = M('role')->add($addRole))
							        {
								        saveFeelDeskEncodeId($company_id,$role_id,'Role');

								        $add['role_id'] = $role_id;
							        }
							        else
							        {
								        $this->ajaxReturn(['error'=>0,'msg'=>'角色'.$value.'导入失败','url'=>$url]);
							        }
						        }
						        else
						        {
							        $add['role_id'] = $role_id;
						        }
					        }
				        }
				        else//导入快捷回复
				        {
					        if($v == 'type_name' && $value)
					        {
						        $fast_type_id = M('fastreply_type')->where(["type_name"=>$value,'company_id'=>$company_id])->getField('fast_type_id');

						        if(!$fast_type_id)
						        {
							        $fast_type_id = M('fastreply_type')->add(["type_name"=>$value,'company_id'=>$company_id,'create_time'=>NOW_TIME]);
						        }

						        $add['fast_type_id'] = $fast_type_id;
					        }

					        unset($add['type_name']);
				        }

				        $add['company_id'] = $company_id;
			        }

//                    开始导入
			        if($source == 'member')
			        {
				        if($member['member_id'] > 0)
				        {
					        $save = $add;

					        $save['member_id'] = $member['member_id'];

					        $save['mobile'] = $save['mobile'] ? $save['mobile'] : $member['mobile'];

					        $save['email'] = $save['email'] ? $save['email'] : $member['email'];

					        M('member')->save($save);
				        }
				        else
				        {
					        $add['create_time'] = NOW_TIME;

					        if($add['account'])
					        {
						        $add['mobile'] = $add['mobile'] ? $add['mobile'] : '';

						        $add['email'] = $add['email'] ? $add['email'] : '';

						        if(!$member_id = M('member')->add($add))
						        {
							        $error = M('member')->getDbError();

							        return ['error'=>0,'msg'=>L('LINE_NUMBER').":".$i.",".L('IMPORT_FAILED')."，用户姓名：".$add['name'].",原因：".$error];
						        }
						        else
						        {
							        saveFeelDeskEncodeId($company_id,$member_id,'Member');
						        }
					        }
				        }

				        $j++;
			        }
			        else
			        {
				        if(!M('fastreply')->add($add))
				        {
					        $error = M('fastreply')->getDbError();

					        return ['error'=>0,'msg'=>L('LINE_NUMBER').":".$i.",".L('IMPORT_FAILED')."，回复语标题：".$add['fast_title'].",原因：".$error];
				        }
				        else
				        {
					        $j++;
				        }
			        }
		        }

		        $data = ['error'=>1,'msg'=>L('IMPORT_SUCCESS'),'url'=>$url];

		        @unlink($file);

		        D('Upload')->deleteDir(dirname($file));

		        return $data;
	        }
	        catch (PHPExcel_Reader_Exception $e)
	        {
		        return ['error'=>0,'msg'=>$e->getMessage()];
	        }
	        catch (PHPExcel_Exception $e)
	        {
		        return ['error'=>0,'msg'=>$e->getMessage()];
	        }
        }
    }
}
