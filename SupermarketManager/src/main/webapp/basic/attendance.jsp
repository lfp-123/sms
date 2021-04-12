<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css">
    <script src="${pageContext.request.contextPath}/static/layui/layui.js" type="text/javascript"></script>
    <title>用户信息</title>
</head>
<script type="text/javascript">
    layui.use(['table', 'form'], function () {
        let table = layui.table;
        let form = layui.form;

        //考勤表格显示
        table.render({
            elem: '#demo'
            , url: '${pageContext.request.contextPath}/emp//empWorkList.do' //数据接口
            , cellMinWidth: 80
            , page: true //开启分页
            , id: 'testReload'
            , cols: [[ //表头
                {field: 'employId', title: '员工ID', align: 'center', sort: true, fixed: 'left'}
                , {field: 'name', align: 'center', title: '员工姓名'}
                , {field: 'workDays', align: 'center', title: '打卡天数'}
                , {field: 'outWorkDays', align: 'center', title: '加班天数'}
                , {field: 'leaveDays', align: 'center', title: '请假天数'}
                , {fixed: 'right', title: '操作', align: 'center', toolbar: '#barDemo'}
            ]]
        });

        //输入框 条件搜索
        let $ = layui.$, active = {
            reload: function () {
                let demoReload = $('#demoReload');
                table.reload('testReload', {
                    where: {
                        userName: demoReload.val()
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
                //删除用户
                layer.confirm('真的删除该用户吗？', function (index) {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/emp/deletew.do",
                        type: "POST",
                        data: {"id": data.employId},
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
                //修改用户
                layer.open({
                    type: 1
                    , anim: 5
                    , title: "考勤修改"
                    , area: ['700px', '520px']
                    , resize: false
                    , offset: '100px'
                    , shade: 0
                    , content: $("#add", function () {
                        $("#employId").val(data.employId);
                        $("#name").val(data.name);
                        $("#workDays").val(data.workDays);
                        $("#outWorkDays").val(data.outWorkDays);
                        $("#leaveDays").val(data.leaveDays);
                        $("#name").attr("disabled", true);
                        $("#employId").attr("disabled", true);
                        form.render("radio");
                    })
                    , btn: '保存'
                    , btnAlign: 'r'
                    , closeBtn: 1
                    , yes: function () {
                        let employId = $("#employId").val();
                        let name = $("#name").val();
                        let workDays = $("#workDays").val();
                        let outWorkDays = $("#outWorkDays").val();
                        let leaveDays = $("#leaveDays").val();
                        //编辑角色在这里修改就行了
                        $.post("${pageContext.request.contextPath}/emp/updatew.do", {
                            employId: employId,
                            name: name,
                            workDays: workDays,
                            outWorkDays: outWorkDays,
                            leaveDays: leaveDays,
                        }, function (result) {
                            if (result.success) {
                                layer.closeAll();
                                layer.msg('用户修改成功！', {icon: 1});
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
    <legend>用户管理</legend>
</fieldset>
<div class="demoTable">
    <div class="site-demo-button" id="layerDemo" style="margin-bottom: 0;">
        用户名称：
        <div class="layui-inline">
            <input class="layui-input" name="userName" id="demoReload" autocomplete="off">
        </div>
        <button class="layui-btn" data-type="reload"><i class="layui-icon">&#xe615;</i>搜索</button>
<%--        <button data-method="offset" data-type="auto" class="layui-btn"><i class="layui-icon">&#xe654;</i>添加用户</button>--%>
    </div>
</div>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="text/javascript">
    layui.use(['layer', 'form'], function () {
        let $ = layui.jquery, layer = layui.layer, form = layui.form;
        let active = {
            offset: function (othis) {
                let type = othis.data('type')
                    , text = othis.text();
                $.post("${pageContext.request.contextPath}/role/rolefind.do", function (result) {
                    let deptSelect = $("#roleId");
                    let arr = eval('(' + result + ')');
                    for (let i = 0; i < arr.length; i++) {
                        let opt = document.createElement("option");
                        opt.value = arr[i].id;
                        opt.innerText = arr[i].name;
                        deptSelect.append(opt);
                        console.log(opt);
                    }
                    form.render("select");
                });
                layer.open({
                    type: 1
                    , anim: 5
                    , title: "考勤添加"
                    , area: ['700px', '600px']
                    , resize: false
                    , shade: 0
                    , offset: '30px'
                    , content: $("#add")
                    , btn: '保存'
                    , btnAlign: 'r' //按钮居中
                    , yes: function () {
                        let userName = $("#name").val();
                        let password = $("#password").val();
                        let confirmPassword = $("#confirmPassword").val();
                        let trueName = $("#trueName").val();
                        let number = $("#number").val();
                        let address = $("#address").val();
                        let roleId = $('#roleId option:selected').val();
                        let r = /^((0\d{2,3}-\d{7,8})|(1[3584]\d{9}))$/;
                        if (userName == null || userName == '') {
                            layer.msg('用户名不能为空！', {icon: 5});
                            return false;
                        }
                        if (password == null || password === '') {
                            layer.msg('密码不能为空！', {icon: 5});
                            return false;
                        }
                        if (confirmPassword == null || confirmPassword === '') {
                            layer.msg('确认密码不能为空！', {icon: 5});
                            return false;
                        }
                        if (confirmPassword !== password) {
                            layer.msg('确认密码有误！', {icon: 5});
                            return false;
                        }
                        if (trueName == null || trueName === '') {
                            layer.msg('真实姓名不能为空！', {icon: 5});
                            return false;
                        }
                        if (roleId == null || roleId === '') {
                            layer.msg('角色不能为空！', {icon: 5});
                            return false;
                        }
                        $.post("${pageContext.request.contextPath}/user/add.do", {
                            userName: userName,
                            password: password,
                            trueName: trueName,
                            address: address,
                            number: number,
                            roleId: roleId
                        }, function (result) {
                            if (result.success) {
                                layer.closeAll();
                                layer.msg('用户添加成功！', {icon: 1});
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
            var othis = $(this), method = othis.data('method');
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
        <label class="layui-form-label" style="color: red;">员工ID</label>
        <div class="layui-input-block">
            <input type="text" name="employId" id="employId" style="width: 350px;" lay-verify="title" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" style="color: red;">员工姓名</label>
        <div class="layui-input-block">
            <input type="text" name="name" id="name" style="width: 350px;" lay-verify="title"
                   autocomplete="off" placeholder="请输入员工姓名" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" style="color: red;">工作天数</label>
        <div class="layui-input-block">
            <input type="text" name="workDays" id="workDays" style="width: 350px;" lay-verify="title" autocomplete="off"
                   placeholder="请输入工作天数" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">加班天数</label>
        <div class="layui-input-block">
            <input type="text" name="outWorkDays" id="outWorkDays" style="width: 350px;" lay-verify="title" autocomplete="off"
                   placeholder="请输入加班天数" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">请假天数</label>
        <div class="layui-input-block">
            <input type="text" name="leaveDays" id="leaveDays" style="width: 350px;" lay-verify="title" autocomplete="off"
                   placeholder="请输入请假天数" class="layui-input">
        </div>
    </div>
</form>
</body>
</html>
