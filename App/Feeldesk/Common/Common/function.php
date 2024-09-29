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

header("content-type:text/html;charset=utf-8");

function checkClientAgentIsMobile()
{
	$user_agent = $_SERVER['HTTP_USER_AGENT'];

	$mobile_agents = ["240x320","acer","acoon","acs-","abacho","ahong","airness","alcatel","amoi","android","anywhereyougo.com","applewebkit/525","applewebkit/532","asus",
		"audio","au-mic","avantogo","becker","benq","bilbo","bird","blackberry","blazer","bleu","cdm-","compal","coolpad","danger","dbtel","dopod","elaine","eric","etouch",
		"fly ","fly_","fly-","go.web","goodaccess","gradiente","grundig","haier","hedy","hitachi","htc","huawei","hutchison","inno","ipad","ipaq","ipod","jbrowser",
		"kddi","kgt","kwc","lenovo","lg ","lg2","lg3","lg4","lg5","lg7","lg8","lg9","lg-","lge-","lge9","longcos","maemo","mercator","meridian","micromax","midp","mini",
		"mitsu","mmm","mmp","mobi","mot-","moto","nec-","netfront","newgen","nexian","nf-browser","nintendo","nitro","nokia","nook","novarra","obigo","palm","panasonic",
		"pantech","philips","phone","pg-","playstation","pocket","pt-","qc-","qtek","rover","sagem","sama","samu","sanyo","samsung","sch-","scooter","sec-","sendo",
		"sgh-","sharp","siemens","sie-","softbank","sony","spice","sprint","spv","symbian","tablet","talkabout","tcl-","teleca","telit","tianyu","tim-","toshiba","tsm",
		"up.browser","utec","utstar","verykool","virgin","vk-","voda","voxtel","vx","wap","wellco","wig browser","wii","windows ce","wireless","xda","xde","zte"];

	$is_mobile = false;

	//这里把值遍历一遍，用于查找是否有上述字符串出现过
	foreach ($mobile_agents as $device)
	{
		// stristr 查找访客端信息是否在上述数组中，不存在即为PC端。
		if(stristr($user_agent, $device))
		{
			$is_mobile = true;

			break;
		}
	}

	return $is_mobile;
}


function _get($name)
{
	$val = !empty($_GET[$name]) ? $_GET[$name] : null;

	return $val;
}


function getParentIds($data,$pk,$id,$level = 1)
{
	$function = __FUNCTION__;

	static $parentIds = [];

	foreach($data as $k => $v)
	{
		if ($v[$pk] == $id)
		{
			$v['level'] = $level;

			if($v['parent_id'] > 0)
			{
				$parentIds[] = $v['parent_id'];
			}

			unset($data[$k]);

			$function($data,$pk,$v['parent_id'],$level+1);
		}
	}

	sort($parentIds);

	return $parentIds;
}


function signature($param,$secret)
{
	ksort($param);

	$sign = '';

	foreach($param as $k=>$p)
	{
		$sign .= $k.'='.$p.'&';
	}

	$sign = rtrim($sign,'&');

	$str = mb_convert_encoding($sign,'UTF-8');

	if (function_exists('hash_hmac'))
	{
		$sign = base64_encode(hash_hmac("sha1", $str, $secret, true));
	}

	return $sign;
}


function getSubjectTree($list =[], $pk='menu_id',$pid = 'parent_id',$child = 'childMenu',$star=0)
{
	// 创建Tree
	$tree = array();

	if(is_array($list))
	{
		// 创建基于主键的数组引用
		$menu = array();

		foreach ($list as $k => $v)
		{
			$menu[$v[$pk]] = &$list[$k];
		}

		foreach ($list as $k => $v)
		{
			// 判断是否存在parent
			$parentId = $v[$pid];

			if ($star == $parentId)
			{
				$tree[] = &$list[$k];
			}
			else
			{
				if (isset($menu[$parentId]))
				{
					$parent = &$menu[$parentId];

					$parent[$child][] = &$list[$k];
				}
			}
		}
	}

	return $tree;
}


function fetchAll($data,$field)
{
    $datas = [];

    foreach($data as $v)
    {
        $datas[$v[$field]] = $v;
    }

    return $datas;
}


