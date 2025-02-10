package DAO;

import Model.CommentBlog;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

public class CommentBlogDAO extends DBContext {

    public Map<Integer, CommentBlog> getAllComments() {
        Map<Integer, CommentBlog> commentList = new HashMap<>();
        String sql = "SELECT * FROM CommentBlog";

        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                CommentBlog comment = extractCommentFromResultSet(rs);
                commentList.put(comment.getCommentID(), comment);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching comments: " + e.getMessage());
        }
        return commentList;
    }

    public Vector<CommentBlog> getAllCommentsAsVector() {
        Vector<CommentBlog> comments = new Vector<>();
        String sql = "SELECT * FROM CommentBlog";

        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                comments.add(extractCommentFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching comments as vector: " + e.getMessage());
        }
        return comments;
    }

    public Vector<CommentBlog> getCommentsByBlogID(int blogID) {
        Vector<CommentBlog> commentsList = new Vector<>();
        String sql = "SELECT * FROM CommentBlog WHERE BlogID = ? ORDER BY CreateAt DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, blogID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    commentsList.add(extractCommentFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching comments by BlogID: " + e.getMessage());
        }
        return commentsList;
    }

    public CommentBlog getCommentByID(int commentID) {
        String sql = "SELECT * FROM CommentBlog WHERE CommentID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, commentID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractCommentFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching comment by ID: " + e.getMessage());
        }
        return null;
    }

    public boolean addComment(CommentBlog comment) {
        String sql = "INSERT INTO CommentBlog (BlogID, UserID, Content, CreateAt) VALUES (?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setCommentPreparedStatement(ps, comment);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error adding comment: " + e.getMessage());
            return false;
        }
    }

    public boolean updateComment(CommentBlog comment) {
        String sql = "UPDATE CommentBlog SET BlogID = ?, UserID = ?, Content = ?, CreateAt = ? WHERE CommentID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setCommentPreparedStatement(ps, comment);
            ps.setInt(5, comment.getCommentID());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error updating comment: " + e.getMessage());
            return false;
        }
    }

    public boolean removeComment(int commentID) {
        String sql = "DELETE FROM CommentBlog WHERE CommentID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, commentID);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("Error removing comment: " + e.getMessage());
            return false;
        }
    }

    private CommentBlog extractCommentFromResultSet(ResultSet rs) throws SQLException {
        CommentBlog comment = new CommentBlog();
        comment.setCommentID(rs.getInt("CommentID"));
        comment.setBlogID(rs.getInt("BlogID"));
        comment.setUserID(rs.getInt("UserID"));
        comment.setContent(rs.getString("Content"));
        comment.setCreateAt(rs.getString("CreateAt"));
        return comment;
    }

    private void setCommentPreparedStatement(PreparedStatement ps, CommentBlog comment) throws SQLException {
        ps.setInt(1, comment.getBlogID());
        ps.setInt(2, comment.getUserID());
        ps.setString(3, comment.getContent());
        ps.setString(4, comment.getCreateAt());
    }
}
