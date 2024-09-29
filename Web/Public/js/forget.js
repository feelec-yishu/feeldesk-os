/* 
 * 软件为成都菲莱克斯科技有限公司出品，未经授权许可不得使用！
 * 作者：Yishu
 * 官网：www.feeldesk.cn
 * 邮件: 1017242700@qq.com
 */

/**
 * 倒计时
 * @param:: string mbinput
 */

$(function ()
{
    var cookie_value = getCookieValue('secondsremained');

    if(cookie_value > 0) countDownTime("send_code");
});

/*
 * 添加cookie的值
 * @param name cookie名
 * @param value cookie值
 * @param expire 有效期
 */
function addCookie(name,value,expire)
{
    //判断是否设置过期时间,0代表关闭浏览器时失效
    if(expire>0)
    {
        var date=new Date();

        date.setTime(date.getTime()+expire*1000);

        $.cookie(name, value, {expires: date});
    }
    else
    {
        $.cookie(name, value);
    }
}

/*修改cookie的值*/
function editCookie(name,value,expire)
{
    if(expire>0)
    {
        var date=new Date();

        date.setTime(date.getTime()+expire*1000); //单位是毫秒

        $.cookie(name, value, {expires: date});
    }
    else
    {
        $.cookie(name, value);
    }
}

function countDownTime(btn) 
{
    var obj = $('#'+btn);

    var countdown = getCookieValue('secondsremained');

    if(countdown == 0)
    {
        obj.removeAttr("disabled");

        obj.val(language.GET_CODE);

        obj.css({"background-color":"#fff","color":"rgb(102, 169, 219)",'border-color':'rgb(102, 169, 219)'});

        return;
    }
    else
    {
        obj.attr("disabled", "true");

        obj.val(language.RESEND+"("+countdown+")");

        obj.css({"background-color":"#d4d7d9","color":"#fff","border-color":'#d4d7d9'});

        countdown--;

        editCookie("secondsremained",countdown,countdown+2);
    }

    setTimeout(function(){ countDownTime(btn)}, 1000);
}

/*获取cookie*/
function getCookieValue(name)
{
    return $.cookie(name);
}