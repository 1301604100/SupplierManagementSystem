package com.sys.servlet;

import com.sys.dao.UserDao;
import com.sys.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String method = req.getParameter("method");
        if ("logOut".equals(method)) {
            logOut(req, resp);
        } else {
            login(req, resp);
        }

    }

    // 登录
    private void login(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // 获取输入的验证码
        String captcha = req.getParameter("captcha");
        // 获取输入的账号
        String name = req.getParameter("username");
        // 获取输入的密码
        String password = req.getParameter("password");
        // 获取选择的类型
//        int type = Integer.parseInt(req.getParameter("type"));
        // 获取验证码
        String loginCaptcha = req.getSession().getAttribute("LoginCaptcha").toString();

        // 验证码错误
        if (!captcha.toLowerCase().equals(loginCaptcha.toLowerCase())) {
            resp.getWriter().write("captchaError");
            return;
        }
        // 验证码通过,判断类型和密码
        // 数据库查询
        UserDao userDao = new UserDao();
        User user = userDao.login(name, password);
        // 关闭数据库
        userDao.closeConnection();
        // 没查到结果时
//        if (user == null || type != user.getStatus()) {
//            resp.getWriter().write("loginError");
//            return;
//        }
        if (user == null) {
            resp.getWriter().write("loginError");
            return;
        }
        // 写进Session
        HttpSession session = req.getSession();
        session.setAttribute("user", user);
//        session.setAttribute("userType", type);
        session.setAttribute("id", user.getUserName());
        resp.getWriter().write("admin");
//        switch (type) {
//            case 1:  // 管理员
//                // 回复
//                resp.getWriter().write("admin");
//                break;
//            case 2:
//                // 回复
//                resp.getWriter().write("student");
//                break;
//            case 3:
//                // 回复
//                resp.getWriter().write("teacher");
//                break;
//        }
    }

    // 退出
    private void logOut(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // 删除Session中的信息
        req.getSession().removeAttribute("user");
        req.getSession().removeAttribute("userType");
        req.getSession().removeAttribute("id");
        req.getSession().removeAttribute("student");
        req.getSession().removeAttribute("teacher");
        // 跳转到登录界面
        resp.sendRedirect("index.jsp");
    }
}
