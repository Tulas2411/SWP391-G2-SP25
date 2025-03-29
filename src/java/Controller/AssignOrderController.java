package Controller;

import DAO.OrdersDAO;
import DAO.UsersDAO;
import Model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/AssignOrderController")
public class AssignOrderController extends HttpServlet {

    private OrdersDAO ordersDAO = new OrdersDAO();
    private UsersDAO usersDAO = new UsersDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("user");

        // Kiểm tra quyền
        if (currentUser == null || !"SaleManager".equalsIgnoreCase(currentUser.getRole())) {
            session.setAttribute("notificationErr", "Bạn không có quyền thực hiện thao tác này");
            response.sendRedirect(request.getContextPath() + "/Login.jsp");
            return;
        }

        try {
            // Lấy và kiểm tra tham số
            String orderIdStr = request.getParameter("orderId");
            String saleIdStr = request.getParameter("saleId");

            if (orderIdStr == null || orderIdStr.isEmpty()
                    || saleIdStr == null || saleIdStr.isEmpty()) {
                throw new NumberFormatException("Tham số không được để trống");
            }

            int orderId = Integer.parseInt(orderIdStr);
            int saleId = Integer.parseInt(saleIdStr);

            // Kiểm tra nhân viên sale
            Users sale = usersDAO.getUserByID(saleId);
            if (sale == null || !"Sale".equalsIgnoreCase(sale.getRole())) {
                session.setAttribute("notificationErr", "Nhân viên không hợp lệ");
                response.sendRedirect(request.getContextPath() + "/SaleManager/OrdersDetailManager?id=" + orderId);
                return;
            }

            // Cập nhật đơn hàng
            if (ordersDAO.assignOrderToSale(orderId, saleId)) {
                session.setAttribute("notification", "Gán đơn hàng thành công");
            } else {
                session.setAttribute("notificationErr", "Gán đơn hàng thất bại");
            }

            response.sendRedirect(request.getContextPath() + "/SaleManager/OrderDetailManager?id=" + orderId);

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/SaleManager/OrdersListManager");
        }
    }
}
