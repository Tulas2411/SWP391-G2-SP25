package Controller;

import DAO.ReviewsDAO;
import Model.Reviews;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/reviews")
public class ReviewsServlet extends HttpServlet {

    private ReviewsDAO reviewsDAO = new ReviewsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productName = request.getParameter("productName");
        String ratingStr = request.getParameter("rating");
        String search = request.getParameter("search");
        String status = request.getParameter("status");
        String sortColumn = request.getParameter("sortColumn");
        String sortOrder = request.getParameter("sortOrder");

        // Xử lý phân trang
        int page = 1;
        int limit = 10; 
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        int offset = (page - 1) * limit;

        // Chuyển đổi rating từ chuỗi sang số nguyên
        Integer rating = (ratingStr != null && !ratingStr.isEmpty()) ? Integer.parseInt(ratingStr) : null;

        // Lấy danh sách reviews với phân trang, lọc, tìm kiếm, và sắp xếp
        List<Reviews> reviewsList = reviewsDAO.getReviews(productName, rating, search, status ,sortColumn, sortOrder, offset, limit);

        request.setAttribute("reviewsList", reviewsList);
        request.setAttribute("currentPage", page);
        request.setAttribute("limit", limit);
        RequestDispatcher dispatcher = request.getRequestDispatcher("Reviews.jsp");
        dispatcher.forward(request, response);
    }
}
