<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css">
    <script src="${pageContext.request.contextPath}/static/layui/layui.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/jquery-3.3.1.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/zTree_v3/js/jquery.ztree.all.js"
            type="text/javascript"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/zTree_v3/css/zTreeStyle/zTreeStyle.css"
          type="text/css">
    <title>角色信息</title>
</head>
<script type="text/javascript">
    layui.use(['table', 'form'], function () {
        let table = layui.table;
        let form = layui.form;

        //数据表格显示
        table.render({
            elem: '#demo'
            , url: '${pageContext.request.contextPath}/role/roleList.do' //数据接口
            , cellMinWidth: 80
            , page: true //开启分页
            , id: 'testReload'
            , cols: [[ //表头
                {field: 'id', title: 'ID', align: 'center', sort: true, fixed: 'left'}
                , {field: 'roleName', align: 'center', title: '角色'}
                , {field: 'roleRemark', align: 'center', title: '备注'}
                , {fixed: 'right', title: '操作', align: 'center', toolbar: '#barDemo'}
            ]]
        });

        //输入框 条件搜索
        let $ = layui.$, active = {
            reload: function () {
                let demoReload = $('#demoReload');
                table.reload('testReload', {
                    where: {
                        roleName: demoReload.val()
                    }
                });
            }
        };

        //输入框按钮监听
        $('.demoTable .layui-btn').on('click', function () {
            let type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });

        //form表格监听
        form.on('submit(formDemo)', function (data) {
            layer.msg(JSON.stringify(data.field));
            return false;
        });

        //操作按钮监听
        table.on('tool(test)', function (obj) {
            let data = obj.data;
            if (obj.event === 'del') {
                //删除角色
                layer.confirm('真的删除该角色吗？', function (index) {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/role/delete.do",
                        type: "POST",
                        data: {"id": data.id},
                        dataType: "json",
                        success: function (data) {
                            if (data.success) {
                                //删除这一行
                                obj.del();
                                //关闭弹框
                                layer.close(index);
                                layer.msg("删除成功", {icon: 6});
                                setTimeout("refreshPage()", 1000);
                            } else {
                                layer.msg(data.errorInfo, {icon: 5});
                            }
                        }
                    });
                });
            } else if (obj.event === 'edit') {
                //修改角色
                layer.open({
                    type: 1
                    , anim: 5
                    , title: "修改角色"
                    , area: ['500px', '320px']
                    , resize: false
                    , offset: 'auto'
                    , shade: 0
                    , content: $("#add", function () {
                        $("#id").val(data.id);
                        $("#roleName").val(data.roleName);
                        $("#roleRemark").val(data.roleRemark);
                        $("#roleName").attr("disabled", true);
                    })
                    , btn: '保存'
                    , btnAlign: 'r'
                    , closeBtn: 1
                    , yes: function () {
                        let id = $("#id").val();
                        let roleName = $("#roleName").val();
                        let roleRemark = $("#roleRemark").val();

                        $.post("${pageContext.request.contextPath}/role/update.do", {
                            id: id,
                            roleName: roleName,
                            roleRemark: roleRemark
                        }, function (result) {
                            if (result.success) {
                                layer.closeAll();
                                layer.msg('角色修改成功！', {icon: 1});
                                setTimeout("refreshPage()", 1000);
                            } else {
                                layer.msg(result.errorInfo, {icon: 5});
                            }
                        });

                    }
                    , cancel: function (index, layero) {
                        setTimeout("refreshPage()", 100);
                        return false;
                    }
                });
            }
        });
    });
</script>
<body>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>角色管理</legend>
</fieldset>
<div class="demoTable">
    <div class="site-demo-button" id="layerDemo" style="margin-bottom: 0;">
        角色名称：
        <div class="layui-inline">
            <input class="layui-input" name="roleName" id="demoReload" autocomplete="off">
        </div>
        <button class="layui-btn" data-type="reload"><i class="layui-icon">&#xe615;</i>搜索</button>
        <button data-method="offset" data-type="auto" class="layui-btn"><i class="layui-icon">&#xe654;</i>添加角色</button>
    </div>
</div>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="text/javascript">
    layui.use('layer', function () {
        let $ = layui.jquery, layer = layui.layer;
        let active = {
            offset: function (othis) {
                let type = othis.data('type')
                    , text = othis.text();
                layer.open({
                    type: 1
                    , anim: 5
                    , title: "添加角色"
                    , area: ['500px', '320px']
                    , resize: false
                    , shade: 0
                    , offset: 'auto'
                    , content: $("#add")
                    , btn: '保存'
                    , btnAlign: 'r' //按钮居中
                    , yes: function () {
                        let roleName = $("#roleName").val();
                        let roleRemark = $("#roleRemark").val();
                        if (roleName == null || roleName === '') {
                            layer.msg('角色名不能为空！', {icon: 5});
                            return false;
                        }
                        $.post("${pageContext.request.contextPath}/role/add.do", {
                            roleName: roleName,
                            roleRemark: roleRemark
                        }, function (result) {
                            if (result.success) {
                                layer.closeAll();
                                layer.msg('角色添加成功！', {icon: 1});
                                setTimeout("refreshPage()", 1000);
                            } else {
                                layer.msg(result.errorInfo, {icon: 5});
                            }
                        });
                    }
                    , cancel: function (index, layero) {
                        setTimeout("refreshPage()", 100);
                        return false;
                    }
                });
            }
        };
        $('#layerDemo .layui-btn').on('click', function () {
            let othis = $(this), method = othis.data('method');
            active[method] ? active[method].call(this, othis) : '';
        });
    });

    function refreshPage() {
        window.location.reload();
    }
</script>
<table id="demo" lay-filter="test"></table>
<form class="layui-form" id="add" action="" style="display:none;padding-left: 10%">
    <div class="layui-form-item" style="padding: 15px;">
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" style="color: red;">角色名</label>
        <div class="layui-input-block">
            <input type="hidden" name="id" id="id" style="width: 15px;" lay-verify="title" autocomplete="off"
                   class="layui-input">
            <input type="text" name="roleName" id="roleName" style="width: 250px;" lay-verify="title" autocomplete="off"
                   placeholder="请输入角色名" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">备注</label>
        <div class="layui-input-block">
            <textarea name="roleRemark" id="roleRemark" placeholder="请输入内容" class="layui-textarea"
                      style="width: 250px;" cols="" rows=""></textarea>
        </div>
    </div>
</form>
<ul id="treeDemo" class="ztree" style="display:none"></ul>
</body>
</html>