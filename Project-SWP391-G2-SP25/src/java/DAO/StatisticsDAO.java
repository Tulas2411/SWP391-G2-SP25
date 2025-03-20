/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StatisticsDAO extends DBContext{

    public List<ArticleStats> getTopViewedArticles() {
        List<ArticleStats> articles = new ArrayList<>();
        String sql = "SELECT Title, NumberOfAccess FROM Blog ORDER BY NumberOfAccess DESC LIMIT 5";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                articles.add(new ArticleStats(rs.getString("Title"), rs.getInt("NumberOfAccess")));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching top viewed articles: " + e.getMessage());
        }

        return articles;
    }

    public List<ProductSalesStats> getTopSellingProducts() {
        List<ProductSalesStats> products = new ArrayList<>();
        String sql = "SELECT p.ProductName, SUM(od.Quantity) AS TotalSold "
                + "FROM OrderDetails od "
                + "JOIN Products p ON od.ProductID = p.ProductID "
                + "GROUP BY p.ProductID, p.ProductName "
                + "ORDER BY TotalSold DESC LIMIT 5";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                products.add(new ProductSalesStats(rs.getString("ProductName"), rs.getInt("TotalSold")));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching top selling products: " + e.getMessage());
        }

        return products;
    }

    public List<CustomerSpendingStats> getTopSpendingCustomers() {
        List<CustomerSpendingStats> customers = new ArrayList<>();
        String sql = "SELECT CONCAT(u.FirstName, ' ', u.LastName) AS CustomerName, SUM(o.TotalAmount) AS TotalSpent "
                + "FROM Orders o "
                + "JOIN Users u ON o.CustomerID = u.UserID "
                + "WHERE o.Status = 'Completed' "
                + "GROUP BY o.CustomerID, CustomerName "
                + "ORDER BY TotalSpent DESC LIMIT 5";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                customers.add(new CustomerSpendingStats(rs.getString("CustomerName"), rs.getDouble("TotalSpent")));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching top spending customers: " + e.getMessage());
        }

        return customers;
    }

    public List<ProductRatingStats> getTopRatedProducts() {
        List<ProductRatingStats> products = new ArrayList<>();
        String sql = "SELECT p.ProductName, ROUND(AVG(r.Rating), 2) AS AvgRating "
                + "FROM Reviews r "
                + "JOIN Products p ON r.ProductID = p.ProductID "
                + "WHERE r.Status = 'Active' "
                + "GROUP BY p.ProductID, p.ProductName "
                + "ORDER BY AvgRating DESC LIMIT 5";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                products.add(new ProductRatingStats(rs.getString("ProductName"), rs.getDouble("AvgRating")));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching top-rated products: " + e.getMessage());
        }

        return products;
    }
}
