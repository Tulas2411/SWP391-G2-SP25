package dao;

import Model.MarketingPost;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MarketingPostDAO {
    private Connection connection;

    // Constructor nhận connection từ lớp khác
    public MarketingPostDAO(Connection connection) {
        this.connection = connection;
    }

    // Phương thức để lấy tất cả MarketingPosts từ cơ sở dữ liệu
    public List<MarketingPost> getAllPosts() throws SQLException {
        List<MarketingPost> posts = new ArrayList<>();
        String query = "SELECT * FROM MarketingPosts";

        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                MarketingPost post = new MarketingPost();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setAuthor(rs.getString("author"));
                post.setCreateDate(rs.getString("createDate"));
                post.setStatus(rs.getString("status"));
                post.setImageLink(rs.getString("imageLink"));
                posts.add(post);
            }
        }
        return posts;
    }

    // Thêm một MarketingPost mới vào cơ sở dữ liệu
    public void addPost(MarketingPost post) throws SQLException {
        String query = "INSERT INTO MarketingPosts (title, content, author, createDate, status, imageLink) VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, post.getTitle());
            pstmt.setString(2, post.getContent());
            pstmt.setString(3, post.getAuthor());
            pstmt.setString(4, post.getCreateDate());
            pstmt.setString(5, post.getStatus());
            pstmt.setString(6, post.getImageLink());
            pstmt.executeUpdate();
        }
    }

    // Cập nhật một MarketingPost
    public void updatePost(MarketingPost post) throws SQLException {
        String query = "UPDATE MarketingPosts SET title = ?, content = ?, author = ?, createDate = ?, status = ?, imageLink = ? WHERE id = ?";

        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, post.getTitle());
            pstmt.setString(2, post.getContent());
            pstmt.setString(3, post.getAuthor());
            pstmt.setString(4, post.getCreateDate());
            pstmt.setString(5, post.getStatus());
            pstmt.setString(6, post.getImageLink());
            pstmt.setInt(7, post.getId());
            pstmt.executeUpdate();
        }
    }

    // Xóa một MarketingPost theo ID
    public void deletePost(int id) throws SQLException {
        String query = "DELETE FROM MarketingPosts WHERE id = ?";

        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        }
    }

    // Lấy một MarketingPost theo ID
    public MarketingPost getPostById(int id) throws SQLException {
        String query = "SELECT * FROM MarketingPosts WHERE id = ?";
        MarketingPost post = null;

        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                post = new MarketingPost();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setAuthor(rs.getString("author"));
                post.setCreateDate(rs.getString("createDate"));
                post.setStatus(rs.getString("status"));
                post.setImageLink(rs.getString("imageLink"));
            }
        }
        return post;
    }
}
