/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAO.*;
import Model.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
/**
 *
 * @author admin
 */
@WebServlet(name="ShipperOrderDetailController", urlPatterns={"/ShipperOrderDetail"})
public class ShipperOrderDetailController extends HttpServlet {
    UsersDAO userDAO = new UsersDAO();
    OrdersDAO orderDAO = new OrdersDAO();
    OrderDetailsDAO odDAO = new OrderDetailsDAO();
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet ShipperOrderDetailController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ShipperOrderDetailController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        int id = Integer.parseInt(request.getParameter("id"));
        if (user != null && user.getRole().equalsIgnoreCase("Shipper")) { // Chỉ cho Shipper truy cập
            Map<Integer, OrderDetails> orderList = odDAO.getOrderDetailsByOrderIDasMap(id);
            Orders o = orderDAO.getOrderByID(id);
            request.setAttribute("list", orderList);
            request.setAttribute("o", o);
            request.setAttribute("currentUser", user);
            request.setAttribute("title", "Chi tiết đơn hàng");
            request.getRequestDispatcher("/Shipper/ShipperOrder.jsp").forward(request, response);
        } else {
            session.setAttribute("notificationErr", "Bạn không có quyền truy cập vào trang này");
            response.sendRedirect("/Project-SWP391-G2-SP25/Login.jsp");
        }
    } 
    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       HttpSession session = request.getSession();
        String emailSession = (String) session.getAttribute("email");
        Users currentUser = (Users) session.getAttribute("user");

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
            response.sendRedirect(request.getContextPath() + "/Shipper/ShipperOrderDetail");
        } else {
            session.setAttribute("notificationErr", "Bạn không có quyền truy cập vào trang này");
            response.sendRedirect(request.getContextPath() + "/Project-SWP391-G2-SP25/Login.jsp");
        }
    }
    

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
