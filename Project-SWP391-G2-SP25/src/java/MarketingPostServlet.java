/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import dao.MarketingPostDAO;
import Model.MarketingPost;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(urlPatterns = {"/MarketingPostServlet"})
public class MarketingPostServlet extends HttpServlet {
    private MarketingPostDAO postDAO;
      @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action == null) {
                // Hiển thị danh sách bài viết
                listPosts(request, response);
            } else if (action.equals("edit")) {
                // Hiển thị form chỉnh sửa
                showEditForm(request, response);
            } else if (action.equals("delete")) {
                // Xóa bài viết
                deletePost(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action == null || action.equals("add")) {
                // Thêm bài viết mới
                addPost(request, response);
            } else if (action.equals("update")) {
                // Cập nhật bài viết
                updatePost(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    // Hiển thị danh sách bài viết
    private void listPosts(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        List<MarketingPost> posts = postDAO.getAllPosts();
        request.setAttribute("posts", posts);
        request.getRequestDispatcher("marketing_posts.jsp").forward(request, response);
    }

    // Hiển thị form chỉnh sửa bài viết
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        MarketingPost post = postDAO.getPostById(id);
        request.setAttribute("post", post);
        request.getRequestDispatcher("edit_post.jsp").forward(request, response);
    }

    // Thêm bài viết mới
    private void addPost(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        MarketingPost post = new MarketingPost();
        post.setTitle(request.getParameter("title"));
        post.setContent(request.getParameter("content"));
        post.setAuthor(request.getParameter("author"));
        post.setCreateDate(request.getParameter("createDate"));
        post.setStatus(request.getParameter("status"));
        post.setImageLink(request.getParameter("imageLink"));

        postDAO.addPost(post);
        response.sendRedirect("MarketingPostServlet");
    }

    // Cập nhật bài viết
    private void updatePost(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        MarketingPost post = new MarketingPost();
        post.setId(id);
        post.setTitle(request.getParameter("title"));
        post.setContent(request.getParameter("content"));
        post.setAuthor(request.getParameter("author"));
        post.setCreateDate(request.getParameter("createDate"));
        post.setStatus(request.getParameter("status"));
        post.setImageLink(request.getParameter("imageLink"));

        postDAO.updatePost(post);
        response.sendRedirect("MarketingPostServlet");
    }

    // Xóa bài viết
    private void deletePost(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        postDAO.deletePost(id);
        response.sendRedirect("MarketingPostServlet");
    }
}
