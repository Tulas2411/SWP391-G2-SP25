/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.UsersDAO;
import Model.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.SecureRandom;
import java.util.List;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

/**
 *
 * @author Tùng Dương
 */
@WebServlet(name = "UserManagementController", urlPatterns = {"/admin/user-management"})
public class UserManagementController extends HttpServlet {

    UsersDAO userDAO = new UsersDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String emailSession = (String) session.getAttribute("email");
        Users user = userDAO.getUserByEmail(emailSession);
        if (user != null) {
            if (user.getRole().equalsIgnoreCase("Admin")) {
                String role = request.getParameter("role");
                String gender = request.getParameter("gender");
                String status = request.getParameter("status");
                List<Users> listUser = userDAO.getAllUser(role, gender, status);
                request.setAttribute("users", listUser);
                request.setAttribute("currentUser", user);
                request.setAttribute("title", "Quản lý người dùng");
                request.getRequestDispatcher("user-management.jsp").forward(request, response);
            } else {
                session.setAttribute("notificationErr", "Bạn không có quyền truy cập vào trang này");
                response.sendRedirect("../Login.jsp");
            }
        } else {
            session.setAttribute("notificationErr", "Bạn cần đăng nhập trước!");
            response.sendRedirect("../Login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String emailSession = (String) session.getAttribute("email");
        Users currentUser = userDAO.getUserByEmail(emailSession);

        if (currentUser != null && currentUser.getRole().equalsIgnoreCase("Admin")) {
            String action = request.getParameter("action");
            if (action.equals("edit")) {

                try {
                    int userID = Integer.parseInt(request.getParameter("id"));
                    String newRole = request.getParameter("role");

                    boolean updated = userDAO.updateUserRole(userID, newRole);
                    if (updated) {
                        session.setAttribute("notification", "Cập nhật thành công");
                    } else {
                        session.setAttribute("notificationErr", "Cập nhật thất bại.");
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("notificationError", "Invalid user ID provided.");
                }
            } else if (action.equals("toggle")) {

                try {
                    int userID = Integer.parseInt(request.getParameter("id"));
                    String newStatus;
                    Users userTogger = userDAO.getUserByID(userID);
                    
                    if (userTogger.getStatus().equalsIgnoreCase("Active")) {
                        newStatus = "Deactive";
                    }else{
                        newStatus = "Active";
                    }

                    boolean updated = userDAO.updateStatus(userID, newStatus);
                    if (updated) {
                        session.setAttribute("notification", "Cập nhật thành công");
                    } else {
                        session.setAttribute("notificationErr", "Cập nhật thất bại.");
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("notificationError", "Invalid user ID provided.");
                }
            } else if ("add".equals(action)) {
                // Retrieve form parameters
                String firstName = request.getParameter("firstName");
                String lastName = request.getParameter("lastName");
                String email = request.getParameter("email");
                String phoneNumber = request.getParameter("phoneNumber");
                String gender = request.getParameter("gender");
                String role = request.getParameter("role");
                String dateOfBirth = request.getParameter("dateOfBirth");
                String address = request.getParameter("address");

                Users user = userDAO.getUserByEmail(email);
                if (user != null) {
                    session.setAttribute("notificationErr", "Email đã tồn tại trong hệ thống, vui lòng thử lại với email khác");
                    response.sendRedirect("user-management");
                    return;
                }
                // Generate a random password
                String randomPassword = generateRandomPassword();

                // Create a new Users object
                Users newUser = new Users();
                newUser.setFirstName(firstName);
                newUser.setLastName(lastName);
                newUser.setEmail(email);
                newUser.setPhoneNumber(phoneNumber);
                newUser.setGender(gender);
                newUser.setRole(role);
                newUser.setDateOfBirth(dateOfBirth);
                newUser.setAddress(address);
                // Generate a username based on email prefix or names
                if (email != null && email.contains("@")) {
                    newUser.setUserName(email.substring(0, email.indexOf("@")));
                } else {
                    newUser.setUserName(firstName.toLowerCase() + lastName.toLowerCase());
                }
                newUser.setPassword(randomPassword);

                // Save the new user
                boolean added = userDAO.addUser(newUser);
                if (added) {
                    // Send the random password to the new user's email
                    boolean emailSent = sendEmail(email, randomPassword);
                    if (emailSent) {
                        session.setAttribute("notification", "Thêm người dùng thành công");
                    } else {
                        session.setAttribute("notification", "User added successfully, but failed to send email.");
                    }
                } else {
                    session.setAttribute("notificationErr", "Failed to add new user.");
                }
            }
            response.sendRedirect(request.getContextPath() + "/admin/user-management");
        } else {
            session.setAttribute("notificationErr", "Bạn không có quyền truy cập vào trang này");
            response.sendRedirect(request.getContextPath() + "/Login.jsp");
        }
    }

    // Helper method to generate a random 8-character alphanumeric password
    private String generateRandomPassword() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        SecureRandom random = new SecureRandom();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 8; i++) {
            int index = random.nextInt(chars.length());
            sb.append(chars.charAt(index));
        }
        return sb.toString();
    }

    // Helper method to send an email using JavaMail
    private boolean sendEmail(String toEmail, String password) {
        // Configure these properties based on your email server
        String fromEmail = "duongdthe181160@fpt.edu.vn"; // your email address
        String host = "smtp.gmail.com";           // your SMTP host
        final String username = "duongdthe181160@fpt.edu.vn"; // email username
        final String emailPassword = "zxobeuirttxaibge"; // email password

        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587"); // or your SMTP port
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        try {
            Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
                @Override
                protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                    return new javax.mail.PasswordAuthentication(username, emailPassword);
                }
            });
            Message message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));

            message.setSubject(MimeUtility.encodeText("Tài khoản mới tại Shop4electric", "UTF-8", null));

            message.setContent("Dear user,<br><br>Tài khoản của bạn đã được tạo thành công với mật khẩu: <strong> "
                    + password + "</strong> <br><br>Vui lòng đổi mật khẩu sau khi đăng nhập.", "text/html; charset=UTF-8");
            Transport.send(message);

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
