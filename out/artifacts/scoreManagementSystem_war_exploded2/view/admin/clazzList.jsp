<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>班级列表</title>
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
        <!-- 头工具栏 -->
        <script type="text/html" id="toolbarDemo">
            <div class="layui-form layui-form-item">
                <button class="layui-btn layui-btn-sm" lay-event="add">添加</button>
                <button class="layui-btn layui-btn-sm" lay-event="delete">删除</button>
                <div class="layui-inline">
                    <div class="layui-input-inline select" style="width: 127px">
                        <select name="type" lay-verify="required" style="width: 50px;" id="type">
                            <option value="">选择搜索类型</option>
                            <option value="1">年级</option>
                            <option value="2">班级</option>
                        </select>
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
                    url: 'ClazzServlet?method=getClazzList&t=' + new Date().getTime(),
                    toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                    ,
                    title: '班级列表',
                    cols: [
                        [{
                            type: 'checkbox',
                            fixed: 'left'
                        }, {
                            field: 'clazzId',
                            title: 'ID',
                            width: 80,
                            fixed: 'left',
                            unresize: true,
                            sort: true
                        }, {
                            field: 'gradeName',
                            title: '年级',
                            width: 120,
                            sort: true
                        }, {
                            field: 'clazzName',
                            title: '班级',
                            width: 150,
                            sort: true
                        }, {
                            fixed: 'right',
                            title: '操作',
                            toolbar: '#barDemo',
                            width: 150,
                            id: 'clazzTable'
                        }]
                    ],
                    page: true,
                    limit: 10
                });

                //头工具栏事件
                table.on('toolbar(test)', function (obj) {
                    let checkStatus = table.checkStatus(obj.config.id);
                    switch (obj.event) {
                        //----------------------add---------------------------------------------------
                        case 'add':
                            let index = layer.open({
                                type: 1,
                                content: '<div id="addDialog" style="padding: 10px">\n' +
                                    '            <form id="addForm" method="post" name="from_" class="layui-form">\n' +
                                    '                <div class="layui-form-item" style="margin: 20px 0 20px 0">\n' +
                                    '                    <label class="layui-form-label" style="width: 50px">年级:</label>\n' +
                                    '                    <div class="layui-input-block">\n' +
                                    '                        <input id="add_grade" type="number" name="grade" placeholder="请输入年级" autocomplete="off" class="layui-input" style="width: 200px">\n' +
                                    '                    </div>\n' +
                                    '                </div>\n' +
                                    '                <div class="layui-form-item">\n' +
                                    '                    <label class="layui-form-label" style="width: 50px">班级:</label>\n' +
                                    '                    <div class="layui-input-block">\n' +
                                    '                        <input id="add_clazz" type="number" name="clazz" placeholder="请输入班级" autocomplete="off" class="layui-input" style="width: 200px">\n' +
                                    '                    </div>\n' +
                                    '                </div>\n' +
                                    '            </form>\n' +
                                    '        </div>',
                                title: '添加班级',
                                btn: ['添加'],
                                yes: function () {
                                    let grade = from_.grade.value;
                                    let clazz = from_.clazz.value;
                                    if (!grade || !clazz) {
                                        layer.msg('请检查你输入的数据!');
                                    } else {
                                        $.ajax({
                                            type: "post",
                                            url: "ClazzServlet?method=AddClazz",
                                            data: $("#addForm").serialize(),
                                            success: function (msg) {
                                                if (msg === "success") {
                                                    layer.msg('添加成功!');
                                                    //关闭窗口
                                                    layer.close(index);
                                                    //重新刷新页面数据
                                                    tableIns.reload({
                                                        page: {current: 1}
                                                    });

                                                } else if (msg === "exist") {
                                                    layer.msg('已存在该班级!');
                                                }
                                            }
                                        })
                                    }
                                },
                                skin: 'layui-layer-rim', //加上边框
                                area: ['420px', '250px'] //宽高
                            });
                            break;
                        //----------------------delete---------------------------------------------------
                        case 'delete':
                            let data = checkStatus.data;
                            if (data == null || data.length === 0)
                                layer.msg('请选择数据进行删除!');
                            else {
                                layer.confirm('将删除班级(班级里有学生、教师等则无法删除)，确认继续？', {
                                        btn: ['确定', '取消']
                                    }, function () {
                                        let clazzIdArr = [];
                                        for (let i = 0; i < data.length; i++) {
                                            clazzIdArr[i] = data[i].clazzId;
                                        }
                                        $.ajax({
                                            type: "get",
                                            url: "ClazzServlet?method=DeleteClazz",
                                            data: {
                                                clazzId: JSON.stringify(clazzIdArr)
                                            },
                                            success: function (msg) {
                                                if (msg === "success") {
                                                    layer.msg('删除成功!');
                                                    //刷新表格
                                                    // table.reload('clazzTable', {
                                                    //     url: 'ClazzServlet?method=getClazzList&t=' + new Date().getTime()
                                                    // })
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
                                url: "ClazzServlet?method=searchClazz&type=" + type + "&text=" + text,
                                page: {current: 1}
                            });
                            break;
                        //----------------------刷新---------------------------------------------------
                        case 'refresh':
                            //重新刷新页面数据
                            tableIns.reload({
                                url: 'ClazzServlet?method=getClazzList',
                                page: {current: 1}
                            });
                            break;
                    }
                });

                //监听行工具事件
                table.on('tool(test)', function (obj) {
                    let data = obj.data;
                    //----------------------delete---------------------------------------------------
                    if (obj.event === 'del') {
                        layer.confirm('真的删除行么', function (index) {
                            layer.close(index);
                            //向服务端发送删除指令
                            $.ajax({
                                type: "get",
                                url: "ClazzServlet?method=DeleteClazz",
                                data: {
                                    clazzId: JSON.stringify(data.clazzId)
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
                    //----------------------edit---------------------------------------------------
                    else if (obj.event === 'edit') {
                        let index = layer.open({
                            type: 1,
                            content: '<div id="" style="padding: 10px">\n' +
                                '         <form id="editForm" method="post" name="from_e" class="layui-form">\n' +
                                '              <input id = "edit_clazzId" type="hidden" name="clazzId" class="edit_id" value="1">\n' +
                                '              <div class="layui-form-item" style="margin: 20px 0 20px 0">\n' +
                                '                  <label class="layui-form-label" style="width: 50px">年级:</label>\n' +
                                '                  <div class="layui-input-block">\n' +
                                '                     <input id="edit_grade" type="number" name="grade_e" placeholder="请输入年级" autocomplete="off" class="layui-input" style="width: 200px"  autofocus="autofocus">\n' +
                                '                  </div>\n' +
                                '              </div>\n' +
                                '              <div class="layui-form-item">\n' +
                                '                  <label class="layui-form-label" style="width: 50px">班级:</label>\n' +
                                '                  <div class="layui-input-block">\n' +
                                '                     <input id="edit_clazz" type="number" name="clazz_e" placeholder="请输入班级" autocomplete="off" class="layui-input" style="width: 200px">\n' +
                                '                  </div>\n' +
                                '              </div>\n' +
                                '          </form>\n' +
                                '      </div>',
                            title: '编辑页面',
                            btn: ['修改'],
                            yes: function () {
                                from_e.clazzId.value = data.clazzId;
                                let grade = from_e.grade_e.value;
                                let clazz = from_e.clazz_e.value;
                                if (!grade || !clazz) {
                                    layer.msg('请检查你输入的数据!');
                                } else {
                                    $.ajax({
                                        type: "post",
                                        url: "ClazzServlet?method=EditClazz",
                                        data: $("#editForm").serialize(),
                                        success: function (msg) {
                                            if (msg === "success") {
                                                layer.msg('修改成功!');
                                                //关闭窗口
                                                layer.close(index);
                                                //重新刷新页面数据
                                                tableIns.reload({
                                                    page: {current: 1}
                                                });
                                            } else if (msg === "exist") {
                                                layer.msg('已存在，修改失败!');
                                            }
                                        }
                                    })
                                }
                            },
                            skin: 'layui-layer-rim', //加上边框
                            area: ['420px', '250px'] //宽高
                        });
                        // layer.prompt({
                        //     formType: 2,
                        //     value: data.email
                        // }, function (value, index) {
                        //     obj.update({
                        //         email: value
                        //     });
                        //     layer.close(index);
                        // });
                    }
                });
            });
        </script>

    </body>

</html>