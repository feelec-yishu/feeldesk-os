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

use Think\Cache\Driver\Redis;

class TicketSatisfyModel extends BasicModel
{
	protected $tableName = 'ticket_satisfy';

    protected $satisfyFields = ['satisfy_id','satisfy_score','satisfy_advise','labelId'];

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


    public function CreateSatisfy($ticket)
    {
        $data = $this->checkSatisfy($ticket);

	    if($data['status'] === 0)
	    {
		    return $data;
	    }
        else if($id = $this->where(['ticket_id'=>$ticket['ticket_id']])->getField('id'))
        {
            $result = ['status'=>0,'msg'=>L('REPEAT_EVALUATE')];
        }
        else
        {
            $satisfy_id = $this->add($data);

            if($satisfy_id > 0)
            {
                $result = ['status'=>1,'msg' => L('SUBMIT_SUCCESS'),'url' => U('detail',['id'=>encrypt($ticket['ticket_id'],'TICKET')])];
            }
            else
            {
                $result = ['status'=>0,'msg' => L('SUBMIT_FAILED')];
            }
        }

        return $result;
    }



    private function checkSatisfy($ticket=[])
    {
        $data = $this->checkFields(I('post.satisfy'), $this->satisfyFields);

	    $satisfy_label_id = '';

	    if(!$satisfy_id = M('satisfaction')->where(['company_id'=>$ticket['company_id'],'satisfy_id'=>$data['satisfy_id']])->getField('satisfy_id'))
        {
	        return ['status'=>0,'msg'=>L('SATISFACTION_NOT')];
        }

        if($data['labelId'])
        {
            foreach($data['labelId'] as $l)
            {
                $label_id = M('satisfy_label')->where(['company_id'=>$ticket['company_id'],'satisfy_id'=>$data['satisfy_id'],'label_id'=>$l])->getField('label_id');

	            if(!$label_id)
	            {
		            return ['status'=>0,'msg'=>L('LABEL_NOT')];

		            break;
	            }
            }

	        $satisfy_label_id = implode(',',$data['labelId']);
        }

	    $data = [
		    'company_id'    => $ticket['company_id'],
		    'ticket_id'     => $ticket['ticket_id'],
		    'satisfy_id'    => $satisfy_id,
		    'advise'        => $data['satisfy_advise'] ? $data['satisfy_advise'] : '',
		    'score'         => $data['satisfy_score'],
		    'member_id'     => $ticket['dispose_id'],//当前处理人ID
		    'label_id'      => $satisfy_label_id,//当前处理人ID
		    'create_time'   => NOW_TIME,
	    ];

        return $data;
    }



    /*
    * 生成满意度评价邮件
    * @param int     $company_id 公司ID
    * @param array   $publish    工单发布人
    * @param array   $ticket     工单信息
    * @param string  $mail_from  通知来源
    */
    public function createSatisfyEmail($company_id = 0,$publish = [],$ticket = [],$mail_from = 'pc')
    {
        $company = M('company')->where(['company_id'=>$company_id])->find();

        $mailSubject = str_replace(['{{ticket.title}}'],[$ticket['title']],self::$_temp['MAIL']['SATISFY_TEMP']['title']);

        $activation_key = $this->getActivationKey($publish['member_id'],$publish['email'],$company_id,$ticket['ticket_id']);

        $satisfySearch = ['{{company_logo}}','{{company_link}}','{{publish_name}}','{{ticket.title}}','{{satisfy_link}}'];

        $satisfyReplace = [
            $company['logo'] ? $company['logo'] : C('HTTP_PROTOCOL').'://'.C('HOST_DOMAIN').'/Attachs/logo/default.png',
            $company['link'] ? $company['link'] : C('HTTP_PROTOCOL')."://".C('HOST_DOMAIN'),
            $publish['name'],
            $ticket['title'],
            C('HTTP_PROTOCOL').'://'.C('HOST_DOMAIN').'/satisfy?activation_key='.$activation_key.'&email='.$publish['email']
        ];

        $mailContent = str_replace($satisfySearch,$satisfyReplace,self::$_temp['MAIL']['SATISFY_TEMP']['content']);

        $sendMailData = ['company_id'=>$company_id,'address'=>$publish['email'],'name'=>$publish['name'],'title'=>$mailSubject,'content'=>$mailContent,'mail_from'=>$mail_from,'send_time'=>NOW_TIME];

        M('send_email')->add($sendMailData);
    }


    /*
    * 获取满意度评价链接验证Key
    * @param int    $member_id  发布人ID
    * @param string $email      发布人邮箱
    * @param int    $company_id 公司ID
    * @param int    $ticket_id  工单ID
    */
    public function getActivationKey($member_id,$email,$company_id,$ticket_id)
    {
        $guid = uniqid ( "", true );

        $hash = hash('md4',$member_id.$guid.md5($email.$company_id));

        $key =  substr ($hash,0,8 ).'-'.substr($hash,8,4 ).'-'.substr($hash,12,4 ).'-'.substr ($hash,16,4 ).'-'.md5(substr( $hash,20,12));

        $redis = new Redis();

        $redis->set($email.'_'.$member_id.'_activationKey',serialize(['key'=>$key,'ticket_id'=>$ticket_id]),3600 * 24 * 3);

        return $key;
    }
}
