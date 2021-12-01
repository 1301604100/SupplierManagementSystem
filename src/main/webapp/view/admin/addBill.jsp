<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/11/30
  Time: 13:16
  To change this template use File | Settings | File Templates.
--%>
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
        <style>
            #addDialog {
                width: 380px;
            }

            .right {
                float: right;
                right: -30px;
            }

            #addButton {
                margin-left: 100px;
            }
        </style>
    </head>
    <body>
        <div id="addDialog" style="padding: 10px">
            <form id="addForm" method="post" name="from_" class="layui-form" lay-filter="formTest">

                <!--        商品名称        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 70px">商品名称:</label>
                    <div class="layui-input-block" style="width: 200px">
                        <select name="productName" lay-verify="required" lay-filter="productName">
                            <option value="">选择商品</option>
                            <option value="iPhone13 pro max">iPhone13 pro max</option>
                            <option value="XiaoMi 11 Ultra">XiaoMi 11 Ultra</option>
                            <option value="OPPO Reno7">OPPO Reno7</option>
                            <option value="vivo X70">vivo X70</option>
                            <option value="Galaxy Z">Galaxy Z</option>
                            <option value="华为 P50 Pro">华为 P50 Pro</option>
                            <option value="k40 Pro">k40 Pro</option>
                            <option value="iQOO 8">iQOO 8</option>
                        </select>
                    </div>
                </div>
                <!--        商品数量        -->
                <div class="layui-form-item">

                    <label class="layui-form-label" style="width: 70px">商品数量:</label>
                    <div class="layui-input-block">
                        <input id="add_productCount" type="number" name="productCount" placeholder="请输入商品数量"
                               autocomplete="off"
                               class="layui-input" style="width: 200px;" lay-verify="required" value="0">
                    </div>
                </div>
                <!--        商品单价        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 70px">商品单价:</label>
                    <div class="layui-input-block">
                        <input id="add_unitPrice" type="number" name="unitPrice" autocomplete="off"
                               class="layui-input" style="width: 200px" lay-verify="required" disabled value="0">
                    </div>
                </div>
                <!--        订单金额        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 70px">订单金额:</label>
                    <div class="layui-input-block">
                        <input id="add_totalPrice" type="number" name="totalPrice" autocomplete="off"
                               class="layui-input" style="width: 200px" lay-verify="required" disabled value="0">
                    </div>
                </div>
                <!--        供应商        -->
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 70px">供应商:</label>
                    <div class="layui-input-block">
                        <input id="add_provider" type="text" name="provider" autocomplete="off"
                               class="layui-input" style="width: 200px" lay-verify="required" disabled>
                    </div>
                </div>

                <!--       提交按钮         -->
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button lay-submit lay-filter="*" class="layui-btn layui-btn layui-btn-sm right">添加</button>
                    </div>
                </div>

            </form>
        </div>
        <script>

            let product = {
                'iPhone13 pro max': {'unitPrice': 120, 'provider': 'Apple'},
                'XiaoMi 11 Ultra': {'unitPrice': 100, 'provider': 'XiaoMi'},
                'OPPO Reno7': {'unitPrice': 200, 'provider': 'OPPO'},
                'vivo X70': {'unitPrice': 50, 'provider': 'vivo'},
                'Galaxy Z': {'unitPrice': 200, 'provider': 'Samsung'},
                'HUAWEI P50 Pro': {'unitPrice': 300, 'provider': 'HUAWEI'},
                'k40 Pro': {'unitPrice': 400, 'provider': 'Redmi'},
                'iQOO 8': {'unitPrice': 600, 'provider': 'iQOO'}
            };

            // // 数量变化
            $('#add_productCount').on('input', function (e) {
                let count = e.delegateTarget.value;
                let unitPrice = $('#add_unitPrice').val();
                form.val("formTest", {
                    'totalPrice':count * unitPrice
                });
            });

            var form;
            layui.use('laydate', function () {
                form = layui.form;

                // 商品选择下拉框
                form.on('select(productName)', function (data) {
                    form.val("formTest", {
                        'provider': product[data.value]['provider'],
                        'unitPrice': product[data.value]['unitPrice']
                    });
                });
                var laydate = layui.laydate;
                //执行一个laydate实例
                laydate.render({
                    elem: '#add_birthday' //指定元素
                });
            });
            layui.use('form', function () {
                let form = layui.form;
                form.on('submit(*)', function (data) {
                    // console.log(typeof data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                    $.ajax({
                        type: "post",
                        url: "http://localhost:8080/SupplierManagement/BillListServlet?method=AddBill",
                        data: data.field,
                        success: function (msg) {
                            if (msg === "success") {
                                layer.msg('添加成功!');
                                //关闭窗口
                                //layer.close(index);
                            }
                        }
                    })
                    return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
                })
            })

            function getData() {
                return $("#addForm").serialize();
            }
        </script>
    </body>
</html>
