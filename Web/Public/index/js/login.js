/*
* 软件为成都菲莱克斯科技有限公司出品，未经授权许可不得使用！
* 作者：Yishu
* 官网：www.feeldesk.cn
* 邮件: 1017242700@qq.com
*/
var slideVerify;

$(function ()
{
	layui.use('form',function ()
	{
		var form = layui.form;
	});

	$("#login-form").find('input').keydown(function(e)
	{
		if(e.keyCode === 13) login();
	});

	$(".language").hover(function()
	{
		$('.lang-panel').show();
	},
	function()
	{
		$('.lang-panel').hide();
	});

	$('#reg-submit').on('click',function ()
	{
		var loading = layer.load(2,{offset:'15vw'});

		var verify = slideVerify.slideFinishState;

		if(false === verify)
		{
			feelDeskAlert(language.SLIDE_VERIFY);

			layer.close(loading);

			return false;
		}

		$.post('/u-reg-submit',$('#reg-form').serialize(),function (result)
		{
			if(result.status !== 2)
			{
				feelDeskAlert(result.msg);
			}
			else
			{
				result.url = '/u-login';

				feelDeskAlert(result.msg,result);
			}

			layer.close(loading);
		});
	});

	$('#reset-submit').on('click',function ()
	{
		var loading = layer.load(2,{offset:'15vw'});

		var verify = slideVerify.slideFinishState;

		if(false === verify)
		{
			feelDeskAlert(language.SLIDE_VERIFY);

			layer.close(loading);

			return false;
		}

		$.post('/u-reset-submit',$('#reset-form').serialize(),function (result)
		{
			if(result.status !== 2)
			{
				feelDeskAlert(result.msg);

				layer.close(loading);
			}
			else
			{
				window.location.href = result.url;
			}
		});
	});
});

var loadSlideVerify = function ()
{
	slideVerify = new window.slideVerifyPlug('#slide-verify',
	{
		wrapWidth:'100%',
		initText:language.SLIDE_VERIFY,
		sucessText:language.VERIFY_PASS
	});
}

var login = function ()
{
	var loading;

	if(window.isclient !== 'true')
	{
		var verify = slideVerify.slideFinishState;

		if(false === verify)
		{
			layer.tips(language.SLIDE_VERIFY,'#slide-verify',{tips:3,time: 5000, skin:'login-tips'});

			return false;
		}

		loading = layer.load(2,{offset:'15vw'});

		$.post("/u-log-in",$('#login-form').serialize(),function(data)
		{
			if(data.status !== 2)
			{
				layer.close(loading);

				layer.tips(data.msg,'#'+data.id,{tips:3,time: 2000, skin:'login-tips'});

				slideVerify.resetVerify();
			}
			else
			{
				window.location.reload();
			}
		},'JSON');
	}
	else
	{
		loading = layer.load(2,{offset:'60vw'});

		$.post("/u-log-in",$('#client-login-form').serialize(),function(data)
		{
			if(data.status !== 2)
			{
				layer.close(loading);

				layer.tips(data.msg,'#'+data.id,{tips:3,time: 2000000, skin:'client-login-tips'});
			}
			else
			{
				if($('#client-remember').is(':checked') === true)
				{
					var name = $('#client-username').val();

					var pass = $('#client-password').val();

					chatcloud.saveAccount('Feelec-'+name,'name',name);

					chatcloud.saveAccount('Feelec-'+name,'pass',pass);
				}

				window.location.href='/u-home?pc=ide';
			}
		},'JSON');
	}


};

var getVerifyCode = function (source)
{
	var loading = layer.load(2,{offset:'15vw'});

	var verify = slideVerify.slideFinishState;

	if(false === verify)
	{
		feelDeskAlert(language.SLIDE_VERIFY);

		layer.close(loading);

		return false;
	}

	var param = {username:$("#username").find('input').val()};

	var url = '/u-reg-code';

	if(source === 'reset')
	{
		param.way = $("input[name='way").val();

		url = '/u-reset-code';
	}

	$.post(url,param,function(result)
	{
		if(result.status !== 2)
		{
			feelDeskAlert(result.msg);
		}
		else
		{
			setCookie(countdown_name,60,60);

			countDownTime('code',countdown_name);

			feelDeskAlert(result.msg);

			slideVerify.resetVerify();
		}

		layer.close(loading);

	},'JSON')
};

