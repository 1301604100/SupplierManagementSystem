package com.sys.dao;

import com.sys.model.Page;
import com.sys.model.Provider;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProviderDao extends BaseDao {
    public List<Provider> getProviderList(Page page) {
        // 查询user表中的内容
        String sql = "select * from smbms_provider ";
        sql += " order by id ";
        // 用于分页查询
        sql += " limit " + page.getStart() + "," + page.getPageSize();
        // 查询出结果
        ResultSet resultSet = query(sql);
        return putData(resultSet);
    }

    private List<Provider> putData(ResultSet resultSet) {
        List<Provider> ret = new ArrayList<>();
        try {
            // 有结果的情况
            while (resultSet.next()) {
                Provider provider = new Provider();
                provider.setProId(resultSet.getInt("id"));
                provider.setProCode(resultSet.getString("proCode"));
                provider.setProName(resultSet.getString("proName"));
                provider.setProDesc(resultSet.getString("proDesc"));
                provider.setProContact(resultSet.getString("proContact"));
                provider.setProPhone(resultSet.getString("proPhone"));
                provider.setProAddress(resultSet.getString("proAddress"));
                ret.add(provider);
            }
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        }
        return ret;
    }

    public int getProviderListTotal() {
        String sql = "SELECT COUNT(*) AS total FROM smbms_provider ";
        return getListTotal(sql);
    }

    public int getProviderListTotal(String searchType, String text) {
        // 记录id
        int total = 0;
        String sql = "SELECT COUNT(*) AS total FROM smbms_provider WHERE " + searchType + " LIKE '%" + text + "%'";
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

    public int editProvider(Provider provider) {
        boolean flag = false;
        String sql = "select proName from smbms_provider where id = '" + provider.getProId() + "'";
        // 查询出结果
        ResultSet resultSet = query(sql);
        try {
            // 遍历
            while (resultSet.next()) {
                if (resultSet.getString("proName").equals(provider.getProName()))
                    flag = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        //账号和原来不同就要看看是否已经存在该账号
        if (!flag) {
            if (isExistProvider(provider.getProName()))
                return 2;
        }
        sql = "update smbms_provider set proName = proName1, proDesc = proDesc1, " +
                "proContact = proContact1, proPhone = proPhone1, proAddress = proAddress1 " +
                " where id = id1";
        sql = ChangeSql(sql, provider);
        return update(sql) ? 0 : 1;
    }

    private String ChangeSql(String sql, Provider provider) {
        sql = sql.replace("id1", "'" + provider.getProId() + "'");
        sql = sql.replace("proName1", "'" + provider.getProName() + "'");
        sql = sql.replace("proDesc1", "'" + provider.getProDesc() + "'");
        sql = sql.replace("proContact1", "'" + provider.getProContact() + "'");
        sql = sql.replace("proPhone1", "'" + provider.getProPhone() + "'");
        sql = sql.replace("proAddress1", "'" + provider.getProAddress() + "'");
        return sql;
    }

    public boolean isExistProvider(String proName) {
        // 记录结果数来判断是否存在
        int count = 0;

        String sql = "select count(*) as count from smbms_provider " +
                "where proName = '" + proName + "'";
        // 查询出结果
        ResultSet resultSet = query(sql);
        try {
            // 遍历
            while (resultSet.next()) {
                count = resultSet.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // count不为0就是存在，为0就是不存在
        return count != 0;
    }

    public int getProviderListLastId() {
        String sql = "SELECT COUNT(*) AS total FROM smbms_provider ";
        return getListTotal(sql);
    }

    public boolean AddProvider(Provider provider) {
        String sql = "insert into smbms_provider values(id1,proCode1,proName1,proDesc1,proContact1,proPhone1,proAddress1)";
        String idstr = provider.getProId() + "";
        String proCode = "GYS" + (idstr.length() >= 2 ? "0" + idstr : "00" + idstr);
        sql = sql.replace("proCode1", "'" + proCode + "'");
        sql = ChangeSql(sql, provider);
        return update(sql);
    }

    public boolean deleteProvider(int[] id) {
        String sql;
        boolean flag;
        for (int j : id) {
            sql = "delete from smbms_provider where id = " + j;
            flag = update(sql);
            // 删除失败
            if (!flag)
                return false;
        }
        return true;
    }

    public List<Provider> searchProviderList(String searchType, String text, Page page) {
        // 查询user表中的内容
        String sql = "select * from smbms_provider where " + searchType + " like '%" + text + "%'";
        sql += " order by id ";
        // 用于分页查询
        sql += " limit " + page.getStart() + "," + page.getPageSize();
        // 查询出结果
        ResultSet resultSet = query(sql);

        return putData(resultSet);
    }
}
