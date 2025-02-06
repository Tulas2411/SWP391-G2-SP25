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
   
}
