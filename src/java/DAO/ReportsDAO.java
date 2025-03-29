package DAO;

import Model.Reports;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

public class ReportsDAO extends DBContext {

    public Map<Integer, Reports> getAllReports() {
        Map<Integer, Reports> reportList = new HashMap<>();
        String sql = "SELECT * FROM Reports";

        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Reports report = extractReportFromResultSet(rs);
                reportList.put(report.getReportID(), report);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching reports: " + e.getMessage());
        }
        return reportList;
    }

    public Vector<Reports> getAllReportsAsVector() {
        Vector<Reports> reports = new Vector<>();
        String sql = "SELECT * FROM Reports";

        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                reports.add(extractReportFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching reports as vector: " + e.getMessage());
        }
        return reports;
    }

    public Reports getReportByID(int reportID) {
        String sql = "SELECT * FROM Reports WHERE ReportID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, reportID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractReportFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching report by ID: " + e.getMessage());
        }
        return null;
    }

    public boolean addReport(Reports report) {
        String sql = "INSERT INTO Reports (CustomerID, Description, ReportDate, Status) VALUES (?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setReportPreparedStatement(ps, report);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error adding report: " + e.getMessage());
            return false;
        }
    }

    public boolean updateReport(Reports report) {
        String sql = "UPDATE Reports SET CustomerID = ?, Description = ?, ReportDate = ?, Status = ? WHERE ReportID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setReportPreparedStatement(ps, report);
            ps.setInt(5, report.getReportID());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error updating report: " + e.getMessage());
            return false;
        }
    }

    public boolean removeReport(int reportID) {
        String sql = "DELETE FROM Reports WHERE ReportID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, reportID);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("Error removing report: " + e.getMessage());
            return false;
        }
    }

    private Reports extractReportFromResultSet(ResultSet rs) throws SQLException {
        Reports report = new Reports();
        report.setReportID(rs.getInt("ReportID"));
        report.setCustomerID(rs.getInt("CustomerID"));
        report.setDescription(rs.getString("Description"));
        report.setReportDate(rs.getString("ReportDate"));
        report.setStatus(rs.getString("Status"));
        return report;
    }

    private void setReportPreparedStatement(PreparedStatement ps, Reports report) throws SQLException {
        ps.setInt(1, report.getCustomerID());
        ps.setString(2, report.getDescription());
        ps.setString(3, report.getReportDate());
        ps.setString(4, report.getStatus());
    }
}
