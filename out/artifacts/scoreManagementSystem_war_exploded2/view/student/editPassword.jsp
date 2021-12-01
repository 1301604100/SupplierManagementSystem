<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/5/22
  Time: 18:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>设置我的密码</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
        <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
        <link rel="stylesheet" href="https://www.layui.com/layuiadmin/std/dist/layuiadmin/style/admin.css">
    </head>
    <body>

        <div class="layui-fluid">
            <div class="layui-row layui-col-space15">
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-header">修改密码</div>
                        <div class="layui-card-body" pad15>

                            <div class="layui-form" lay-filter="">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">新密码</label>
                                    <div class="layui-input-inline">
                                        <input type="password" name="newPassword" lay-verify="pass" lay-verType="tips" autocomplete="off" id="LAY_password" class="layui-input">
                                    </div>
                                    <div class="layui-form-mid layui-word-aux">6到16个字符</div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">确认新密码</label>
                                    <div class="layui-input-inline">
                                        <input type="password" name="rePassword" lay-verify="repass" lay-verType="tips" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <div class="layui-input-block">
                                        <button class="layui-btn" lay-submit lay-filter="*">确认修改</button>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            layui.use('form', function () {
                let form = layui.form;
                form.on('submit(*)', function (data) {
                    // console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                    if (data.newPassword === data.rePassword) {
                        $.ajax({
                            type: "post",
                            url: "StudentServlet?method=EditPassword",
                            data: data.field,
                            success: function (msg) {
                                if (msg === "success") {
                                    layer.msg('修改成功!');
                                } else {
                                    layer.msg('修改失败!');
                                }
                            }
                        })
                        return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
                    }else {
                        layer.msg("两次输入密码不相同！");
                    }
                })
            })
        </script>
    </body>
</html>
