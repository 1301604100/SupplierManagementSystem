package com.sys.model;

import java.util.Date;

/**
 * 系统用户类User
 *
 */
public class User {

    private int userId;//用户id

    private String userCode;

    private String userName;//账户

    private String userPassword;

    private String gender;

    private String birthday;

    private String phone;

    private String address;

    private String userRole;

    public User() {
    }

    public String getUserCode() {
        return userCode;
    }

    public void setUserCode(String userCode) {
        this.userCode = userCode;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getUserRole() {
        return userRole;
    }

    public void setUserRole(String userRole) {
        this.userRole = userRole;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

//    public void setUserRole(int userRole) {
//        this.userRole = userRole;
//        if (userRole == 1)
//            type = "管理员";
//        else if (userRole == 2)
//            type = "学生";
//        else if (userRole == 3)
//            type = "教师";
//    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
