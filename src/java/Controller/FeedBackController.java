/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.OrderDetailsDAO;
import DAO.OrdersDAO;
import DAO.ProductsDAO;
import DAO.SendMail;
import DAO.UsersDAO;
import Model.EmailTemplate;
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
import java.util.Vector;

/**
 *
 * @author
 */
@WebServlet(name = "FeedBackController", urlPatterns = {"/feed-back"})
public class FeedBackController extends HttpServlet {

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
            out.println("<title>Servlet FeedBackController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FeedBackController at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("FeedBack.jsp").forward(request, response);
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
        
        SendMail sendMail = new SendMail();
        
        OrdersDAO ordersDAO = new OrdersDAO();
        UsersDAO usersDAO = new UsersDAO();
        OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();
        ProductsDAO productsDAO = new ProductsDAO();
        
        
        
        Orders orders = ordersDAO.getOrderByID(2);
        Users users = usersDAO.getUserByID(orders.getCustomerID());
        
        Vector<OrderDetails> orderDetailses = orderDetailsDAO.getOrderDetailsByOrderID(2);
        
        List<OrderDetailWithProduct> list = new ArrayList<>();
        
        for(OrderDetails details : orderDetailses){
            Products products = productsDAO.getProductByID(details.getProductID());
            list.add(new OrderDetailWithProduct(details, products));
        }
        
        EmailTemplate emailTemplate = new EmailTemplate(orders, list, users);
        
        
        sendMail.sendMail(users.getEmail(), "Đặt hàng thành công", emailTemplate.getTemplate());
        response.sendRedirect("home");
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
