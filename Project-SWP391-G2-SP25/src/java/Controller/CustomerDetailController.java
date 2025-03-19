package Controller;

import DAO.UsersDAO;
import Model.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "CustomerDetailController", urlPatterns = {"/marketing/customer-detail"})
public class CustomerDetailController extends HttpServlet {

    UsersDAO userDAO = new UsersDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String emailSession = (String) session.getAttribute("email");

        // Kiểm tra người dùng đã đăng nhập và có vai trò Marketing
        Users currentUser = userDAO.getUserByEmail(emailSession);
        if (currentUser == null || !currentUser.getRole().equalsIgnoreCase("Marketing")) {
            session.setAttribute("notificationErr", "Bạn không có quyền truy cập vào trang này!");
            response.sendRedirect(request.getContextPath() + "/Login.jsp");
            return;
        }

        // Lấy ID khách hàng từ tham số truy vấn
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            session.setAttribute("notificationErr", "ID khách hàng không được để trống.");
            response.sendRedirect(request.getContextPath() + "/marketing/customer-management");
            return;
        }

        try {
            int userId = Integer.parseInt(idStr);
            Users customer = userDAO.getUserByID(userId);
            if (customer == null || !customer.getRole().equalsIgnoreCase("Customer")) {
                session.setAttribute("notificationErr", "Khách hàng không tồn tại.");
                response.sendRedirect(request.getContextPath() + "/marketing/customer-management");
                return;
            }
            // Đặt đối tượng khách hàng vào request attribute và chuyển tiếp đến trang chi tiết
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("customer-detail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            session.setAttribute("notificationErr", "ID khách hàng không hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/marketing/customer-management");
        }
    }
}