/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Products;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
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
                return b;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;

    }
    public void updateProduct1(Products product) {
        String sql = "UPDATE Products SET product_name = ?, description = ?, price = ?, quantity = ?, supplier_id = ?, category_id = ?, expiration_date = ?, img_url = ? WHERE product_id = ?";

        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setString(1, product.getProductName());
            pre.setString(2, product.getDescription());
            pre.setDouble(3, product.getPrice());
            pre.setInt(4, product.getQuantity());
            pre.setInt(5, product.getSupplierId());
            pre.setInt(6, product.getCategoryId());
            pre.setDate(7, new java.sql.Date(product.getExpirationDate().getTime()));
            pre.setString(8, product.getImg_url());
            pre.setInt(9, product.getProductId());

            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error updating product: " + e.getMessage());
        }
    }
    public static void main(String[] args) {
        ProductsDAO p = new ProductsDAO();
        System.out.println(p.GetProductbyID(1));
    }
}
