package com.sys.servlet;

import com.sys.util.CaptchaUtil;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;

public class CaptchaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 获取请求的内容
        String method = req.getParameter("method");
        // 判断是否为请求登录验证码
        if ("LoginCaptcha".equals(method)){
            // 创建登录验证码
            generaterLoginCaptcha(req, resp);
            return;
        }
        resp.getWriter().write("error method");
    }

    /**
     *  创建登录验证码
     */
    private void generaterLoginCaptcha (HttpServletRequest req, HttpServletResponse resp) throws IOException {
        CaptchaUtil captchaUtil = new CaptchaUtil();
        String generatorVCode = captchaUtil.generatorVCode();
        // 把验证码写进Session
        req.getSession().setAttribute("LoginCaptcha", generatorVCode);
        // 获取验证码图像
        BufferedImage generatorRotateVCodeImage = captchaUtil.generatorRotateVCodeImage(generatorVCode, true);
        // 把验证码图像放进网页
        ImageIO.write(generatorRotateVCodeImage, "gif", resp.getOutputStream());
    }
}
