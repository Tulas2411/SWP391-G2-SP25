package Controller;

import DAO.CategoryDAO;
import DAO.MarketingPostsDAO;
import DAO.ProductsDAO;
import Model.Category;
import Model.MarketingPosts;
import Model.Products;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Controller xử lý trang chủ
 *
 * @author Tùng Dương
 */
@WebServlet(name = "HomeController", urlPatterns = {"/home"})
public class HomeController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Khởi tạo DAO
        ProductsDAO productsDAO = new ProductsDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        MarketingPostsDAO marketingPostsDAO = new MarketingPostsDAO();

        // Lấy danh sách danh mục sản phẩm từ database dưới dạng Map
        Map<String, Category> categoryMap = categoryDAO.getAllCategories();
        List<Category> categories = categoryMap.values().stream().toList(); // Chuyển từ Map sang List
        
        // Lấy danh sách 5 sản phẩm khuyến mãi
        List<Products> promotedProducts = productsDAO.getPromotedProducts();
        
        // Lấy tất cả sản phẩm dưới dạng danh sách
        List<Products> allProducts = productsDAO.getAllProductsAsVector();
        
        // Lấy các bài viết mới nhất
        List<MarketingPosts> latestPosts = marketingPostsDAO.getLatestPosts(4);
        
        // Đưa dữ liệu vào request để truyền sang JSP
        request.setAttribute("categories", categories);
        request.setAttribute("promotedProducts", promotedProducts);
        request.setAttribute("allProducts", allProducts);
        request.setAttribute("latestPosts", latestPosts);
        
        // Chuyển hướng đến trang HomePage.jsp
        request.getRequestDispatcher("HomePage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