// 储存UUID
function saveFeelDeskEncodeId($company_id = 0,$id = 0,$source = '')
{
	$chars = 'F'.sha1(md5(uniqid(md5(microtime(true)).$source.$id.$company_id,true)).rand(0,9));

	$uuid  = substr($chars,0,8);

	$uuid .= substr($chars,8,4);

	$uuid .= substr($chars,12,4);

	$uuid .= substr($chars,16,4);

	$uuid .= substr($chars,20,12);

	$table = [
		'Member'         => ['member','member_id','employee_id'],
		'Group'          => ['group','group_id','department_id'],
		'Role'           => ['role','role_id','part_id']
	];

	M($table[$source][0])->where([$table[$source][1]=>$id])->setField([$table[$source][2]=>$uuid]);

	return $uuid;
}


function FeelDeskCurl($url,$method = 'GET',$params = '')
{
    $curl = curl_init(); // 启动一个CURL会话

    curl_setopt($curl, CURLOPT_URL, $url); // 要访问的地址

    curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, 0); // 对认证证书来源的检查

    curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 1); // 从证书中检查SSL加密算法是否存在

    curl_setopt($curl, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']); // 模拟用户使用的浏览器

    curl_setopt($curl, CURLOPT_FOLLOWLOCATION, 1); // 使用自动跳转

    curl_setopt($curl, CURLOPT_AUTOREFERER, 1); // 自动设置Referer

    curl_setopt($curl, CURLOPT_REFERER, $_SERVER['REQUEST_SCHEME'].'://'.$_SERVER['HTTP_HOST']); // 设置Referer

	curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, FALSE);

	curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, FALSE);

    if($method == 'GET')
    {
        curl_setopt($curl, CURLOPT_HTTPGET, 1); // 发送一个常规的GET请求
    }
    else
    {
        curl_setopt($curl, CURLOPT_CUSTOMREQUEST, "POST");//HTTP 请求时，使用自定义的 Method 来代替"GET"或"HEAD"。对 "DELETE" 或者其他更隐蔽的 HTTP 请求有用。 有效值如 "GET"，"POST"，"CONNECT"等等；

        //设置提交的信息
        curl_setopt($curl, CURLOPT_POSTFIELDS,$params);//全部数据使用HTTP协议中的 "POST" 操作来发送。
    }

    curl_setopt($curl, CURLOPT_TIMEOUT, 30); // 设置超时限制防止死循环

    curl_setopt($curl, CURLOPT_HEADER, 0); // 显示返回的Header区域内容

    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1); // 获取的信息以文件流的形式返回

    $result = curl_exec($curl); // 执行操作

	$result = json_decode($result, true);

	$result['http_code'] = curl_getinfo($curl,CURLINFO_HTTP_CODE);//最后一个收到的HTTP代码

	$result['last_url'] = curl_getinfo($curl,CURLINFO_EFFECTIVE_URL);//最后一个有效的URL地址

	$error = curl_error($curl);

	if ($error != '')
	{
		$result['curl']['code'] = curl_errno($curl);

		$result['curl']['msg'] = $error;
	}
	else
	{
		$result['errcode'] = 0;

		$result['msg'] = 'ok';
	}

	curl_close($curl); // 关闭CURL会话

    return $result;
}


function getTreeChild($data,$id)
{
    foreach($data as $v)
    {
        if($v['parent_id'] == $id)
        {
            return true;
        }
    }
}


// 判断奇偶数
function judgeParity($num)
{
    return ($num%2) ? 1 : 2;
}


function curl($url)
{
    $curl = curl_init();

    //设置抓取的url
    curl_setopt($curl, CURLOPT_URL, $url);

    //设置头文件的信息作为数据流输出
    curl_setopt($curl, CURLOPT_HEADER, 1);

    //设置获取的信息以文件流的形式返回，而不是直接输出。
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);

    //执行命令
    $data = curl_exec($curl);

    //关闭URL请求
    curl_close($curl);

    return $data;
}


/**
 * 判断用户是否在线
 * @param int $last_active_time 最后活动时间
 * @return string
 */
function checkUserLoginStatus($last_active_time)
{
//    有效时间
    $effective = time() - 5*60;

    if($last_active_time > $effective)
    {
        return true;
    }

    return false;
}


