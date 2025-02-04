/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import Dto.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author Tùng Dương
 */
public class CategoryDAO {
    private Connection conn;
    
    public CategoryDAO() {
        conn = DBContext.makeConnection();
    }
    
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        try {
            String query = "SELECT * FROM Category";
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                categories.add(new Category(rs.getString("CategoryID"), rs.getString("CategoryName")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }
    
    public Category getCategoryById(String id) {
        try {
            String query = "SELECT * FROM Category WHERE CategoryID = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Category(rs.getString("CategoryID"), rs.getString("CategoryName"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean addCategory(Category category) {
        try {
            String query = "INSERT INTO Category (CategoryID, CategoryName) VALUES (?, ?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, category.getCategoryId());
            ps.setString(2, category.getCategoryName());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateCategory(Category category) {
        try {
            String query = "UPDATE Category SET CategoryName = ? WHERE CategoryID = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, category.getCategoryName());
            ps.setString(2, category.getCategoryId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean removeCategory(String id) {
        try {
            String query = "DELETE FROM Category WHERE CategoryID = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}