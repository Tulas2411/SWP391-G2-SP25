package Controller;

import DAO.CartsDAO;
import DAO.UsersDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.Random;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.mindrot.jbcrypt.BCrypt;

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

            // Kiểm tra nếu bất kì trường nào là rỗng sau khi loại bỏ khoảng trắng
            if (firstName.isEmpty() || lastName.isEmpty() || userName.isEmpty() || gender.isEmpty() || email.isEmpty() || password.isEmpty() || rePassword.isEmpty() || phoneNumber.isEmpty() || address.isEmpty()) {
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

            // Kiểm tra xem email đã tồn tại chưa
            if (uDAO.isEmailExists(email)) {
                request.setAttribute("status", "email_exists");
                RequestDispatcher dispatcher = request.getRequestDispatcher("Register.jsp");
                dispatcher.forward(request, response);
                return;
            }

            // Kiểm tra xem username đã tồn tại chưa
            if (uDAO.isUsernameExists(userName)) {
                request.setAttribute("status", "username_exists");
                RequestDispatcher dispatcher = request.getRequestDispatcher("Register.jsp");
                dispatcher.forward(request, response);
                return;
            }

            // Kiểm tra xem số điện thoại đã tồn tại chưa
            if (uDAO.isPhoneNumberExists(phoneNumber)) {
                request.setAttribute("status", "phone_exists");
                RequestDispatcher dispatcher = request.getRequestDispatcher("Register.jsp");
                dispatcher.forward(request, response);
                return;
            }

            // Kiểm tra ngày sinh hợp lệ
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            sdf.setLenient(false); // Không cho phép chuyển đổi tự động các ngày không hợp lệ

            try {
                Date dateOfBirthStr = sdf.parse(dateOfBirth);
                Date currentDate = new Date();

                // Kiểm tra ngày sinh không được là ngày trong tương lai
                if (dateOfBirthStr.after(currentDate)) {
                    request.setAttribute("status", "invalid_date");
                    request.setAttribute("message", "Ngày sinh không hợp lệ. Vui lòng nhập lại.");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("Register.jsp");
                    dispatcher.forward(request, response);
                    return;
                }

                // Kiểm tra người dùng phải đủ ít nhất 13 tuổi
                Calendar dob = Calendar.getInstance();
                dob.setTime(dateOfBirthStr);
                Calendar today = Calendar.getInstance();
                int age = today.get(Calendar.YEAR) - dob.get(Calendar.YEAR);

                if (today.get(Calendar.MONTH) < dob.get(Calendar.MONTH)
                        || (today.get(Calendar.MONTH) == dob.get(Calendar.MONTH) && today.get(Calendar.DAY_OF_MONTH) < dob.get(Calendar.DAY_OF_MONTH))) {
                    age--;
                }

                if (age < 13) {
                    request.setAttribute("status", "underage");
                    request.setAttribute("message", "Bạn phải đủ 13 tuổi để đăng ký.");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("Register.jsp");
                    dispatcher.forward(request, response);
                    return;
                }

            } catch (ParseException e) {
                // Ngày sinh không hợp lệ
                request.setAttribute("status", "invalid_date");
                request.setAttribute("message", "Ngày sinh không hợp lệ. Vui lòng nhập lại.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("Register.jsp");
                dispatcher.forward(request, response);
                return;
            }
            
            // Mã hóa mật khẩu
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

            // Tạo mã OTP ngẫu nhiên
            Random random = new Random();
            int otp = 100000 + random.nextInt(900000); // OTP 6 chữ số

            // Lưu thông tin người dùng và OTP vào session
            HttpSession session = request.getSession();
            session.setAttribute("otp", otp);
            session.setAttribute("firstName", firstName);
            session.setAttribute("lastName", lastName);
            session.setAttribute("userName", userName);
            session.setAttribute("gender", gender);
            session.setAttribute("dateOfBirth", dateOfBirth);
            session.setAttribute("email", email);
            session.setAttribute("password", hashedPassword);
            session.setAttribute("phoneNumber", phoneNumber);
            session.setAttribute("address", address);

            // Gửi mã OTP qua email
            sendOTPEmail(email, otp);

            // Chuyển hướng đến trang nhập OTP
            response.sendRedirect("EnterOtpRegister.jsp");
        }
    }

    private void sendOTPEmail(String email, int otp) {

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("luuthequangbkvip@gmail.com", "oouvorqzkguxbmez");
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(email));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject("Shop 4 Electrical");
            message.setText("Your OTP is: " + otp);

            Transport.send(message);
            System.out.println("OTP đã được gửi thành công đến " + email);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
