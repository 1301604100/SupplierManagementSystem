package com.sys.servlet.admin;

import com.sys.dao.ProviderDao;
import com.sys.dao.UserDao;
import com.sys.model.Page;
import com.sys.model.Provider;
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

public class ProviderListServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String method = req.getParameter("method");
        // 打开用户管理界面
        if ("toProviderListView".equals(method)) {
            providerList(req, resp);
        }
        // 获取数据
        else if ("getProviderList".equals(method)) {
            getProviderList(req, resp);
        }
        // 添加
        else if ("AddProvider".equals(method)) {
            addProvider(req, resp);
        }
        // 删除
        else if ("DeleteProvider".equals(method)) {
            deleteProvider(req, resp);
        }
        // 修改
        else if ("EditProvider".equals(method)) {
            editProvider(req, resp);
        }
        // 搜索
        else if ("SearchProvider".equals(method)) {
            searchProvider(req, resp);
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }



    // 搜索
    private void searchProvider(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // 搜索的类型
        String searchType = req.getParameter("type");
        // 搜索的内容
        String text = req.getParameter("text");

        // 获取当前的页数
        int currPage = Integer.parseInt(req.getParameter("page"));
        // 获取一页显示的行数
        int rows = Integer.parseInt(req.getParameter("limit"));
        // 创建数据库查询对象
        ProviderDao providerDao = new ProviderDao();
        // 获得查询结果
        List<Provider> providerList = providerDao.searchProviderList(searchType, text, new Page(currPage, rows));
        // 结果数量
        int total = providerDao.getProviderListTotal(searchType,text);
        // 关闭数据库
        providerDao.closeConnection();
        // JSON转换
        JsonConfig jsonConfig = new JsonConfig();
        String providerListString = JSONArray.fromObject(providerList, jsonConfig).toString();
        // 设置编码 防止乱码
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(new JSONUtil().ToJson(providerListString, total));
    }

    // 修改信息
    private void editProvider(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // 获取输入的密码和要修改的用户id
        int id = Integer.parseInt(req.getParameter("id"));
        Provider provider = getDateFromJsp(req);
        provider.setProId(id);
        // 获取对应对象
        ProviderDao providerDao = new ProviderDao();
        // 写进数据库
        int num = providerDao.editProvider(provider);
        if (num == 0)
            resp.getWriter().write("success");
        else if (num == 2)
            resp.getWriter().write("exist");
        // 关闭数据库
        providerDao.closeConnection();
    }

    // 删除
    private void deleteProvider(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        ProviderDao providerDao = new ProviderDao();
        // 获取要删除的id
        String idStr = req.getParameter("proId");
        int[] idArr = StringUtil.getDeleteIdArr(idStr);
        if (providerDao.deleteProvider(idArr))
            resp.getWriter().write("success");
        else
            resp.getWriter().write("error");

        providerDao.closeConnection();
    }

    // 添加
    // 1、判断是否存在
    private void addProvider(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        // 放到类里
        Provider provider = getDateFromJsp(req);
        ProviderDao providerDao = new ProviderDao();
        // 1、判断是否存在
        if (providerDao.isExistProvider(provider.getProName())) {
            resp.getWriter().write("exist");
            providerDao.closeConnection();
            return;
        }
        // 获取要添加地方的下标
        int id = providerDao.getProviderListLastId() + 1;

        provider.setProId(id);


        // 写进数据库
        if (providerDao.AddProvider(provider))
            resp.getWriter().write("success");
        // 关闭数据库
        providerDao.closeConnection();
    }

    // 打开界面
    private void providerList(HttpServletRequest req, HttpServletResponse resp) {
        try {
            req.getRequestDispatcher("view/admin/providerList.jsp").forward(req, resp);
        } catch (ServletException | IOException e) {
            e.printStackTrace();
        }
    }

    // 获取数据
    private void getProviderList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 获取当前的页数
        int currPage = Integer.parseInt(req.getParameter("page"));
        // 获取一页显示的行数
        int rows = Integer.parseInt(req.getParameter("limit"));
        // 创建数据库查询对象
        ProviderDao providerDao = new ProviderDao();
        // 获得查询结果
        List<Provider> providerList = providerDao.getProviderList(new Page(currPage, rows));
        // 结果数量
        int total = providerDao.getProviderListTotal();
        // 关闭数据库
        providerDao.closeConnection();
        // JSON转换
        JsonConfig jsonConfig = new JsonConfig();
        String providerListString = JSONArray.fromObject(providerList, jsonConfig).toString();
        // 设置编码 防止乱码
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(new JSONUtil().ToJson(providerListString, total));
    }

    // 封装从jsp获取数据并写入user的方法
    private Provider getDateFromJsp(HttpServletRequest req){
        String proCode = req.getParameter("proCode");
        String proName = req.getParameter("proName");
        String proDesc = req.getParameter("proDesc");
        String proContact = req.getParameter("proContact");
        String proPhone = req.getParameter("proPhone");
        String proAddress = req.getParameter("proAddress");

        Provider provider = new Provider();

        provider.setProCode(proCode);
        provider.setProName(proName);
        provider.setProDesc(proDesc);
        provider.setProContact(proContact);
        provider.setProPhone(proPhone);
        provider.setProAddress(proAddress);

        return provider;
    }
}
