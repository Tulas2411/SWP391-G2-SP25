/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author admin
 */
public class GuestDAO extends DBContext{
    public Map<Integer, Guest> getAllGuest() {
        Map<Integer, Guest> userList = new HashMap<>();
        String sql = "SELECT * FROM Guest";
        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Guest user = extractGuestFromResultSet(rs);
                userList.put(user.getGuestID(), user);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching all users: " + e.getMessage());
        }
        return userList;
    }
    private void setUserPreparedStatement(PreparedStatement ps, Guest user) throws SQLException {
        ps.setString(1, user.getFirstName());
        ps.setString(2, user.getLastName());
        ps.setString(3, user.getGender());
        ps.setString(4, user.getEmail());
        ps.setString(5, user.getPhoneNumber());
        ps.setString(6, user.getAddress());
    }

    private Guest extractGuestFromResultSet(ResultSet rs) throws SQLException {
        Guest user = new Guest();
        user.setGuestID(rs.getInt("GuestID"));
        user.setFirstName(rs.getString("FirstName"));
        user.setLastName(rs.getString("LastName"));
        user.setGender(rs.getString("Gender"));
        user.setEmail(rs.getString("Email"));
        user.setPhoneNumber(rs.getString("PhoneNumber"));
        user.setAddress(rs.getString("Address"));
        user.setStatus(rs.getString("Status"));
        return user;
    }
    public boolean addGuest(Guest user) {
        String sql = "INSERT INTO Guest (FirstName, LastName, Gender, Email, PhoneNumber, Address) VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setUserPreparedStatement(ps, user);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("Error adding user: " + e.getMessage());
            return false;
        }
    }
    
    public Guest getLatestGuest() {
    Guest latestGuest = null;
    String sql = "SELECT * FROM Guest ORDER BY GuestID DESC LIMIT 1"; // Lấy Guest mới nhất theo ID
    try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
        if (rs.next()) {
            latestGuest = extractGuestFromResultSet(rs);
        }
    } catch (SQLException e) {
        System.out.println("Error fetching the latest guest: " + e.getMessage());
    }
    return latestGuest;
}
    
    public static void main(String[] args) {
        GuestDAO gDAO = new GuestDAO();
        System.out.println(gDAO.getLatestGuest().getStatus());
    }
}
