package Controller;

import DAO.UserLogDAO;
import DAO.UsersDAO;
import Model.UserLog;
import Model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin từ form
        String userName = request.getParameter("userName");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String gender = request.getParameter("gender");
        String dateOfBirth = request.getParameter("dateOfBirth");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        int userID = Integer.parseInt(request.getParameter("userID"));

        // Khởi tạo DAO và lấy thông tin người dùng từ database
        UsersDAO usersDAO = new UsersDAO();
        Users currentUser = usersDAO.getUserByID(userID);

        // Lưu lại các giá trị cũ để so sánh sau khi cập nhật
        String oldFirstName = currentUser.getFirstName();
        String oldLastName = currentUser.getLastName();
        String oldGender = currentUser.getGender();
        String oldPhoneNumber = currentUser.getPhoneNumber();
        String oldAddress = currentUser.getAddress();

        // Cập nhật các trường không liên quan đến mật khẩu và email
        currentUser.setFirstName(firstName);
        currentUser.setLastName(lastName);
        currentUser.setGender(gender);
        currentUser.setDateOfBirth(dateOfBirth);
        currentUser.setPhoneNumber(phoneNumber);
        currentUser.setAddress(address);

        // Email và username không thay đổi
        currentUser.setUserName(userName);
        // currentUser.setEmail(currentUser.getEmail()); // Không cần thiết

        // Thực hiện cập nhật thông tin người dùng
        boolean isUpdated = usersDAO.updateUser(currentUser);

        // Xử lý kết quả cập nhật
        if (isUpdated) {
            StringBuilder changes = new StringBuilder();
            if (!firstName.equals(oldFirstName)) {
                changes.append("FirstName: [").append(oldFirstName).append("] -> [").append(firstName).append("], ");
            }
            if (!lastName.equals(oldLastName)) {
                changes.append("LastName: [").append(oldLastName).append("] -> [").append(lastName).append("], ");
            }
            if (!gender.equals(oldGender)) {
                changes.append("Gender: [").append(oldGender).append("] -> [").append(gender).append("], ");
            }
            if (!phoneNumber.equals(oldPhoneNumber)) {
                changes.append("PhoneNumber: [").append(oldPhoneNumber).append("] -> [").append(phoneNumber).append("], ");
            }
            if (!address.equals(oldAddress)) {
                changes.append("Address: [").append(oldAddress).append("] -> [").append(address).append("], ");
            }

            if (changes.length() > 0) {
                // Loại bỏ dấu phẩy và khoảng trắng cuối chuỗi
                changes.setLength(changes.length() - 2);
                UserLogDAO userLogDAO = new UserLogDAO();
                UserLog userLog = new UserLog();
                userLog.setUserId(userID);
                userLog.setLog("Người dùng đã sửa: " + changes.toString());
                userLogDAO.addLogs(userLog);
            }
            request.setAttribute("updateSuccess", "Hồ sơ được cập nhật thành công!");
        } else {
            request.setAttribute("updateError", "Lỗi khi cập nhật hồ sơ.");
        }
        request.getRequestDispatcher("UserProfile.jsp").forward(request, response);
    }
}
