/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Settings;
import Model.UserLog;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class UserLogDAO extends DBContext {

    public List<UserLog> getAllUserLogs() {
        List<UserLog> logs = new ArrayList<>();
        String sql = "SELECT * FROM User_Logs Order by change_date desc";

        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                UserLog log = new UserLog();
                log.setId(rs.getInt("id"));
                log.setLog(rs.getString("log"));
                log.setChange_date(rs.getTimestamp("change_date"));
                log.setUserId(rs.getInt("userID"));
                logs.add(log);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching settings: " + e.getMessage());
        }
        return logs;
    }

    public boolean addLogs(UserLog userLog) {
        String sql = "INSERT INTO User_Logs (userID , log) VALUES (?,  ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userLog.getUserId());
            ps.setString(2, userLog.getLog());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error adding setting: " + e.getMessage());
            return false;
        }
    }

    public static void main(String[] args) {
        System.out.println(new UserLogDAO().getAllUserLogs().size());
    }
}
