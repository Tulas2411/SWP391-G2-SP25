package DAO;

import Model.Reply;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

public class ReplyDAO extends DBContext {

    public Map<Integer, Reply> getAllRepliesByReviewID(int reviewID) {
        Map<Integer, Reply> replyList = new HashMap<>();
        String sql = "SELECT * FROM Reply WHERE ReviewID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, reviewID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Reply reply = extractReplyFromResultSet(rs);
                    replyList.put(reply.getReplyID(), reply);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching replies: " + e.getMessage());
        }
        return replyList;
    }

    public Vector<Reply> getAllRepliesAsVectorByReviewID(int reviewID) {
        Vector<Reply> replies = new Vector<>();
        String sql = "SELECT * FROM Reply WHERE ReviewID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, reviewID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    replies.add(extractReplyFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching replies as vector: " + e.getMessage());
        }
        return replies;
    }

    public Reply getReplyByID(int replyID) {
        String sql = "SELECT * FROM Reply WHERE ReplyID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, replyID);
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

    public boolean addReply(Reply reply) {
        String sql = "INSERT INTO Reply (ReviewID, ReplyComment, ReplyDate) VALUES (?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setReplyPreparedStatement(ps, reply);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error adding reply: " + e.getMessage());
            return false;
        }
    }

    public boolean updateReply(Reply reply) {
        String sql = "UPDATE Reply SET ReviewID = ?, ReplyComment = ?, ReplyDate = ? WHERE ReplyID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setReplyPreparedStatement(ps, reply);
            ps.setInt(4, reply.getReplyID());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error updating reply: " + e.getMessage());
            return false;
        }
    }

    public boolean removeReply(int replyID) {
        String sql = "DELETE FROM Reply WHERE ReplyID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, replyID);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("Error removing reply: " + e.getMessage());
            return false;
        }
    }

    private Reply extractReplyFromResultSet(ResultSet rs) throws SQLException {
        Reply reply = new Reply();
        reply.setReplyID(rs.getInt("ReplyID"));
        reply.setReviewID(rs.getInt("ReviewID"));
        reply.setReplyComment(rs.getString("ReplyComment"));
        reply.setReplyDate(rs.getString("ReplyDate"));
        return reply;
    }

    private void setReplyPreparedStatement(PreparedStatement ps, Reply reply) throws SQLException {
        ps.setInt(1, reply.getReviewID());
        ps.setString(2, reply.getReplyComment());
        ps.setString(3, reply.getReplyDate());
    }
}
