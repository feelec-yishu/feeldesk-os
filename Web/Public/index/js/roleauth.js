/* 
* 软件为成都菲莱克斯科技有限公司出品，未经授权许可不得使用！
* 作者：Yishu
* 官网：www.feeldesk.cn
* 邮件: 1017242700@qq.com
*/
layui.config({base: '/Public/js/layui/extends/'}).extend({authtree: 'authtree/authtree'}).use(['form','authtree'],function()
{
    var loading;

    var form = layui.form;

    var tree = layui.authtree;

    function getFeelMenus(id,menu,name)
    {
        loading = layer.load(2,{offset:'15vw'});

        tree.render('#'+id, menu,
        {
            inputname: name,
            layfilter: 'lay-check-auth',
            childKey:'children',
            nameKey: 'menu_name',
            valueKey: 'menu_id',
            openall:true,
            autowidth: true
        });

        layer.close(loading);
    }

    form.on('submit',function(data)
    {
        loading = layer.load(2,{offset:'15vw'});

        var role_id = data.elem.getAttribute('data-id');

        $.post("/Role/auth.html?role_id="+role_id,$('form').serialize(),function(data)
        {
            if(data.status == 0)
            {
                feelDeskAlert(data.msg);
            }
            else
            {
                feelDeskAlert(data.msg,data);
            }

            layer.close(loading);

        },'JSON');
    })
});

