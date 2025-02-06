/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.*;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author admin
 */
public class ProductDetailDAO extends DBContext{
    public ProductDetail ProductDetailbyProductID(int id) {
        try {
            String sql = "Select * from ProductDetails where ProductID = " + id;
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            if (rs.next()) {
                ProductDetail b = new ProductDetail();
                b.setProductDetailID(rs.getInt("ProductDetailID"));
                b.setProductID(rs.getInt("ProductID"));
                b.setProductDetailName(rs.getString("ProductDetailName"));
                b.setValue(rs.getString("Value"));
                return b;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;

    }
    public static void main(String[] args) {
        ProductDetailDAO p = new ProductDetailDAO();
        System.out.println(p.ProductDetailbyProductID(1));
    }
}
