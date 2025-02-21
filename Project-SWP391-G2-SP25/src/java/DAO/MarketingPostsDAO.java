package DAO;

import Model.MarketingPosts;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

public class MarketingPostsDAO extends DBContext {

    public List<MarketingPosts> getAllMarketingPosts() {
        List<MarketingPosts> postList = new ArrayList<>();
        String sql = "SELECT * FROM MarketingPosts";

        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                // Sử dụng phương thức extractMarketingPostFromResultSet để tạo đối tượng từ ResultSet
                MarketingPosts post = extractMarketingPostFromResultSet(rs);
                postList.add(post); // Thêm đối tượng vào danh sách
            }
        } catch (SQLException e) {
            System.out.println("Error fetching marketing posts: " + e.getMessage());
        }

        return postList; // Trả về danh sách các bài viết
    }

    public Map<Integer, MarketingPosts> getAllMarketingPostsAsMap() {
    Map<Integer, MarketingPosts> postMap = new HashMap<>();
    String sql = "SELECT * FROM MarketingPosts";

    try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
        while (rs.next()) {
            // Sử dụng phương thức extractMarketingPostFromResultSet để tạo đối tượng từ ResultSet
            MarketingPosts post = extractMarketingPostFromResultSet(rs);
            postMap.put(post.getPostID(), post); // Thêm vào map với postID làm key
        }
    } catch (SQLException e) {
        System.out.println("Error fetching marketing posts: " + e.getMessage());
    }

    return postMap; // Trả về map chứa các bài viết
}

    public Vector<MarketingPosts> getAllMarketingPostsAsVector() {
        Vector<MarketingPosts> posts = new Vector<>();
        String sql = "SELECT * FROM MarketingPosts";

        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                posts.add(extractMarketingPostFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching marketing posts as vector: " + e.getMessage());
        }
        return posts;
    }

    public List<MarketingPosts> getLatestPosts(int limit) {
        List<MarketingPosts> posts = new ArrayList<>();
        String query = "SELECT * FROM MarketingPosts WHERE Status = 'Published' ORDER BY CreateDate DESC LIMIT ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                MarketingPosts post = extractMarketingPostFromResultSet(rs);
                posts.add(post);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching latest posts: " + e.getMessage());
        }
        return posts;
    }

    public MarketingPosts getMarketingPostByID(int postID) {
        String sql = "SELECT * FROM MarketingPosts WHERE PostID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, postID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractMarketingPostFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching marketing post by ID: " + e.getMessage());
        }
        return null;
    }

    public boolean addMarketingPost(MarketingPosts post) {
        String sql = "INSERT INTO MarketingPosts (Title, Content, Author, CreateDate, Status, ImageLink) VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setMarketingPostPreparedStatement(ps, post);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error adding marketing post: " + e.getMessage());
            return false;
        }
    }

    public boolean updateMarketingPost(MarketingPosts post) {
        String sql = "UPDATE MarketingPosts SET Title = ?, Content = ?, Author = ?, CreateDate = ?, Status = ?, ImageLink = ? WHERE PostID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setMarketingPostPreparedStatement(ps, post);
            ps.setInt(7, post.getPostID());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error updating marketing post: " + e.getMessage());
            return false;
        }
    }

    public boolean removeMarketingPost(int postID) {
        String sql = "DELETE FROM MarketingPosts WHERE PostID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, postID);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("Error removing marketing post: " + e.getMessage());
            return false;
        }
    }

    private MarketingPosts extractMarketingPostFromResultSet(ResultSet rs) throws SQLException {
        MarketingPosts post = new MarketingPosts();
        post.setPostID(rs.getInt("PostID"));
        post.setTitle(rs.getString("Title"));
        post.setContent(rs.getString("Content"));
        post.setAuthor(rs.getInt("Author"));
        post.setCreateDate(rs.getDate("CreateDate"));
        post.setStatus(rs.getString("Status"));
        post.setImageLink(rs.getString("ImageLink"));
        return post;
    }

    private void setMarketingPostPreparedStatement(PreparedStatement ps, MarketingPosts post) throws SQLException {
        ps.setString(1, post.getTitle());
        ps.setString(2, post.getContent());
        ps.setInt(3, post.getAuthor());
        ps.setDate(4, (Date) post.getCreateDate());
        ps.setString(5, post.getStatus());
        ps.setString(6, post.getImageLink());
    }
//public static void main(String[] args) {
//        MarketingPostsDAO dao = new MarketingPostsDAO();
//        List<MarketingPosts> list = dao.getAllMarketingPostsAsMap();
//        for (MarketingPosts o : list) {
//            System.out.println(o);
//        }
//    }

    public boolean updateMarketingPost(int i, String title, String content, int author, java.util.Date createDate, String status, String imageLink) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    }

