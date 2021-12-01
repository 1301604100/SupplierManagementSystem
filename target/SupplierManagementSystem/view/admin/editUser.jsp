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
                <!--        ID        -->
                <input id="edit_id" type="hidden" name="id">
                <!--        用户编码        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 70px">用户编码:</label>
                    <div class="layui-input-block">
                        <input id="edit_userCode" type="text" name="userCode" placeholder="请输入用户编码" autocomplete="off"
                               class="layui-input" style="width: 200px" lay-verify="required" disabled>
                    </div>
                </div>
                <!--        账号        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 70px">用户名:</label>
                    <div class="layui-input-block">
                        <input id="edit_account" type="text" name="account" placeholder="请输入用户名" autocomplete="off"
                               class="layui-input" style="width: 200px" lay-verify="required">
                    </div>
                </div>
                <!--        密码        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 70px">密码:</label>
                    <div class="layui-input-block">
                        <input id="edit_password" type="number" name="password" placeholder="请输入密码" autocomplete="off"
                               class="layui-input" style="width: 200px" lay-verify="required">
                    </div>
                </div>
                <!--        性别        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 70px">性别:</label>
                    <div class="layui-input-block" style="width: 200px">
                        <select name="gender" lay-verify="required" id="edit_gender">
                            <option value="">选择性别</option>
                            <option value="2">男</option>
                            <option value="1">女</option>
                        </select>
                    </div>
                </div>
                <!--        出生日期        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 70px">出生日期:</label>
                    <div class="layui-input-block">
                        <input id="edit_birthday" type="text" name="birthday" lay-verify="date" placeholder="yyyy-MM-dd"
                               autocomplete="off"
                               class="layui-input" style="width: 200px" lay-verify="required">
                    </div>
                </div>
                <!--        手机        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 70px">手机:</label>
                    <div class="layui-input-block">
                        <input id="edit_phone" type="number" name="phone" placeholder="请输入手机号" autocomplete="off"
                               class="layui-input" style="width: 200px" lay-verify="required">
                    </div>
                </div>
                <!--        地址        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 70px">地址:</label>
                    <div class="layui-input-block">
                        <input id="edit_address" type="text" name="address" placeholder="请输入地址" autocomplete="off"
                               class="layui-input" style="width: 200px" lay-verify="required">
                    </div>
                </div>
                <!--        类型        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 70px">类型:</label>
                    <div class="layui-input-block" style="width: 200px">
                        <select name="role" lay-verify="required" id="edit_userRole">
                            <option value="">选择用户类型</option>
                            <option value="系统管理员">系统管理员</option>
                            <option value="供应商">供应商</option>
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
                $('#edit_userCode').val(UrlParm.parm("userCode"))
                $('#edit_account').val(UrlParm.parm("account"))
                $('#edit_password').val(UrlParm.parm("password"))
                $('#edit_gender').val(UrlParm.parm("gender") === '女' ? 1 : 2)
                $('#edit_birthday').val(UrlParm.parm("birthday"))
                $('#edit_phone').val(UrlParm.parm("phone"))
                $('#edit_address').val(UrlParm.parm("address"))
                $('#edit_userRole').val(UrlParm.parm("userRole"))
                $('#edit_id').val(UrlParm.parm("userId"))
            }

            layui.use('laydate', function () {
                var laydate = layui.laydate;

                //执行一个laydate实例
                laydate.render({
                    elem: '#edit_birthday' //指定元素
                });
            });
            // 先填入数据
            setData();
            layui.use('form', function () {
                let form = layui.form;
                form.on('submit(*)', function (data) {
                    // console.log(typeof data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                    $.ajax({
                        type: "post",
                        url: "http://localhost:8080/SupplierManagement/UserListServlet?method=EditUser",
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