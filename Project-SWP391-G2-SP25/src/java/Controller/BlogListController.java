/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.BlogDAO;
import DAO.CategoryDAO;
import DAO.MarketingPostsDAO;
import DAO.ProductsDAO;
import Model.Blog;
import Model.Category;
import Model.MarketingPosts;
import Model.Products;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 *
 * @author daoducdanh
 */
@WebServlet(name = "BlogListController", urlPatterns = {"/blogs"})
public class BlogListController extends HttpServlet {

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
        processRequest(request, response);
        
        ProductsDAO productsDAO = new ProductsDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        MarketingPostsDAO marketingPostsDAO = new MarketingPostsDAO();
        BlogDAO blogDAO = new BlogDAO();

        // Lấy danh sách danh mục sản phẩm từ database dưới dạng Map
        Map<String, Category> categoryMap = categoryDAO.getAllCategories();
        List<Category> categories = categoryMap.values().stream().toList(); // Chuyển từ Map sang List

        // Lấy danh sách 5 sản phẩm khuyến mãi
        List<Products> promotedProducts = productsDAO.getPromotedProducts();

        // Lấy danh sách sản phẩm mới
        List<Products> newProducts = productsDAO.getNewProducts();


        // Lấy các bài viết mới nhất
        List<Blog> latestPosts = blogDAO.getLatestBlogs();


        // Đưa dữ liệu vào request để truyền sang JSP
        request.setAttribute("categories", categories);
        request.setAttribute("promotedProducts", promotedProducts);
        request.setAttribute("newProducts", newProducts);
        request.setAttribute("latestPosts", latestPosts);
        
        int limit = 4; 
        int page = 1; 

   
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        int totalBlogs = blogDAO.getAllBlogs1().size();
        int totalPages = (int) Math.ceil((double) totalBlogs / limit);

        List<Blog> blogs = blogDAO.getAllBlogsAndPagination(page, limit);
        
        request.setAttribute("blogs", blogs);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("limit", limit);
        
        request.getRequestDispatcher("BlogList.jsp").forward(request, response);
        
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
