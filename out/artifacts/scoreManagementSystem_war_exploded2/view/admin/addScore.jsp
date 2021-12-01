<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>add</title>
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
                <!--        学号        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 50px">学号:</label>
                    <div class="layui-input-block">
                        <input id="add_number" type="number" name="number" placeholder="请输入学号" autocomplete="off"
                               class="layui-input" style="width: 200px" lay-verify="required">
                    </div>
                </div>
                <!--        科目        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 50px">科目:</label>
                    <div class="layui-input-block" style="width: 200px">
                        <select name="course" lay-verify="required" >
                            <option value="">选择科目</option>
                            <option value="1">语文</option>
                            <option value="2">数学</option>
                            <option value="3">英语</option>
                            <option value="4">物理</option>
                        </select>
<%--                        <input id="add_course" type="text" name="course" placeholder="请输入科目" autocomplete="off"--%>
<%--                               class="layui-input" style="width: 200px" lay-verify="required">--%>
                    </div>
                </div>
                <!--        成绩        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 50px">成绩:</label>
                    <div class="layui-input-block">
                        <input id="add_score" type="number" name="score" placeholder="请输入成绩" autocomplete="off"
                               class="layui-input" style="width: 200px" lay-verify="required">
                    </div>
                </div>
                <!--       提交按钮         -->
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button lay-submit lay-filter="*" class="layui-btn layui-btn layui-btn-sm">添加</button>
                    </div>
                </div>

            </form>
        </div>
        <script>
            layui.use('form', function () {
                let form = layui.form;
                form.on('submit(*)', function (data) {
                    // console.log(typeof data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                    $.ajax({
                        type: "post",
                        url: "http://localhost:8080/StudentScoreListServlet?method=AddStudentScore",
                        data: $("#Form").serialize(),
                        success: function (msg) {
                            if (msg === "success")
                                layer.msg('添加成功!');
                            else if (msg === "exist")
                                layer.msg('已存在该学生的科目成绩!');
                            else if (msg === "nonexistence")
                                layer.msg('不存在该学生!');
                            else if (msg === "error")
                                layer.msg('添加失败!');
                        }
                    })
                    return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
                })
            })
        </script>
    </body>
</html>