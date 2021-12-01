package com.sys.dao;

import com.sys.model.Bill;
import com.sys.model.Page;
import com.sys.model.User;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BillDao extends BaseDao{

    /**
     * @param page page类，计算分页的
     * @return 查询结果
     */
    public List<Bill> getBillList(Page page) {
        // 查询user表中的内容
        String sql = "select smbms_bill.*, smbms_provider.proName " +
                " from smbms_bill, smbms_provider " +
                " WHERE smbms_bill.providerId = smbms_provider.id ";
        sql += " order by id ";
        // 用于分页查询
        sql += " limit " + page.getStart() + "," + page.getPageSize();
        // 查询出结果
        ResultSet resultSet = query(sql);
        return putData(resultSet);
    }

    /**
     * @return 结果数量
     */
    public int getBillListTotal() {
        String sql = "SELECT COUNT(*) AS total FROM smbms_bill ";
        return getListTotal(sql);
    }

    /**
     * @return 结果数量, 用于模糊搜索
     */
    public int getBillListTotal(String searchType, String text) {
        // 记录id
        int total = 0;
        String sql = "SELECT COUNT(*) AS total " +
                " from smbms_bill, smbms_provider " +
                " where " + searchType + " like '%" + text + "%' " +
                " and providerId = smbms_provider.id ";
        // 查询出结果
        ResultSet resultSet = query(sql);
        try {
            // 遍历
            while (resultSet.next()) {
                total = resultSet.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }
    // 修改支付状态
    public boolean edit_payment(Bill bill){
        String sql = "update smbms_bill set isPayment = " + bill.getPayment() +
                     " where id = " + bill.getBillId();
        return update(sql);
    }

    // 封装查询后的数据设置
    private List<Bill> putData(ResultSet resultSet) {
        List<Bill> ret = new ArrayList<>();
        try {
            // 有结果的情况
            while (resultSet.next()) {
                Bill bill = new Bill();
                bill.setBillId(resultSet.getInt("id"));
                bill.setBillCode(resultSet.getString("billCode"));
                bill.setProductName(resultSet.getString("productName"));
                bill.setProductCount(resultSet.getInt("productCount"));
                bill.setUnitPrice(resultSet.getInt("unitPrice"));
                bill.setTotalPrice(resultSet.getInt("totalPrice"));
                bill.setPayment(resultSet.getInt("isPayment"));
                bill.setCreationDate(resultSet.getString("creationDate"));
                bill.setProviderId(resultSet.getInt("providerId"));
                bill.setProvider(resultSet.getString("proName"));
                ret.add(bill);
            }
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        }
        return ret;
    }

    /**
     * @return 获取最后一条数据的id
     */
    public int getBillListLastId() {
        String sql = "SELECT * FROM smbms_bill ORDER BY id DESC LIMIT 1 ";
        return getListLastId(sql);
    }

    public boolean AddBill(Bill bill) {
        String sql = "insert into smbms_bill values(id1, billCode1, productName1, " +
                "productCount1, unitPrice1, totalPrice1, isPayment1, creationDate1, providerId1)";

        String id = bill.getBillId() + "";
        id = id.length() >= 2 ? "0" + id: "00" + id;
        String billCode = "BILL2021_" + id;
        bill.setBillCode(billCode);

        String sql1 = "select id from smbms_provider where proName = '" + bill.getProvider() + "'";
        // 查询出结果
        int providerId = 0;
        ResultSet resultSet = query(sql1);
        try {
            // 遍历
            while (resultSet.next()) {
                providerId = resultSet.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        bill.setProviderId(providerId);

        sql = ChangeSql(sql, bill);
        return update(sql);
    }

    private String ChangeSql(String sql, Bill bill) {
        sql = sql.replace("id1"," " + bill.getBillId() +" ");
        sql = sql.replace("billCode1","'" + bill.getBillCode() +"'");
        sql = sql.replace("productName1","'" + bill.getProductName() +"'");
        sql = sql.replace("productCount1"," " + bill.getProductCount() +" ");
        sql = sql.replace("unitPrice1"," " + bill.getUnitPrice() +" ");
        sql = sql.replace("totalPrice1"," " + bill.getTotalPrice() +" ");
        sql = sql.replace("isPayment1"," " + bill.getPayment() +" ");
        sql = sql.replace("creationDate1","'" + bill.getCreationDate() +"'");
        sql = sql.replace("providerId1"," " + bill.getProviderId() +" ");
        return sql;
    }

    public boolean deleteBill(int[] id) {
        String sql;
        boolean flag;
        for (int j : id) {
            sql = "delete from smbms_bill where id = " + j;
            flag = update(sql);
            // 删除失败
            if (!flag)
                return false;
        }
        return true;
    }

    public List<Bill> searchBillList(String searchType, String text, Page page) {
        // 查询user表中的内容
        String sql = "select smbms_bill.*, smbms_provider.proName " +
                     " from smbms_bill, smbms_provider " +
                     " where " + searchType + " like '%" + text + "%' "  +
                     " and providerId = smbms_provider.id ";
        sql += " order by id ";
        // 用于分页查询
        sql += " limit " + page.getStart() + "," + page.getPageSize();
        // 查询出结果
        ResultSet resultSet = query(sql);

        return putData(resultSet);
    }
}
