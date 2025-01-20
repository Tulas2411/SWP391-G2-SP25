/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import DAO.DBContext;
import Dto.tblUsers;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author Acer
 */
public class UserDAO {

    // Phương thức lấy về danh sách tất cả user
    public ArrayList<tblUsers> listUsers() {
        ArrayList<tblUsers> users = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBContext.makeConnection();
            if (cn != null) {
                String sql = "SELECT * FROM tblUsers where status = 1";
                Statement st = cn.createStatement();
                ResultSet table = st.executeQuery(sql);
                if (table != null) {
                    while (table.next()) {
                        tblUsers user = new tblUsers();
                        user.setUserID(table.getString("userID"));
                        user.setFirstName(table.getString("firstName"));
                        user.setLastName(table.getString("lastName"));
                        user.setUserName(table.getString("userName"));
                        user.setPassword(table.getString("password"));
                        user.setRoleID(table.getString("roleID"));
                        user.setGmail(table.getString("gmail"));
                        user.setPhone(table.getString("phone"));
                        user.setAddress(table.getString("address"));
                        user.setStatus(table.getBoolean("status"));
                        users.add(user);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return users;
    }

    // Phương thức lấy về một user theo userID
    public tblUsers getUserByID(String userID) {
        tblUsers user = null;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT * FROM tblUsers WHERE userID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, userID);
                ResultSet table = pst.executeQuery();
                if (table != null && table.next()) {
                    user = new tblUsers();
                    user.setUserID(table.getString("userID"));
                    user.setFirstName(table.getString("firstName"));
                        user.setLastName(table.getString("lastName"));
                        user.setUserName(table.getString("userName"));
                        user.setPassword(table.getString("password"));
                        user.setRoleID(table.getString("roleID"));
                        user.setGmail(table.getString("gmail"));
                        user.setPhone(table.getString("phone"));
                        user.setAddress(table.getString("address"));
                        user.setStatus(table.getBoolean("status"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return user;
    }

    // Phương thức lấy về một user theo email
    public tblUsers getUserByEmail(String email) {
        tblUsers user = null;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT * FROM tblUsers WHERE gmail = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, email);
                ResultSet table = pst.executeQuery();
                if (table != null && table.next()) {
                    user = new tblUsers();
                    user.setUserID(table.getString("userID"));
                    user.setFirstName(table.getString("firstName"));
                        user.setLastName(table.getString("lastName"));
                        user.setUserName(table.getString("userName"));
                        user.setPassword(table.getString("password"));
                        user.setRoleID(table.getString("roleID"));
                        user.setGmail(table.getString("gmail"));
                        user.setPhone(table.getString("phone"));
                        user.setAddress(table.getString("address"));
                        user.setStatus(table.getBoolean("status"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return user;
    }

    public boolean isEmailExistForOtherUser(String email, String userID) {
        Connection cn = null;
        boolean exist = false;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT gmail FROM tblUsers WHERE gmail = ? AND userID != ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, email);
                pst.setString(2, userID);
                ResultSet rs = pst.executeQuery();
                if (rs.next()) {
                    exist = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return exist;
    }

    // Phương thức chèn (insert) một user mới
    public boolean insertUser(tblUsers user) {
        Connection cn = null;
        boolean result = false;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "INSERT INTO tblUsers (userID, userName, firstName, lastName, password, roleID, gmail, address, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, user.getUserID());
                pst.setString(2, user.getUserName());
                pst.setString(3, user.getFirstName());
                pst.setString(4, user.getLastName());
                pst.setString(5, user.getPassword());
                pst.setString(6, user.getRoleID());
                pst.setString(7, user.getGmail());
                pst.setString(8, user.getAddress());
                pst.setBoolean(9, user.isStatus());
                result = pst.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public boolean isUserIDExist(String userID) {
        Connection cn = null;
        boolean exist = false;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT userID FROM tblUsers WHERE userID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, userID);
                ResultSet rs = pst.executeQuery();
                if (rs.next()) {
                    exist = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return exist;
    }

    public boolean isEmailExist(String email) {
        Connection cn = null;
        boolean exist = false;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT gmail FROM tblUsers WHERE gmail = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, email);
                ResultSet rs = pst.executeQuery();
                if (rs.next()) {
                    exist = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return exist;
    }

    // Phương thức cập nhật thông tin tài khoản
    public boolean updateUser(tblUsers user) {
        Connection cn = null;
        boolean result = false;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "UPDATE tblUsers SET firstName = ?, lastName = ?, userName = ?, password = ?, roleID = ?, gmail = ?, address = ?, status = ? WHERE userID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, user.getFirstName());
                pst.setString(2, user.getLastName());
                pst.setString(3, user.getUserName());
                pst.setString(4, user.getPassword());
                pst.setString(5, user.getRoleID());
                pst.setString(6, user.getGmail());
                pst.setString(7, user.getAddress());
                pst.setBoolean(8, user.isStatus());
                pst.setString(9, user.getUserID());
                result = pst.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }
// Phương thức xóa (chuyển trạng thái thành false) một user
// Phương thức tìm kiếm người dùng theo tên đầy đủ (full name)

    public ArrayList<tblUsers> searchUsersByLastName(String lastName) {
        ArrayList<tblUsers> users = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT * FROM tblUsers WHERE lastName LIKE ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, "%" + lastName + "%");
                ResultSet rs = pst.executeQuery();
                while (rs.next()) {
                    tblUsers user = new tblUsers();
                    user.setUserName(rs.getString("userID"));
                    user.setLastName(rs.getString("userName"));
                    user.setPassword(rs.getString("password"));
                    user.setRoleID(rs.getString("roleID"));
                    user.setGmail(rs.getString("gmail"));
                    user.setAddress(rs.getString("address"));
                    user.setStatus(rs.getBoolean("status"));
                    users.add(user);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return users;
    }

    public boolean deleteUser(String userID) {
        Connection cn = null;
        boolean result = false;
        try {
            cn = DBContext.makeConnection();
            if (cn != null) {
                String sql = "UPDATE tblUsers SET status = ? WHERE userID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setBoolean(1, false);
                pst.setString(2, userID);
                result = pst.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public static void main(String[] args) {
        UserDAO dao = new UserDAO();

        // Kiểm tra lấy user theo userID
        tblUsers user1 = dao.getUserByID("U001");
        System.out.println(dao.deleteUser("U001"));

        // Kiểm tra lấy user theo email
        tblUsers user2 = dao.getUserByEmail("tranthib@gmail.com");
        System.out.println(user2);
//
//        // Kiểm tra chèn user mới
//        tblUsers newUser = new tblUsers();
//        newUser.setUserID("U004");
//        newUser.setFullName("Pham Thi D");
//        newUser.setPassword("password4");
//        newUser.setRoleID("R2");
//        newUser.setGmail("phamthid@gmail.com");
//        newUser.setAddress("Hai Phong");
//        newUser.setStatus(true);
//        boolean insertResult = dao.insertUser(newUser);
//        System.out.println("Insert result: " + insertResult);
//
//        // Kiểm tra cập nhật thông tin user
//        newUser.setFullName("Pham Thi D Updated");
//        newUser.setPassword("newpassword4");
//        boolean updateResult = dao.updateUser(newUser);
//        System.out.println("Update result: " + updateResult);
    }
}
