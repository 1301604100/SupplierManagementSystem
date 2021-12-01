<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>用户列表</title>
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
                            <option value="1">用户编码</option>
                            <option value="2">用户名</option>
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
            <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
        </script>

        <%--  表格  --%>
        <script>
            layui.use('table', function () {
                let table = layui.table;
                let tableIns = table.render({
                    elem: '#test',
                    method: 'get',
                    url: 'UserListServlet?method=getUserList&t=' + new Date().getTime(),
                    toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                    ,
                    title: '用户列表',
                    cols: [
                        [{
                            type: 'checkbox',
                            fixed: 'left'
                        }, {
                            field: 'userId',
                            title: 'ID',
                            width: 60,
                            fixed: 'left',
                            unresize: true,
                            sort: true,
                        }, {
                            field: 'userCode',
                            title: '用户编码',
                            width: 140,
                            sort: true,
                        }, {
                            field: 'userName',
                            title: '用户名',
                            width: 100,
                        }, {
                            field: 'userPassword',
                            title: '密码',
                            width: 130,
                        }, {
                            field: 'gender',
                            title: '性别',
                            width: 110,
                        }, {
                            field: 'birthday',
                            title: '出生日期',
                            width: 150,
                            sort: true,
                        }, {
                            field: 'phone',
                            title: '手机号码',
                            width: 150,
                        },{
                            field: 'address',
                            title: '地址',
                            width: 150,
                        },{
                            field: 'userRole',
                            title: '用户类型',
                            width: 130,
                            templet:function (date){
                                let state;
                                if (date.userRole === '供应商') {
                                    state = `<span class='layui-badge layui-bg-green'>供应商</span>`
                                } else {
                                    state = `<span class='layui-badge layui-bg-blue'>系统管理员</span>`
                                }
                                return state;
                            },
                            sort: true,
                        },{
                            fixed: 'right',
                            title: '操作',
                            toolbar: '#barDemo',
                            width: 150,
                            id: 'UserTable'
                        }]
                    ],
                    page: true,
                    limit: 10
                });

                //头工具栏事件
                table.on('toolbar(test)', function (obj) {
                    let checkStatus = table.checkStatus(obj.config.id);
                    switch (obj.event) {
                        //----------------------添加---------------------------------------------------
                        case 'add':
                            let index = layer.open({
                                type: 2,
                                content: '${pageContext.request.contextPath}/view/admin/addUser.jsp',
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
                                area: ['420px', '550px'] //宽高
                            });
                            break;
                        //----------------------删除---------------------------------------------------
                        case 'delete': {
                            let data = checkStatus.data;
                            if (data == null || data.length === 0)
                                layer.msg('请选择数据进行删除!');
                            else {
                                layer.confirm('将删除用户的信息(用户有其他相关信息则无法删除)，确认继续？', {
                                        btn: ['确定', '取消']
                                    }, function () {
                                        let userIdArr = [];
                                        for (let i = 0; i < data.length; i++) {
                                            userIdArr[i] = data[i].userId;
                                        }
                                        $.ajax({
                                            type: "get",
                                            url: "UserListServlet?method=DeleteUser",
                                            data: {
                                                userId: JSON.stringify(userIdArr)
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
                                url: "UserListServlet?method=SearchUser&type=" + type + "&text=" + text,
                                page: {current: 1}
                            });
                            break;
                        //----------------------刷新---------------------------------------------------
                        case 'refresh':
                            //重新刷新页面数据
                            tableIns.reload({
                                url: 'UserListServlet?method=getUserList',
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
                        layer.confirm('将删除用户的信息(用户有其他相关信息则无法删除)，确认继续？', function (index) {
                            layer.close(index);
                            //向服务端发送删除指令
                            $.ajax({
                                type: "get",
                                url: "UserListServlet?method=DeleteUser",
                                data: {
                                    userId: JSON.stringify(data.userId)
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
                    //----------------------编辑---------------------------------------------------
                    else if (obj.event === 'edit') {
                        let str = 'userCode=' + data.userCode + '&account=' + data.userName + '&password=' + data.userPassword +
                                  '&gender=' + data.gender + '&userId=' + data.userId + '&birthday=' + data.birthday +
                                  '&phone=' + data.phone + '&address=' + data.address  + '&userRole=' + data.userRole;
                        let index = layer.open({
                            type: 2,
                            content: '${pageContext.request.contextPath}/view/admin/editUser.jsp?' + str,
                            title: '修改',
                            cancel: function () {
                                //重新刷新页面数据
                                tableIns.reload({
                                    page: {current: 1}
                                });
                                layer.close(index);
                                return false;
                            },
                            skin: 'layui-layer-rim', //加上边框
                            area: ['420px', '550px'] //宽高
                        });
                    }
                });
            });
        </script>

    </body>

</html>