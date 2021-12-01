<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>成绩列表</title>
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

        <%--  表格  --%>
        <script>
            layui.use('table', function () {
                let table = layui.table;

                let tableIns = table.render({
                    elem: '#test',
                    method: 'get',
                    url: 'StudentServlet?method=getStudentScore&t=' + new Date().getTime(),
                    // toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                    // ,
                    title: '成绩列表',
                    cols: [
                        [{
                            type: 'checkbox',
                            fixed: 'left'
                        }, {
                            field: 'id',
                            title: 'ID',
                            width: 80,
                            fixed: 'left',
                            unresize: true,
                            sort: true,
                        }, {
                            field: 'number',
                            title: '学号',
                            width: 120,
                            sort: true
                        }, {
                            field: 'studentName',
                            title: '姓名',
                            width: 150,
                        }, {
                            field: 'gradeName',
                            title: '年级',
                            width: 150,
                        }, {
                            field: 'clazzName',
                            title: '班级',
                            width: 150,
                        }, {
                            field: 'courseName',
                            title: '科目',
                            width: 150,
                            totalRowText: '总分',
                        }, {
                            field: 'score',
                            title: '成绩',
                            width: 150,
                            sort: true,
                            totalRow: true
                        }]
                    ],
                    page: true,
                    limit: 10,
                    totalRow: true
                });

            })
        </script>

    </body>

</html>
