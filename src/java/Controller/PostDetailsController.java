/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.MarketingPostsDAO;
import Model.MarketingPosts;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Tùng Dương
 */
@WebServlet(name = "PostDetailsController", urlPatterns = {"/PostDetailsController"})
public class PostDetailsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy postId từ request
        String postIdStr = request.getParameter("postId");
        if (postIdStr == null || postIdStr.isEmpty()) {
            response.sendRedirect("HomePage.jsp"); // Nếu không có postId, quay lại trang chủ
            return;
        }

        try {
            int postId = Integer.parseInt(postIdStr);
            MarketingPostsDAO postDAO = new MarketingPostsDAO();
            MarketingPosts post = postDAO.getMarketingPostByID(postId);

            if (post == null) {
                request.setAttribute("errorMessage", "Bài viết không tồn tại.");
            } else {
                request.setAttribute("post", post);
            }

            // Kiểm tra xem postId có đúng không
            System.out.println("Lấy bài viết với ID: " + postId);

            request.getRequestDispatcher("PostDetails.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("HomePage.jsp"); // Nếu postId không hợp lệ, quay lại HomePage
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
