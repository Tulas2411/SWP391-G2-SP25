package DAO;

import Model.Products;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

public class ProductsDAO extends DBContext {

    public Map<Integer, Products> getAllProducts() {
        Map<Integer, Products> productList = new HashMap<>();
        String sql = "SELECT * FROM Products";

        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Products product = extractProductFromResultSet(rs);
                productList.put(product.getProductID(), product);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching products: " + e.getMessage());
        }
        return productList;
    }

    public Vector<Products> getAllProductsAsVector() {
        Vector<Products> products = new Vector<>();
        String sql = "SELECT * FROM Products";

        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                products.add(extractProductFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching products as vector: " + e.getMessage());
        }
        return products;
    }

    public List<Products> getPromotedProducts() {
        List<Products> promotedProducts = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE IsPromoted = 1";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                promotedProducts.add(extractProductFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching promoted products: " + e.getMessage());
        }
        return promotedProducts;
    }

    public List<Products> getNewProducts() {
        List<Products> newProducts = new ArrayList<>();
        String sql = "SELECT * FROM Products ORDER BY CreateAt DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                newProducts.add(extractProductFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching new products: " + e.getMessage());
        }
        return newProducts;
    }

    public Products getProductByID(int id) {
        String sql = "SELECT * FROM Products WHERE ProductID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractProductFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching product by ID: " + e.getMessage());
        }
        return null;
    }

    public List<Products> getProductsByCategory(String categoryID) {
        List<Products> productList = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE CategoryID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, categoryID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    productList.add(extractProductFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching products by category: " + e.getMessage());
        }
        return productList;
    }

    public boolean addProduct(Products product) {
        String sql = "INSERT INTO Products (CategoryID, ProductName, Description, Provider, Price, WarrantyPeriod, Amount, ImageLink, IsPromoted, OldPrice, CreateAt) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setProductPreparedStatement(ps, product);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error adding product: " + e.getMessage());
            return false;
        }
    }

    public boolean updateProduct(Products product) {
        String sql = "UPDATE Products SET CategoryID = ?, ProductName = ?, Description = ?, Provider = ?, Price = ?, WarrantyPeriod = ?, Amount = ?, ImageLink = ?, IsPromoted = ?, OldPrice = ?, CreateAt = ? WHERE ProductID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setProductPreparedStatement(ps, product);
            ps.setInt(12, product.getProductID());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error updating product: " + e.getMessage());
            return false;
        }
    }

    public boolean removeProduct(int id) {
        String sql = "DELETE FROM Products WHERE ProductID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("Error removing product: " + e.getMessage());
            return false;
        }
    }

    private Products extractProductFromResultSet(ResultSet rs) throws SQLException {
        Products product = new Products();
        product.setProductID(rs.getInt("ProductID"));
        product.setCategoryID(rs.getString("CategoryID"));
        product.setProductName(rs.getString("ProductName"));
        product.setDescription(rs.getString("Description"));
        product.setProvider(rs.getString("Provider"));
        product.setPrice(rs.getFloat("Price"));
        product.setWarrantyPeriod(rs.getString("WarrantyPeriod"));
        product.setAmount(rs.getInt("Amount"));
        product.setImageLink(rs.getString("ImageLink"));
        product.setIsPromoted(rs.getBoolean("IsPromoted"));
        product.setCreateAt(rs.getString("CreateAt"));
        product.setOldprice(rs.getFloat("OldPrice"));
        return product;
    }

    private void setProductPreparedStatement(PreparedStatement ps, Products product) throws SQLException {
        ps.setString(1, product.getCategoryID());
        ps.setString(2, product.getProductName());
        ps.setString(3, product.getDescription());
        ps.setString(4, product.getProvider());
        ps.setFloat(5, product.getPrice());
        ps.setString(6, product.getWarrantyPeriod());
        ps.setInt(7, product.getAmount());
        ps.setString(8, product.getImageLink());
        ps.setBoolean(9, product.getIsPromoted());
        ps.setFloat(10, product.getOldprice());
        ps.setString(11, product.getCreateAt());
    }

    public static void main(String[] args) {
        ProductsDAO productsDAO = new ProductsDAO();
        List<Products> promotedList = productsDAO.getPromotedProducts();

        if (promotedList.isEmpty()) {
            System.out.println("No promoted products found.");
        } else {
            for (Products product : promotedList) {
                System.out.println("Promoted Product: " + product.getProductName() + " - Price: " + product.getPrice());
            }
        }
    }

}
