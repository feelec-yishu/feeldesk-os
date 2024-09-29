/*
 * 软件为成都菲莱克斯科技有限公司出品，未经授权许可不得使用！
 * 作者：Yishu
 * 官网：www.feeldesk.cn
 * 邮件: 1017242700@qq.com
 */

$(function()
{
    //setInterval('getTicketNumber()',1000*10);

    $('.feeldesk-menu-first').unbind('click').click(function()
    {
        if($(this).find('.feeldesk-menu-second').css("display") === 'none')
        {
            $(this).find('.feeldesk-leftMenu-menu1 .layui-icon').html('&#xe61a;');
        }
        else
        {
            $(this).find('.feeldesk-leftMenu-menu1 .layui-icon').html('&#xe602;');
        }

        $(this).find('.feeldesk-menu-second').slideToggle('fast');

        $(this).find('.feeldesk-leftMenu-menu1').toggleClass('current');

        event.stopPropagation();
    });

    $('.feeldesk-menu-second').unbind('click').click(function()
    {
        event.stopPropagation();

        var thirdMenu = $(this).find('.feeldesk-menu-third');

        if(thirdMenu.length > 0)
        {
            $('.feeldesk-leftMenu-menu2').removeClass('current');

            if(thirdMenu.css("display") === 'none')
            {
                $(this).find('.feeldesk-leftMenu-menu2 .layui-icon').html('&#xe61a;');
            }
            else
            {
                $(this).find('.feeldesk-leftMenu-menu2 .layui-icon').html('&#xe602;');
            }

            thirdMenu.slideToggle('fast');

            $(this).find('.feeldesk-leftMenu-menu2').addClass('current');
        }
    });
});

function feeldeskActive(obj,l)
{
    event.stopPropagation();

    if(l === 2)
    {
        $('.ticket-second-menu,.feeldesk-leftMenu-menu2,.ticket-third-menu').removeClass('current');
    }
    else
    {
        $('.ticket-third-menu,.ticket-second-menu,.feeldesk-leftMenu-menu2').removeClass('current');

        $(obj).parents('.feeldesk-menu-third').prev('.feeldesk-leftMenu-menu2').addClass('current');
    }

    $(obj).addClass('current');

    showRightLoading();
}


function hideRightLoading()
{
    $('.global-loading').remove();
}


function showRightLoading()
{
    $('.ticket-main-right').after("<div class='global-loading'><i class='layui-icon layui-icon-loading layui-anim layui-anim-rotate layui-anim-loop'></i></div>");
}
