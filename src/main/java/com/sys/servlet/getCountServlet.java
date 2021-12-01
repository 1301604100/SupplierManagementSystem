package com.sys.servlet;

import com.mysql.cj.xdevapi.JsonArray;
import com.sys.dao.BillDao;
import com.sys.dao.ProviderDao;
import com.sys.dao.UserDao;
import com.sys.util.JSONUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class getCountServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String method = req.getParameter("method");
        if ("getCount".equals(method)) {
            getCount(req, resp);
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    private void getCount(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        BillDao billDao = new BillDao();
        UserDao userDao = new UserDao();
        ProviderDao providerDao = new ProviderDao();

        int userListTotal = userDao.getUserListTotal();
        int billListTotal = billDao.getBillListTotal();
        int providerListTotal = providerDao.getProviderListTotal();

        JSONObject Json = new JSONObject();

        Json.put("billListTotal", billListTotal);
        Json.put("providerListTotal", providerListTotal);
        Json.put("userListTotal", userListTotal);

        resp.getWriter().write(String.valueOf(Json));
        billDao.closeConnection();
        userDao.closeConnection();
        providerDao.closeConnection();
    }
}
