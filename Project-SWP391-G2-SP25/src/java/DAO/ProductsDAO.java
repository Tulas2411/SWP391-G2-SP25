/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author admin
 */
public class ProductsDAO extends DBContext{
    public Map<Integer, Products> getAllProducts() {
        Map<Integer, Products> list = new HashMap<>();
        try {
            String sql = "SELECT * "
                    + "FROM Products";
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Products b = new Products();
                b.setProductID(rs.getInt("ProductID"));
                b.setCategoryID(rs.getString("CategoryID"));
                b.setProductName(rs.getString("ProductName"));
                b.setDescription(rs.getString("Description"));
                b.setProvider(rs.getString("Provider"));
                b.setPrice(rs.getFloat("Price"));
                b.setWarrantyPeriod(rs.getString("WarrantyPeriod"));
                b.setAmount(rs.getInt("Amount"));
                b.setImageLink(rs.getString("ImageLink"));
                b.setIsPromoted(rs.getBoolean("IsPromoted"));
                b.setCreatAt(rs.getDate("CreateAt"));
                b.setOldPrice(rs.getInt("OldPrice"));
                list.put(b.getProductID(), b);
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }
    public Products GetProductbyID(int id) {
        try {
            String sql = "Select * from Products where ProductID = " + id;
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            if (rs.next()) {
                Products b = new Products();
                b.setProductID(rs.getInt("ProductID"));
                b.setCategoryID(rs.getString("CategoryID"));
                b.setProductName(rs.getString("ProductName"));
                b.setDescription(rs.getString("Description"));
                b.setProvider(rs.getString("Provider"));
                b.setPrice(rs.getFloat("Price"));
                b.setWarrantyPeriod(rs.getString("WarrantyPeriod"));
                b.setAmount(rs.getInt("Amount"));
                b.setImageLink(rs.getString("ImageLink"));
                b.setIsPromoted(rs.getBoolean("IsPromoted"));
                b.setCreatAt(rs.getDate("CreateAt"));
                b.setOldPrice(rs.getInt("OldPrice"));
                return b;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;

    }
    public boolean updateProduct1(Products product) {
        String sql = "UPDATE Products SET CategoryID = ?, ProductName = ?, Description = ?, Provider = ?, Price = ?, WarrantyPeriod = ?, Amount = ?, ImageLink = ?, IsPromoted = ?, OldPrice = ? WHERE ProductID = ?";

        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setString(1, product.getCategoryID());
            pre.setString(2, product.getProductName());
            pre.setString(3, product.getDescription());
            pre.setString(4, product.getProvider());
            pre.setFloat(5, product.getPriceFloat());
            pre.setString(6, product.getWarrantyPeriod());
            pre.setInt(7, product.getAmount());
            pre.setString(8, product.getImageLink());
            pre.setBoolean(9, product.isIsPromoted());
            pre.setFloat(10, product.getOldPriceFloat());
            pre.setInt(11, product.getProductID());
            
            
            pre.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error updating product: " + e.getMessage());
            return false;
        }
    }
    
    public Category GetCategorybyID(String id) {
        try {
            String sql = "Select * from Category where CategoryID = " + "'" + id + "'";
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            if (rs.next()) {
                Category b = new Category();
                b.setCategoryID(rs.getString("CategoryID"));
                b.setCategoryName(rs.getString("CategoryName"));
                return b;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;

    }
    
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        try {
            String query = "SELECT * FROM Category";
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                categories.add(new Category(rs.getString("CategoryID"), rs.getString("CategoryName")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }
    
    public static void main(String[] args) {
        ProductsDAO p = new ProductsDAO();
        Products p1 = p.GetProductbyID(1);
        p1.setProductName("Quat dien aaa");
        System.out.println(p.updateProduct1(p1));
    }
}
