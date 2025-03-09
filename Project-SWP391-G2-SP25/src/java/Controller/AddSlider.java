/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.BlogDAO;
import DAO.ProductsDAO;
import DAO.SlidersDAO;
import Model.Blog;
import Model.Products;
import Model.Sliders;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AddSlider", urlPatterns = {"/marketing/AddSlider"})
public class AddSlider extends HttpServlet {

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
            out.println("<title>Servlet AddSlider</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddSlider at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductsDAO productdao = new ProductsDAO();
        BlogDAO blogDAO = new BlogDAO(); 
        
        List<Products> productList = productdao.getAllProducts1(); 
        List<Blog> blogs = blogDAO.getAllBlogs1();
        
        request.setAttribute("blogs", blogs);
        request.setAttribute("productList", productList); 
        request.getRequestDispatcher("addSlider.jsp").forward(request, response);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String title = request.getParameter("title");
    String backlink = request.getParameter("backlink");
    String image = request.getParameter("image");
    String status = request.getParameter("status");

    int blogID = 0;
    int productId = 0;

    try {
        if (request.getParameter("blogID") != null && !request.getParameter("blogID").isEmpty()) {
            blogID = Integer.parseInt(request.getParameter("blogID"));
        }
    } catch (NumberFormatException e) {
        blogID = 0; // Nếu lỗi, đặt về giá trị mặc định
    }

    try {
        if (request.getParameter("productId") != null && !request.getParameter("productId").isEmpty()) {
            productId = Integer.parseInt(request.getParameter("productId"));
        }
    } catch (NumberFormatException e) {
        productId = 0;
    }

    // Tạo đối tượng Slider
    Sliders slider = new Sliders(title, backlink, image, status, blogID, productId);

    // Gọi DAO để thêm slider
    SlidersDAO sliderDAO = new SlidersDAO();
    sliderDAO.addSlider(slider);

    // Chuyển hướng về danh sách sliders
    response.sendRedirect("ListSliders");
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
