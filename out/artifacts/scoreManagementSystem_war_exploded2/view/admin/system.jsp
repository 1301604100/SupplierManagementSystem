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
        <title>学生成绩管理系统 管理员后台</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/system.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
        <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
        <script>
            $(function () {
                $('.nav dd a').click(function () {
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

    <body>
        <!-- 头部 -->
        <div class="header">
            <h1>学生成绩管理系统</h1>
        </div>

        <div class="left">
            <!-- 头像 -->
            <div class="profile">
                <div class="photo">
                    <img src="${pageContext.request.contextPath}/img/admin.jpg" alt="" class="image">
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
                        <a href="javascript:void(0);" id="home"
                           url="${pageContext.request.contextPath}/view/admin/welcome.jsp">主页</a>
                    </li>
                    <li class="layui-nav-item">
                        <a href="javascript:;">学生信息管理</a>
                        <dl class="layui-nav-child">
                            <dd><a href="javascript:void(0);" url="StudentListServlet?method=toStudentListView">学生列表</a>
                            </dd>
                            <dd><a href="javascript:void(0);"
                                   url="StudentScoreListServlet?method=toStudentScoreListView">学生成绩</a></dd>
                            <dd><a href="javascript:void(0);"
                                   url="">学生班级</a></dd>
                        </dl>
                    </li>

                    <li class="layui-nav-item">
                        <a href="javascript:;">班级信息管理</a>
                        <dl class="layui-nav-child">
                            <dd><a href="javascript:void(0);" url="ClazzServlet?method=toClazzListView">班级列表</a></dd>
                        </dl>
                    </li>

                    <li class="layui-nav-item">
                        <a href="javascript:;">教师信息管理</a>
                        <dl class="layui-nav-child">
                            <dd><a href="javascript:void(0);" url="TeacherListServlet?method=toTeacherListView">教师列表</a>
                            </dd>
                        </dl>
                    </li>

                    <li class="layui-nav-item">
                        <a href="javascript:;">用户信息管理</a>
                        <dl class="layui-nav-child">
                            <dd><a href="javascript:void(0);" url="UserListServlet?method=toUserListView">用户列表</a></dd>
                        </dl>
                    </li>
                    <li class="layui-nav-item">
                        <a href="javascript:void(0);" id="logOut">退出</a>
                    </li>
                </ul>
            </div>
        </div>

        <div class="main">
            <iframe src="${pageContext.request.contextPath}/view/admin/welcome.jsp" width="100%" height="100%"
                    frameborder="0"></iframe>
        </div>
    </body>

</html>
