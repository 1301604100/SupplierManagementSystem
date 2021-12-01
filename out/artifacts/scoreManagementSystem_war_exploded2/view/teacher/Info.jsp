<%@ page import="com.sys.model.Student" %>
<%@ page import="com.sys.model.Teacher" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Info</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/system.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
        <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
        <style>
            body {
                background-color: #F2F2F2;
            }

            .layui-form-item {
                margin-top: 20px;
            }

            .layui-card-body {
                position: relative;
                height: 530px;
            }
        </style>
    </head>
    <body>
        <div class="layui-fluid">
            <div class="layui-row layui-col-space15">
                <div class="layui-col-md12" style="margin-top: 20px">
                    <div class="layui-card">
                        <div class="layui-card-header" style="height: 52px; padding: 0">
                            <blockquote class="layui-elem-quote">我的资料</blockquote>
                        </div>
                        <div class="layui-card-body">
                            <form id="Form" method="post" name="from" class="layui-form layui-form-pane"
                                  lay-filter="formData" style="width: 200px; margin-left: 50px;">
                                <!--        学号        -->
                                <div class="layui-form-item " pane>
                                    <label class="layui-form-label">学号:</label>
                                    <div class="layui-input-block">
                                        <input id="number" type="number" name="number" placeholder="请输入学号"
                                               autocomplete="off"
                                               class="layui-input layui-font-gray" style="width: 200px" disabled>
                                    </div>
                                </div>
                                <!--        姓名        -->
                                <div class="layui-form-item">
                                    <label class="layui-form-label">姓名:</label>
                                    <div class="layui-input-block">
                                        <input id="Name" type="text" name="name" placeholder="请输入姓名"
                                               autocomplete="off"
                                               class="layui-input layui-font-gray" style="width: 200px" disabled>
                                    </div>
                                </div>
                                <!--        性别        -->
                                <div class="layui-form-item">
                                    <label class="layui-form-label">性别:</label>
                                    <div class="layui-input-block" style="width: 200px">
                                        <select name="sex" disabled class="layui-font-gray">
                                            <option value="">选择性别</option>
                                            <option value="男">男</option>
                                            <option value="女">女</option>
                                        </select>
                                    </div>
                                </div>
                                <!--        手机        -->
                                <div class="layui-form-item">
                                    <label class="layui-form-label">手机:</label>
                                    <div class="layui-input-block">
                                        <input id="phone" type="number" name="phone" placeholder="请输入手机号"
                                               autocomplete="off"
                                               class="layui-input" style="width: 200px" lay-verify="required|phone">
                                    </div>
                                </div>
                                <!--        qq        -->
                                <div class="layui-form-item">
                                    <label class="layui-form-label">qq:</label>
                                    <div class="layui-input-block">
                                        <input id="qq" type="number" name="qq" placeholder="请输入qq"
                                               autocomplete="off"
                                               class="layui-input" style="width: 200px" lay-verify="required">
                                    </div>
                                </div>
                                <!--        年级        -->
                                <div class="layui-form-item">
                                    <label class="layui-form-label">授课年级:</label>
                                    <div class="layui-input-block">
                                        <input id="grade" type="text" name="grade" autocomplete="off"
                                               class="layui-input  layui-font-gray" style="width: 200px" disabled>
                                    </div>
                                </div>
                                <!--        班级        -->
                                <div class="layui-form-item">
                                    <label class="layui-form-label">授课班级:</label>
                                    <div class="layui-input-block">
                                        <input id="clazz" type="text" name="clazz" autocomplete="off"
                                               class="layui-input layui-font-gray" style="width: 200px" disabled>
                                    </div>
                                </div>
                                <!--        课程        -->
                                <div class="layui-form-item">
                                    <label class="layui-form-label">授课课程:</label>
                                    <div class="layui-input-block">
                                        <input id="course" type="text" name="course" autocomplete="off"
                                               class="layui-input layui-font-gray" style="width: 200px" disabled>
                                    </div>
                                </div>
                                <!--       提交按钮         -->
                                <div class="layui-form-item">
                                    <div class="layui-input-block">
                                        <button lay-submit lay-filter="*" class="layui-btn">确认修改</button>
                                    </div>
                                </div>
                            </form>
                            <div class="layui-upload"
                                 style="width: 300px; height: 400px; margin: 20px 120px 0 0; position: absolute; right: 50px; top: 100px;">

                                <div class="layui-upload-list">
                                    <img class="layui-upload-img" id="demo1" src="PhotoServlet?method=GetPhoto"
                                         style="width: 258px; height: 164px">
                                    <p id="demoText"></p>
                                </div>

                                <button type="button" class="layui-btn" id="test1"
                                        style="margin-bottom: 20px; width: 258px">
                                    <i class="layui-icon">&#xe67c;</i>上传图片
                                </button>

                                <div style="width: 258px;">
                                    <div class="layui-progress layui-progress-big" lay-showpercent="yes"
                                         lay-filter="demo">
                                        <div class="layui-progress-bar" lay-percent=""></div>
                                    </div>
                                </div>
                            </div>
                            <a name="list-progress"> </a>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <script>
            let form = layui.form;
            <%Teacher teacher = (Teacher) request.getSession().getAttribute("teacher");%>

            function setData() {
                form.val("formData", {
                    "number": "<%=teacher.getNumber()%>" // "name": "value"
                    , "name": "<%=teacher.getTeacherName()%>"
                    , "sex": "<%=teacher.getSex()%>"
                    , "phone": "<%=teacher.getPhone()  == null? "无": teacher.getPhone()%>"
                    , "qq": "<%=teacher.getQq() == null? "无": teacher.getQq()%>"
                    , "clazz": "<%= teacher.getClazzName() == null? "无": teacher.getClazzName()%>"
                    , "grade": "<%=teacher.getGradeName() == null? "无": teacher.getGradeName()%>"
                    , "course": "<%=teacher.getCourse() == null? "无": teacher.getCourse()%>"
                });
            }

            setData();
            layui.use('form', function () {
                form.on('submit(*)', function (data) {
                    // console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                    $.ajax({
                        type: "post",
                        url: "TeacherServlet?method=EditTeacher",
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
                })
            })
            layui.use(['upload', 'element', 'layer'], function () {
                let $ = layui.jquery
                    , upload = layui.upload
                    , element = layui.element
                    , layer = layui.layer;

                //常规使用 - 普通图片上传
                let uploadInst = upload.render({
                    elem: '#test1'
                    , url: 'PhotoServlet?method=SetPhoto' //改成您自己的上传接口
                    , before: function (obj) {
                        //预读本地文件示例，不支持ie8
                        obj.preview(function (index, file, result) {
                            $('#demo1').attr('src', result); //图片链接（base64）
                        });

                        element.progress('demo', '0%'); //进度条复位
                        layer.msg('上传中', {icon: 16, time: 0});
                    }
                    , done: function (res) {
                        //如果上传失败
                        if (res.code > 0) {
                            return layer.msg('上传失败');
                        }
                        //上传成功的一些操作
                        //……
                        $('#demoText').html(''); //置空上传失败的状态
                    }
                    , error: function () {
                        //演示失败状态，并实现重传
                        var demoText = $('#demoText');
                        demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                        demoText.find('.demo-reload').on('click', function () {
                            uploadInst.upload();
                        });
                    }
                    //进度条
                    , progress: function (n, index, e) {
                        element.progress('demo', n + '%'); //可配合 layui 进度条元素使用
                        if (n == 100) {
                            layer.msg('上传完毕', {icon: 1});
                        }
                    }
                });
            })
        </script>
    </body>
</html>