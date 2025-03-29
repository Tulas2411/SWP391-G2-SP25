/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAO.CategoryDAO;
import DAO.MarketingPostsDAO;
import DAO.OrdersDAO;
import DAO.ProductsDAO;
import DAO.ReviewsDAO;
import DAO.UsersDAO;
import Model.Category;
import Model.MarketingPosts;
import Model.Products;
import Model.Reviews;
import Model.Users;
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
@WebServlet(name="ProductDetailControllerCustomer", urlPatterns={"/ProductDetailControllerCustomer"})
public class ProductDetailControllerCustomer extends HttpServlet {
   
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
            out.println("<title>Servlet ProductDetailController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductDetailController at " + request.getContextPath () + "</h1>");
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
        int id = Integer.parseInt(request.getParameter("id"));
        ProductsDAO pDAO = new ProductsDAO();
        ReviewsDAO r = new ReviewsDAO();
         // Khởi tạo DAO
        ProductsDAO productsDAO = new ProductsDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        MarketingPostsDAO marketingPostsDAO = new MarketingPostsDAO();

        // Lấy danh sách danh mục sản phẩm từ database dưới dạng Map
        Map<String, Category> categoryMap = categoryDAO.getAllCategories();
        List<Category> categories = categoryMap.values().stream().toList(); // Chuyển từ Map sang List

        // Lấy danh sách 5 sản phẩm khuyến mãi
        List<Products> promotedProducts = productsDAO.getPromotedProducts();

        // Lấy danh sách sản phẩm mới
        List<Products> newProducts = productsDAO.getNewProducts();

        // Lấy tất cả sản phẩm dưới dạng danh sách
        List<Products> allProducts = productsDAO.getAllProductsAsVector();

        // Lấy các bài viết mới nhất
        List<MarketingPosts> latestPosts = marketingPostsDAO.getLatestPosts(4);

        // Lấy sản phẩm thiết bị quạt
        List<Products> fanProducts = productsDAO.getProductsByCategory("TBQ");

        // Lấy sản phẩm thiết bị chiếu sáng
        List<Products> lightingProducts = productsDAO.getProductsByCategory("TBCS");

        // Lấy sản phẩm công tắc điện
        List<Products> electricalSwitchProducts = productsDAO.getProductsByCategory("CTD");

        // Lấy các sản phẩm thiết bị thông minh
        List<Products> smartDevices = productsDAO.getProductsByCategory("TBTM");

        // Đưa dữ liệu vào request để truyền sang JSP
        request.setAttribute("categories", categories);
        request.setAttribute("promotedProducts", promotedProducts);
        request.setAttribute("newProducts", newProducts);
        request.setAttribute("allProducts", allProducts);
        request.setAttribute("latestPosts", latestPosts);
        request.setAttribute("fanProducts", fanProducts);
        request.setAttribute("lightingProducts", lightingProducts);
        request.setAttribute("electricalSwitchProducts", electricalSwitchProducts);
        request.setAttribute("smartDevices", smartDevices);

        Products p = pDAO.getProductByID(id);
        Map<Integer, Reviews> listr = r.getAllReviewsByProductID(id);
        request.setAttribute("product", p);
        request.setAttribute("listr", listr);
        
        HttpSession session = request.getSession();
        
        UsersDAO usersDAO = new UsersDAO();

        String userId = request.getParameter("user");
        if(userId != null){
            Users users = usersDAO.getUserByID(Integer.parseInt(userId));
            session.setAttribute("user", users);
            session.setAttribute("username", users.getUserName());
        }

        Users user = (Users) session.getAttribute("user");
        OrdersDAO ordersDAO = new OrdersDAO();
        boolean checkUserPurchasedProduct = user == null ? false : ordersDAO.hasUserPurchasedProduct(user.getUserID(), id);
        request.setAttribute("checkUserPurchasedProduct", checkUserPurchasedProduct);
        
        request.getRequestDispatcher("ProductDetailCustomer.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}