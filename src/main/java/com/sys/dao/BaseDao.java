package com.sys.dao;

import com.sys.util.DbUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/*
基础数据库语句
 */
public class BaseDao {
    private final DbUtil dbUtil = new DbUtil();

    /**
     * 关闭数据库
     */
    public void closeConnection(){
        dbUtil.closeConnection();
    }
    /**
     * 查询
     */
    public ResultSet query(String sql) {
        PreparedStatement preparedStatement;
        try {
            preparedStatement = dbUtil.getConnection().prepareStatement(sql);
            return preparedStatement.executeQuery();
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        }

        return null;
    }
    /**
     * 更新，插入
     */
    public boolean update(String sql){
        // 判断是否更新成功
        boolean flag = false;
        try {
            flag = dbUtil.getConnection().prepareStatement(sql).executeUpdate() > 0;
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        }

        return flag;
    }

    public Connection getConnection(){
        return dbUtil.getConnection();
    }


    public int getListTotal(String sql){
        // 记录id
        int total = 0;

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

    /**
     * @return 获取最后一条数据的id
     */
    public int getListLastId(String sql) {
        // 记录id
        int id = 0;
        // 查询出结果
        ResultSet resultSet = query(sql);
        try {
            // 遍历
            while (resultSet.next()) {
                id = resultSet.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return id;
    }
}
