package Controller;

import DAO.UsersDAO;
import Model.Users;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.mindrot.jbcrypt.BCrypt; // Import thư viện BCrypt

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    UsersDAO userDAO = new UsersDAO();

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
            // Kết nối đến cơ sở dữ liệu
            con = makeConnection();
            if (con != null) {
                // Truy vấn để lấy mật khẩu đã mã hóa từ cơ sở dữ liệu
                pst = con.prepareStatement("SELECT * FROM Users WHERE Email = ?");
                pst.setString(1, email);
                rs = pst.executeQuery();

                if (rs.next()) {
                    // Lấy mật khẩu đã mã hóa từ cơ sở dữ liệu
                    String hashedPasswordFromDB = rs.getString("Password");

                    // Kiểm tra mật khẩu người dùng nhập vào có khớp với mật khẩu đã mã hóa không
                    if (BCrypt.checkpw(password, hashedPasswordFromDB)) {
                        // Lấy thông tin người dùng từ kết quả truy vấn
                        String username = rs.getString("username");
                        String emailFromDB = rs.getString("Email");
                        String role = rs.getString("Role");

                        // Thêm thông tin người dùng vào session
                        session.setAttribute("username", username);
                        session.setAttribute("email", emailFromDB);
                        session.setAttribute("role", role);

                        Users u = userDAO.getUserByEmail(email);

                        if (u.getStatus().equalsIgnoreCase("Deactive")){
                            request.setAttribute("loginError", "Tài khoản của bạn đã bị vô hiệu hóa");
                    dispatcher = request.getRequestDispatcher("Login.jsp");
                    dispatcher.forward(request, response);
                        }
// Kiểm tra vai trò và chuyển hướng người dùng
                        if (u.getRole().equalsIgnoreCase("Admin")) {
                            response.sendRedirect("admin/dashboard");
                        } else if (u.getRole().equalsIgnoreCase("marketing")) {
                            response.sendRedirect("marketing/dashboard");
                        } else if (u.getRole().equalsIgnoreCase("sale")) {
                            response.sendRedirect("sale/OrdersList");
                        } else {
                            session.setAttribute("user", userDAO.getUserByUserName(username));
                            response.sendRedirect("/Project-SWP391-G2-SP25/home");
                        }
                    } else {
                        // Mật khẩu không khớp
                        request.setAttribute("loginError", "Sai tài khoản hoặc mật khẩu");
                        dispatcher = request.getRequestDispatcher("Login.jsp");
                        dispatcher.forward(request, response);
                    }
                } else {
                    // Email không tồn tại
                    request.setAttribute("loginError", "Sai tài khoản hoặc mật khẩu");
                    dispatcher = request.getRequestDispatcher("Login.jsp");
                    dispatcher.forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi trong quá trình đăng nhập.");
        } finally {
            // Đóng kết nối và tài nguyên
            try {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

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