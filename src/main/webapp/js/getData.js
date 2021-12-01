
    // 获取请求头的信息
    UrlParm = function () { // url参数
        let data, index;
        (function init() {
            data = [];
            index = {};
            let u = window.location.search.substr(1);
            if (u != '') {
                let parms = decodeURIComponent(u).split('&');
                for (let i = 0, len = parms.length; i < len; i++) {
                    if (parms[i] != '') {
                        let p = parms[i].split("=");
                        if (p.length == 1 || (p.length == 2 && p[1] == '')) {// p | p=
                            data.push(['']);
                            index[p[0]] = data.length - 1;
                        } else if (typeof(p[0]) == 'undefined' || p[0] == '') { // =c | =
                            data[0] = [p[1]];
                        } else if (typeof(index[p[0]]) == 'undefined') { // c=aaa
                            data.push([p[1]]);
                            index[p[0]] = data.length - 1;
                        } else {// c=aaa
                            data[index[p[0]]].push(p[1]);
                        }
                    }
                }
            }
        })();
        return {
            // 获得参数,类似request.getParameter()
            parm : function(o) { // o: 参数名或者参数次序
                try {
                    return (typeof(o) == 'number' ? data[o][0] : data[index[o]][0]);
                } catch (e) {
                }
            },
            //获得参数组, 类似request.getParameterValues()
            parmValues : function(o) { //  o: 参数名或者参数次序
                try {
                    return (typeof(o) == 'number' ? data[o] : data[index[o]]);
                } catch (e) {}
            },
            //是否含有parmName参数
            hasParm : function(parmName) {
                return typeof(parmName) == 'string' ? typeof(index[parmName]) != 'undefined' : false;
            },
            // 获得参数Map ,类似request.getParameterMap()
            parmMap : function() {
                let map = {};
                try {
                    for (let p in index) {  map[p] = data[index[p]];  }
                } catch (e) {}
                return map;
            }
        }
    }();

