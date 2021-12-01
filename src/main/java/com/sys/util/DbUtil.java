package com.sys.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * 数据库连接
 */
public class DbUtil {
    private final String dbPassword;

    {
        dbPassword = "130160";
    }

    private Connection connection = null;

    public Connection getConnection() {
        try {
            String jdbcName = "com.mysql.cj.jdbc.Driver";
            Class.forName(jdbcName);
            String dbUrl = "jdbc:mysql://localhost:3306/smbms?" +
                    "serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
            String dbUser = "root";
            connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            System.out.println("数据库连接成功");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return connection;
    }

    public void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("数据库已关闭");
            } catch (SQLException throwable) {
                throwable.printStackTrace();
            }
        }
    }

//    public static void main(String[] args) {
//        DbUtil dbUtil = new DbUtil();
//        dbUtil.getConnection();
//    }
}
