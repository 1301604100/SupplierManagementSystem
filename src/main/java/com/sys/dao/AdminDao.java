package com.sys.dao;

import com.sys.model.Admin;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * 对管理员数据库的操作
 */
public class AdminDao extends BaseDao{

    public Admin login(String name, String password){
        // 查询登录账号和密码
        String sql = "select * from user where account = '" + name
                + "' and password = '" + password + "'";
        // 获取查询结果集
        ResultSet resultSet = query(sql);
        try {
            // 有结果的情况
            if (resultSet.next()){
                Admin admin = new Admin();
                admin.setId(resultSet.getInt("id"));
                admin.setName(resultSet.getString("name"));
                admin.setPassword(resultSet.getString("password"));
                admin.setStatus(resultSet.getInt("status"));
                return admin;
            }
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        }
        return null;
    }
}