function encrypt($tex, $key = 'yzpencode', $expire = 0)
{
    $chrArr = array('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z','A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z','0', '1', '2', '3', '4', '5', '6', '7', '8', '9');

    $tex.="~#~" . sprintf('%010d', $expire ? $expire + time() : 0) . "~#~";

    $key_b = $chrArr[rand() % 62] . $chrArr[rand() % 62] . $chrArr[rand() % 62] . $chrArr[rand() % 62] . $chrArr[rand() % 62] . $chrArr[rand() % 62];

    $rand_key = $key_b . $key;

    $rand_key = md5($rand_key);

    $texlen = strlen($tex);

    $reslutstr = "";

    for ($i = 0; $i < $texlen; $i++)
    {
        $reslutstr.=$tex{$i} ^ $rand_key{$i % 32};
    }

    $reslutstr = trim($key_b . base64_encode($reslutstr), "==");

    $reslutstr = substr(md5($reslutstr), 0, 8) . $reslutstr;

    return $reslutstr;
}


function decrypt($tex, $key = 'yzpencode') {
    if (strlen($tex) < 14)
        return false;
    $verity_str = substr($tex, 0, 8);
    $tex = substr($tex, 8);
    if ($verity_str != substr(md5($tex), 0, 8)) {
        //完整性验证失败
        return false;
    }
    $key_b = substr($tex, 0, 6);
    $rand_key = $key_b . $key;
    $rand_key = md5($rand_key);
    $tex = base64_decode(substr($tex, 6));
    $texlen = strlen($tex);
    $reslutstr = "";
    for ($i = 0; $i < $texlen; $i++) {
        $reslutstr.=$tex{$i} ^ $rand_key{$i % 32};
    }
    $expiry_arr = array();
    preg_match('/^(.*)~#~(\d{10})~#~$/', $reslutstr, $expiry_arr);
    if (count($expiry_arr) != 3) {
        //过期时间完整性验证失败
        return false;
    } else {
        $tex_time = $expiry_arr[2];
        if ($tex_time > 0 && $tex_time - time() <= 0) {
            //验证码过期
            return false;
        } else {
            $reslutstr = $expiry_arr[1];
        }
    }
    return $reslutstr;
}


/*
* 根据组件时间检测工单是否超时,计算超时时间
* @param int   $dead_time      工单完成期限
* @param int   $end_time       工单完成时间
* @param int   $count          是否计算超时时间
* @return string
*/
function checkTicketIsTimeout($dead_time = 0,$end_time = 0,$count = false)
{
//    如果当前时间 > 完成期限并且工单未完成那么工单已超时
    if($dead_time > 0 && time() > $dead_time && $end_time == 0)
    {
        if($count)
        {
            $timeout = getTakingTime(time(),$dead_time);

            $timeStr = '';

            if($timeout['day'] > 0) $timeStr .= $timeout['day'].L('DAYS');

            if($timeout['hour'] > 0) $timeStr .= $timeout['hour'].L('HOURS');

            if($timeout['min'] > 0) $timeStr .= $timeout['min'].L('MINUTES');

            return "<span class='orange4'>{$timeStr}</span>";
        }

        return "<span class='red'>".L('YES')."</span>";
    }
    else if($dead_time > 0 && $end_time > $dead_time)//完成时间 > 完成期限 那么 工单已超时
    {
        if($count)
        {
            $timeout = getTakingTime($end_time,$dead_time);

            $timeStr = '';

            if($timeout['day'] > 0) $timeStr .= $timeout['day'].L('DAYS');

            if($timeout['hour'] > 0) $timeStr .= $timeout['hour'].L('HOURS');

            if($timeout['min'] > 0) $timeStr .= $timeout['min'].L('MINUTES');

            return "<span class='orange4'>{$timeStr}</span>";
        }

        return "<span class='red'>".L('YES')."</span>";
    }
    else
    {
        if($count == 1) return 0;

        return L('NO');
    }
}


function checkTicketIsTimeoutByCron($dead_time = 0,$end_time = 0)
{
//    如果完成期限已设置 并且 当前时间 > 完成期限并且工单未完成 或者 完成时间 > 完成期限 那么工单已超时
    if($dead_time > 0 && ((time() > $dead_time && $end_time == 0) || $end_time > $dead_time))
    {
        return true;
    }
    else
    {
        return false;
    }
}


