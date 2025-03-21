/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.UserLog;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class UserLogDAO extends DBContext {

    public List<UserLog> getAllUserLogs() {
        List<UserLog> logs = new ArrayList<>();
        String sql = "SELECT id, userID, log, email, full_name, gender, mobile, address, updated_by, change_date " +
                     "FROM User_Logs ORDER BY change_date DESC";

        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                UserLog log = new UserLog();
                log.setId(rs.getInt("id"));
                log.setUserId(rs.getInt("userID"));
                log.setLog(rs.getString("log"));
                log.setEmail(rs.getString("email"));
                log.setFullName(rs.getString("full_name"));
                log.setGender(rs.getString("gender"));
                log.setMobile(rs.getString("mobile"));
                log.setAddress(rs.getString("address"));
                log.setUpdatedBy(rs.getString("updated_by"));
                log.setChangeDate(rs.getTimestamp("change_date")); // Fixed method name
                logs.add(log);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching user logs: " + e.getMessage());
        }
        return logs;
    }

    public List<UserLog> getLogsByUserId(int userId) {
        List<UserLog> logs = new ArrayList<>();
        String sql = "SELECT id, userID, log, email, full_name, gender, mobile, address, updated_by, change_date " +
                     "FROM User_Logs WHERE userID = ? ORDER BY change_date DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    UserLog log = new UserLog();
                    log.setId(rs.getInt("id"));
                    log.setUserId(rs.getInt("userID"));
                    log.setLog(rs.getString("log"));
                    log.setEmail(rs.getString("email"));
                    log.setFullName(rs.getString("full_name"));
                    log.setGender(rs.getString("gender"));
                    log.setMobile(rs.getString("mobile"));
                    log.setAddress(rs.getString("address"));
                    log.setUpdatedBy(rs.getString("updated_by"));
                    log.setChangeDate(rs.getTimestamp("change_date"));
                    logs.add(log);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching user logs by userId: " + e.getMessage());
        }
        return logs;
    }

    public boolean addLogs(UserLog userLog) {
        String sql = "INSERT INTO User_Logs (userID, log, email, full_name, gender, mobile, address, updated_by, change_date) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userLog.getUserId());
            ps.setString(2, userLog.getLog());
            ps.setString(3, userLog.getEmail());
            ps.setString(4, userLog.getFullName());
            ps.setString(5, userLog.getGender());
            ps.setString(6, userLog.getMobile());
            ps.setString(7, userLog.getAddress());
            ps.setString(8, userLog.getUpdatedBy());
            ps.setTimestamp(9, new Timestamp(System.currentTimeMillis())); // Set change_date to current timestamp
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error adding user log: " + e.getMessage());
            return false;
        }
    }

    public static void main(String[] args) {
        UserLogDAO dao = new UserLogDAO();
        System.out.println("Total logs: " + dao.getAllUserLogs().size());
    }
}