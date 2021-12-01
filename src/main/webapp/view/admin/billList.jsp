<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/11/29
  Time: 15:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>订单列表</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
        <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
        <style>
            * {
                margin: 0;
                padding: 0;
            }

            .layui-form-item {
                margin-bottom: 0;
            }

            .select {
                margin-left: 50px;
            }

            .layui-form .layui-inline {
                margin: 0;
            }

            .searchBtn {
                left: 100px;
            }

        </style>
    </head>

    <body>
        <%--  数据列表  --%>
        <table class="layui-hide" id="test" lay-filter="test"></table>
        <!-- 头部工具栏 -->
        <script type="text/html" id="toolbarDemo">
            <div class="layui-form layui-form-item">
                <button class="layui-btn layui-btn-sm" lay-event="add">添加</button>
                <button class="layui-btn layui-btn-sm" lay-event="delete">删除</button>
                <div class="layui-inline">
                    <div class="layui-input-inline select" style="width: 127px">
                        <select name="type" lay-verify="required" style="width: 50px;" id="type">
                            <option value="">选择搜索类型</option>
                            <option value="billCode">订单编号</option>
                            <option value="productName">产品</option>
                            <option value="proName">供应商</option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <div class="layui-input-inline" style="width: 150px">
                        <input id="searchText" type="text" name="searchText" placeholder="请输入搜索内容" autocomplete="off"
                               class="layui-input" style="width: 150px" lay-verify="required">
                    </div>
                    <div class="layui-input-inline" style="" class="searchBtn">
                        <button class="layui-btn layui-btn-sm" lay-event="search" style="height: 38px">搜索</button>
                    </div>
                    <div class="layui-input-inline" style="" class="refreshBtn">
                        <button class="layui-btn layui-btn-sm" lay-event="refresh" style="height: 38px">刷新</button>
                    </div>
                </div>
            </div>
        </script>

        <%--  数据操作按钮  --%>
        <script type="text/html" id="barDemo">
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
        </script>

        <%--  表格  --%>
        <script>
            layui.use('table', function () {
                let table = layui.table;
                let tableIns = table.render({
                    elem: '#test',
                    method: 'get',
                    url: 'BillListServlet?method=getBillList&t=' + new Date().getTime(),
                    toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                    ,
                    title: '用户列表',
                    cols: [
                        [{
                            type: 'checkbox',
                            fixed: 'left'
                        }, {
                            field: 'billId',
                            title: 'ID',
                            width: 60,
                            fixed: 'left',
                            unresize: true,
                            sort: true,
                        }, {
                            field: 'billCode',
                            title: '订单编号',
                            width: 140,
                            sort: true,
                        }, {
                            field: 'productName',
                            title: '商品名称',
                            width: 150,
                        }, {
                            field: 'productCount',
                            title: '商品数量',
                            width: 100,
                        }, {
                            field: 'unitPrice',
                            title: '商品单价',
                            width: 100,
                        }, {
                            field: 'totalPrice',
                            title: '订单金额',
                            width: 110,
                        }, {
                            field: 'provider',
                            title: '供应商',
                            width: 120,
                            sort: true,
                        }, {
                            field: 'payment',
                            title: '是否付款',
                            templet: function (d) {
                                var state = "";
                                if (d.payment == "1") {
                                    state = "<input type='checkbox' value='" + d.billId + "' id='payment' lay-filter='payment' " +
                                        "checked='checked' name='payment'  lay-skin='switch' lay-text='已支付|未支付' >";
                                } else {
                                    state = "<input type='checkbox' value='" + d.billId + "' id='payment' lay-filter='payment'  " +
                                        "name='payment'  lay-skin='switch' lay-text='已支付|未支付' >";
                                }
                                return state;
                            },
                            width: 130,
                            sort: true
                        }, {
                            field: 'creationDate',
                            title: '创建时间',
                            width: 170,
                            sort: true
                        }, {
                            fixed: 'right',
                            title: '操作',
                            toolbar: '#barDemo',
                            width: 120,
                            id: 'UserTable'
                        }]
                    ],
                    page: true,
                    limit: 10
                });
                let form = layui.form;
                form.on('switch(payment)', function (data) {
                    // 得到开关的value值，实际是需要修改的ID值。
                    var id = data.value;
                    var isPayment = this.checked ? '1' : '0';
                    $.ajax({
                        type: 'get',
                        url: 'http://localhost:8080/SupplierManagement/BillListServlet?method=changePayment',
                        data: {"id": id, "isPayment": isPayment},
                        success: function (msg) {
                            if (msg === "success") {
                                layer.msg('操作成功！');
                            } else {
                                console.log(data);
                                layer.msg('数据异常，操作失败！');
                            }
                            layer.close(index);
                        },
                        dataType: 'JSON',
                    });
                });
                //头工具栏事件
                table.on('toolbar(test)', function (obj) {
                    let checkStatus = table.checkStatus(obj.config.id);
                    switch (obj.event) {
                        //----------------------添加---------------------------------------------------
                        case 'add':
                            let index = layer.open({
                                type: 2,
                                content: '${pageContext.request.contextPath}/view/admin/addBill.jsp',
                                cancel: function () {
                                    //重新刷新页面数据
                                    tableIns.reload({
                                        page: {current: 1}
                                    });
                                    layer.close(index);
                                    return false;
                                },
                                title: '添加用户',
                                skin: 'layui-layer-rim', //加上边框
                                area: ['420px', '400px'] //宽高
                            });
                            break;
                        //----------------------删除---------------------------------------------------
                        case 'delete': {
                            let data = checkStatus.data;
                            if (data == null || data.length === 0)
                                layer.msg('请选择数据进行删除!');
                            else {
                                layer.confirm('将删除订单信息，确认继续？', {
                                        btn: ['确定', '取消']
                                    }, function () {
                                        let IdArr = [];
                                        for (let i = 0; i < data.length; i++) {
                                            IdArr[i] = data[i].billId;
                                        }
                                        $.ajax({
                                            type: "get",
                                            url: "BillListServlet?method=DeleteBill",
                                            data: {
                                                billId: JSON.stringify(IdArr)
                                            },
                                            success: function (msg) {
                                                if (msg === "success") {
                                                    layer.msg('删除成功!');
                                                    //重新刷新页面数据
                                                    tableIns.reload({
                                                        page: {current: 1}
                                                    });
                                                } else
                                                    layer.msg('删除失败!');
                                            }
                                        });
                                    }, function () {

                                    },
                                )
                            }
                            break;
                        }
                        //----------------------搜索---------------------------------------------------
                        case 'search':
                            let type = $('#type').val();
                            let text = $('#searchText').val();
                            if (!type || !text) {
                                layer.msg("请检查搜索条件或内容");
                                return;
                            }
                            //重新刷新页面数据
                            tableIns.reload({
                                url: "BillListServlet?method=SearchBill&type=" + type + "&text=" + text,
                                page: {current: 1}
                            });
                            break;
                        //----------------------刷新---------------------------------------------------
                        case 'refresh':
                            //重新刷新页面数据
                            tableIns.reload({
                                url: 'BillListServlet?method=getBillList',
                                page: {current: 1}
                            });
                            break;
                    }
                });

                //监听行工具事件
                table.on('tool(test)', function (obj) {
                    let data = obj.data;
                    //----------------------删除---------------------------------------------------
                    if (obj.event === 'del') {
                        layer.confirm('将删除订单信息，确认继续？', function (index) {
                            layer.close(index);
                            //向服务端发送删除指令
                            $.ajax({
                                type: "get",
                                url: "BillListServlet?method=DeleteBill",
                                data: {
                                    billId: JSON.stringify(data.billId)
                                },
                                success: function (msg) {
                                    if (msg === "success") {
                                        layer.msg('删除成功!');
                                        obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                                        //重新刷新页面数据
                                        tableIns.reload({
                                            page: {current: 1}
                                        });
                                    } else
                                        layer.msg('删除失败!');
                                }
                            });

                        });
                    }
                });
            });
        </script>

    </body>

</html>