/*
* 检测工单是否超时,计算超时时间
* @param int   $ticket_id      工单ID
* @param int   $create_time    工单创建时间
* @param int   $end_time       工单完成时间
* @param int   $count          是否计算超时时间
* @param int   $company_id     公司ID，适用于API
* @return string
*/
function checkIsTimeout($ticket_id,$create_time = 0,$end_time = 0,$count = 0,$company_id = 0)
{
//	获取工单停止时长
	$stopTiming = M('stop_timing')->where(['ticket_id'=>$ticket_id])->select();

	$stop_timing_sec = $start_time = 0;

	foreach($stopTiming as $st)
	{
		$close_time = $st['close_time'] ? $st['close_time'] : NOW_TIME;

		$stop_timing_sec += $close_time - $st['start_time'];
	}

	$company_id = $company_id ? $company_id : session('company_id');

    $overtime = M('ticket_config')->where(['company_id'=>$company_id])->getField('overtime');

//    超时上限
	$timeUpper = intval($create_time + $overtime * 3600);

	$time = $end_time > 0 ? $end_time : NOW_TIME;

//    计算超时秒数
	$timeout_sec = $time - $timeUpper - $stop_timing_sec;

	if($timeout_sec <= 0)
	{
		if($count == 1)
		{
			return 0;
		}
		else
		{
			return L('NO');
		}
	}
	else
	{
		if($count)
		{
			$timeout = getTakingTimeBySec($timeout_sec);

			$timeStr = '';

			if($timeout['day'] > 0) $timeStr .= $timeout['day'].L('DAYS').' ';

			if($timeout['hour'] > 0) $timeStr .= $timeout['hour'].L('HOURS').' ';

			if($timeout['min'] > 0) $timeStr .= $timeout['min'].L('MINUTES');

			return "<span class='orange4'>{$timeStr}</span>";
		}
		else
		{

			return "<span class='red'>".L('YES')."</span>";
		}
	}
}


/*
* 检测工单是否超时,计算超时时间
* @param int   $ticket_id      工单ID
* @param int   $create_time    工单创建时间
* @param int   $end_time       工单完成时间
* @param int   $source         是否计算超时时间
* @param int   $company_id     公司ID，适用于超时通知
* @return string
*/
function checkTicketIsTimeoutByGlobal($ticket_id = 0,$create_time = 0,$end_time = 0,$company_id = 0)
{
	//	获取工单停止时长
	$stopTiming = M('stop_timing')->where(['ticket_id'=>$ticket_id])->select();

	$stop_timing_sec = 0;

	foreach($stopTiming as $st)
	{
		$close_time = $st['close_time'] ? $st['close_time'] : NOW_TIME;

		$stop_timing_sec += $close_time - $st['start_time'];
	}

    $company_id = $company_id > 0 ? $company_id : session('company_id');

    $overtime = M('ticket_config')->where(['company_id'=>$company_id])->getField('overtime');

//    超时上限
    $timeUpper = intval($create_time + $overtime * 3600);

    $time = $end_time > 0 ? $end_time : NOW_TIME;

//    计算超时秒数
	$timeout_sec = $time - $timeUpper - $stop_timing_sec;

//    如果已完成用完成时间计算，未完成用当前时间计算
    if($timeout_sec > 0)
    {
        return true;
    }
    else
    {
        return false;
    }
}


//转换文件单位
function getFileSize($bit)
{
    $type = ['B','KB','M','G','T'];

    for($i = 0; $bit >= 1024; $i++)//单位每增大1024，则单位数组向后移动一位表示相应的单位
    {
        $bit/=1024;
    }

    return (floor($bit*100)/100).$type[$i];//floor是取整函数，为了防止出现一串的小数，这里取了两位小数
}


//检查语言版本权限
function checkLangAuth()
{
    $lang = cookie('think_language');

    $langAuth = M('company')->where(["company_id"=>session('company_id')])->field('en_auth,jp_auth')->find();

    if(($lang == 'en-us' && $langAuth['en_auth'] != 10) || ($lang== 'ja-jp' && $langAuth['jp_auth'] != 10))
    {
        cookie('think_language','zh-cn',3600*24*365);

        return false;
    }
    else
    {
        return strtolower($lang);
    }
}


