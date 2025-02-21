/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Users;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author admin
 */
public class UsersDAO extends DBContext{
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
                u.setDateOfBirth(rs.getString("DateOfBirth"));
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
    public Users getUserByID(int id) {
        try {
            String strSQL = "select * from Users where UserID = ?";
            PreparedStatement stm = connection.prepareStatement(strSQL);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {

                Users u = new Users();
                u.setUserID(rs.getInt("UserID"));
                u.setFirstName(rs.getString("FirstName"));
                u.setLastName(rs.getString("LastName"));
                u.setGender(rs.getString("Gender"));
                u.setDateOfBirth(rs.getString("DateOfBirth"));
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
    
    // Lấy người dùng theo tên đăng nhập (UserName)
    public Users getUserByUserName(String userName) {
        String sql = "SELECT * FROM Users WHERE UserName = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, userName);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractUserFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching user by UserName: " + e.getMessage());
        }
        return null;
    }

    public boolean addUser(Users user) {
        String sql = "INSERT INTO Users (FirstName, LastName, Gender, DateOfBirth, UserName, Password, Role, Email, PhoneNumber, Address) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setUserPreparedStatement(ps, user);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error adding user: " + e.getMessage());
            return false;
        }
    }

    public boolean updateUser(Users user) {
        String sql = "UPDATE Users SET FirstName = ?, LastName = ?, Gender = ?, DateOfBirth = ?, UserName = ?, Password = ?, Role = ?, Email = ?, PhoneNumber = ?, Address = ? WHERE UserID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setUserPreparedStatement(ps, user);
            ps.setInt(11, user.getUserID());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error updating user: " + e.getMessage());
            return false;
        }
    }
    
    // Cập nhật thông tin người dùng chỉ cho phép sửa username, firstname, lastname, gender, DateOfBirth, PhoneNumber, Address
    public boolean updateUserProfile(Users user) {
        String sql = "UPDATE Users SET UserName = ?, FirstName = ?, LastName = ?, Gender = ?, DateOfBirth = ?, PhoneNumber = ?, Address = ? WHERE UserID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, user.getUserName());
            ps.setString(2, user.getFirstName());
            ps.setString(3, user.getLastName());
            ps.setString(4, user.getGender());
            ps.setString(5, user.getDateOfBirth());
            ps.setString(6, user.getPhoneNumber());
            ps.setString(7, user.getAddress());
            ps.setInt(8, user.getUserID());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error updating user profile: " + e.getMessage());
            return false;
        }
    }


    public boolean removeUser(int id) {
        String sql = "DELETE FROM Users WHERE UserID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("Error removing user: " + e.getMessage());
            return false;
        }
        return null;
    }
   
}
