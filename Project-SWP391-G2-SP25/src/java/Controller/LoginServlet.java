/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import com.mysql.cj.xdevapi.PreparableStatement;
import com.sun.jdi.connect.spi.Connection;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author luuth
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("username");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();
        RequestDispatcher dispatcher = null;

        java.sql.Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {

            // Sử dụng phương thức makeConnection
            con = makeConnection();
            if (con != null) {
                pst = con.prepareStatement("SELECT * FROM Users WHERE Email = ? AND Password = ?");
                pst.setString(1, email);
                pst.setString(2, password); // Lưu ý: nên mã hóa mật khẩu trước khi lưu và kiểm tra
                rs = pst.executeQuery();

                if (rs.next()) {
                    // Lấy tên người dùng từ kết quả truy vấn
                    String username = rs.getString("username");
                    // Lấy email từ kết quả truy vấn
                    String emailFromDB = rs.getString("Email");

                    // Thêm username vào session
                    session.setAttribute("username", username);
                    // Thêm email vào session
                    session.setAttribute("email", emailFromDB);

                    // Chuyển hướng người dùng đến trang HomePage sau khi đăng nhập thành công
                    response.sendRedirect("HomePage.jsp");
                } else {
                    request.setAttribute("status", "failed");
                    dispatcher = request.getRequestDispatcher("Login.jsp");
                    dispatcher.forward(request, response);
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý lỗi bằng cách chuyển hướng đến trang lỗi hoặc hiển thị thông báo lỗi
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi trong quá trình đăng nhập.");
        } finally {
            // Đảm bảo đóng các tài nguyên đúng cách
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pst != null) {
                    pst.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
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

    public static java.sql.Connection makeConnection() {
        java.sql.Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/EcommerceDB", "root", "1234");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

}

