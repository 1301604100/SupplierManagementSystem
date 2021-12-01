<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>edit</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/system.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
        <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/getData.js"></script>
        <style>
            button {
                float: right;
                right: -30px;
            }
        </style>
    </head>
    <body>
        <div id="Dialog" style="padding: 10px">
            <form id="Form" method="post" name="from" class="layui-form">
                <!--        id        -->
                <input id="edit_id" type="hidden" name="id" autocomplete="off"
                       class="layui-input">
                <!--        账号        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 50px">账号:</label>
                    <div class="layui-input-block">
                        <input id="edit_account" type="number" name="account" placeholder="请输入账号" autocomplete="off"
                               class="layui-input" style="width: 200px" lay-verify="required">
                    </div>
                </div>
                <!--        密码        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 50px">密码:</label>
                    <div class="layui-input-block">
                        <input id="edit_password" type="number" name="password" placeholder="请输入密码" autocomplete="off"
                               class="layui-input" style="width: 200px" lay-verify="required">
                    </div>
                </div>
                <!--        姓名        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 50px">姓名:</label>
                    <div class="layui-input-block">
                        <input id="edit_name" type="text" name="name" placeholder="请输入姓名" autocomplete="off"
                               class="layui-input" style="width: 200px" lay-verify="required">
                    </div>
                </div>
                <!--        下拉框        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 50px">类型:</label>
                    <div class="layui-input-block" style="width: 200px">
                        <select id="edit_status" name="status" lay-verify="required">
                            <option value="">选择用户类型</option>
                            <option value="1">管理员</option>
                            <option value="2">学生</option>
                            <option value="3">教师</option>
                        </select>
                    </div>
                </div>
                <!--       提交按钮         -->
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button lay-submit lay-filter="*" class="layui-btn layui-btn layui-btn-sm">修改</button>
                    </div>
                </div>

            </form>
        </div>
        <script>
            // 填入数据
            function setData() {
                $('#edit_id').val(UrlParm.parm("userId"))
                $('#edit_account').val(UrlParm.parm("account"))
                $('#edit_password').val(UrlParm.parm("password"))
                $('#edit_name').val(UrlParm.parm("name"))
                $('#edit_status').val(UrlParm.parm("status"))
            }

            // 先填入数据
            setData();
            layui.use('form', function () {
                let form = layui.form;
                form.on('submit(*)', function (data) {
                    // console.log(typeof data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                    $.ajax({
                        type: "post",
                        url: "http://localhost:8080/UserListServlet?method=EditUser",
                        data: $("#Form").serialize(),
                        success: function (msg) {
                            if (msg === "success") {
                                layer.msg('修改成功!');
                            } else if (msg === "exist") {
                                layer.msg('已存在该账号，修改失败!');
                            }
                        }
                    })
                    return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
                })
            })
        </script>
    </body>
</html>