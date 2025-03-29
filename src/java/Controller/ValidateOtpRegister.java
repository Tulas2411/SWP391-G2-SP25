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
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import static DAO.DBContext.makeConnection;

@WebServlet("/ValidateOtpRegister")
public class ValidateOtpRegister extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int storedOTP = (int) session.getAttribute("otp"); // Lấy OTP từ session
        int userOTP = Integer.parseInt(request.getParameter("otp")); // Lấy OTP từ form

        if (storedOTP == userOTP) {
            // OTP hợp lệ, lưu thông tin người dùng vào database
            String firstName = (String) session.getAttribute("firstName");
            String lastName = (String) session.getAttribute("lastName");
            String userName = (String) session.getAttribute("userName");
            String gender = (String) session.getAttribute("gender");
            String dateOfBirth = (String) session.getAttribute("dateOfBirth");
            String email = (String) session.getAttribute("email");
            String password = (String) session.getAttribute("password");
            String phoneNumber = (String) session.getAttribute("phoneNumber");
            String address = (String) session.getAttribute("address");

            Connection con = null;
            try {
                con = makeConnection();
                if (con != null) {
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

                    int rowCount = pst.executeUpdate();
                    if (rowCount > 0) {
                        // Thêm giỏ hàng cho người dùng
                        UsersDAO uDAO = new UsersDAO();
                        CartsDAO cDAO = new CartsDAO();
                        cDAO.addCart(new Carts(uDAO.getUserByUserName(userName).getUserID(), "Normal"));

                        // Xóa session OTP
                        session.removeAttribute("otp");

                        // Chuyển hướng đến trang thành công
                        response.sendRedirect("registerSuccess.jsp");
                    } else {
                        // Nếu có lỗi khi thêm vào database
                        request.setAttribute("message", "Đã xảy ra lỗi khi đăng ký. Vui lòng thử lại.");
                        RequestDispatcher dispatcher = request.getRequestDispatcher("EnterOtpRegister.jsp");
                        dispatcher.forward(request, response);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                // Nếu có lỗi, gửi thông báo lỗi về trang JSP
                request.setAttribute("message", "Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("EnterOtpRegister.jsp");
                dispatcher.forward(request, response);
            } finally {
                if (con != null) {
                    try {
                        con.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        } else {
            // OTP không hợp lệ
            request.setAttribute("message", "Mã OTP không đúng. Vui lòng thử lại.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("EnterOtpRegister.jsp");
            dispatcher.forward(request, response);
        }
    }
}