/**
* 获取真实IP
* @return string 访客IP
*/
function Getip()
{
	if(!empty($_SERVER["HTTP_CLIENT_IP"]))
	{
		$ip = $_SERVER["HTTP_CLIENT_IP"];
	}

	// 获取代理ip
	if(! empty($_SERVER['HTTP_X_FORWARDED_FOR']))
	{
		$ips = explode(',', $_SERVER['HTTP_X_FORWARDED_FOR']);
	}

	if($ip)
	{
		$ips = array_unshift($ips, $ip);
	}

	$count = count($ips);

	for($i = 0; $i < $count; $i ++)
	{
		// 排除局域网ip
		if(! preg_match("/^(10|172\.16|192\.168)\./i", $ips[$i]))
		{
			$ip = $ips[$i];

			break;
		}
	}

	$tip = empty($_SERVER['REMOTE_ADDR']) ? $ip : $_SERVER['REMOTE_ADDR'];

	return $tip;
}


/**
* 获取七牛图片名称
* @param string		原图路径
* @return string	图片名称
*/
function getImageName($url,$image)
{
//	针对本地空间
	if(strpos($image,'Attach'))
	{
		$url = C('HTTP_PROTOCOL').'://'.C('HOST_DOMAIN');
	}

	$imageName = str_replace($url,'',$image);

	return $imageName;
}


/**
 * 获取高亮
 * @param string $str	需要高亮的字符串
 * @param string $text	原字符串
 * @return string
 */
function getHighLight($str,$text)
{
	return str_replace($str,"<span style='color: #138df5'>".$str."</span>",$text);
}


/**
 * 获取数组长度
 * @param string $array 需要计算的数组
 * @return string
 */
function getCount($array = array())
{
	return count($array);
}


/**
 * 转换实体
 * @param string $html 需要转换的html字符串
 * @return string
 */
function getHtml($html)
{
	return html_entity_decode($html);
}


/**
 * 格式化输出数组
 * @param array $array 需要格式化的数组
 * @return array
 */
function getPrint($array)
{
	echo '<pre>';print_r($array);echo '</pre>';
}


/**
 * 判断输入的字符串是否是一个合法的字段名（以小写字母开头，只能包含字母或字母加下划线）
 * @param string $string 需要验证的字段名
 * @return boolean
 */
function isFormField($string)
{
    if(preg_match('/^[a-z]([a-z]|_[a-z])*$/', $string))
	{
		return true;
	}

    return false;
}


/**
* 判断输入的字符串是否是一个合法的手机号(仅限中国大陆)
* @param string $string
* @return boolean
*/
function isMobile($string)
{
    if (preg_match('/^[1]+[3,4,5,6,7,8,9]+\d{9}$/', $string))
	{
		 return true;
	}

    return false;
}


function isInternationalMobile($string)
{
    if(preg_match('/^(\\+\\d{2})(\d{9})$/', $string) || preg_match('/^(\d{7,11})$/', $string))
    {
        return true;
    }

    return false;
}


/**
 * 判断一个字符串是否是一个Email地址
 * @param string $string
 * @return boolean
 */
function isEmail($string)
{
    return (boolean) preg_match('/([a-z0-9]*[-_.]?[a-z0-9]+)*@([a-z0-9]*[-_]?[a-z0-9]+)+[.][a-z]{2,3}([.][a-z]{2})?/i', $string);
}


/**
 * 判断密码格式是否合法（6-16位，仅允许数字、下划线、字母的组合）
 * @param string $string
 * @return boolean
 */
function isPassword($string)
{
    return (boolean) preg_match('/^[_0-9a-z]{6,16}$/i',$string);
}


/**
 * 检查是否为一个合法的时间格式
 * @access public
 * @param string  $time
 * @return void
 */
function isTime($time)
{
    $pattern = '/[\d]{4}-[\d]{1,2}-[\d]{1,2}\s[\d]{1,2}:[\d]{1,2}:[\d]{1,2}/';

    return preg_match($pattern, $time);
}


/**
 * 字符串截取，支持中文和其他编码
 * @static
 * @access public
 * @param string $str 需要转换的字符串
 * @param string $start 开始位置
 * @param string $length 截取长度
 * @param string $charset 编码格式
 * @param string $suffix 截断显示字符
 * @return string
 */
