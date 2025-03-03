package DAO;

import Model.Reviews;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import java.sql.PreparedStatement;


public class ReviewsDAO extends DBContext {

    public List<Reviews> getReviews(String productName, Integer rating, String search, String status, String sortColumn, String sortOrder, int offset, int limit) {
        List<Reviews> reviewsList = new ArrayList<>();
        String sql = "SELECT r.*, u.UserName, p.ProductName "
                + "FROM Reviews r "
                + "JOIN Users u ON r.CustomerID = u.UserID "
                + "JOIN Products p ON r.ProductID = p.ProductID "
                + "WHERE 1=1";

        // Thêm điều kiện lọc sản phẩm và rating
        if (productName != null && !productName.isEmpty()) {
            sql += " AND p.ProductName LIKE ?";
        }
        if (rating != null) {
            sql += " AND r.Rating = ?";
        }

        // Thêm điều kiện tìm kiếm theo userName hoặc feedback content
        if (search != null && !search.isEmpty()) {
            sql += " AND (u.UserName LIKE ? OR r.Comment LIKE ?)";
        }
        
        if (status != null && !status.isEmpty()) {
            sql += " AND r.Status = ?";
        }

        // Thêm điều kiện sắp xếp
        if (sortColumn != null && sortOrder != null) {
            sql += " ORDER BY " + sortColumn + " " + sortOrder;
        } else {
            sql += " ORDER BY r.ReviewDate DESC"; // Mặc định sắp xếp theo ngày review
        }

        // Thêm phân trang
        sql += " LIMIT ? OFFSET ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int paramIndex = 1;
            if (productName != null && !productName.isEmpty()) {
                ps.setString(paramIndex++, "%" + productName + "%");
            }
            if (rating != null) {
                ps.setInt(paramIndex++, rating);
            }
            if (search != null && !search.isEmpty()) {
                ps.setString(paramIndex++, "%" + search + "%");
                ps.setString(paramIndex++, "%" + search + "%");
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(paramIndex++, status);
            }
            ps.setInt(paramIndex++, limit);
            ps.setInt(paramIndex, offset);
            
            

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Reviews review = new Reviews();
                    review.setReviewID(rs.getInt("ReviewID"));
                    review.setProductID(rs.getInt("ProductID"));
                    review.setCustomerID(rs.getInt("CustomerID"));
                    review.setRating(rs.getInt("Rating"));
                    review.setComment(rs.getString("Comment"));
                    review.setReviewDate(rs.getDate("ReviewDate"));
                    review.setUserName(rs.getString("UserName"));
                    review.setProductName(rs.getString("ProductName"));
                    review.setStatus(rs.getString("Status"));
                    reviewsList.add(review);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviewsList;
    }
    

    public Map<Integer, Reviews> getAllReviewsByProductID(int productID) {
        Map<Integer, Reviews> reviewList = new HashMap<>();
        String sql = "SELECT * FROM Reviews WHERE ProductID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Reviews review = extractReviewFromResultSet(rs);
                    reviewList.put(review.getReviewID(), review);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching reviews: " + e.getMessage());
        }
        return reviewList;
    }

    public Vector<Reviews> getAllReviewsAsVectorByProductID(int productID) {
        Vector<Reviews> reviews = new Vector<>();
        String sql = "SELECT * FROM Reviews WHERE ProductID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    reviews.add(extractReviewFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching reviews as vector: " + e.getMessage());
        }
        return reviews;
    }

    public Reviews getReviewByID(int reviewID) {
        String sql = "SELECT * FROM Reviews WHERE ReviewID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, reviewID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractReviewFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching review by ID: " + e.getMessage());
        }
        return null;
    }

    public boolean addReview(Reviews review) {
        String sql = "INSERT INTO Reviews (ProductID, CustomerID, Rating, Comment, ReviewDate) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setReviewPreparedStatement(ps, review);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error adding review: " + e.getMessage());
            return false;
        }
    }

    public boolean updateReview(Reviews review) {
        String sql = "UPDATE Reviews SET ProductID = ?, CustomerID = ?, Rating = ?, Comment = ?, ReviewDate = ? WHERE ReviewID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setReviewPreparedStatement(ps, review);
            ps.setInt(6, review.getReviewID());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error updating review: " + e.getMessage());
            return false;
        }
    }

    public boolean removeReview(int reviewID) {
        String sql = "DELETE FROM Reviews WHERE ReviewID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, reviewID);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("Error removing review: " + e.getMessage());
            return false;
        }
    }

    private Reviews extractReviewFromResultSet(ResultSet rs) throws SQLException {
        Reviews review = new Reviews();
        review.setReviewID(rs.getInt("ReviewID"));
        review.setProductID(rs.getInt("ProductID"));
        review.setCustomerID(rs.getInt("CustomerID"));
        review.setRating(rs.getInt("Rating"));
        review.setComment(rs.getString("Comment"));
        review.setReviewDate(rs.getDate("ReviewDate"));
        return review;
    }

    private void setReviewPreparedStatement(PreparedStatement ps, Reviews review) throws SQLException {
        ps.setInt(1, review.getProductID());
        ps.setInt(2, review.getCustomerID());
        ps.setInt(3, review.getRating());
        ps.setString(4, review.getComment());
    }

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
