/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DAO.UserDAO;
import Dto.tblUsers;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Acer
 */
public class LoginController extends HttpServlet {

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
        HttpSession session = request.getSession();

        try (PrintWriter out = response.getWriter()) {
            String identifier = request.getParameter("identifier");
            String password = request.getParameter("password");
            UserDAO userDao = new UserDAO();
            tblUsers user = null;
            String remember = request.getParameter("remember_me");
            // Kiểm tra xem identifier là userID hay email
            if (identifier.contains("@")) {
                // Identifier là email
                user = userDao.getUserByEmail(identifier);
            } else {
                // Identifier là userID
                user = userDao.getUserByID(identifier);
            }

            // Kiểm tra mật khẩu
            if (user != null && user.getPassword().equals(password)) {
                if (!user.isStatus()) {
                    request.setAttribute("updateStatus", "Đăng nhập thất bại!");
                    request.setAttribute("ERROR", "Tài khoản của bạn đã bị chặn bởi người quản trị!!!");
                    request.getRequestDispatcher("MainController?action=Login_page").forward(request, response);
                }
                session.setAttribute("USER", user);
                // Xử lý lưu thông tin đăng nhập trong cookie
                Cookie cu = new Cookie("cuser", identifier);
                Cookie cp = new Cookie("cpass", password);
                Cookie cr = new Cookie("crem", remember != null ? "true" : "false");

                if (remember != null) {
                    // Người dùng chọn "Remember Me"
                    cu.setMaxAge(60 * 60 * 24 * 7); // 1 tuần
                    cp.setMaxAge(60 * 60 * 24 * 7); // 1 tuần
                    cr.setMaxAge(60 * 60 * 24 * 7); // 1 tuần
                } else {
                    // Người dùng không chọn "Remember Me"
                    cu.setMaxAge(0);
                    cp.setMaxAge(0);
                    cr.setMaxAge(0);
                }

                if (user.getRoleID().equals("AD")) {
                    request.setAttribute("updateStatus", "Chào mừng ADMMIN: " + user.getUserName() + " đăng nhập thành công");
                    request.getRequestDispatcher("MainController?action=Home_Page").forward(request, response);
                } else {
                    request.setAttribute("updateStatus", "Chào mừng " + user.getUserName() + " đăng nhập thành công");
                    request.getRequestDispatcher("MainController?action=Home_Page").forward(request, response);
                }
            } else {
                request.setAttribute("updateStatus", "Đăng nhập thất bại!");
                request.setAttribute("ERROR", "Invalid userID/email or password");
                request.getRequestDispatcher("MainController?action=Login_page").forward(request, response);
            }
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
