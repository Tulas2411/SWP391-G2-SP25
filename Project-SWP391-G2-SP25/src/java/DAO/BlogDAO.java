package DAO;

import Model.Blog;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

public class BlogDAO extends DBContext {

    public Map<Integer, Blog> getAllBlogs() {
        Map<Integer, Blog> blogList = new HashMap<>();
        String sql = "SELECT * FROM Blog";

        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Blog blog = extractBlogFromResultSet(rs);
                blogList.put(blog.getBlogID(), blog);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching blogs: " + e.getMessage());
        }
        return blogList;
    }

    public Vector<Blog> getAllBlogsAsVector() {
        Vector<Blog> blogs = new Vector<>();
        String sql = "SELECT * FROM Blog";

        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                blogs.add(extractBlogFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching blogs as vector: " + e.getMessage());
        }
        return blogs;
    }

    public Blog getBlogByID(int blogID) {
        String sql = "SELECT * FROM Blog WHERE BlogID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, blogID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractBlogFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching blog by ID: " + e.getMessage());
        }
        return null;
    }

    public boolean addBlog(Blog blog) {
        String sql = "INSERT INTO Blog (CateID, Title, Author, Image, BriefInfor, CreateDate, BlogContent, Status, Thumbnail, Flag, DateModified, NumberOfAccess) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setBlogPreparedStatement(ps, blog);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error adding blog: " + e.getMessage());
            return false;
        }
    }

    public boolean updateBlog(Blog blog) {
        String sql = "UPDATE Blog SET CateID = ?, Title = ?, Author = ?, Image = ?, BriefInfor = ?, CreateDate = ?, BlogContent = ?, Status = ?, Thumbnail = ?, Flag = ?, DateModified = ?, NumberOfAccess = ? WHERE BlogID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setBlogPreparedStatement(ps, blog);
            ps.setInt(13, blog.getBlogID());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error updating blog: " + e.getMessage());
            return false;
        }
    }

    public boolean removeBlog(int blogID) {
        String sql = "DELETE FROM Blog WHERE BlogID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, blogID);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("Error removing blog: " + e.getMessage());
            return false;
        }
    }

    private Blog extractBlogFromResultSet(ResultSet rs) throws SQLException {
        Blog blog = new Blog();
        blog.setBlogID(rs.getInt("BlogID"));
        blog.setCateID(rs.getString("CateID"));
        blog.setTitle(rs.getString("Title"));
        blog.setAuthor(rs.getInt("Author"));
        blog.setImage(rs.getString("Image"));
        blog.setBriefInfor(rs.getString("BriefInfor"));
        blog.setCreateDate(rs.getDate("CreateDate"));
        blog.setBlogContent(rs.getString("BlogContent"));
        blog.setStatus(rs.getString("Status"));
        blog.setThumbnail(rs.getString("Thumbnail"));
        blog.setFlag(rs.getBoolean("Flag"));
        blog.setDateModified(rs.getDate("DateModified"));
        blog.setNumberOfAccess(rs.getInt("NumberOfAccess"));
        return blog;
    }

    private void setBlogPreparedStatement(PreparedStatement ps, Blog blog) throws SQLException {
        ps.setString(1, blog.getCateID());
        ps.setString(2, blog.getTitle());
        ps.setInt(3, blog.getAuthor());
        ps.setString(4, blog.getImage());
        ps.setString(5, blog.getBriefInfor());
        ps.setDate(6, new java.sql.Date(blog.getCreateDate().getTime()));
        ps.setString(7, blog.getBlogContent());
        ps.setString(8, blog.getStatus());
        ps.setString(9, blog.getThumbnail());
        ps.setBoolean(10, blog.getFlag());
        ps.setDate(11, new java.sql.Date(blog.getDateModified().getTime()));
        ps.setInt(12, blog.getNumberOfAccess());
    }
}
