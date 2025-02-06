package DAO;

import Model.ReplyBlog;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

public class ReplyBlogDAO extends DBContext {

    public Map<Integer, ReplyBlog> getAllReplies() {
        Map<Integer, ReplyBlog> replyList = new HashMap<>();
        String sql = "SELECT * FROM ReplyBlog";

        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                ReplyBlog reply = extractReplyFromResultSet(rs);
                replyList.put(reply.getReportID(), reply);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching replies: " + e.getMessage());
        }
        return replyList;
    }

    public Vector<ReplyBlog> getAllRepliesAsVector() {
        Vector<ReplyBlog> replies = new Vector<>();
        String sql = "SELECT * FROM ReplyBlog";

        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                replies.add(extractReplyFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching replies as vector: " + e.getMessage());
        }
        return replies;
    }

    public ReplyBlog getReplyByID(int reportID) {
        String sql = "SELECT * FROM ReplyBlog WHERE ReportID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, reportID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractReplyFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching reply by ID: " + e.getMessage());
        }
        return null;
    }

    public boolean addReply(ReplyBlog reply) {
        String sql = "INSERT INTO ReplyBlog (CustomerID, Description, ReportDate, Status) VALUES (?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setReplyPreparedStatement(ps, reply);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error adding reply: " + e.getMessage());
            return false;
        }
    }

    public boolean updateReply(ReplyBlog reply) {
        String sql = "UPDATE ReplyBlog SET CustomerID = ?, Description = ?, ReportDate = ?, Status = ? WHERE ReportID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setReplyPreparedStatement(ps, reply);
            ps.setInt(5, reply.getReportID());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error updating reply: " + e.getMessage());
            return false;
        }
    }

    public boolean removeReply(int reportID) {
        String sql = "DELETE FROM ReplyBlog WHERE ReportID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, reportID);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("Error removing reply: " + e.getMessage());
            return false;
        }
    }

    private ReplyBlog extractReplyFromResultSet(ResultSet rs) throws SQLException {
        ReplyBlog reply = new ReplyBlog();
        reply.setReportID(rs.getInt("ReportID"));
        reply.setCustomerID(rs.getInt("CustomerID"));
        reply.setDescription(rs.getString("Description"));
        reply.setReportDate(rs.getString("ReportDate"));
        reply.setStatus(rs.getString("Status"));
        return reply;
    }

    private void setReplyPreparedStatement(PreparedStatement ps, ReplyBlog reply) throws SQLException {
        ps.setInt(1, reply.getCustomerID());
        ps.setString(2, reply.getDescription());
        ps.setString(3, reply.getReportDate());
        ps.setString(4, reply.getStatus());
    }
}
