<%@ page import="com.sys.model.Student" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>studentInfo</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/system.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
        <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
        <style>
            body {
                background-color: #F2F2F2;
            }

            /*button {*/
            /*    float: right;*/
            /*    right: -30px;*/
            /*}*/

            .layui-form-item {
                margin-top: 20px;
            }

            .layui-card-body {
                position: relative;
                height: 520px;
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
                                  lay-filter="formData" style="width: 200px; margin-left: 50px">
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
                                    <label class="layui-form-label">年级:</label>
                                    <div class="layui-input-block">
                                        <input id="grade" type="text" name="grade" autocomplete="off"
                                               class="layui-input layui-font-gray" style="width: 200px" disabled>
                                    </div>
                                </div>
                                <!--        班级        -->
                                <div class="layui-form-item">
                                    <label class="layui-form-label">班级:</label>
                                    <div class="layui-input-block">
                                        <input id="clazz" type="text" name="clazz" autocomplete="off"
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
            <%Student student = (Student) request.getSession().getAttribute("student");%>

            function setData() {
                form.val("formData", {
                    "number": "<%=student.getNumber()%>" // "name": "value"
                    , "name": "<%=student.getStudentName()%>"
                    , "sex": "<%=student.getSex()%>"
                    , "phone": "<%=student.getPhone() == null? "无": student.getPhone()%>"
                    , "qq": "<%=student.getQq() == null? "无": student.getQq()%>"
                    , "clazz": "<%=student.getClazzName() == null? "无": student.getClazzName()%>"
                    , "grade": "<%=student.getGradeName() == null? "无": student.getGradeName()%>"
                });
                // $.ajax({
                //     type: "get",
                //     url: "http://localhost:8080/StudentServlet?method=GetStudent",
                //     success: function () {
                //
                //     }
                // })
            }

            setData();
            layui.use('form', function () {
                form.on('submit(*)', function (data) {
                    // console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                    $.ajax({
                        type: "post",
                        url: "StudentServlet?method=EditStudent",
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
            //http://localhost:8080/
            layui.use(['upload', 'element', 'layer'], function () {
                var $ = layui.jquery
                    , upload = layui.upload
                    , element = layui.element
                    , layer = layui.layer;

                //常规使用 - 普通图片上传
                var uploadInst = upload.render({
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
            // layui.use('upload', function () {
            //     let upload = layui.upload;
            //     $('#demo1').attr("src", "")
            //     //执行实例
            //     let uploadInst = upload.render({
            //         elem: '#test1' //绑定元素
            //         , url: 'PhotoServlet?method=SetPhoto' //上传接口
            //         ,progress: function(n, elem, res, index) {
            //             let percent = n + '%' //获取进度百分比
            //             element.progress('demo', percent); //可配合 layui 进度条元素使用
            //
            //             console.log(elem); //得到当前触发的元素 DOM 对象。可通过该元素定义的属性值匹配到对应的进度条。
            //             console.log(res); //得到 progress 响应信息
            //             console.log(index); //得到当前上传文件的索引，多文件上传时的进度条控制，如：
            //             element.progress('demo-' + index, n + '%');//进度条
            //         }
            //         , done: function (res) {
            //             //上传完毕回调
            //             layer.msg("上传成功");
            //         }
            //         , error: function () {
            //             //请求异常回调
            //             layer.msg("上传失败");
            //         }
            //     });
            // });
        </script>
    </body>
</html>