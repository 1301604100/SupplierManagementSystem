$(function() {
    // 选项卡
    let table = $(".table")
    let tabs = $(".tab")
    // 密码界面
    let login = $(".login")
    let close = $(".close")
    // 记录选择的用户类型
    let type = $(".user")
    // 输入框组
    let inputs = $("input");

    // 点击选项时
    for (let i = 0; i < tabs.length; i++) {
        tabs[i].onclick = function() {
            let spanName = (tabs[i].getElementsByTagName('span'))
            let text = spanName[0].innerHTML;
            switch (text){
                case "学生" :
                    type[0].value = "2";
                    break;
                case "教师" :
                    type[0].value = "3";
                    break;
                case "管理员" :
                    type[0].value = "1";
                    break;
            }
            show("undisplay", "display");
            document.getElementById('username').focus();
        }
    }

    // 关闭登录界面
    close[0].onclick = function() {
        show("display", "undisplay")
        for (let i = 0; i < inputs.length - 1; i++){
            inputs[i].value = "";
        }
    }



    // 显示与不显示切换
    function show(str1, str2) {
        let loginStr = login[0].className;
        let tableStr = table[0].className;
        loginStr = loginStr.replace(str1, str2)
        tableStr = tableStr.replace(str2, str1)
        login[0].className = loginStr
        table[0].className = tableStr
    }

    //点击图片切换验证码
    $("#vccodeImg").click(function() {
        console.log("123")
        this.src = "CaptchaServlet?method=LoginCaptcha&t=" + new Date().getTime();
    });

    // 回车登录
    $(document).keydown(function (event){
        if (event.keyCode === 13)
            $("#submitBtn").click();
    })


    //登录
    $("#submitBtn").click(function() {
        const data = $("#form").serialize();
        $.ajax({
            type: "post",
            url: "LoginServlet?method=Login",
            data: data,
            dataType: "text", //返回数据类型
            success: function(msg) {
                if ("vcodeError" === msg) {
                    layer.msg('验证码错误!');
                    $("#vcodeImg").click(); //切换验证码
                } else if ("loginError" === msg) {
                    layer.msg('用户名或密码错误!');
                    $("#vcodeImg").click(); //切换验证码
                } else if ("admin" === msg) {
                    window.location.href = "SystemServlet?method=toAdminView";
                } else if ("student" === msg) {
                    window.location.href = "SystemServlet?method=toStudentView";
                } else if ("teacher" === msg) {
                    window.location.href = "SystemServlet?method=toTeacherView";
                }
            }

        });
    })
})