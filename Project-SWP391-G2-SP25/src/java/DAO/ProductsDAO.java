/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Products;
import java.sql.ResultSet;
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
    public static void main(String[] args) {
        ProductsDAO p = new ProductsDAO();
        System.out.println(p.getAllProducts());
    }
}
