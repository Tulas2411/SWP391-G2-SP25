/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.MarketingPostsDAO;
import Model.MarketingPosts;
import DAO.DBContext;
import DAO.UsersDAO;
import Model.Users;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Admin
 */
@WebServlet(name = "DeletePostController", urlPatterns = {"/marketing/DeletePost"})
public class DeletePostController extends HttpServlet {

    private MarketingPostsDAO postsDAO;

    @Override
    public void init() throws ServletException {
        // Kết nối cơ sở dữ liệu và khởi tạo DAO
        Connection connection = DBContext.makeConnection();
//        MarketingPostsDAO = new MarketingPostsDAO(connection);
    }
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
            out.println("<title>Servlet DeletePostController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeletePostController at " + request.getContextPath() + "</h1>");
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
        UsersDAO userDAO = new UsersDAO();
        HttpSession session = request.getSession();
        String emailSession = (String) session.getAttribute("email");
        Users user = userDAO.getUserByEmail(emailSession);
        if (user != null) {
            if (user.getRole().equalsIgnoreCase("marketing")) {
    String postID = request.getParameter("postID");

    if (postID != null && !postID.isEmpty()) {
        try {
            int postIdInt = Integer.parseInt(postID);
            MarketingPostsDAO DAO = new MarketingPostsDAO();
            boolean success = DAO.removeMarketingPost(postIdInt);

            if (success) {
                // Xóa thành công
                response.sendRedirect("PostList?message=delete-success");
            } else {
                // Xóa thất bại
                response.sendRedirect("PostList?message=delete-failure");
            }
        } catch (NumberFormatException e) {
            response.getWriter().write("ID bài viết không hợp lệ.");
        }
    } else {
        // Không có postID, chuyển hướng về danh sách bài viết
        response.sendRedirect("PostList");
    }
     } else {
                session.setAttribute("notificationErr", "Bạn không có quyền truy cập vào trang này");
                response.sendRedirect("../Login.jsp");
            }
        } else {
            session.setAttribute("notificationErr", "Bạn cần đăng nhập trước!");
            response.sendRedirect("../Login.jsp");
        }
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
