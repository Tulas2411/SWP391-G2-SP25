package DAO;

import Model.DailyRevenue;
import Model.Orders;
import Model.Users;
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

    public Orders getOrderById(int orderId) throws SQLException {
        String sql = "SELECT * FROM Orders WHERE OrderID = ?";
        Orders order = null;

        try (Connection conn = makeConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    order = new Orders();
                    order.setOrderID(rs.getInt("OrderID"));
                    order.setCustomerID(rs.getInt("CustomerID"));
                    order.setDeliveryAddress(rs.getString("DeliveryAddress"));
                    order.setStatus(rs.getString("Status"));
                    order.setTotalAmount(rs.getDouble("TotalAmount"));
                    order.setBillOfLading(rs.getString("BillOfLading"));
                    // Thêm các trường khác nếu cần
                }
            }
        }
        return order;
    }

    public boolean assignOrderToSale(int orderId, int saleId) {
        String sql = "UPDATE Orders SET assigned_sale_id = ?, Status = 'Processing' WHERE OrderID = ?";

        try (Connection conn = makeConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, saleId);
            stmt.setInt(2, orderId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Orders> getOrdersByAssignedSalePaginated(
            int saleId,
            String search,
            String fromDate,
            String toDate,
            String status,
            int page,
            int pageSize
    ) throws SQLException {
        List<Orders> orders = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT o.order_id, o.order_date, o.delivery_address, o.status, o.total_amount, "
                + "u.user_id, u.first_name, u.last_name, u.email, u.phone "
                + "FROM orders o "
                + "JOIN users u ON o.user_id = u.user_id "
                + "WHERE o.assigned_sale_id = ? "
        );

        // Thêm điều kiện tìm kiếm
        List<Object> params = new ArrayList<>();
        params.add(saleId);

        if (search != null && !search.isEmpty()) {
            sql.append("AND (o.order_id LIKE ? OR u.first_name LIKE ? OR u.last_name LIKE ? OR u.email LIKE ?) ");
            String searchParam = "%" + search + "%";
            params.add(searchParam);
            params.add(searchParam);
            params.add(searchParam);
            params.add(searchParam);
        }

        if (fromDate != null && !fromDate.isEmpty()) {
            sql.append("AND o.order_date >= ? ");
            params.add(fromDate);
        }

        if (toDate != null && !toDate.isEmpty()) {
            sql.append("AND o.order_date <= ? ");
            params.add(toDate);
        }

        if (status != null && !status.isEmpty()) {
            sql.append("AND o.status = ? ");
            params.add(status);
        }

        sql.append("ORDER BY o.order_date DESC LIMIT ? OFFSET ?");
        params.add(pageSize);
        params.add((page - 1) * pageSize);

        try (Connection conn = makeConnection(); PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            // Thiết lập các tham số
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Orders order = new Orders();
                    order.setOrderID(rs.getInt("order_id"));
                    order.setDeliveryAddress(rs.getString("delivery_address"));
                    order.setStatus(rs.getString("status"));
                    order.setTotalAmount(rs.getDouble("total_amount"));

                    // Ánh xạ thông tin khách hàng
                    Users customer = new Users();
                    customer.setUserID(rs.getInt("user_id"));
                    customer.setFirstName(rs.getString("first_name"));
                    customer.setLastName(rs.getString("last_name"));
                    customer.setEmail(rs.getString("email"));
                    customer.setPhoneNumber(rs.getString("phone"));                   
                    orders.add(order);
                   
                }
            }
        }
        return orders;
    }

    public int getTotalOrdersByAssignedSale(
            int saleId,
            String search,
            String fromDate,
            String toDate,
            String status
    ) throws SQLException {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) FROM orders o "
                + "JOIN users u ON o.user_id = u.user_id "
                + "WHERE o.assigned_sale_id = ? "
        );

        List<Object> params = new ArrayList<>();
        params.add(saleId);

        if (search != null && !search.isEmpty()) {
            sql.append("AND (o.order_id LIKE ? OR u.first_name LIKE ? OR u.last_name LIKE ? OR u.email LIKE ?) ");
            String searchParam = "%" + search + "%";
            params.add(searchParam);
            params.add(searchParam);
            params.add(searchParam);
            params.add(searchParam);
        }

        if (fromDate != null && !fromDate.isEmpty()) {
            sql.append("AND o.order_date >= ? ");
            params.add(fromDate);
        }

        if (toDate != null && !toDate.isEmpty()) {
            sql.append("AND o.order_date <= ? ");
            params.add(toDate);
        }

        if (status != null && !status.isEmpty()) {
            sql.append("AND o.status = ? ");
            params.add(status);
        }

        try (Connection conn = makeConnection(); PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    public boolean updateOrderStatus(int orderId, String status) {
        boolean isUpdated = false;
        String query = "UPDATE Orders SET Status = ? WHERE OrderID = ?";

        try (// Lấy kết nối
                PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, status); // Set giá trị trạng thái mới
            ps.setInt(2, orderId);   // Set OrderID

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                isUpdated = true; // Nếu có bản ghi được cập nhật
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isUpdated;
    }

    public List<Orders> searchOrders(String search, String fromDate, String toDate, String saleName, String status) {
        List<Orders> orderList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT o.*, u.FirstName, u.LastName FROM Orders o ");
        sql.append("JOIN Users u ON o.CustomerID = u.UserID WHERE 1=1");

        if (search != null && !search.isEmpty()) {
            sql.append(" AND (o.OrderID LIKE ? OR u.FirstName LIKE ? OR u.LastName LIKE ?)");
        }
        if (fromDate != null && !fromDate.isEmpty()) {
            sql.append(" AND o.OrderDate >= ?");
        }
        if (toDate != null && !toDate.isEmpty()) {
            sql.append(" AND o.OrderDate <= ?");
        }
        if (saleName != null && !saleName.isEmpty()) {
            sql.append(" AND o.SaleName LIKE ?");
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND o.Status = ?");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;

            if (search != null && !search.isEmpty()) {
                ps.setString(paramIndex++, "%" + search + "%");

            }
            if (fromDate != null && !fromDate.isEmpty()) {
                ps.setString(paramIndex++, fromDate);
            }
            if (toDate != null && !toDate.isEmpty()) {
                ps.setString(paramIndex++, toDate);
            }
            if (saleName != null && !saleName.isEmpty()) {
                ps.setString(paramIndex++, "%" + saleName + "%");
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(paramIndex++, status);
            }

            // Thực thi câu truy vấn
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Orders order = extractOrderFromResultSet(rs);
                    // Thêm thông tin khách hàng (FirstName, LastName, Email) vào đối tượng Order
                    order.setCustomerFirstName(rs.getString("FirstName"));
                    order.setCustomerLastName(rs.getString("LastName"));
                    order.setCustomerEmail(rs.getString("Email"));
                    orderList.add(order);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error executing search query: " + e.getMessage());
        }
        return orderList;
    }

    public List<Orders> getOrdersPaginated(String search, String fromDate, String toDate, String saleName, String status, int page, int pageSize) {
        List<Orders> orderList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT o.*, u.FirstName, u.LastName, u.Email FROM Orders o ");
        sql.append("JOIN Users u ON o.CustomerID = u.UserID WHERE 1=1");

        if (search != null && !search.isEmpty()) {
            sql.append(" AND (o.OrderID LIKE ? OR o.CustomerID LIKE ?)");
        }
        if (fromDate != null && !fromDate.isEmpty()) {
            sql.append(" AND o.OrderDate >= ?");
        }
        if (toDate != null && !toDate.isEmpty()) {
            sql.append(" AND o.OrderDate <= ?");
        }
        if (saleName != null && !saleName.isEmpty()) {
            sql.append(" AND o.SaleName LIKE ?");
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND o.Status = ?");
        }

        int offset = (page - 1) * pageSize;
        sql.append(" LIMIT ? OFFSET ?");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (search != null && !search.isEmpty()) {
                ps.setString(paramIndex++, "%" + search + "%");
                ps.setString(paramIndex++, "%" + search + "%");
            }
            if (fromDate != null && !fromDate.isEmpty()) {
                ps.setString(paramIndex++, fromDate);
            }
            if (toDate != null && !toDate.isEmpty()) {
                ps.setString(paramIndex++, toDate);
            }
            if (saleName != null && !saleName.isEmpty()) {
                ps.setString(paramIndex++, "%" + saleName + "%");
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(paramIndex++, status);
            }

            ps.setInt(paramIndex++, pageSize);
            ps.setInt(paramIndex++, offset);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Orders order = extractOrderFromResultSet(rs);

                    order.setCustomerFirstName(rs.getString("FirstName"));
                    order.setCustomerLastName(rs.getString("LastName"));
                    order.setCustomerEmail(rs.getString("Email"));
                    orderList.add(order);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error executing search query: " + e.getMessage());
        }
        return orderList;
    }

    public int getTotalOrders(String search, String fromDate, String toDate, String saleName, String status) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Orders o ");
        sql.append("JOIN Users u ON o.CustomerID = u.UserID WHERE 1=1");

        if (search != null && !search.isEmpty()) {
            sql.append(" AND (o.OrderID LIKE ? OR u.FirstName LIKE ? OR u.LastName LIKE ?)");
        }
        if (fromDate != null && !fromDate.isEmpty()) {
            sql.append(" AND o.OrderDate >= ?");
        }
        if (toDate != null && !toDate.isEmpty()) {
            sql.append(" AND o.OrderDate <= ?");
        }
        if (saleName != null && !saleName.isEmpty()) {
            sql.append(" AND o.SaleName LIKE ?");
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND o.Status = ?");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (search != null && !search.isEmpty()) {
                ps.setString(paramIndex++, "%" + search + "%"); // tìm theo OrderID
                ps.setString(paramIndex++, "%" + search + "%"); // tìm theo FirstName
                ps.setString(paramIndex++, "%" + search + "%"); // tìm theo LastName
            }
            if (fromDate != null && !fromDate.isEmpty()) {
                ps.setString(paramIndex++, fromDate);
            }
            if (toDate != null && !toDate.isEmpty()) {
                ps.setString(paramIndex++, toDate);
            }
            if (saleName != null && !saleName.isEmpty()) {
                ps.setString(paramIndex++, "%" + saleName + "%");
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(paramIndex++, status);
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1); // Trả về tổng số đơn hàng
                }
            }
        } catch (SQLException e) {
            System.out.println("Error getting total orders: " + e.getMessage());
        }
        return 0;
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
        String sql = "INSERT INTO Orders (CustomerID, OrderDate, DeliveryAddress, Status, TotalAmount, BillOfLading, ShipperID, assigned_sale_id ) VALUES (?, NOW(), ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, order.getCustomerID());
            ps.setString(2, order.getDeliveryAddress());
            ps.setString(3, order.getStatus());
            ps.setDouble(4, order.getTotalAmount());
            ps.setString(5, order.getBillOfLading());
            ps.setInt(6, order.getShipperID());
            ps.setInt(7, order.getSaleID());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error adding order: " + e.getMessage());
            return false;
        }
    }

    public boolean updateOrder(Orders order) {
        String sql = "UPDATE Orders SET CustomerID = ?, OrderDate = ?, DeliveryAddress = ?, Status = ?, TotalAmount = ?, BillOfLading = ?, ShipperID = ?,  assigned_sale_id = ? WHERE OrderID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setOrderPreparedStatement(ps, order);
            ps.setInt(9, order.getOrderID());
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
        order.setShipperID(rs.getInt("ShipperID"));
        order.setSaleID(rs.getInt("assigned_sale_id"));
        return order;
    }

    private void setOrderPreparedStatement(PreparedStatement ps, Orders order) throws SQLException {
        ps.setInt(1, order.getCustomerID());
        ps.setString(2, order.getOrderDate());
        ps.setString(3, order.getDeliveryAddress());
        ps.setString(4, order.getStatus());
        ps.setDouble(5, order.getTotalAmount());
        ps.setString(6, order.getBillOfLading());
        ps.setInt(7, order.getShipperID());
        ps.setInt(8, order.getSaleID());
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

    public List<DailyRevenue> getDailyRevenueByMonthYear(int month, int year) {
        List<DailyRevenue> revenueList = new ArrayList<>();
        String sql = "SELECT DAY(orderDate) AS day, SUM(totalAmount) AS totalRevenue "
                + "FROM Orders WHERE MONTH(orderDate) = ? AND YEAR(orderDate) = ? "
                + "GROUP BY DAY(orderDate) ORDER BY day";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, month);
            ps.setInt(2, year);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    revenueList.add(new DailyRevenue(rs.getInt("day"), rs.getDouble("totalRevenue")));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching daily revenue: " + e.getMessage());
        }

        return revenueList;
    }

    public boolean hasUserPurchasedProduct(int userId, int productId) {
        String sql = "SELECT COUNT(*) FROM Orders o "
                + "JOIN OrderDetails od ON o.OrderID = od.OrderID "
                + "WHERE o.CustomerID = ? AND od.ProductID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    return true;
                }
            }
        } catch (SQLException e) {
            System.out.println("Error checking purchase history: " + e.getMessage());
        }

        return false;
    }

    public List<Orders> getAllOrdersForShipper(int shipperID, String status) {
        List<Orders> orderList = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE shipperID = ?";
        if (status != null && !status.trim().isEmpty()) {
            sql += " AND status = ?";
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            // Gán giá trị cho ShipperID
            ps.setInt(1, shipperID);
            // Gán giá trị cho Status nếu có
            if (status != null && !status.trim().isEmpty()) {
                ps.setString(2, status);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Orders order = extractOrderFromResultSet(rs);
                orderList.add(order);
            }
        } catch (SQLException e) {
            System.out.println("ERROR fetching orders: " + e.getMessage());
            e.printStackTrace();
        }
        return orderList;
    }

    public List<Orders> getAllOrdersbyStatus(String status) {
        List<Orders> orderList = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE";
        if (status != null && !status.trim().isEmpty()) {
            sql += " status = ?";
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            // Gán giá trị cho Status nếu có
            if (status != null && !status.trim().isEmpty()) {
                ps.setString(1, status);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Orders order = extractOrderFromResultSet(rs);
                orderList.add(order);
            }
        } catch (SQLException e) {
            System.out.println("ERROR fetching orders: " + e.getMessage());
            e.printStackTrace();
        }
        return orderList;
    }

    public static void main(String[] args) {
        OrdersDAO oDAO = new OrdersDAO();
        Orders o = new Orders(21, null, "Hanoi", "Submitted", 20000, "Hello");
        System.out.println(oDAO.addOrder(o));
    }
}
