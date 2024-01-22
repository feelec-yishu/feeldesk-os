<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2012 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------
namespace Behavior;
use Think\Lang;
/**
 * 语言检测 并自动加载语言包
 */
class CheckLangBehavior
{
	// 行为扩展的执行入口必须是run
	public function run(&$params)
	{
		// 检测语言
		$this->checkLanguage();

	}

	/**
	 * 语言检查
	 * 检查浏览器支持语言，并自动加载语言包
	 * @access private
	 * @return void
	 */
	private function checkLanguage()
	{
		// 不开启语言包功能，仅仅加载框架语言文件直接返回
		if (!C('LANG_SWITCH_ON', null, false))
		{
			return;
		}

		$langSet = 'zh-cn';

		cookie('think_language', $langSet, 3600 * 24 * 365);
		// 定义当前语言
		define('LANG_SET', strtolower($langSet));
		// 读取语言设置
//	    if(APP_MODE != 'cli' && md5(self::get_language_key()) != 'd475d24a4a84fc14a77194a8807e8304') $this->lang_set();
		// 读取框架语言包
		$file = THINK_PATH . 'Lang/' . LANG_SET . '.php';
		if (LANG_SET != C('DEFAULT_LANG') && is_file($file)) L(include $file);
		// 读取应用公共语言包
		$file = LANG_PATH . LANG_SET . '.php';
		if (is_file($file)) L(include $file);
		// 读取模块语言包
		$file = MODULE_PATH . 'Lang/' . LANG_SET . '.php';
		if (is_file($file)) L(include $file);
		// 读取当前控制器语言包
		$file = MODULE_PATH . 'Lang/' . LANG_SET . '/' . strtolower(CONTROLLER_NAME) . '.php';
		if (is_file($file)) L(include $file);
	}
}
