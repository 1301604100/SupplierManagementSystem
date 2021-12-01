<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/5/10
  Time: 16:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>供应商管理后台</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/system.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
        <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.5/css/layui.css" media="all">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/font-awesome-4.7.0/css/font-awesome.min.css"
              media="all">
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/Public/img/favicon.ico" >
        <script>
            $(function () {
                $('.nav a').click(function () {
                    $('iframe').attr("src", $(this).attr("url"));
                })

                $('#home').click(function () {
                    $('iframe').attr("src", $(this).attr("url"))
                })
                $('#logOut').click({
                    btn: ['确定', '取消']
                }, function (e) {
                    // e.preventDefault();
                    // e.stopPropagation();
                    layer.confirm('确认退出吗?', function (index) {
                        layer.close(index);
                        window.location.href = "LoginServlet?method=logOut";
                    }, function () {

                    });
                })
            })
        </script>
    </head>
    <style>
        .layui-left-nav {
            margin-left: 10px;
        }

        .admin-login-background {
            /*width: 360px;*/
            height: 90px;
            /*position: absolute;*/
            /*left: 50%;*/
            /*top: 40%;*/
            /*margin-left: -180px;*/
            /*margin-top: -100px;*/
            background: #1E9FFF;
        }

        .admin-login-background  h1 {
            position: absolute;
            width: 80%;
            height: 50%;
            font-size: 30px;
            top: 25px;
            left: 250px;
        }
    </style>
    <body>
        <!-- 头部 -->
        <div class="admin-login-background ">

            <h1><i class="layui-icon layui-icon-windows" style="font-size: 20px"></i>  供应商管理系统</h1>
        </div>

        <div class="left">
            <!-- 头像 -->
            <div class="profile">
                <div class="photo">
                    <img src="${pageContext.request.contextPath}/img/phone.png" alt="" class="image">
                </div>
                <div class="name">
                    <p>admin</p>
                </div>
            </div>
            <!-- 侧边栏 -->
            <div class="nav">
                <ul class="layui-nav layui-nav-tree layui-inline" lay-filter="test" lay-shrink="all">
                    <!-- 侧边导航: <ul class="layui-nav layui-nav-tree layui-nav-side"> -->
                    <li class="layui-nav-item">
                        <a href="javascript:;" id="home"
                           url="${pageContext.request.contextPath}/view/admin/welcome.jsp">
                            <i class="fa fa-home"></i>
                            <span class="layui-left-nav">主页</span>
                        </a>
                    </li>
                    <li class="layui-nav-item">
                        <a href="javascript:void(0);" url="BillListServlet?method=toBillListView">
                            <i class="fa fa-bars"></i>
                            <span class="layui-left-nav">订单管理</span>
                        </a>
                    </li>
                    <li class="layui-nav-item">
                        <a href="javascript:void(0);" url="ProviderListServlet?method=toProviderListView">
                            <i class="fa fa-weixin"></i>
                            <span class="layui-left-nav">供应商管理</span>
                        </a>
                    </li>
                    <li class="layui-nav-item">
                        <a href="javascript:void(0);" url="UserListServlet?method=toUserListView">
                            <i class="fa fa-user"></i>
                            <span class="layui-left-nav">用户管理</span>
                        </a>
                    </li>
                    <li class="layui-nav-item">
                        <a href="javascript:void(0);" id="logOut">
                            <i class="fa fa-sign-out"></i>
                            <span class="layui-left-nav">退出</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <div class="main">
            <iframe src="${pageContext.request.contextPath}/view/admin/welcome.jsp" width="100%" height="100%"
                    frameborder="0"></iframe>
        </div>
    </body>
    <script src="${pageContext.request.contextPath}/lib/jquery-3.4.1/jquery-3.4.1.min.js" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/lib/jq-module/jquery.particleground.min.js"
            charset="utf-8"></script>
    <script>
        // 粒子线条背景
        $(document).ready(function () {
            $('.admin-login-background').particleground({
                dotColor: '#7ec7fd',
                lineColor: '#7ec7fd'
            });
        });
    </script>
</html>
