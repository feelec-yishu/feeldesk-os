/* 
 * 软件为成都菲莱克斯科技有限公司出品，未经授权许可不得使用！
 * 作者：Yishu
 * 官网：www.feeldesk.cn
 * 邮件: 1017242700@qq.com
 */

$(function()
{
//  新工单推送 - 我处理的工单，仅支持处理人推送
	if(action === 'disposeTicket')
	{
		top.socket.on('new_ticket', function (data)
		{
			updateTicketHtml(data,'new_ticket');
		});
	}

//    新工单推送 - 待回复的工单
	if(action === 'waitReplyTicket')
	{
		top.socket.on('new_wait_reply', function (data)
		{
			updateTicketHtml(data,'new_wait_reply');
		});
	}
	else
	{
		// 更新最新回复数 - 待回复工单页面不监听最新回复数
		top.socket.on('new_reply', function (data)
		{
			data = JSON.parse(data);

			updateNewReplyNumber(data);
		});
	}
});

//在列表中增加新工单
function updateTicketHtml(data,type)
{
	data = JSON.parse(data);

	//当前页面是待回复工单时，如果工单已存在于页面中则更新工单最新回复数
	if(type === 'new_wait_reply' && $("tr[data-value='"+data.ticket_no+"']").length > 0)
	{
		updateNewReplyNumber(data);
	}
	//在列表中增加一行新工单
	else
	{
		var minimalistDiv = $("#minimalist");

		minimalistDiv.find('.minimalist-main').children().first().before(data.minimalist);

		minimalistDiv.find('.nodata').remove();

		$('tbody>:first').before(data.list);

		$('tr.nodata').remove();

		layui.use('form',function(){layui.form.render();});
	}
}

//更新列表中的最新回复数
function updateNewReplyNumber(data)
{
	var newReplyNum = $("#newReplyNum"+data.ticket_no);

	newReplyNum.css({'font-size':'14px','color':'red',"font-weight":"600"});

	var new_reply_num = parseInt(newReplyNum.text());

	if(data.new_reply_num)
	{
		new_reply_num = new_reply_num + data.new_reply_num;
	}
	else
	{
		new_reply_num++;
	}

	newReplyNum.html(new_reply_num);
}

