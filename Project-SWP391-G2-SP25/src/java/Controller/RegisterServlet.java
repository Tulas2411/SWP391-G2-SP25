package Controller;

import DAO.CartsDAO;
import DAO.UsersDAO;
import Model.Carts;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            CartsDAO cDAO = new CartsDAO();
            UsersDAO uDAO = new UsersDAO();
            
            // Lấy các giá trị từ form
            String firstName = request.getParameter("firstname").trim();
            String lastName = request.getParameter("lastname").trim();
            String userName = request.getParameter("username").trim();
            String gender = request.getParameter("gender").trim();
            String dateOfBirth = request.getParameter("DateOfBirth").trim();
            String email = request.getParameter("email").trim();
            String password = request.getParameter("password").trim();
            String rePassword = request.getParameter("re_pass").trim();
            String phoneNumber = request.getParameter("contact").trim();
            String address = request.getParameter("address").trim();

            
            //Kiểm tra nếu bất kì trường nào là rỗng sau khi loại bỏ khoảng trắng
            if(firstName.isEmpty() || lastName.isEmpty() || userName.isEmpty() || gender.isEmpty() || email.isEmpty() || password.isEmpty() || rePassword.isEmpty() || phoneNumber.isEmpty() || address.isEmpty()){
                request.setAttribute("status", "empty_fields");
                RequestDispatcher dispatcher = request.getRequestDispatcher("Register.jsp");
                dispatcher.forward(request, response);
                return;
            }

            // Kiểm tra mật khẩu và nhắc lại mật khẩu có khớp hay không
            if (!password.equals(rePassword)) {
                request.setAttribute("status", "password_mismatch");
                RequestDispatcher dispatcher = request.getRequestDispatcher("Register.jsp");
                dispatcher.forward(request, response);
                return;
            }

            // Tạo kết nối tới cơ sở dữ liệu
            Connection con = null;
            try {
                con = makeConnection();
                if (con != null) {
                    // Chuẩn bị truy vấn SQL để thêm người dùng mới
                    String query = "INSERT INTO Users(FirstName, LastName, UserName, Gender, DateOfBirth, Email, Password, Role, PhoneNumber, Address) "
                            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement pst = con.prepareStatement(query);
                    pst.setString(1, firstName);
                    pst.setString(2, lastName);
                    pst.setString(3, userName);
                    pst.setString(4, gender);
                    pst.setString(5, dateOfBirth);
                    pst.setString(6, email);
                    pst.setString(7, password);
                    pst.setString(8, "Customer");
                    pst.setString(9, phoneNumber);
                    pst.setString(10, address);

                    // Thực thi truy vấn
                    int rowCount = pst.executeUpdate();
                    RequestDispatcher dispatcher = request.getRequestDispatcher("registerSuccess.jsp");

                    if (rowCount > 0) {
                        request.setAttribute("status", "success");
                        cDAO.addCart(new Carts(uDAO.getUserByUserName(userName).getUserID(), "Normal"));
                    } else {
                        request.setAttribute("status", "failed");
                    }

                    dispatcher.forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // Đóng kết nối cơ sở dữ liệu
                if (con != null) {
                    try {
                        con.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }

    // Kết nối đến cơ sở dữ liệu
    public static Connection makeConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/EcommerceDB", "root", "1234");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }


    @Override
    public String getServletInfo() {
        return "Register Servlet to handle user registration.";
    }
}

