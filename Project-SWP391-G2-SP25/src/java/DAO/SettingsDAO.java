package DAO;

import Model.Settings;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

public class SettingsDAO extends DBContext {

    public Map<Integer, Settings> getAllSettings() {
        Map<Integer, Settings> settingsList = new HashMap<>();
        String sql = "SELECT * FROM Settings";

        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Settings setting = extractSettingFromResultSet(rs);
                settingsList.put(setting.getSettingID(), setting);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching settings: " + e.getMessage());
        }
        return settingsList;
    }

    public Vector<Settings> getAllSettingsAsVector() {
        Vector<Settings> settings = new Vector<>();
        String sql = "SELECT * FROM Settings";

        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                settings.add(extractSettingFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching settings as vector: " + e.getMessage());
        }
        return settings;
    }

    public Settings getSettingByID(int id) {
        String sql = "SELECT * FROM Settings WHERE SettingID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractSettingFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching setting by ID: " + e.getMessage());
        }
        return null;
    }

    public boolean addSetting(Settings setting) {
        String sql = "INSERT INTO Settings (SettingType, SettingValue, Status) VALUES (?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setSettingPreparedStatement(ps, setting);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error adding setting: " + e.getMessage());
            return false;
        }
    }

    public boolean updateSetting(Settings setting) {
        String sql = "UPDATE Settings SET SettingType = ?, SettingValue = ?, Status = ? WHERE SettingID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setSettingPreparedStatement(ps, setting);
            ps.setInt(4, setting.getSettingID());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error updating setting: " + e.getMessage());
            return false;
        }
    }

    public boolean removeSetting(int id) {
        String sql = "DELETE FROM Settings WHERE SettingID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("Error removing setting: " + e.getMessage());
            return false;
        }
    }

    private Settings extractSettingFromResultSet(ResultSet rs) throws SQLException {
        Settings setting = new Settings();
        setting.setSettingID(rs.getInt("SettingID"));
        setting.setSettingType(rs.getString("SettingType"));
        setting.setSettingValue(rs.getString("SettingValue"));
        setting.setStatus(rs.getString("Status"));
        return setting;
    }

    private void setSettingPreparedStatement(PreparedStatement ps, Settings setting) throws SQLException {
        ps.setString(1, setting.getSettingType());
        ps.setString(2, setting.getSettingValue());
        ps.setString(3, setting.getStatus());
    }
}
