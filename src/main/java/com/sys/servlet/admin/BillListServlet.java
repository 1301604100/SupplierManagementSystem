package com.sys.servlet.admin;

import com.sys.dao.BillDao;
import com.sys.dao.UserDao;
import com.sys.model.Bill;
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
import javax.xml.crypto.Data;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class BillListServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String method = req.getParameter("method");
        // 打开用户管理界面
        if ("toBillListView".equals(method)) {
            billList(req, resp);
        }
        // 获取数据
        else if ("getBillList".equals(method)) {
            getBillList(req, resp);
        }
        // 添加
        else if ("AddBill".equals(method)) {
            addBill(req, resp);
        }
        // 删除
        else if ("DeleteBill".equals(method)) {
            deleteBill(req, resp);
        }
        // 搜索
        else if ("SearchBill".equals(method)) {
            searchBill(req, resp);
        }
        // 修改支付状态
        else if ("changePayment".equals(method)) {
            changePayment(req, resp);
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    // 搜索
    private void searchBill(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // 搜索的类型
        String searchType = req.getParameter("type");
        // 搜索的内容
        String text = req.getParameter("text");
        // 获取当前的页数
        int currPage = Integer.parseInt(req.getParameter("page"));
        // 获取一页显示的行数
        int rows = Integer.parseInt(req.getParameter("limit"));
        // 创建数据库查询对象
        BillDao billDao = new BillDao();
        // 获得查询结果
        List<Bill> billList = billDao.searchBillList(searchType, text, new Page(currPage, rows));
        // 结果数量
        int total = billDao.getBillListTotal(searchType, text);
        // 关闭数据库
        billDao.closeConnection();
        // JSON转换
        JsonConfig jsonConfig = new JsonConfig();
        String userListString = JSONArray.fromObject(billList, jsonConfig).toString();
        // 设置编码 防止乱码
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(new JSONUtil().ToJson(userListString, total));
    }


    // 修改订单支付状态
    private void changePayment(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String isPayment = req.getParameter("isPayment");
        Bill bill = new Bill();
        bill.setBillId(id);
        bill.setPayment(Integer.parseInt(isPayment));
        BillDao billDao = new BillDao();
        if(billDao.edit_payment(bill)) {
            resp.getWriter().write("success");
        }
        else {
            resp.getWriter().write("error");
        }
        billDao.closeConnection();

    }

    // 删除
    private void deleteBill(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        BillDao billDao = new BillDao();
        // 获取要删除的id
        String idStr = req.getParameter("billId");
        int[] idArr = StringUtil.getDeleteIdArr(idStr);
        if (billDao.deleteBill(idArr))
            resp.getWriter().write("success");
        else
            resp.getWriter().write("error");

        billDao.closeConnection();
    }

    // 添加
    private void addBill(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        // 放到类里
        Bill bill = getDateFromJsp(req);
        BillDao billdao = new BillDao();

        // 获取要添加地方的下标
        int id = billdao.getBillListLastId() + 1;

        bill.setBillId(id);

        // 写进数据库
        if (billdao.AddBill(bill))
            resp.getWriter().write("success");
        // 关闭数据库
        billdao.closeConnection();
    }

    // 打开界面
    private void billList(HttpServletRequest req, HttpServletResponse resp) {
        try {
            req.getRequestDispatcher("view/admin/billList.jsp").forward(req, resp);
        } catch (ServletException | IOException e) {
            e.printStackTrace();
        }
    }

    // 获取数据
    private void getBillList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 获取当前的页数
        int currPage = Integer.parseInt(req.getParameter("page"));
        // 获取一页显示的行数
        int rows = Integer.parseInt(req.getParameter("limit"));
        // 创建数据库查询对象
        BillDao billDao = new BillDao();
        // 获得查询结果
        List<Bill> billList = billDao.getBillList(new Page(currPage, rows));
        // 结果数量
        int total = billDao.getBillListTotal();
        // 关闭数据库
        billDao.closeConnection();
        // JSON转换
        JsonConfig jsonConfig = new JsonConfig();
        String billListString = JSONArray.fromObject(billList, jsonConfig).toString();
        // 设置编码 防止乱码
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(new JSONUtil().ToJson(billListString, total));
    }

    // 封装从jsp获取数据并写入user的方法
    private Bill getDateFromJsp(HttpServletRequest req) {
        String productName = req.getParameter("productName");
        String productCount = req.getParameter("productCount");
        String unitPrice = req.getParameter("unitPrice");
        String totalPrice = req.getParameter("totalPrice");
        String provider = req.getParameter("provider");
        Date dNow = new Date( );
        SimpleDateFormat ft = new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss");

        Bill bill = new Bill();
        bill.setProductName(productName);
        bill.setProductCount(Integer.parseInt(productCount));
        bill.setUnitPrice(Integer.parseInt(unitPrice));
        bill.setTotalPrice(Integer.parseInt(totalPrice));
        bill.setPayment(0);
        bill.setCreationDate(ft.format(dNow));
        bill.setProvider(provider);

        return bill;
    }
}
