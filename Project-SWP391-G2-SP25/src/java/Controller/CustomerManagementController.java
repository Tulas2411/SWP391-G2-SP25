/*
 * Click nbfs://youtu/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbf://youtu/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
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
@WebServlet(name = "CustomerManagementController", urlPatterns = {"/marketing/customer-management"})
public class CustomerManagementController extends HttpServlet {

    private static final int PAGE_SIZE = 10; // Số bản ghi trên mỗi trang
    UsersDAO userDAO = new UsersDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String emailSession = (String) session.getAttribute("email");
        Users user = userDAO.getUserByEmail(emailSession);
        if (user != null) {
            if (user.getRole().equalsIgnoreCase("Marketing")) {
                String action = request.getParameter("action");
                if ("detail".equals(action)) {
                    String idStr = request.getParameter("id");
                    if (idStr != null && !idStr.isEmpty()) {
                        try {
                            int userID = Integer.parseInt(idStr);
                            Users customer = userDAO.getUserByID(userID);
                            if (customer != null && customer.getRole().equalsIgnoreCase("Customer")) {
                                request.setAttribute("customer", customer);
                                request.setAttribute("title", "Chi tiết khách hàng");
                                request.getRequestDispatcher("customer-detail.jsp").forward(request, response);
                            } else {
                                session.setAttribute("notificationErr", "Khách hàng không tồn tại.");
                                response.sendRedirect(request.getContextPath() + "/marketing/customer-management");
                            }
                        } catch (NumberFormatException e) {
                            session.setAttribute("notificationErr", "ID không hợp lệ.");
                            response.sendRedirect(request.getContextPath() + "/marketing/customer-management");
                        }
                    } else {
                        session.setAttribute("notificationErr", "ID không được cung cấp.");
                        response.sendRedirect(request.getContextPath() + "/marketing/customer-management");
                    }
                } else {
                    // Logic phân trang và danh sách khách hàng
                    String search = request.getParameter("search");
                    String status = request.getParameter("status");
                    String pageStr = request.getParameter("page");
                    int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;

                    List<Users> allCustomers = userDAO.getAllUser("Customer", null, status);
                    List<Users> filteredCustomers = new java.util.ArrayList<>();
                    if (search != null && !search.trim().isEmpty()) {
                        for (Users u : allCustomers) {
                            if ((u.getFirstName() + " " + u.getLastName()).toLowerCase().contains(search.toLowerCase())
                                    || u.getEmail().toLowerCase().contains(search.toLowerCase())
                                    || u.getPhoneNumber().toLowerCase().contains(search.toLowerCase())) {
                                filteredCustomers.add(u);
                            }
                        }
                    } else {
                        filteredCustomers = allCustomers;
                    }

                    int totalItems = filteredCustomers.size();
                    int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);
                    int start = (page - 1) * PAGE_SIZE;
                    int end = Math.min(start + PAGE_SIZE, totalItems);
                    if (start >= totalItems) {
                        start = 0;
                        end = Math.min(PAGE_SIZE, totalItems);
                        page = 1;
                    }
                    List<Users> customers = filteredCustomers.subList(start, end);

                    request.setAttribute("customers", customers);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("title", "Quản lý khách hàng");
                    request.getRequestDispatcher("customer-management.jsp").forward(request, response);
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String emailSession = (String) session.getAttribute("email");
        Users currentUser = userDAO.getUserByEmail(emailSession);

        if (currentUser != null && currentUser.getRole().equalsIgnoreCase("Marketing")) {
            String action = request.getParameter("action");
            if ("edit".equals(action)) {
                try {
                    int userID = Integer.parseInt(request.getParameter("id"));
                    String firstName = request.getParameter("firstName");
                    String lastName = request.getParameter("lastName");
                    String gender = request.getParameter("gender");
                    String email = request.getParameter("email");
                    String phoneNumber = request.getParameter("phoneNumber");
                    String address = request.getParameter("address");
                    String status = request.getParameter("status");

                    if (firstName == null || lastName == null || email == null || phoneNumber == null
                            || gender == null || address == null || status == null
                            || firstName.trim().isEmpty() || lastName.trim().isEmpty() || email.trim().isEmpty()
                            || phoneNumber.trim().isEmpty() || gender.trim().isEmpty() || address.trim().isEmpty()
                            || status.trim().isEmpty()) {
                        session.setAttribute("notificationErr", "Vui lòng điền đầy đủ thông tin.");
                        response.sendRedirect(request.getContextPath() + "/marketing/customer-management");
                        return;
                    }

                    Users user = userDAO.getUserByID(userID);
                    if (user == null || !user.getRole().equalsIgnoreCase("Customer")) {
                        session.setAttribute("notificationErr", "Khách hàng không tồn tại hoặc không có quyền.");
                        response.sendRedirect(request.getContextPath() + "/marketing/customer-management");
                        return;
                    }

                    user.setFirstName(firstName);
                    user.setLastName(lastName);
                    user.setGender(gender);
                    user.setEmail(email);
                    user.setPhoneNumber(phoneNumber);
                    user.setAddress(address);
                    user.setStatus(status);

                    boolean updated = userDAO.updateUserProfile(user);
                    if (updated) {
                        session.setAttribute("notification", "Cập nhật khách hàng thành công!");
                    } else {
                        session.setAttribute("notificationErr", "Cập nhật khách hàng thất bại.");
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("notificationErr", "ID khách hàng không hợp lệ.");
                }
            } else if ("add".equals(action)) {
                String firstName = request.getParameter("firstName");
                String lastName = request.getParameter("lastName");
                String email = request.getParameter("email");
                String phoneNumber = request.getParameter("phoneNumber");
                String gender = request.getParameter("gender");
                String address = request.getParameter("address");

                if (firstName == null || lastName == null || email == null || phoneNumber == null
                        || gender == null || address == null
                        || firstName.trim().isEmpty() || lastName.trim().isEmpty() || email.trim().isEmpty()
                        || phoneNumber.trim().isEmpty() || gender.trim().isEmpty() || address.trim().isEmpty()) {
                    session.setAttribute("notificationErr", "Vui lòng điền đầy đủ thông tin.");
                    response.sendRedirect(request.getContextPath() + "/marketing/customer-management");
                    return;
                }

                Users existingUser = userDAO.getUserByEmail(email);
                if (existingUser != null) {
                    session.setAttribute("notificationErr", "Email đã tồn tại trong hệ thống.");
                    response.sendRedirect(request.getContextPath() + "/marketing/customer-management");
                    return;
                }

                String randomPassword = generateRandomPassword();
                Users newUser = new Users();
                newUser.setFirstName(firstName);
                newUser.setLastName(lastName);
                newUser.setEmail(email);
                newUser.setPhoneNumber(phoneNumber);
                newUser.setGender(gender);
                newUser.setAddress(address);
                newUser.setUserName(email.substring(0, email.indexOf("@")));
                newUser.setPassword(randomPassword);
                newUser.setRole("Customer");
                newUser.setStatus("Active");

                boolean added = userDAO.addUser(newUser);
                if (added) {
                    boolean emailSent = sendEmail(email, randomPassword);
                    if (emailSent) {
                        session.setAttribute("notification", "Thêm khách hàng thành công và email đã được gửi.");
                    } else {
                        session.setAttribute("notification", "Thêm khách hàng thành công nhưng gửi email thất bại.");
                    }
                } else {
                    session.setAttribute("notificationErr", "Thêm khách hàng thất bại.");
                }
            }
            response.sendRedirect(request.getContextPath() + "/marketing/customer-management");
        } else {
            session.setAttribute("notificationErr", "Bạn không có quyền truy cập vào trang này");
            response.sendRedirect(request.getContextPath() + "/Login.jsp");
        }
    }

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

    private boolean sendEmail(String toEmail, String password) {
        String fromEmail = "duongdthe181160@fpt.edu.vn"; // your email address
        String host = "smtp.gmail.com";           // your SMTP host
        final String username = "duongdthe181160@fpt.edu.vn"; // email username
        final String emailPassword = "zxobeuirttxaibge"; // email password

        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");
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
            message.setContent("Dear user,<br><br>Tài khoản của bạn đã được tạo với mật khẩu: <strong>" + password + "</strong><br>Vui lòng đổi mật khẩu sau khi đăng nhập.", "text/html; charset=UTF-8");
            Transport.send(message);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
