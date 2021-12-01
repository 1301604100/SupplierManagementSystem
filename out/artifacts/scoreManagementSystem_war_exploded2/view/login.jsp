<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>login</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
        <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script src="${pageContext.request.contextPath}/js/login.js"></script>
        <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
    </head>

    <body>
        <div class="box">
            <!-- 选项 -->
            <div class="table display">
                <div class="tab">
                    <img src="img/tab1.png" alt="">
                    <span>学生</span>
                </div>
                <div class="tab">
                    <img src="img/tab2.png" alt="">
                    <span>教师</span>
                </div>
                <div class="tab">
                    <img src="img/tab4.png" alt="">
                    <span>管理员</span>
                </div>
            </div>
            <!-- 密码界面 -->
            <div class="login layui-anim layui-anim-scale undisplay">
                <div class="title">
                    <p class="logo">账号登陆</p>
                </div>

                <form class="form" action="" method="post" id="form">
                    <%--用户类型--%>
                    <input type="hidden" name="type" value="1" class="user">
                    <%--用户名--%>
                    <input type="text" name="username" id="username" required lay-verify="required" placeholder="请输入用户名" title="请输入用户名" autocomplete="off" class="layui-input" autofocus>
                    <%--密码--%>
                    <input type="password" name="password" required lay-verify="required" placeholder="请输入密码" title="请输入密码" autocomplete="off" class="layui-input">
                    <%--验证码--%>
                    <div class="vcode">
                        <input type="text" name="securityCode" required lay-verify="required" placeholder="请输入验证码" title="请输入验证码" autocomplete="off" class="layui-input" id="vcodeInput">
                        <img title="点击图片切换验证码" id="vccodeImg" src="CaptchaServlet?method=LoginCaptcha" class="Img">
                    </div>
                    <%--登录按钮--%>
                    <input type="button" name="submit" value="登   录" class="submit" id="submitBtn">

                    <div class="close">
                        <img src="img/close.png" alt="">
                    </div>
                </form>

            </div>
        </div>
    </body>

</html>