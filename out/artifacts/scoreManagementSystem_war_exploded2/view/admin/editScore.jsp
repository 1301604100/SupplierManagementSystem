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
                <!--        学号        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 50px">学号:</label>
                    <div class="layui-input-block">
                        <input id="edit_number" type="number" name="number" autocomplete="off"
                               class="layui-input" style="width: 200px" disabled="disabled">
                    </div>
                </div>
                <!--        姓名        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 50px">姓名:</label>
                    <div class="layui-input-block">
                        <input id="edit_name" type="text" name="name" autocomplete="off"
                               class="layui-input" style="width: 200px" disabled="disabled">
                    </div>
                </div>
                <!--        科目        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 50px">科目:</label>
                    <div class="layui-input-block">
                        <input id="edit_course" type="text" name="course" autocomplete="off"
                               class="layui-input" style="width: 200px" disabled="disabled">
                    </div>
                </div>
                <!--        成绩        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 50px">成绩:</label>
                    <div class="layui-input-block">
                        <input id="edit_score" type="number" name="score" placeholder="请输入成绩" autocomplete="off"
                               class="layui-input" style="width: 200px" lay-verify="required">
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
            layui.use('form', function () {
                let form = layui.form;
                // 填入数据
                function setData() {
                    $('#edit_id').val(UrlParm.parm("id"))
                    $('#edit_number').val(UrlParm.parm("number"))
                    $('#edit_name').val(UrlParm.parm("name"))
                    $('#edit_course').val(UrlParm.parm("courseName"))
                    $('#edit_score').val(UrlParm.parm("score"))
                    form.render()
                }
                // 先填入数据
                setData();
                form.on('submit(*)', function (data) {
                    // console.log(typeof data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                    $.ajax({
                        type: "post",
                        url: "http://localhost:8080/StudentScoreListServlet?method=EditScore",
                        data: $("#Form").serialize(),
                        success: function (msg) {
                            if (msg === "success")
                                layer.msg('修改成功!');
                        }
                    })
                    return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
                })
            })
        </script>
    </body>
</html>