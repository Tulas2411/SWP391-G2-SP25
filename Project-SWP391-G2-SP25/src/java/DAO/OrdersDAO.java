package DAO;

import Model.Orders;
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

public class OrdersDAO extends DBContext {

    public Map<Integer, Orders> getAllOrders() {
        Map<Integer, Orders> orderList = new HashMap<>();
        String sql = "SELECT * FROM Orders";

        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Orders order = extractOrderFromResultSet(rs);
                orderList.put(order.getOrderID(), order);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching orders: " + e.getMessage());
        }
        return orderList;
    }

    public List<Orders> getAllOrders1() {
        List<Orders> orderList = new ArrayList<>();
        String sql = "SELECT * FROM Orders";

        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Orders order = extractOrderFromResultSet(rs);
                orderList.add(order);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching orders: " + e.getMessage());
        }
        return orderList;
    }

    public Vector<Orders> getAllOrdersAsVector() {
        Vector<Orders> orders = new Vector<>();
        String sql = "SELECT * FROM Orders";

        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                orders.add(extractOrderFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching orders as vector: " + e.getMessage());
        }
        return orders;
    }

    public Orders getOrderByID(int orderID) {
        String sql = "SELECT * FROM Orders WHERE OrderID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractOrderFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching order by ID: " + e.getMessage());
        }
        return null;
    }

    public List<Orders> getAllOrderByUser(int customerID, int page, int limit) {
        List<Orders> orderses = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE CustomerID = ? LIMIT ? OFFSET ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerID);
            ps.setInt(2, limit);
            ps.setInt(3, (page - 1) * limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    orderses.add(extractOrderFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching paginated orders by CustomerID: " + e.getMessage());
        }
        return orderses;
    }

    public int getTotalOrdersByUser(int customerID) {
        String sql = "SELECT COUNT(*) FROM Orders WHERE CustomerID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error counting total orders: " + e.getMessage());
        }
        return 0;
    }

    
    public Vector<Orders> getOrdersByCustomerID(int customerID) {
        Vector<Orders> ordersList = new Vector<>();
        String sql = "SELECT * FROM Orders WHERE CustomerID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ordersList.add(extractOrderFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching orders by CustomerID: " + e.getMessage());
        }
        return ordersList;
    }

    public boolean addOrder(Orders order) {
        String sql = "INSERT INTO Orders (CustomerID, OrderDate, DeliveryAddress, Status, TotalAmount, BillOfLading) VALUES (?, NOW(), ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, order.getCustomerID());
            ps.setString(2, order.getDeliveryAddress());
            ps.setString(3, order.getStatus());
            ps.setDouble(4, order.getTotalAmount());
            ps.setString(5, order.getBillOfLading());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error adding order: " + e.getMessage());
            return false;
        }
    }

    public boolean updateOrder(Orders order) {
        String sql = "UPDATE Orders SET CustomerID = ?, OrderDate = ?, DeliveryAddress = ?, Status = ?, TotalAmount = ?, BillOfLading = ? WHERE OrderID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setOrderPreparedStatement(ps, order);
            ps.setInt(7, order.getOrderID());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error updating order: " + e.getMessage());
            return false;
        }
    }

    public boolean removeOrder(int orderID) {
        String sql = "DELETE FROM Orders WHERE OrderID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderID);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("Error removing order: " + e.getMessage());
            return false;
        }
    }

    private Orders extractOrderFromResultSet(ResultSet rs) throws SQLException {
        Orders order = new Orders();
        order.setOrderID(rs.getInt("OrderID"));
        order.setCustomerID(rs.getInt("CustomerID"));
        order.setOrderDate(rs.getString("OrderDate"));
        order.setDeliveryAddress(rs.getString("DeliveryAddress"));
        order.setStatus(rs.getString("Status"));
        order.setTotalAmount(rs.getDouble("TotalAmount"));
        order.setBillOfLading(rs.getString("BillOfLading"));
        return order;
    }

    private void setOrderPreparedStatement(PreparedStatement ps, Orders order) throws SQLException {
        ps.setInt(1, order.getCustomerID());
        ps.setString(2, order.getOrderDate());
        ps.setString(3, order.getDeliveryAddress());
        ps.setString(4, order.getStatus());
        ps.setDouble(5, order.getTotalAmount());
        ps.setString(6, order.getBillOfLading());
    }

    public Map<Integer, Orders> getOrdersByCustomerIDasMap(int customerID) {
        Map<Integer, Orders> orderList = new HashMap<>();
        String sql = "SELECT * FROM Orders WHERE CustomerID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Orders order = extractOrderFromResultSet(rs);
                    orderList.put(order.getOrderID(), order);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching orders by CustomerID: " + e.getMessage());
        }
        return orderList;
    }

    public Orders getOrderPendingByID(int orderID) {
        String status = "Pending";
        String sql = "SELECT * FROM Orders WHERE CustomerID = ? AND Status = 'Pending'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractOrderFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching order by ID: " + e.getMessage());
        }
        return null;
    }

    public Orders getLatestOrder() {
        String sql = "SELECT * FROM Orders ORDER BY OrderID DESC LIMIT 1"; // Sắp xếp giảm dần và lấy 1 bản ghi đầu tiên
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return extractOrderFromResultSet(rs); // Trả về Order mới nhất
            }
        } catch (SQLException e) {
            System.out.println("Error fetching the latest order: " + e.getMessage());
        }
        return null; // Trả về null nếu không tìm thấy
    }

    public static void main(String[] args) {
        OrdersDAO oDAO = new OrdersDAO();
        Orders order = new Orders(6, null, null, "Pending", 0, null);
        System.out.println(oDAO.getLatestOrder().getOrderDate());
    }
}
