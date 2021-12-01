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
        <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
        <link rel="stylesheet" href="https://www.layui.com/layuiadmin/std/dist/layuiadmin/style/admin.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
        <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
        <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
        <script src="${pageContext.request.contextPath}/node_modules/echarts/dist/echarts.min.js"></script>

        <style>
            .layui-card-body, .layui-col-xs6 {
                background-color: #fff;
            }

            .layui-col-md6 {
                margin-top: 7.5px;
            }
        </style>
    </head>

    <body>

        <div class="layui-fluid">
            <div class="layui-row layui-col-space15">
                <div class="layui-col-md12">
                    <div class="layui-row layui-col-space15">
                        <div class="layui-col-md6">
                            <div class="layui-card">
                                <div class="layui-card-header">版本信息</div>
                                <div class="layui-card-body layui-text layadmin-version">
                                    <table class="layui-table">
                                        <colgroup>
                                            <col width="100">
                                            <col>
                                        </colgroup>
                                        <tbody>
                                        <tr>
                                            <td>系统名称</td>
                                            <td>
                                                Student information management system
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>当前版本</td>
                                            <td>
                                                v1.0
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>UI 框架</td>
                                            <td>
                                                layui
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>主要特色</td>
                                            <td>清爽 / 极简</td>
                                        </tr>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6">
                            <div class="layui-card">
                                <div class="layui-card-header">基本信息</div>
                                <div class="layui-card-body">
                                    <div class="layui-carousel layadmin-carousel layadmin-backlog">
                                        <div>
                                            <ul class="layui-row layui-col-space10">
                                                <li class="layui-col-xs6">
                                                    <a lay-href="" class="layadmin-backlog-body">
                                                        <h3>学生人数</h3>
                                                        <p><cite>70</cite></p>
                                                    </a>
                                                </li>
                                                <li class="layui-col-xs6">
                                                    <a lay-href="" class="layadmin-backlog-body">
                                                        <h3>教师人数</h3>
                                                        <p><cite>12</cite></p>
                                                    </a>
                                                </li>
                                                <li class="layui-col-xs6">
                                                    <a lay-href="" class="layadmin-backlog-body">
                                                        <h3>管理员数</h3>
                                                        <p><cite>1</cite></p>
                                                    </a>
                                                </li>
                                                <li class="layui-col-xs6">
                                                    <a href="javascript:;" onclick="layer.tips('不跳转', this, {tips: 3});" class="layadmin-backlog-body">
                                                        <h3>用户数</h3>
                                                        <p><cite>92</cite></p>
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md12">
                            <div class="layui-card">
                                <div class="layui-card-header">数据概览</div>
                                <div class="layui-card-body">
                                    <div id="echarts" style="width: 1280px;height:350px;"></div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            var chartDom = document.getElementById('echarts');
            var myChart = echarts.init(chartDom);
            var option;

            option = {
                color: ['#80FFA5', '#00DDFF', '#37A2FF', '#FF0087', '#FFBF00'],
                title: {
                },
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'cross',
                        label: {
                            backgroundColor: '#6a7985'
                        }
                    }
                },
                legend: {
                    data: ['Line 1', 'Line 2', 'Line 3', 'Line 4', 'Line 5']
                },
                toolbox: {
                    feature: {
                        saveAsImage: {}
                    }
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                },
                xAxis: [{
                    type: 'category',
                    boundaryGap: false,
                    data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日']
                }],
                yAxis: [{
                    type: 'value'
                }],
                series: [{
                    name: 'Line 1',
                    type: 'line',
                    stack: '总量',
                    smooth: true,
                    lineStyle: {
                        width: 0
                    },
                    showSymbol: false,
                    areaStyle: {
                        opacity: 0.8,
                        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                            offset: 0,
                            color: 'rgba(128, 255, 165)'
                        }, {
                            offset: 1,
                            color: 'rgba(1, 191, 236)'
                        }])
                    },
                    emphasis: {
                        focus: 'series'
                    },
                    data: [140, 232, 101, 264, 90, 340, 250]
                }, {
                    name: 'Line 2',
                    type: 'line',
                    stack: '总量',
                    smooth: true,
                    lineStyle: {
                        width: 0
                    },
                    showSymbol: false,
                    areaStyle: {
                        opacity: 0.8,
                        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                            offset: 0,
                            color: 'rgba(0, 221, 255)'
                        }, {
                            offset: 1,
                            color: 'rgba(77, 119, 255)'
                        }])
                    },
                    emphasis: {
                        focus: 'series'
                    },
                    data: [120, 282, 111, 234, 220, 340, 310]
                }, {
                    name: 'Line 3',
                    type: 'line',
                    stack: '总量',
                    smooth: true,
                    lineStyle: {
                        width: 0
                    },
                    showSymbol: false,
                    areaStyle: {
                        opacity: 0.8,
                        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                            offset: 0,
                            color: 'rgba(55, 162, 255)'
                        }, {
                            offset: 1,
                            color: 'rgba(116, 21, 219)'
                        }])
                    },
                    emphasis: {
                        focus: 'series'
                    },
                    data: [320, 132, 201, 334, 190, 130, 220]
                }, {
                    name: 'Line 4',
                    type: 'line',
                    stack: '总量',
                    smooth: true,
                    lineStyle: {
                        width: 0
                    },
                    showSymbol: false,
                    areaStyle: {
                        opacity: 0.8,
                        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                            offset: 0,
                            color: 'rgba(255, 0, 135)'
                        }, {
                            offset: 1,
                            color: 'rgba(135, 0, 157)'
                        }])
                    },
                    emphasis: {
                        focus: 'series'
                    },
                    data: [220, 402, 231, 134, 190, 230, 120]
                }, {
                    name: 'Line 5',
                    type: 'line',
                    stack: '总量',
                    smooth: true,
                    lineStyle: {
                        width: 0
                    },
                    showSymbol: false,
                    label: {
                        show: true,
                        position: 'top'
                    },
                    areaStyle: {
                        opacity: 0.8,
                        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                            offset: 0,
                            color: 'rgba(255, 191, 0)'
                        }, {
                            offset: 1,
                            color: 'rgba(224, 62, 76)'
                        }])
                    },
                    emphasis: {
                        focus: 'series'
                    },
                    data: [220, 302, 181, 234, 210, 290, 150]
                }]
            };

            option && myChart.setOption(option);
        </script>
    </body>

</html>