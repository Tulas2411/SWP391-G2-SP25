/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.OrderDetailsDAO;
import DAO.OrdersDAO;
import DAO.ProductsDAO;
import Model.OrderDetailWithProduct;
import Model.OrderDetails;
import Model.Orders;
import Model.Products;
import Model.Users;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;

/**
 *
 * @author daoducdanh
 */
@WebServlet(name = "MyOrderDetailController", urlPatterns = {"/my-order-detail"})
public class MyOrderDetailController extends HttpServlet {

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
            out.println("<title>Servlet MyOrderDetailController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MyOrderDetailController at " + request.getContextPath() + "</h1>");
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
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();
        OrdersDAO ordersDAO = new OrdersDAO();
        ProductsDAO productsDAO = new ProductsDAO();
        
        HttpSession session = request.getSession();
        Users users = (Users) session.getAttribute("user");
        
        Vector<OrderDetails> orderDetailses = orderDetailsDAO.getOrderDetailsByOrderID(orderId);
        
        List<OrderDetailWithProduct> list = new ArrayList<>();
        
        for(OrderDetails details : orderDetailses){
            Products products = productsDAO.getProductByID(details.getProductID());
            list.add(new OrderDetailWithProduct(details, products));
        }
        Orders orders = ordersDAO.getOrderByID(orderId);
       
        
        request.setAttribute("user", users);
        request.setAttribute("order", orders);
        request.setAttribute("list", list);
        
        request.getRequestDispatcher("MyOrderDetail.jsp").forward(request, response);
        
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
