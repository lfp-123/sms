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
    <title>员工信息</title>
</head>
<script type="text/javascript">
    layui.use(['table', 'form'], function () {
        let table = layui.table;
        let form = layui.form;

        //数据表格显示
        table.render({
            elem: '#demo'
            , url: '${pageContext.request.contextPath}/emp/empList.do' //数据接口
            , cellMinWidth: 80
            , page: true //开启分页
            , id: 'testReload'
            , cols: [[ //表头
                {field: 'empName', align: 'center', title: '姓名', sort: true, fixed: 'left'}
                , {field: 'empNativePlace', align: 'center', title: '籍贯'}
                , {field: 'empAddr', align: 'center', title: '地址'}
                , {field: 'empPhone', align: 'center', title: '电话'}
                , {field: 'empIdentity', align: 'center', title: '身份证'}
                , {field: 'empSex', align: 'center', title: '性别'}
                , {field: 'empDept', align: 'center', title: '部门'}
                , {field: 'empDescribe', align: 'center', title: '描述'}
                , {fixed: 'right', title: '操作', align: 'center', toolbar: '#barDemo'}
            ]]
        });

        //输入框 条件搜索
        let $ = layui.$, active = {
            reload: function () {
                let demoReload = $('#demoReload');
                table.reload('testReload', {
                    where: {
                        empName: demoReload.val()
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
                //删除员工
                layer.confirm('真的删除该员工吗？', function (index) {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/emp/delete.do",
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
                $.ajax({
                    url: '${pageContext.request.contextPath}/emp/getDept.do',
                    dataType: 'json',
                    type: 'get',
                    success: function (result) {
                        //使用循环遍历，给下拉列表赋值
                        $.each(result, function (index, item) {
                            //option 第一个参数是页面显示的值，第二个参数是传递到后台的值
                            $('#deptId').append(new Option(item.deptName, item.deptId));//往下拉菜单里添加元素
                        })
                        //重新渲染 固定写法
                        form.render('select')
                    }
                });

                //修改员工
                layer.open({
                    type: 1
                    , anim: 5
                    , title: "修改员工"
                    , area: ['1000px', '800px']
                    , resize: false
                    , offset: '0px'
                    , shade: 0
                    , content: $("#add", function () {
                        $("#id").val(data.id);
                        $("#empName").val(data.empName);
                        $("#empNativePlace").val(data.empNativePlace);
                        $("#empAddr").val(data.empAddr);
                        $("#empPhone").val(data.empPhone);
                        $("#empIdentity").val(data.empIdentity);
                        $("#empSex").val(data.empSex);
                        $("#deptId").val(data.deptId);
                        $("#empDescribe").val(data.empDescribe);
                    })
                    , btn: '保存'
                    , btnAlign: 'r'
                    , closeBtn: 1
                    , yes: function () {
                        let id = $("#id").val();
                        let empName = $("#empName").val();
                        let empNativePlace = $("#empNativePlace").val();
                        let empAddr = $("#empAddr").val();
                        let empPhone = $("#empPhone").val();
                        let empIdentity = $("#empIdentity").val();
                        let empSex = $("#empSex").val();
                        let deptId = $("#deptId").val();
                        let empDescribe = $("#empDescribe").val();
                        $.post("${pageContext.request.contextPath}/emp/update.do", {
                            empId: id,
                            empName: empName,
                            empNativePlace: empNativePlace,
                            empAddr: empAddr,
                            empPhone: empPhone,
                            empIdentity: empIdentity,
                            empSex: empSex,
                            deptId: deptId,
                            empDescribe: empDescribe,
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
    <legend>员工管理</legend>
</fieldset>
<div class="demoTable">
    <div class="site-demo-button" id="layerDemo" style="margin-bottom: 0;">
        员工名称：
        <div class="layui-inline">
            <input class="layui-input" name="empName" id="demoReload" autocomplete="off">
        </div>
        <button class="layui-btn" data-type="reload"><i class="layui-icon">&#xe615;</i>搜索</button>
        <button data-method="offset" data-type="auto" class="layui-btn"><i class="layui-icon">&#xe654;</i>添加员工</button>
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
                    , title: "添加员工"
                    , area: ['700px', '700px']
                    , resize: false
                    , shade: 0
                    , offset: '60px'
                    , content: $("#add")
                    , btn: '保存'
                    , btnAlign: 'r' //按钮居中
                    , yes: function () {
                        let empName = $("#empName").val();
                        let empNativePlace = $("#empNativePlace").val();
                        let empAddr = $("#empAddr").val();
                        let empPhone = $("#empPhone").val();
                        let empIdentity = $("#empIdentity").val();
                        let empSex = $("#empSex").val();
                        let deptId = $("#deptId").val();
                        let empDescribe = $("#empDescribe").val();
                        if (empName == null || empName === '') {
                            layer.msg('员工名不能为空！', {icon: 5});
                            return false;
                        }
                        $.post("${pageContext.request.contextPath}/emp/add.do", {
                            empName: empName,
                            empNativePlace: empNativePlace,
                            empAddr: empAddr,
                            empPhone: empPhone,
                            empIdentity: empIdentity,
                            empSex: empSex,
                            deptId: deptId,
                            empDescribe: empDescribe,
                        }, function (result) {
                            if (result.success) {
                                layer.closeAll();
                                layer.msg('员工添加成功！', {icon: 1});
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
<form class="layui-form" id="add" action="" style="display:none;">
    <div class="layui-form-item" style="padding: 15px;">
        <div class="layui-form-item">
            <input type="hidden" name="id" id="id" autocomplete="off" class="layui-input">
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">姓名</label>
            <div class="layui-input-block">
                <input type="text" name="empName" id="empName" lay-verify="required"
                       autocomplete="off"
                       placeholder="请输入姓名" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">籍贯</label>
            <div class="layui-input-block">
                <input type="text" name="empNativePlace" id="empNativePlace"
                       autocomplete="off"
                       placeholder="请输入籍贯" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">地址</label>
            <input type="text" name="empAddr" id="empAddr" autocomplete="off"
                   placeholder="请输入地址" class="layui-input">
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">电话</label>
            <div class="layui-input-block">
                <input type="text" name="empPhone" id="empPhone" lay-verify="phone"
                       autocomplete="off"
                       placeholder="请输入电话" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">身份证</label>
            <div class="layui-input-block">
                <input type="text" name="empIdentity" id="empIdentity" lay-verify="identity"
                       autocomplete="off"
                       placeholder="请输入身份证" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-block">
                <select name="empSex" id="empSex">
                    <option value="0">女</option>
                    <option value="1">男</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item" lay-filter="deptId">
            <label class="layui-form-label">部门</label>
            <select name="deptId" id="deptId">
                <option value="null">请选择</option>
            </select>
        </div>
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">描述</label>
            <div class="layui-input-block">
            <textarea name="empDescribe" id="empDescribe" placeholder="请输入描述" class="layui-textarea"
                      cols="" rows=""></textarea>
            </div>
        </div>
    </div>
</form>
<ul id="treeDemo" class="ztree" style="display:none"></ul>
</body>
</html>