function msubstr($str, $start = 0, $length, $charset = "utf-8", $suffix = false)
{
    if (function_exists("mb_substr"))
	{
		$slice = mb_substr($str, $start, $length, $charset);
	}
    else if (function_exists('iconv_substr'))
	{
        $slice = iconv_substr($str, $start, $length, $charset);

        if (false === $slice)
		{
            $slice = '';
        }
    }
	else
	{
        $re['utf-8'] = "/[\x01-\x7f]|[\xc2-\xdf][\x80-\xbf]|[\xe0-\xef][\x80-\xbf]{2}|[\xf0-\xff][\x80-\xbf]{3}/";

        $re['gb2312'] = "/[\x01-\x7f]|[\xb0-\xf7][\xa0-\xfe]/";

        $re['gbk'] = "/[\x01-\x7f]|[\x81-\xfe][\x40-\xfe]/";

        $re['big5'] = "/[\x01-\x7f]|[\x81-\xfe]([\x40-\x7e]|\xa1-\xfe])/";

        preg_match_all($re[$charset], $str, $match);

        $slice = join("", array_slice($match[0], $start, $length));
    }

    return $suffix ? $slice . '...' : $slice;
}


//时间格式化
function formatTime($time)
{
    $rtime = date("m-d H:i", $time);

    $htime = date("H:i", $time);

    $time = time() - $time;

    if ($time < 60)
    {
        $str = '刚刚';
    }
    elseif ($time < 60 * 60)
    {
        $min = floor($time / 60);

        $str = $min . '分钟前';
    }
    elseif ($time < 60 * 60 * 24)
    {
        $h = floor($time / (60 * 60));

        $str = $h . '小时前 ';
    }
    elseif ($time < 60 * 60 * 24 * 3)
    {
        $d = floor($time / (60 * 60 * 24));

        if ($d == 1)
        {
            $str = '昨天 ' . date("H:i", $time);
        }
        else
        {
            $str = '前天 ' . date("H:i", $time);
        }
    }
    else
    {
        $str = $rtime;
    }

    return $str;
}

//时间格式化
function format($time)
{
    $t = NOW_TIME - $time;

    $mon = (int) ($t / (86400 * 30));

    if ($mon >= 1) {return '一个月前';}

    $day = (int) ($t / 86400);

    if ($day >= 1) {return $day . '天前';}

    $h = (int) ($t / 3600);

    if ($h >= 1) {return $h . '小时前';}

    $min = (int) ($t / 60);

    if ($min >= 1){return $min . '分前';}

    return '刚刚';
}


function getDates($time,$type = 1)
{
	if($time > 0)
	{
		if($type == 0)
		{
			return date('Y-m-d H:i:s',$time);
		}
		else if($type == 1)
		{
            return date('Y-m-d H:i',$time);
        }
        else if($type == 2)
        {
            return date('Y-m-d',$time);
        }
        else if($type == 3)
        {
            return date('Y-m-d H:00',$time);
        }
        else if($type == 4)
        {
            return date('H:i',$time);
        }
        else if($type == 5)
        {
            return date('Y-m-d 00:00',$time);
        }
        else if($type == 6)
        {
	        return date('Y-m-d H:i',$time);
        }
	}
	else
	{
		return "<span class='iconfont icon-nothing'></span>";
	}
}


/**
 * 无限级分类菜单
 * @param array     $list	要转换的数据集
 * @param string    $pk	主键
 * @param string    $pid	父标记字段
 * @param string    $child	子标记字段
 * @param int       $star	star标记字段
 * @param array     $checkedMenuIds 已有菜单ID，用于默认选中
 * @return array
 */
function getMenuTree($list =[], $pk='menu_id',$pid = 'parent_id',$child = 'childMenu',$star=0,$checkedMenuIds=[])
{
    // 创建Tree
    $tree = array();

    if(is_array($list))
	{
        // 创建基于主键的数组引用
        $menu = array();

        foreach ($list as $k => &$v)
		{
			if(in_array($v[$pk],$checkedMenuIds))
			{
				$v['checked'] = 'checked';
			}

            $menu[$v[$pk]] = &$list[$k];
        }

        foreach ($list as $k => &$v)
		{
            // 判断是否存在parent
            $parentId = $v[$pid];

            if ($star == $parentId)
			{
				if($checkedMenuIds)
				{
					$tree[] = &$list[$k];
				}
				else
				{
					$tree[$list[$k][$pk]] = &$list[$k];
				}
            }
			else
			{
                if (isset($menu[$parentId]))
				{
                    $parent = &$menu[$parentId];

					if($checkedMenuIds)
					{
						$parent[$child][] = &$list[$k];
					}
					else
					{
						$parent[$child][$list[$k][$pk]] = &$list[$k];
					}
                }
            }
        }
    }

    return $tree;
}


