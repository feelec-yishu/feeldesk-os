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

use Think\Cache\Driver\Redis;

use Think\Controller;

class SatisfyController extends Controller
{
    protected $satisfyField = ['verify_code','ticket_satisfy','ticket_advise'];

    protected $publish = [];

    protected $ticket_id = 0;

    protected $activationKey;

    protected $email;


    public function _initialize()
    {
        $email = isset($_GET['email']) ? I('get.email') : '';

        $activationKey = isset($_GET['activation_key']) ? I('get.activation_key') : '';

        if(!$email || !isEmail($email))
        {
            $this->_empty();die;
        }
        else
        {
            $this->activationKey = $activationKey;

            $this->email = $email;

            $publish = M('member')->where(['email'=>$email])->field('member_id,company_id')->find();

            $redis = new Redis();

            $activation = unserialize($redis->get($email.'_'.$publish['member_id'].'_activationKey'));

            if($activationKey !== $activation['key'])
            {
                $this->_empty();die;
            }

            $this->ticket_id = $activation['ticket_id'];

            $this->publish = $publish;

            $this->assign('email',$email);

            $this->assign('activation_key',$activationKey);
        }
    }



	public function index()
	{
		$lang_name = D('Satisfaction')->getNameByLang('satisfy_name');

		$satisfaction = M('satisfaction')->alias('a')
			->join('feel_satisfy_label as b on a.satisfy_id = b.satisfy_id')
			->where(['a.company_id'=>$this->publish['company_id'],'b.company_id'=>$this->publish['company_id']])
			->field('a.satisfy_id,label_id,score,label_name,'.$lang_name)
			->order('score asc')
			->select();

		$satisfyData = [];

		foreach($satisfaction as $sk => $s)
		{
			$satisfyData['satisfy'][$s['satisfy_id']]['satisfy_id'] = $s['satisfy_id'];

			$satisfyData['satisfy'][$s['satisfy_id']]['lang_name'] = $s['lang_name'];

			$satisfyData['satisfy'][$s['satisfy_id']]['score'] = $s['score'];

			$satisfyData['labels'][$s['satisfy_id']][] = $s;
		}

		$satisfyData['satisfy'] = array_values($satisfyData['satisfy']);

		$this->assign('satisfyData',json_encode($satisfyData));

        $this->display();
	}



	public function create()
    {
        if(IS_AJAX)
        {
            $data = $this->checkCreate();

	        if($data['status'] == 1)
	        {
		        $data['url'] = U('satisfy_success')."?activation_key={$this->activationKey}&email={$this->email}";
	        }

            $this->ajaxReturn($data);
        }
        else
        {
            $this->_empty();
        }
    }


    public function satisfy_success()
    {
        $this->display();
    }



    public function satisfy_repeat()
    {
        $this->display();
    }



    private function checkCreate()
    {
        $data = I('post.satisfy',[]);

        if(empty($data['verify_code']))
        {
	        $data = ['status'=>0,'msg'=>L('ENTER_IMAGE_CODE')];
        }
        else if(!PublicController::check_verify($data['verify_code'],7))
        {
	        $data = ['status'=>0,'msg'=>L('CODE_ERROR')];
        }
	    else
	    {
		    $ticket = M('Ticket')->where(['ticket_id'=>$this->ticket_id])->field('company_id,ticket_id,dispose_id')->find();

		    $data = D('TicketSatisfy')->CreateSatisfy($ticket);
	    }

        return $data;
    }



	public function _empty()
    {
        header("HTTP/1.0 404 Not Found");//使HTTP返回404状态码

        $this->display("Public:404");
    }
}
