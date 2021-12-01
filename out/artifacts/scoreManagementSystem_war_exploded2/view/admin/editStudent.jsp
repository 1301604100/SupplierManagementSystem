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
                        <input id="edit_number" type="number" name="number" placeholder="请输入学号" autocomplete="off"
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
                <!--        性别        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 50px; margin: 0" >性别:</label>
                    <div class="layui-input-block" style="width: 200px">
                        <input type="radio" name="sex" value="男" title="男">
                        <input type="radio" name="sex" value="女" title="女">
                    </div>
                </div>
                <!--        手机        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 50px">手机:</label>
                    <div class="layui-input-block">
                        <input id="edit_phone" type="number" name="phone" placeholder="请输入手机号" autocomplete="off"
                               class="layui-input" style="width: 200px" lay-verify="required|phone">
                    </div>
                </div>
                <!--        qq        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 50px">qq:</label>
                    <div class="layui-input-block">
                        <input id="edit_qq" type="number" name="qq" placeholder="请输入qq" autocomplete="off"
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
                    let i = UrlParm.parm("sex") == '男'? 0:1;
                    $('input:radio').eq(i).attr('checked', 'true');
                    $('#edit_phone').val(UrlParm.parm("phone"))
                    $('#edit_qq').val(UrlParm.parm("qq"))
                    form.render()
                }
                // 先填入数据
                setData();
                form.on('submit(*)', function (data) {
                    // console.log(typeof data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                    $.ajax({
                        type: "post",
                        url: "http://localhost:8080/StudentListServlet?method=EditStudent",
                        data: $("#Form").serialize(),
                        success: function (msg) {
                            if (msg === "success") {
                                layer.msg('修改成功!');
                            } else if (msg === "exist") {
                                layer.msg('已存在该学号!,修改失败');
                            }
                        }
                    })
                    return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
                })
            })
        </script>
    </body>
</html>