package Controller;

import DAO.OrderDetailsDAO;
import DAO.OrdersDAO;
import DAO.UsersDAO;
import Model.OrderDetails;
import Model.Orders;
import Model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderDetailManager", urlPatterns = {"/SaleManager/OrderDetailManager"})
public class OrderDetailManager extends HttpServlet {

    private final OrdersDAO ordersDAO = new OrdersDAO();
    private final UsersDAO usersDAO = new UsersDAO();
    private final OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("user");

        // Kiểm tra quyền truy cập
        if (currentUser == null || !"SaleManager".equalsIgnoreCase(currentUser.getRole())) {
            session.setAttribute("notificationErr", "Bạn không có quyền truy cập vào trang này");
            response.sendRedirect(request.getContextPath() + "/Login.jsp");
            return;
        }

        try {
            // Lấy ID đơn hàng từ request
            int orderId = Integer.parseInt(request.getParameter("id"));

            // Lấy thông tin đơn hàng
            Orders order = ordersDAO.getOrderByID(orderId);
            if (order == null) {
                session.setAttribute("notificationErr", "Không tìm thấy đơn hàng");
                response.sendRedirect(request.getContextPath() + "/SaleManager/OrdersListManager");
                return;
            }

            // Lấy chi tiết đơn hàng
            List<OrderDetails> orderDetailsList = orderDetailsDAO.getOrderDetailsByOrderID1(orderId);
            
            // Lấy thông tin khách hàng
            Users customer = usersDAO.getUserByID(order.getCustomerID());
            
            // Lấy danh sách nhân viên Sale để gán đơn hàng
            List<Users> salesList = usersDAO.getUsersByRole("Sale");

            // Đặt các thuộc tính vào request
            request.setAttribute("order", order);
            request.setAttribute("customer", customer);
            request.setAttribute("orderDetailsList", orderDetailsList);
            request.setAttribute("salesList", salesList);

            // Chuyển tiếp đến trang JSP
            request.getRequestDispatcher("/SaleManager/OrderDetailManager.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            session.setAttribute("notificationErr", "ID đơn hàng không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/SaleManager/OrdersListManager");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("notificationErr", "Lỗi hệ thống: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/SaleManager/OrdersListManager");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("user");

        // Kiểm tra quyền truy cập
        if (currentUser == null || !"SaleManager".equalsIgnoreCase(currentUser.getRole())) {
            session.setAttribute("notificationErr", "Bạn không có quyền thực hiện thao tác này");
            response.sendRedirect(request.getContextPath() + "/Login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/SaleManager/OrdersListManager");
            return;
        }

        try {
            int orderId = Integer.parseInt(request.getParameter("orderID"));
            Orders order = ordersDAO.getOrderByID(orderId);
            
            if (order == null) {
                session.setAttribute("notificationErr", "Đơn hàng không tồn tại");
                response.sendRedirect(request.getContextPath() + "/SaleManager/OrdersListManager");
                return;
            }

            switch (action) {
                case "updateStatus":
                    handleUpdateStatus(request, response, orderId, "Processing");
                    break;
                case "updateStatus1":
                    handleUpdateStatus(request, response, orderId, "Processed");
                    break;
                case "assign":
                    handleAssignOrder(request, response, orderId);
                    break;
                default:
                    session.setAttribute("notificationErr", "Hành động không hợp lệ");
                    response.sendRedirect(request.getContextPath() + "/SaleManager/OrdersDetailManager?id=" + orderId);
            }
        } catch (NumberFormatException e) {
            session.setAttribute("notificationErr", "ID đơn hàng không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/SaleManager/OrdersListManager");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("notificationErr", "Lỗi hệ thống: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/SaleManager/OrdersListManager");
        }
    }

    private void handleUpdateStatus(HttpServletRequest request, HttpServletResponse response, 
            int orderId, String status) throws IOException {
        HttpSession session = request.getSession();
        
        boolean updated = ordersDAO.updateOrderStatus(orderId, status);
        if (updated) {
            session.setAttribute("notification", "Cập nhật trạng thái đơn hàng thành công");
        } else {
            session.setAttribute("notificationErr", "Cập nhật trạng thái thất bại");
        }
        response.sendRedirect(request.getContextPath() + "/SaleManager/OrdersDetailManager?id=" + orderId);
    }

    private void handleAssignOrder(HttpServletRequest request, HttpServletResponse response, 
            int orderId) throws IOException {
        HttpSession session = request.getSession();
        
        int saleId = Integer.parseInt(request.getParameter("saleId"));
        Users sale = usersDAO.getUserByID(saleId);
        
        if (sale == null || !"Sale".equalsIgnoreCase(sale.getRole())) {
            session.setAttribute("notificationErr", "Nhân viên không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/SaleManager/OrdersDetailManager?id=" + orderId);
            return;
        }
        
        if (ordersDAO.assignOrderToSale(orderId, saleId)) {
            session.setAttribute("notification", "Gán đơn hàng thành công cho " + sale.getFirstName());
        } else {
            session.setAttribute("notificationErr", "Gán đơn hàng thất bại");
        }
        response.sendRedirect(request.getContextPath() + "/SaleManager/OrdersDetailManager?id=" + orderId);
    }
}