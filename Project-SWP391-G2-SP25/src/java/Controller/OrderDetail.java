/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.CartItemsDAO;
import DAO.CartsDAO;
import DAO.OrderDetailsDAO;
import DAO.OrdersDAO;
import DAO.SlidersDAO;
import DAO.UsersDAO;
import Model.CartItems;
import Model.OrderDetails;
import Model.Orders;
import Model.Sliders;
import Model.Users;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.List;

/**
 *
 * @author manh
 */
@WebServlet(name = "OrderDetail", urlPatterns = {"/OrderDetail"})
public class OrderDetail extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet OrdersList</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrdersList at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy tham số id từ request
        int id = Integer.parseInt(request.getParameter("id"));

        // Tạo đối tượng DAO để truy xuất dữ liệu
        OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();

        // Lấy thông tin chi tiết đơn hàng theo id
        OrderDetails orderDetails = orderDetailsDAO.getOrderDetailByID(id);

        // Kiểm tra xem orderDetails có null không, nếu có thể xử lý lỗi (ví dụ: không tìm thấy đơn hàng)
        if (orderDetails == null) {
            request.setAttribute("errorMessage", "Order detail not found");
            request.getRequestDispatcher("OrderDetailError.jsp").forward(request, response); // Chuyển đến trang lỗi nếu không tìm thấy đơn hàng
            return; // Dừng lại để không tiếp tục xử lý
        }

        // Tiếp tục nếu orderDetails không null
        OrdersDAO ordersDAO = new OrdersDAO();
        UsersDAO usersDAO = new UsersDAO();

        // Lấy orderID từ orderDetails để truy vấn thông tin đơn hàng
        int orderid = orderDetails.getOrderID();

        // Lấy thông tin đơn hàng tương ứng với orderID
        Orders orders = ordersDAO.getOrderByID(orderid);
        int customerid = orders.getCustomerID();
        Users users = usersDAO.getUserByID(customerid);

        // Kiểm tra xem orders có null không
        if (orders == null) {
            request.setAttribute("errorMessage", "Order not found for the given order ID");
            request.getRequestDispatcher("OrderDetailError.jsp").forward(request, response); // Chuyển đến trang lỗi nếu không tìm thấy đơn hàng
            return; // Dừng lại để không tiếp tục xử lý
        }
        CartItemsDAO CartItemsDAO = new CartItemsDAO();
        List<CartItems> cartItems = CartItemsDAO.getCartItemsByCustomerID(customerid);

        // Đưa thông tin vào request để chuyển tiếp đến JSP
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("users", users);
        request.setAttribute("orders", orders);
        request.setAttribute("orderDetails", orderDetails);

        // Chuyển tiếp đến trang OrderDetail.jsp để hiển thị thông tin chi tiết đơn hàng
        request.getRequestDispatcher("OrderDetail.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
