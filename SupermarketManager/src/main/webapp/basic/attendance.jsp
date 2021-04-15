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
            , url: '${pageContext.request.contextPath}/emp/empWorkList.do' //数据接口
            , cellMinWidth: 80
            , page: true //开启分页
            , id: 'testReload'
            , cols: [[ //表头
                {field: 'emp_name', align: 'center', title: '员工姓名', sort: true, fixed: 'left'}
                , {field: 'work_days', align: 'center', title: '打卡天数'}
                , {field: 'out_work_days', align: 'center', title: '加班天数'}
                , {field: 'leave_days', align: 'center', title: '请假天数'}
                , {fixed: 'right', title: '操作', align: 'center', toolbar: '#barDemo'}
            ]]
        });

        //输入框 条件搜索
        let $ = layui.$, active = {
            reload: function () {
                let demoReload = $('#demoReload');
                let index = layer.msg("查询中，请稍后...", {icon: 16, time: false, shade: 0});
                setTimeout(function () {
                    table.reload('testReload', {
                        where: {
                            empName: demoReload.val()
                        }
                    });
                    layer.close(index);
                }, 800);
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
                    // $("#employId").val(data.emp_id);
                    $("#name").val(data.emp_name);
                    $("#workDays").val(data.work_days);
                    $("#outWorkDays").val(data.out_work_days);
                    $("#leaveDays").val(data.leave_days);
                    $("#name").attr("disabled", true);
                    $("#employId").attr("disabled", true);
                })
                , btn: '保存'
                , btnAlign: 'r'
                , closeBtn: 1
                , yes: function () {
                    let id = data.id;
                    let employId = $("#employId").val();
                    let name = $("#name").val();
                    let workDays = $("#workDays").val();
                    let outWorkDays = $("#outWorkDays").val();
                    let leaveDays = $("#leaveDays").val();
                    //编辑角色在这里修改就行了
                    $.post("${pageContext.request.contextPath}/emp/updatew.do", {
                        id: id,
                        empId: employId,
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
                    setTimeout("refreshPage()", 1000);
                    return false;
                }
            });
        });
    });

    function refreshPage() {
        window.location.reload();
    }
</script>
<body>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>用户管理</legend>
</fieldset>
<div class="demoTable">
    <div class="site-demo-button" id="layerDemo" style="margin-bottom: 0;">
        用户名称：
        <div class="layui-inline">
            <input class="layui-input" name="empName" id="demoReload" autocomplete="off">
        </div>
        <button class="layui-btn" data-type="reload"><i class="layui-icon">&#xe615;</i>搜索</button>
        <%--        <button data-method="offset" data-type="auto" class="layui-btn"><i class="layui-icon">&#xe654;</i>添加用户</button>--%>
    </div>
</div>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
</script>
<table id="demo" lay-filter="test"></table>
<form class="layui-form" id="add" action="" style="display:none;padding-left: 10%">
    <div class="layui-form-item">
        <div class="layui-input-block">
            <input type="hidden" name="employId" id="employId" autocomplete="off" class="layui-input">
        </div>
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
            <input type="text" name="outWorkDays" id="outWorkDays" style="width: 350px;" lay-verify="title"
                   autocomplete="off"
                   placeholder="请输入加班天数" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">请假天数</label>
        <div class="layui-input-block">
            <input type="text" name="leaveDays" id="leaveDays" style="width: 350px;" lay-verify="title"
                   autocomplete="off"
                   placeholder="请输入请假天数" class="layui-input">
        </div>
    </div>
</form>
</body>
</html>
