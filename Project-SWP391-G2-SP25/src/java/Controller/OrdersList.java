/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.OrdersDAO;
import DAO.SlidersDAO;
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
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.List;

/**
 *
 * @author manh
 */
@WebServlet(name = "OrdersList", urlPatterns = {"/sale/OrdersList"})
public class OrdersList extends HttpServlet {

    private static final int PAGE_SIZE = 5;

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
    HttpSession session = request.getSession();
    Users currentUser = (Users) session.getAttribute("user");

    if (currentUser == null || currentUser.getRole() == null || !"sale".equalsIgnoreCase(currentUser.getRole())) {
        session.setAttribute("notificationErr", "Bạn không có quyền truy cập vào trang này");
        response.sendRedirect(request.getContextPath() + "/Login.jsp");
        return;
    }

    try {
        // Lấy thông tin đơn hàng của nhân viên sale hiện tại
        String search = request.getParameter("search");
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String status = request.getParameter("status");

        int currentPage = 1;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }

        OrdersDAO ordersDAO = new OrdersDAO();
        List<Orders> orders = ordersDAO.getOrdersByAssignedSalePaginated(
            currentUser.getUserID(), search, fromDate, toDate, status, currentPage, PAGE_SIZE
        );

        int totalOrders = ordersDAO.getTotalOrdersByAssignedSale(
            currentUser.getUserID(), search, fromDate, toDate, status
        );

        int totalPages = (int) Math.ceil((double) totalOrders / PAGE_SIZE);

        request.setAttribute("orders", orders);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("search", search);
        request.setAttribute("fromDate", fromDate);
        request.setAttribute("toDate", toDate);
        request.setAttribute("status", status);

        request.getRequestDispatcher("/sale/OrderList.jsp").forward(request, response);
    } catch (Exception e) {
        e.printStackTrace();
        session.setAttribute("notificationErr", "Lỗi hệ thống: " + e.getMessage());
        response.sendRedirect(request.getContextPath() + "/sale/OrderList.jsp");
    }
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
