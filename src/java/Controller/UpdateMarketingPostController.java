/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.*;
import DAO.MarketingPostsDAO;
import Model.MarketingPosts;
import DAO.DBContext;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UpdateMarketingPostController", urlPatterns = {"/UpdateMarketingPost"})
public class UpdateMarketingPostController extends HttpServlet {

    private static final long serialVersionUID = 1L;

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
            out.println("<title>Servlet UpdateMarketingPostController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateMarketingPostController at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
     

        try {
            // Lấy dữ liệu từ form gửi lên
            int postID = Integer.parseInt(request.getParameter("postID"));
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            int author = Integer.parseInt(request.getParameter("author"));
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm"); // Định dạng của input datetime-local
            Date createDate = sdf.parse(request.getParameter("createDate"));
            String status = request.getParameter("status");
            String imageLink = request.getParameter("imageLink");

            // Tạo đối tượng MarketingPosts
            MarketingPosts post = new MarketingPosts(postID, title, content, author, createDate, status, imageLink);

            // Gọi DAO để cập nhật dữ liệu
            MarketingPostsDAO dao = new MarketingPostsDAO();
            boolean isUpdate = dao.updateMarketingPost(post);

            if (isUpdate) {
                // Nếu cập nhật thành công, chuyển hướng về trang danh sách
                response.sendRedirect("PostList?success=true");
            } else {
                // Nếu lỗi, quay lại form cập nhật với thông báo lỗi
                request.setAttribute("errorMessage", "Cập nhật bài viết thất bại!");
                request.getRequestDispatcher("PostList").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("PostList").forward(request, response);
        }

        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
