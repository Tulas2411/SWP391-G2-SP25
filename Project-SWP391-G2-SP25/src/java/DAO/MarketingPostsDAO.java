package DAO;

import Model.*;
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

    public List<MarketingPosts> getMarketingPostsByPage(int start, int limit) {
        List<MarketingPosts> posts = new ArrayList<>();
        String sql = "SELECT * FROM MarketingPosts LIMIT ?, ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, start); // Vị trí bắt đầu (tính từ 0)
            ps.setInt(2, limit); // Giới hạn số bài viết trên một trang

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                MarketingPosts post = extractMarketingPostFromResultSet(rs);
                posts.add(post);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching marketing posts by page: " + e.getMessage());
        }
        return posts;
    }

    // Lấy tổng số bài viết (dùng để tính số trang)
    public int getTotalMarketingPosts() {
        int totalRecords = 0;
        String sql = "SELECT COUNT(*) FROM MarketingPosts";

        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) {
                totalRecords = rs.getInt(1); // Số lượng bản ghi
            }
        } catch (SQLException e) {
            System.out.println("Error fetching total marketing posts: " + e.getMessage());
        }
        return totalRecords;
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
        String sql = "INSERT INTO MarketingPosts (Title, Content, Author, CreateDate, Status, ImageLink, CategoryID) VALUES (?, ?, ?, ?, ?, ?, ?)";

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
        String sql = "UPDATE MarketingPosts SET Title = ?, Content = ?, Author = ?, CreateDate = ?, Status = ?, ImageLink = ?, CategoryID = ? WHERE PostID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setMarketingPostPreparedStatement(ps, post);
            ps.setInt(8, post.getPostID());
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
        post.setCategory(rs.getString("CategoryID"));
        return post;
    }

    private void setMarketingPostPreparedStatement(PreparedStatement ps, MarketingPosts post) throws SQLException {
        ps.setString(1, post.getTitle());
        ps.setString(2, post.getContent());
        ps.setInt(3, post.getAuthor());
        ps.setDate(4, (Date) post.getCreateDate());
        ps.setString(5, post.getStatus());
        ps.setString(6, post.getImageLink());
        ps.setString(7, post.getCategory());
    }

    public boolean removePostCategory(String cateID) {
        String sql = "DELETE FROM marketingpostcategories WHERE CategoryID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, cateID);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("Error removing marketing post: " + e.getMessage());
            return false;
        }
    }

    public Map<String, PostCategory> getAllPostCategories() {
        Map<String, PostCategory> cateList = new HashMap<>();
        String sql = "SELECT * FROM marketingpostcategories";

        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                // Sử dụng phương thức extractMarketingPostFromResultSet để tạo đối tượng từ ResultSet
                PostCategory cate = new PostCategory();
                cate.setCategoryID(rs.getString("CategoryID"));
                cate.setCategoryName(rs.getString("CategoryName"));
                cateList.put(cate.getCategoryID(), cate); // Thêm đối tượng vào danh sách
            }
        } catch (SQLException e) {
            System.out.println("Error fetching marketing posts: " + e.getMessage());
        }

        return cateList; // Trả về danh sách các bài viết
    }

    public List<MarketingPosts> getAllPostAndPagination(int page, int limit, String cate) {
        List<MarketingPosts> posts = new ArrayList<>();
        String sql = "SELECT * FROM MarketingPosts";
        if (cate != null && !cate.trim().isEmpty()) {
            sql += " Where CategoryID = ?";
        }
        sql += " ORDER BY CreateDate DESC LIMIT ? OFFSET ?"; // Đúng thứ tự
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            if (cate != null && !cate.trim().isEmpty()) {
                ps.setString(1, cate);
                ps.setInt(2, limit);
                ps.setInt(3, (page - 1) * limit);
            } else {
                ps.setInt(1, limit);
                ps.setInt(2, (page - 1) * limit);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    MarketingPosts post = extractMarketingPostFromResultSet(rs);
                    posts.add(post);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching blogs: " + e.getMessage());
        }
        return posts;
    }

    public List<MarketingPosts> searchPostsByTitleAndContent(int page, int limit, String searchQuery) {
        List<MarketingPosts> posts = new ArrayList<>();
        String sql = "SELECT * FROM MarketingPosts WHERE Title LIKE ? OR Content LIKE ? ORDER BY CreateDate DESC LIMIT ? OFFSET ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String query = "%" + searchQuery + "%"; // Thêm % để tìm kiếm gần đúng
            ps.setString(1, query);
            ps.setString(2, query);
            ps.setInt(3, limit);
            ps.setInt(4, (page - 1) * limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                MarketingPosts post = extractMarketingPostFromResultSet(rs);
                posts.add(post);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching marketing posts: " + e.getMessage());
        }

        return posts; // Trả về danh sách các bài viết
    }

    public static void main(String[] args) {
        MarketingPostsDAO dao = new MarketingPostsDAO();
        MarketingPosts post = dao.getMarketingPostByID(4);
        post.setCategory("GTSP");
        System.out.println(dao.updateMarketingPost(post));
    }

    public boolean updateMarketingPost(int i, String title, String content, int author, java.util.Date createDate, String status, String imageLink) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
