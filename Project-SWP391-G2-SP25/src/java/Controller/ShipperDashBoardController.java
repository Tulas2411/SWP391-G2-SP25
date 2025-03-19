/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAO.OrdersDAO; // Giả định có DAO cho Orders
import Model.Orders; // Giả định có model Orders
import DAO.UsersDAO;
import Model.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@WebServlet(name = "ShipperDashBoardController", urlPatterns = {"/ShipperDashBoard"})
public class ShipperDashBoardController extends HttpServlet {

    UsersDAO userDAO = new UsersDAO();
    OrdersDAO orderDAO = new OrdersDAO(); // Thêm DAO cho Orders

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String emailSession = (String) session.getAttribute("email");
        Users user = userDAO.getUserByEmail(emailSession);

        if (user != null && user.getRole().equalsIgnoreCase("Shipper")) { // Chỉ cho Shipper truy cập
            String statusFilter = request.getParameter("status"); // Lọc theo trạng thái đơn hàng
            List<Orders> orderList = orderDAO.getAllOrders1(); // Lấy danh sách đơn hàng
            request.setAttribute("orders", orderList);
            request.setAttribute("currentUser", user);
            request.setAttribute("title", "Danh sách đơn hàng");
            request.getRequestDispatcher("ShipperDashBoard.jsp").forward(request, response);
        } else {
            session.setAttribute("notificationErr", "Bạn không có quyền truy cập vào trang này");
            response.sendRedirect("../Login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String emailSession = (String) session.getAttribute("email");
        Users currentUser = userDAO.getUserByEmail(emailSession);

        if (currentUser != null && currentUser.getRole().equalsIgnoreCase("Shipper")) {
            String action = request.getParameter("action");
            if ("updateStatus".equals(action)) {
                try {
                    int orderID = Integer.parseInt(request.getParameter("orderID"));
                    Orders order = orderDAO.getOrderByID(orderID);
                    if (order == null) {
                        session.setAttribute("notificationErr", "Đơn hàng không tồn tại.");
                        response.sendRedirect(request.getContextPath() + "/ShipperDashBoard");
                        return;
                    }

                    // Cập nhật trạng thái thành "Delivered"
                    boolean updated = orderDAO.updateOrderStatus(orderID, "Delivered");
                    if (updated) {
                        session.setAttribute("notification", "Cập nhật trạng thái đơn hàng thành công");
                    } else {
                        session.setAttribute("notificationErr", "Cập nhật trạng thái thất bại.");
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("notificationErr", "ID đơn hàng không hợp lệ.");
                }
            }
            response.sendRedirect(request.getContextPath() + "/ShipperDashBoard");
        } else {
            session.setAttribute("notificationErr", "Bạn không có quyền truy cập vào trang này");
            response.sendRedirect(request.getContextPath() + "/Login.jsp");
        }
    }
}