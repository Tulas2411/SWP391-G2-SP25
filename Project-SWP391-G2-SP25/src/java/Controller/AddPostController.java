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
import java.text.ParseException;
import java.util.List;
import java.util.Map;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.sql.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Date; // Chú ý import đúng loại
import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AddPostController", urlPatterns = {"/AddPost"})
public class AddPostController extends HttpServlet {

    private Object post;

    public void init() throws ServletException {
        // Kết nối cơ sở dữ liệu và khởi tạo DAO
        Connection connection = DBContext.makeConnection();
//        MarketingPostsDAO = new MarketingPostsDAO(connection);
    }
    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddPostController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddPostController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm"); // Định dạng của input datetime-local
            String createDateStr = request.getParameter("createDate");
            java.util.Date utilDate = new SimpleDateFormat("yyyy-MM-dd").parse(createDateStr);

// Chuyển đổi thành java.sql.Date
            java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
            String status = request.getParameter("status");
            String imageLink = request.getParameter("imageLink");

            // Gọi DAO để cập nhật dữ liệu
            MarketingPostsDAO dao = new MarketingPostsDAO();
            MarketingPosts newPost = new MarketingPosts(0, title, content, 0, sqlDate, status, imageLink);
            boolean success = dao.addMarketingPost(newPost);

        } catch (ParseException ex) {
            Logger.getLogger(AddPostController.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.setAttribute("posts", post);
        response.sendRedirect("PostList");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