/**
 * 菜单权限的URL校验
 * @param string $action URL表达式，格式：'[分组/模块/操作#锚点@域名]?参数1=值1&参数2=值2...'
 * @param array  $params 参数 数组形式
 * @param string $title  标题
 * @param string $style  A标签样式
 * @param string $load   是否异步加载
 * @return string
 */
function FEELDESK($action='',$params=[],$title='',$style='',$load='',$iconstyle='')
{
    $user = session('index');

    $class = $icon = '';

    $hasAuth = D('RoleAuth')->checkRoleAuthByMenu($user['company_id'],$action,$user['role_id']);

    if($user['is_first'] == 1)
    {
        if(!$hasAuth)
        {
            $action = 'javascript:';

            $title = L('UNAUTHORIZED');

            $class = ' style=display:none';
        }
        else if(!$action)
        {
            $action = 'javascript:';
        }
        else
        {
            if($style) $class = ' class="'.$style.'"';

            $action = U($action, $params);
        }
    }
    else
    {
        if($style) $class = ' class="'.$style.'"';

        if(!$action)
        {
            $action = 'javascript:;';
        }
        else
        {
            $action = U($action, $params);
        }
    }

    if($iconstyle) $icon = "class='{$iconstyle}'";

    if($load)
    {
	    $load = ' load="'.$load.'"';
    }
    else
    {
	    $load = ' load=loading';
    }

    if(strpos($action,'Member/') !== false ||strpos($action,'member/') !== false ||strpos($action,'Weixin/') !== false || strpos($action,'weixin/') !== false)
    {
        $action = '/Index'.$action;
    }

    $a_tag = '<a href="'.$action.'"'.$class.$load.' ><i '.$icon.'></i>'.$title.'</a>';

    return $a_tag;
}


/**
 * 时间差计算
 * @param string $begin_time 开始时间
 * @param string $end_time  结束时间
 * @return array
 */
function getTakingTime($begin_time,$end_time)
{
	if($begin_time < $end_time)
	{
		$starttime = $begin_time;

		$endtime = $end_time;
	}
	else
	{
		$starttime = $end_time;

		$endtime = $begin_time;
	}

	//计算天数
	$timediff = $endtime-$starttime;

	$days = intval($timediff/86400);

	$days = $days ? sprintf("%02d", $days) : 0;

	//计算小时数
	$remain = $timediff%86400;

	$hours = intval($remain/3600);

	$hours = $hours ? sprintf("%02d", $hours) : 0;

	//计算分钟数
	$remain = $remain%3600;

	$mins = intval($remain/60);

	$mins = $mins ? sprintf("%02d", $mins) : 0;

	//计算秒数
	$secs = $remain%60;

	$secs = sprintf("%02d", $secs);

	$res = ["day" => $days,"hour" => $hours,"min" => $mins,"sec" => $secs];

	return $res;
}


function getTakingTimeBySec($time)
{
	if(is_numeric($time))
	{
		$value = ['day'=>0,"hour" => 0, "min" => 0];

		if($time >= 86400)
		{
			$value["day"] = floor($time/86400);

			$time = ($time%86400);
		}

		if($time >= 3600)
		{
			$value["hour"] = floor($time/3600);

			$time = ($time%3600);
		}

		if($time >= 60)
		{
			$value["min"] = floor($time/60);

			$time = ($time%60);
		}

		if(floor($time) > 0)
		{
			$value["min"] += 1;
		}

		return $value;
	}
	else
	{
		return 0;
	}
}


/**
 * 去除文件后缀
 * @param string $filename 完整文件名
 * @return string
 */
function getFileName($filename)
{
    // $name = explode('.',$filename);

    return substr($filename,0,strrpos($filename, '.'));
}


//移除非法字段
function checkFields($data = array(), $fields = array())
{
    foreach ($data as $k => $val )
    {
        if (!in_array($k, $fields))
        {
            unset($data[$k]);
        }
    }

    return $data;
}


function getLanguage($company = [])
{
	$language = M('language')->select();

	if($company)
	{
		foreach($language as $k=>$v)
		{
			if($v['lang'] == 'en-us' && $company['en_auth'] != 10) unset($language[$k]);

			if($v['lang'] == 'ja-jp' && $company['jp_auth'] != 10) unset($language[$k]);
		}
	}

	return $language;
}

