<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/11/30
  Time: 20:04
  To change this template use File | Settings | File Templates.
--%>
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
            label{
                width: 130px;
            }
        </style>
    </head>
    <body>
        <div id="Dialog" style="padding: 10px">
            <form id="Form" method="post" name="from" class="layui-form">
                <!--        ID        -->
                <input id="id" type="hidden" name="id">
                <!--        供应商编号        -->
                <div class="layui-form-item">
                    <label class="layui-form-label">供应商编号:</label>
                    <div class="layui-input-block">
                        <input id="proCode" type="text" name="proCode" placeholder="请输入供应商编号" autocomplete="off"
                               class="layui-input" style="width: 200px" lay-verify="required" disabled>
                    </div>
                </div>
                <!--        供应商名        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" >供应商名:</label>
                    <div class="layui-input-block">
                        <input id="proName" type="text" name="proName" placeholder="请输入供应商名" autocomplete="off"
                               class="layui-input" style="width: 200px" lay-verify="required">
                    </div>
                </div>
                <!--        供应商描述        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" >供应商描述:</label>
                    <div class="layui-input-block" style="width: 200px">
                        <select name="proDesc" lay-verify="required" id="proDesc">
                            <option value="">选择合作关系</option>
                            <option value="初次合作伙伴">初次合作伙伴</option>
                            <option value="长期合作伙伴">长期合作伙伴</option>
                        </select>
                    </div>
                </div>
                <!--        供应商联系人        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 100px">供应商联系人:</label>
                    <div class="layui-input-block">
                        <input id="proContact" type="text" name="proContact" placeholder="请输入供应商联系人" autocomplete="off"
                               class="layui-input" style="width: 200px" lay-verify="required" >
                    </div>
                </div>
                <!--        供应商电话        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" >供应商电话:</label>
                    <div class="layui-input-block">
                        <input id="proPhone" type="number" name="proPhone" placeholder="请输入供应商电话" autocomplete="off"
                               class="layui-input" style="width: 200px" lay-verify="required" >
                    </div>
                </div>
                <!--        供应商地址        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" >供应商地址:</label>
                    <div class="layui-input-block">
                        <input id="proAddress" type="text" name="proAddress" placeholder="请输入供应商地址" autocomplete="off"
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
            // 填入数据
            function setData() {
                $('#id').val(UrlParm.parm("id"))
                $('#proCode').val(UrlParm.parm("proCode"))
                $('#proName').val(UrlParm.parm("proName"))
                $('#proDesc').val(UrlParm.parm("proDesc"))
                $('#proContact').val(UrlParm.parm("proContact"))
                $('#proPhone').val(UrlParm.parm("proPhone"))
                $('#proAddress').val(UrlParm.parm("proAddress"))
            }

            // 先填入数据
            setData();
            layui.use('form', function () {
                let form = layui.form;
                form.on('submit(*)', function (data) {
                    // console.log(typeof data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                    $.ajax({
                        type: "post",
                        url: "http://localhost:8080/SupplierManagement/ProviderListServlet?method=EditProvider",
                        data: $("#Form").serialize(),
                        success: function (msg) {
                            if (msg === "success") {
                                layer.msg('修改成功!');
                            } else if (msg === "exist") {
                                layer.msg('已存在该供应商，修改失败!');
                            }
                        }
                    })
                    return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
                })
            })
        </script>
    </body>
</html>
