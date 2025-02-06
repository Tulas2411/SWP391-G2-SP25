/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import DAO.DBContext;
import Dto.tblUsers;
import Model.Users;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author Acer
 */
public class UserDAO extends DBContext{

    // Phương thức lấy về danh sách tất cả user
    public ArrayList<tblUsers> listUsers() {
        ArrayList<tblUsers> users = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBContext.makeConnection();
            if (cn != null) {
                String sql = "SELECT * FROM User";
                Statement st = cn.createStatement();
                ResultSet table = st.executeQuery(sql);
                if (table != null) {
                    while (table.next()) {
                        tblUsers user = new tblUsers();
                        user.setUserID(table.getString("UserID"));
                        user.setFirstName(table.getString("FirstName"));
                        user.setLastName(table.getString("LastName"));
                        user.setUserName(table.getString("UserName"));
                        user.setPassword(table.getString("Password"));
                        user.setRole(table.getString("Role"));
                        user.setGmail(table.getString("Email"));
                        user.setPhone(table.getString("PhoneNumber"));
                        user.setAddress(table.getString("Address"));
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
            cn = DBContext.makeConnection();
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
                        user.setRole(table.getString("roleID"));
                        user.setGmail(table.getString("gmail"));
                        user.setPhone(table.getString("phone"));
                        user.setAddress(table.getString("address"));
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
            cn = DBContext.makeConnection();
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
                        user.setRole(table.getString("roleID"));
                        user.setGmail(table.getString("gmail"));
                        user.setPhone(table.getString("phone"));
                        user.setAddress(table.getString("address"));
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
            cn = DBContext.makeConnection();
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
            cn = DBContext.makeConnection();
            if (cn != null) {
                String sql = "INSERT INTO tblUsers (userID, userName, firstName, lastName, password, roleID, gmail, address, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, user.getUserID());
                pst.setString(2, user.getUserName());
                pst.setString(3, user.getFirstName());
                pst.setString(4, user.getLastName());
                pst.setString(5, user.getPassword());
                pst.setString(6, user.getRole());
                pst.setString(7, user.getGmail());
                pst.setString(8, user.getAddress());
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
            cn = DBContext.makeConnection();
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
            cn = DBContext.makeConnection();
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
            cn = DBContext.makeConnection();
            if (cn != null) {
                String sql = "UPDATE tblUsers SET firstName = ?, lastName = ?, userName = ?, password = ?, roleID = ?, gmail = ?, address = ?, status = ? WHERE userID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, user.getFirstName());
                pst.setString(2, user.getLastName());
                pst.setString(3, user.getUserName());
                pst.setString(4, user.getPassword());
                pst.setString(5, user.getRole());
                pst.setString(6, user.getGmail());
                pst.setString(7, user.getAddress());
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
            cn = DBContext.makeConnection();
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
                    user.setRole(rs.getString("roleID"));
                    user.setGmail(rs.getString("gmail"));
                    user.setAddress(rs.getString("address"));
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

    public Map<Integer, Users> getAllUsers() {
        Map<Integer, Users> list = new HashMap<>();
        try {
            String sql = "SELECT * FROM Users";
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Users u = new Users();
                u.setUserID(rs.getInt("UserID"));
                u.setFirstName(rs.getString("FirstName"));
                u.setLastName(rs.getString("LastName"));
                u.setGender(rs.getString("Gender"));
                u.setDateOfBirth(rs.getDate("DateOfBirth"));
                u.setUserName(rs.getString("UserName"));
                u.setPassword(rs.getString("Password"));
                u.setRole(rs.getString("Role"));
                u.setEmail(rs.getString("Email"));
                u.setPhoneNumber(rs.getString("PhoneNumber"));
                u.setAddress(rs.getString("Address"));
                
                list.put(u.getUserID(), u);
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            e.printStackTrace();  // In lỗi ra console để kiểm tra
        }
        return list;
    }
    PreparedStatement stm;//thuc hien cau lenh sql
    ResultSet rs;//dung luu tru du lieu lay ve tu select
    public Users getUserByID(int id) {
        try {
            String strSQL = "select * from Users where UserID = ?";
            stm = connection.prepareStatement(strSQL);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            while (rs.next()) {

                Users u = new Users();
                u.setUserID(rs.getInt("UserID"));
                u.setFirstName(rs.getString("FirstName"));
                u.setLastName(rs.getString("LastName"));
                u.setGender(rs.getString("Gender"));
                u.setDateOfBirth(rs.getDate("DateOfBirth"));
                u.setUserName(rs.getString("UserName"));
                u.setPassword(rs.getString("Password"));
                u.setRole(rs.getString("Role"));
                u.setEmail(rs.getString("Email"));
                u.setPhoneNumber(rs.getString("PhoneNumber"));
                u.setAddress(rs.getString("Address"));
                
                return u;
            }
        } catch (Exception e) {
            System.out.println("getUserByAcc: " + e.getMessage());
        }
        return null;
    }
    
    public static void main(String[] args) {
        UserDAO dao = new UserDAO();
        //<%=uDAO.getUserByID(r.getCustomerID()).getFirstName()%>
        System.out.println(dao.getUserByID(1));
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
