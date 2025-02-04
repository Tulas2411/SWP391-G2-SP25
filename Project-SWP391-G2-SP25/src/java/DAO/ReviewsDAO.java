/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.*;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author admin
 */
public class ReviewsDAO extends DBContext{
    public Map<Integer, Reviews> getAllReviewsbyProductID(int id) {
        Map<Integer, Reviews> list = new HashMap<>();
        try {
            String sql = "SELECT * "
                    + "FROM Reviews where ProductID = " + id;
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Reviews b = new Reviews();
                b.setReviewID(rs.getInt("ReviewID"));
                b.setProductID(rs.getInt("ProductID"));
                b.setCustomerID(rs.getInt("CustomerID"));
                b.setRating(rs.getInt("Rating"));
                b.setComment(rs.getString("Comment"));
                b.setReviewDate(rs.getDate("ReviewDate"));
                list.put(b.getReviewID(), b);
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }
    public static void main(String[] args) {
        ReviewsDAO r = new ReviewsDAO();
        System.out.println(r.getAllReviewsbyProductID(1));
    }
}
