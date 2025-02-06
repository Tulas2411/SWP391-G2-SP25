/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import Model.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author Tùng Dương
 */
public class ProductDAO {
    private Connection conn;
    
    public ProductDAO() {
        conn = DBContext.makeConnection();
    }
    
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        try {
            String query = "SELECT * FROM Products";
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                products.add(new Product(
                    rs.getInt("ProductID"),
                    rs.getString("CategoryID"),
                    rs.getString("ProductName"),
                    rs.getString("Description"),
                    rs.getString("Provider"),
                    rs.getBigDecimal("Price"),
                    rs.getString("WarrantyPeriod"),
                    rs.getInt("Amount"),
                    rs.getString("ImageLink"),
                    rs.getBoolean("IsPromoted"),
                    rs.getTimestamp("CreateAt")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }
    
    public List<Product> getPromotedProducts() {
        List<Product> products = new ArrayList<>();
        try {
            String query = "SELECT * FROM Products WHERE IsPromoted = 1";
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                products.add(new Product(
                    rs.getInt("ProductID"),
                    rs.getString("CategoryID"),
                    rs.getString("ProductName"),
                    rs.getString("Description"),
                    rs.getString("Provider"),
                    rs.getBigDecimal("Price"),
                    rs.getString("WarrantyPeriod"),
                    rs.getInt("Amount"),
                    rs.getString("ImageLink"),
                    rs.getBoolean("IsPromoted"),
                    rs.getTimestamp("CreateAt")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }
    
    public boolean addProduct(Product product) {
        try {
            String query = "INSERT INTO Products (CategoryID, ProductName, Description, Provider, Price, WarrantyPeriod, Amount, ImageLink, IsPromoted) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, product.getCategoryId());
            ps.setString(2, product.getProductName());
            ps.setString(3, product.getDescription());
            ps.setString(4, product.getProvider());
            ps.setBigDecimal(5, product.getPrice());
            ps.setString(6, product.getWarrantyPeriod());
            ps.setInt(7, product.getAmount());
            ps.setString(8, product.getImageLink());
            ps.setBoolean(9, product.isIsPromoted());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateProduct(Product product) {
        try {
            String query = "UPDATE Products SET CategoryID = ?, ProductName = ?, Description = ?, Provider = ?, Price = ?, WarrantyPeriod = ?, Amount = ?, ImageLink = ?, IsPromoted = ? WHERE ProductID = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, product.getCategoryId());
            ps.setString(2, product.getProductName());
            ps.setString(3, product.getDescription());
            ps.setString(4, product.getProvider());
            ps.setBigDecimal(5, product.getPrice());
            ps.setString(6, product.getWarrantyPeriod());
            ps.setInt(7, product.getAmount());
            ps.setString(8, product.getImageLink());
            ps.setBoolean(9, product.isIsPromoted());
            ps.setInt(10, product.getProductId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean removeProduct(int productId) {
        try {
            String query = "DELETE FROM Products WHERE ProductID = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, productId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
