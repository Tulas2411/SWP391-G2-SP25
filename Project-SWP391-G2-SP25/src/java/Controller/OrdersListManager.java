/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.OrdersDAO;
import DAO.SlidersDAO;
import DAO.UsersDAO;
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
@WebServlet(name = "OrdersListManager", urlPatterns = {"/SaleManager/OrdersListManager"})
public class OrdersListManager extends HttpServlet {

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
        String emailSession = (String) session.getAttribute("email");
        Users currentUser = (Users) session.getAttribute("user");

        if (currentUser != null && currentUser.getRole().equalsIgnoreCase("SaleManager")) {

            // Lấy các tham số tìm kiếm từ request
            String search = request.getParameter("search");
            String fromDate = request.getParameter("fromDate");
            String toDate = request.getParameter("toDate");
            String saleName = request.getParameter("saleName");
            String status = request.getParameter("status");
            String assignedSaleId = request.getParameter("assignedSale");

            int currentPage = 1;
            if (request.getParameter("page") != null) {
                currentPage = Integer.parseInt(request.getParameter("page"));
            }
            UsersDAO usersDAO = new UsersDAO();
            List<Users> allSales = usersDAO.getUsersByRole("Sale");
            
            OrdersDAO ordersDAO = new OrdersDAO();
            
            List<Orders> orders = ordersDAO.getOrdersPaginated(search, fromDate, toDate, saleName, status, assignedSaleId, currentPage, PAGE_SIZE);

//            List<Orders> orders = ordersDAO.getOrdersWithFilters(search, fromDate, toDate, status, assignedSaleId, currentPage, PAGE_SIZE);
            
            int totalOrders = ordersDAO.getTotalOrders(search, fromDate, toDate, saleName, status);
            int totalPages = (int) Math.ceil((double) totalOrders / PAGE_SIZE);

            // Lưu các giá trị cần thiết vào request để hiển thị phân trang trong JSP
            request.setAttribute("orders", orders);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("search", search);
            request.setAttribute("fromDate", fromDate);
            request.setAttribute("toDate", toDate);
            request.setAttribute("saleName", saleName);
            request.setAttribute("status", status);
            request.setAttribute("allSales", allSales);

            // Chuyển tiếp đến trang JSP
            request.getRequestDispatcher("OrderListManager.jsp").forward(request, response);
        } else {
            session.setAttribute("notificationErr", "Bạn không có quyền truy cập vào trang này");
            response.sendRedirect(request.getContextPath() + "/Login.jsp");
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
