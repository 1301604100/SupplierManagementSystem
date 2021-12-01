package com.sys.dao;

import com.sys.model.Page;
import com.sys.model.User;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class UserDao extends BaseDao {
    /**
     * @param page page类，计算分页的
     * @return 查询结果
     */
    public List<User> getUserList(Page page) {
        // 查询user表中的内容
        String sql = "select * from smbms_user ";
        sql += " order by id ";
        // 用于分页查询
        sql += " limit " + page.getStart() + "," + page.getPageSize();
        // 查询出结果
        ResultSet resultSet = query(sql);
        return putData(resultSet);
    }

    /**
     * @return 获取最后一条数据的id
     */
    public int getUserListLastId() {
        String sql = "SELECT * FROM smbms_user ORDER BY id DESC LIMIT 1 ";
        return getListLastId(sql);
    }

    /**
     * @return 结果数量
     */
    public int getUserListTotal() {
        String sql = "SELECT COUNT(*) AS total FROM smbms_user ";
        return getListTotal(sql);
    }

    /**
     * @param userName 账号
     * @return 存在为true
     */
    public boolean isExistUser(String userName) {
        // 记录结果数来判断是否存在
        int count = 0;

        String sql = "select count(*) as count from smbms_user where userName = '" + userName + "'";
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

    /**
     * @param user 用户对象
     * @return 插入情况
     */
    public boolean AddUser(User user) {
        String sql = "insert into smbms_user values(id1,userCode1,userName1,userPassword1,gender1,birthday1,phone1,address1,userRole1)";
        sql = ChangeSql(sql, user);
        return update(sql);
    }

    /**
     * @param id 要删除的id
     * @return 删除情况
     */
    public boolean deleteUser(int[] id) {
        String sql;
        boolean flag;
        for (int j : id) {
            sql = "delete from smbms_user where id = " + j;
            flag = update(sql);
            // 删除失败
            if (!flag)
                return false;
        }
        return true;
    }

    /**
     * @param user 用户对象
     * @return 修改情况
     * 三个状态码 0表示成功 1表示失败 2表示存在相同的
     */
    public int editUser(User user) {

        //先判断账号和id间的关系
        //账号和原来的相同就修改后面的内容
        //账号和原来不同就要看看是否已经存在该账号

        // 记录账号是否和原来的相同
        boolean flag = false;
        String sql = "select userName from smbms_user where id = '" + user.getUserId() + "'";
        // 查询出结果
        ResultSet resultSet = query(sql);
        try {
            // 遍历
            while (resultSet.next()) {
                if (resultSet.getString("userName").equals(user.getUserName()))
                    flag = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        //账号和原来不同就要看看是否已经存在该账号
        if (!flag) {
            if (isExistUser(user.getUserName()))
                return 2;
        }
        sql = "update smbms_user set userName = userName1, userPassword = userPassword1, gender = gender1, birthday = birthday1, phone = phone1," +
                "address = address1, userRole = userRole1 " +
                "where id = id1";
        sql = ChangeSql(sql, user);
        return update(sql) ? 0 : 1;
    }

    /**
     * @param searchType 搜索条件
     * @param text       搜索内容
     * @return ret
     */
    public List<User> searchUserList(String searchType, String text, Page page) {

        // 查询user表中的内容
        String sql = "select * from smbms_user where " + searchType + " like '%" + text + "%'";
        sql += " order by id ";
        // 用于分页查询
        sql += " limit " + page.getStart() + "," + page.getPageSize();
        // 查询出结果
        ResultSet resultSet = query(sql);

        return putData(resultSet);
    }

    /**
     * @return 结果数量, 用于模糊搜索
     */
    public int getUserListTotal(String searchType, String text) {
        // 记录id
        int total = 0;
        String sql = "SELECT COUNT(*) AS total FROM smbms_user WHERE " + searchType + " LIKE '%" + text + "%'";
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

    // 登录
    public User login(String name, String password) {
        // 查询登录账号和密码
        String sql = "select * from smbms_user " +
                "where userName = '" + name
                + "' and userPassword = '" + password + "'";
        // 获取查询结果集
        ResultSet resultSet = query(sql);

        return putData(resultSet).get(0);

    }

    // 封装查询后的数据设置
    private List<User> putData(ResultSet resultSet) {
        List<User> ret = new ArrayList<>();
        try {
            // 有结果的情况
            while (resultSet.next()) {
                User user = new User();
                user.setUserId(resultSet.getInt("id"));
                user.setUserCode(resultSet.getString("userCode"));
                user.setUserName(resultSet.getString("userName"));
                user.setUserPassword(resultSet.getString("userPassword"));
                user.setGender(resultSet.getInt("gender") == 1 ? "女" : "男");
                user.setBirthday(resultSet.getString("birthday"));
                user.setPhone(resultSet.getString("phone"));
                user.setAddress(resultSet.getString("address"));
                String Role = "";
                int Role_of_int = resultSet.getInt("userRole");
                if (Role_of_int == 1)
                    Role = "系统管理员";
                else
                    Role = "供应商";
                user.setUserRole(Role);
                ret.add(user);
            }
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        }
        return ret;
    }

    private String ChangeSql(String sql, User user) {
        sql = sql.replace("id1", " " + user.getUserId() + " ");
        sql = sql.replace("userCode1", "'" + user.getUserCode() + "'");
        sql = sql.replace("userName1", "'" + user.getUserName() + "'");
        sql = sql.replace("userPassword1", "'" + user.getUserPassword() + "'");
        int gender = user.getGender().equals("女") ? 1 : 2;
        sql = sql.replace("gender1", " " + gender + " ");
        sql = sql.replace("birthday1", "DATE('" + user.getBirthday() + "')");
        sql = sql.replace("phone1", "'" + user.getPhone() + "'");
        sql = sql.replace("address1", "'" + user.getAddress() + "'");
        String role_str = user.getUserRole();
        int role = role_str.equals("系统管理员") ? 1 : 2;
        sql = sql.replace("userRole1", " " + role + " ");
        return sql;
    }
}
