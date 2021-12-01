package com.sys.servlet.admin;

import com.sys.dao.UserDao;
import com.sys.model.Page;
import com.sys.model.User;
import com.sys.util.JSONUtil;
import com.sys.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class UserListServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String method = req.getParameter("method");
        // 打开用户管理界面
        if ("toUserListView".equals(method)) {
            userList(req, resp);
        }
        // 获取数据
        else if ("getUserList".equals(method)) {
            getUserList(req, resp);
        }
        // 添加
        else if ("AddUser".equals(method)) {
            addUser(req, resp);
        }
        // 删除
        else if ("DeleteUser".equals(method)) {
            deleteUser(req, resp);
        }
        // 修改
        else if ("EditUser".equals(method)) {
            editUser(req, resp);
        }
        // 搜索
        else if ("SearchUser".equals(method)) {
            searchUser(req, resp);
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }



    // 搜索
    private void searchUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // 搜索的类型
        int searchType = Integer.parseInt(req.getParameter("type"));
        // 搜索的内容
        String text = req.getParameter("text");
        // 转换
        String str = null;
        switch (searchType){
            case 1:
                str = "userCode";
                break;
            case 2:
                str = "userName";
                break;
        }
        // 获取当前的页数
        int currPage = Integer.parseInt(req.getParameter("page"));
        // 获取一页显示的行数
        int rows = Integer.parseInt(req.getParameter("limit"));
        // 创建数据库查询对象
        UserDao userDao = new UserDao();
        // 获得查询结果
        List<User> userList = userDao.searchUserList(str, text, new Page(currPage, rows));
        // 结果数量
        int total = userDao.getUserListTotal(str,text);
        // 关闭数据库
        userDao.closeConnection();
        // JSON转换
        JsonConfig jsonConfig = new JsonConfig();
        String userListString = JSONArray.fromObject(userList, jsonConfig).toString();
        // 设置编码 防止乱码
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(new JSONUtil().ToJson(userListString, total));
    }

    // 修改信息
    private void editUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // 获取输入的密码和要修改的用户id
        int id = Integer.parseInt(req.getParameter("id"));
        User user = getDateFromJsp(req);
        user.setUserId(id);
        // 获取对应对象
        UserDao userDao = new UserDao();
        // 写进数据库
        int num = userDao.editUser(user);
        if (num == 0)
            resp.getWriter().write("success");
        else if (num == 2)
            resp.getWriter().write("exist");
        // 关闭数据库
        userDao.closeConnection();
    }

    // 删除
    private void deleteUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        UserDao userDao = new UserDao();
        // 获取要删除的id
        String idStr = req.getParameter("userId");
        int[] idArr = StringUtil.getDeleteIdArr(idStr);
        if (userDao.deleteUser(idArr))
            resp.getWriter().write("success");
        else
            resp.getWriter().write("error");

        userDao.closeConnection();
    }

    // 添加
    // 1、判断是否存在
    private void addUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        // 放到类里
        User user = getDateFromJsp(req);
        UserDao userDao = new UserDao();
        // 1、判断是否存在
        if (userDao.isExistUser(user.getUserName())) {
            resp.getWriter().write("exist");
            userDao.closeConnection();
            return;
        }
        // 获取要添加地方的下标
        int id = userDao.getUserListLastId() + 1;

        user.setUserId(id);


        // 写进数据库
        if (userDao.AddUser(user))
            resp.getWriter().write("success");
        // 关闭数据库
        userDao.closeConnection();
    }

    // 打开用户管理界面
    private void userList(HttpServletRequest req, HttpServletResponse resp) {
        try {
            req.getRequestDispatcher("view/admin/userList.jsp").forward(req, resp);
        } catch (ServletException | IOException e) {
            e.printStackTrace();
        }
    }

    // 获取数据
    private void getUserList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 获取当前的页数
        int currPage = Integer.parseInt(req.getParameter("page"));
        // 获取一页显示的行数
        int rows = Integer.parseInt(req.getParameter("limit"));
        // 创建数据库查询对象
        UserDao userDao = new UserDao();
        // 获得查询结果
        List<User> userList = userDao.getUserList(new Page(currPage, rows));
        // 结果数量
        int total = userDao.getUserListTotal();
        // 关闭数据库
        userDao.closeConnection();
        // JSON转换
        JsonConfig jsonConfig = new JsonConfig();
        String userListString = JSONArray.fromObject(userList, jsonConfig).toString();
        // 设置编码 防止乱码
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(new JSONUtil().ToJson(userListString, total));
    }

    // 封装从jsp获取数据并写入user的方法
    private User getDateFromJsp(HttpServletRequest req){
        String userCode = req.getParameter("userCode");
        String userName = req.getParameter("account");
        String userPassword = req.getParameter("password");
        String gender = req.getParameter("gender").equals("1")? "女":"男";
        String birthday = req.getParameter("birthday");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String role = req.getParameter("role");

        User user = new User();

        user.setUserCode(userCode);
        user.setUserName(userName);
        user.setUserPassword(userPassword);
        user.setGender(gender);
        user.setBirthday(birthday);
        user.setPhone(phone);
        user.setAddress(address);
        user.setUserRole(role);

        return user;
    }
}
