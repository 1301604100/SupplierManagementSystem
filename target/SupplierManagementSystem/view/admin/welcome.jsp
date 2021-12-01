<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/5/10
  Time: 20:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="utf-8">
        <title>welcome</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport"
              content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">

        <script src="${pageContext.request.contextPath}/js/jquery.js"></script>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.5/css/layui.css" media="all">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/font-awesome-4.7.0/css/font-awesome.min.css"
              media="all">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layuimini.css?v=2.0.1" media="all">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/themes/default.css" media="all">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">

        <style>
            .welcome .layui-card {
                border: 1px solid #f2f2f2;
                border-radius: 5px;
            }

            .welcome .icon {
                margin-right: 10px;
                color: #1aa094;
            }

            .welcome .icon-cray {
                color: #ffb800 !important;
            }

            .welcome .icon-blue {
                color: #1e9fff !important;
            }

            .welcome .icon-tip {
                color: #ff5722 !important;
            }

            .welcome .layuimini-qiuck-module {
                text-align: center;
                margin-top: 10px
            }

            .welcome .layuimini-qiuck-module a i {
                display: inline-block;
                width: 100%;
                height: 60px;
                line-height: 60px;
                text-align: center;
                border-radius: 2px;
                font-size: 30px;
                background-color: #F8F8F8;
                color: #333;
                transition: all .3s;
                -webkit-transition: all .3s;
            }

            .welcome .layuimini-qiuck-module a cite {
                position: relative;
                top: 2px;
                display: block;
                color: #666;
                text-overflow: ellipsis;
                overflow: hidden;
                white-space: nowrap;
                font-size: 14px;
            }

            .welcome .welcome-module {
                width: 100%;
                height: 210px;
            }

            .welcome .panel {
                background-color: #fff;
                border: 1px solid transparent;
                border-radius: 3px;
                -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
                box-shadow: 0 1px 1px rgba(0, 0, 0, .05)
            }

            .welcome .panel-body {
                padding: 10px
            }

            .welcome .panel-title {
                margin-top: 0;
                margin-bottom: 0;
                font-size: 12px;
                color: inherit
            }

            .welcome .label {
                display: inline;
                padding: .2em .6em .3em;
                font-size: 75%;
                font-weight: 700;
                line-height: 1;
                color: #fff;
                text-align: center;
                white-space: nowrap;
                vertical-align: baseline;
                border-radius: .25em;
                margin-top: .3em;
            }

            .welcome .layui-red {
                color: red
            }

            .welcome .main_btn > p {
                height: 40px;
            }

            .welcome .layui-bg-number {
                background-color: #F8F8F8;
            }

            .welcome .layuimini-notice:hover {
                background: #f6f6f6;
            }

            .welcome .layuimini-notice {
                padding: 7px 16px;
                clear: both;
                font-size: 12px !important;
                cursor: pointer;
                position: relative;
                transition: background 0.2s ease-in-out;
            }

            .welcome .layuimini-notice-title, .layuimini-notice-label {
                padding-right: 70px !important;
                text-overflow: ellipsis !important;
                overflow: hidden !important;
                white-space: nowrap !important;
            }

            .welcome .layuimini-notice-title {
                line-height: 28px;
                font-size: 14px;
            }

            .welcome .layuimini-notice-extra {
                position: absolute;
                top: 50%;
                margin-top: -8px;
                right: 16px;
                display: inline-block;
                height: 16px;
                color: #999;
            }

            h1 {
                margin: 10px 1px;
            }

        </style>
    </head>

    <body>
        <div class="layuimini-container layuimini-page-anim">
            <div class="layuimini-main welcome">
                <div class="layui-row layui-col-space15">
                    <%--        数据统计        --%>
                    <div class="layui-col-md6">
                        <div class="layui-card">
                            <div class="layui-card-header"><i class="fa fa-warning icon"></i>数据统计</div>
                            <div class="layui-card-body">
                                <div class="welcome-module">
                                    <div class="layui-row layui-col-space10">
                                        <div class="layui-col-xs6">
                                            <div class="panel layui-bg-number">
                                                <div class="panel-body">
                                                    <div class="panel-title">
                                                        <span class="label pull-right layui-bg-blue">实时</span>
                                                        <h5>用户统计</h5>
                                                    </div>
                                                    <div class="panel-content">
                                                        <h1 class="no-margins" id="userCount"></h1>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs6">
                                            <div class="panel layui-bg-number">
                                                <div class="panel-body">
                                                    <div class="panel-title">
                                                        <span class="label pull-right layui-bg-cyan">实时</span>
                                                        <h5>供应商统计</h5>
                                                    </div>
                                                    <div class="panel-content">
                                                        <h1 class="no-margins" id="providerCount"></h1>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs6">
                                            <div class="panel layui-bg-number">
                                                <div class="panel-body">
                                                    <div class="panel-title">
                                                        <span class="label pull-right layui-bg-orange">实时</span>
                                                        <h5>订单统计</h5>
                                                    </div>
                                                    <div class="panel-content">
                                                        <h1 class="no-margins" id="billCount"></h1>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs6">
                                            <div class="panel layui-bg-number">
                                                <div class="panel-body">
                                                    <div class="panel-title">
                                                        <span class="label pull-right layui-bg-green">实时</span>
                                                        <h5>访问统计</h5>
                                                    </div>
                                                    <div class="panel-content">
                                                        <h1 class="no-margins" id="">10086</h1>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--        快捷入口        --%>
                    <div class="layui-col-md6">
                        <div class="layui-card">
                            <div class="layui-card-header"><i class="fa fa-credit-card icon icon-blue"></i>快捷入口
                            </div>
                            <div class="layui-card-body">
                                <div class="welcome-module">
                                    <div class="layui-row layui-col-space10 layuimini-qiuck">
                                        <div class="layui-col-xs6 layuimini-qiuck-module">
                                            <a href="javascript:void(0);"
                                               layuimini-content-href="${pageContext.request.contextPath}/view/admin/welcome.jsp"
                                               data-title="主页" data-icon="fa fa-shield">
                                                <i class="fa fa-home"></i>
                                                <cite>主页</cite>
                                            </a>
                                        </div>
                                        <div class="layui-col-xs6 layuimini-qiuck-module">
                                            <a href="javascript:void(0);" url="BillListServlet?method=toBillListView"
                                               data-title="订单管理" data-icon="fa fa-window-maximize">
                                                <i class="fa fa-bars"></i>
                                                <cite>订单管理</cite>
                                            </a>
                                        </div>
                                        <div class="layui-col-xs6 layuimini-qiuck-module">
                                            <a href="javascript:void(0);"
                                               url="ProviderListServlet?method=toProviderListView"
                                               data-title="供应商管理" data-icon="fa fa-gears">
                                                <i class="fa fa-weixin"></i>
                                                <cite>供应商管理</cite>
                                            </a>
                                        </div>
                                        <div class="layui-col-xs6 layuimini-qiuck-module">
                                            <a href="javascript:void(0);" url="UserListServlet?method=toUserListView"
                                               data-title="用户管理" data-icon="fa fa-file-text">
                                                <i class="fa fa-user"></i>
                                                <cite>用户管理</cite>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>

            <div class="layui-row layui-col-space15">
                <%--        版本        --%>
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-header"><i class="fa fa-fire icon"></i>版本信息</div>
                        <div class="layui-card-body layui-text">
                            <table class="layui-table">
                                <colgroup>
                                    <col width="100">
                                    <col>
                                </colgroup>
                                <tbody>
                                <tr>
                                    <td>系统名称</td>
                                    <td>
                                        供应商管理系统
                                    </td>
                                </tr>
                                <tr>
                                    <td>当前版本</td>
                                    <td>v1.0.0</td>
                                </tr>
                                <tr>
                                    <td>主要特色</td>
                                    <td>清爽 / 极简</td>
                                </tr>
                                <tr>
                                    <td>Gitee</td>
                                    <td style="padding-bottom: 0;">
                                        <div class="layui-btn-container">
                                            <a href="https://gitee.com/zhongshaofa/layuimini" target="_blank"
                                               style="margin-right: 15px"><img
                                                    src="https://gitee.com/zhongshaofa/layuimini/badge/star.svg?theme=dark"
                                                    alt="star"></a>
                                            <a href="https://gitee.com/zhongshaofa/layuimini"
                                               target="_blank"><img
                                                    src="https://gitee.com/zhongshaofa/layuimini/badge/fork.svg?theme=dark"
                                                    alt="fork"></a>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Github</td>
                                    <td style="padding-bottom: 0;">
                                        <div class="layui-btn-container">
                                            <iframe src="https://ghbtns.com/github-btn.html?user=zhongshaofa&repo=layuimini&type=star&count=true"
                                                    frameborder="0" scrolling="0" width="100px"
                                                    height="20px"></iframe>
                                            <iframe src="https://ghbtns.com/github-btn.html?user=zhongshaofa&repo=layuimini&type=fork&count=true"
                                                    frameborder="0" scrolling="0" width="100px"
                                                    height="20px"></iframe>
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>

            // 获取页数与数据总数
            $.ajax({
                url: "http://localhost:8080/SupplierManagement/getCountServlet?method=getCount",
                type: "post",
                // async: false,//此处需要注意的是要想获取ajax返回的值这个async属性必须设置成同步的，否则获取不到返回值
                data: '',
                dataType: "json",
                success: function (data) {
                    $('#userCount').text(data.userListTotal);
                    $('#providerCount').text(data.providerListTotal);
                    $('#billCount').text(data.billListTotal);
                }
            });


        </script>
    </body>

</html>