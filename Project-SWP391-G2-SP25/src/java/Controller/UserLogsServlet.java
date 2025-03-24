package Controller;

import DAO.UserLogDAO;
import Model.UserLog;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/marketing/user-logs")
public class UserLogsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userIdStr = request.getParameter("userId");
        int userId = 0;
        try {
            userId = Integer.parseInt(userIdStr);
        } catch (NumberFormatException e) {
            response.getWriter().println("User ID không hợp lệ.");
            return;
        }

        UserLogDAO userLogDAO = new UserLogDAO();
        List<UserLog> logs = userLogDAO.getLogsByUserId(userId); // Use the new method

        StringBuilder html = new StringBuilder();
        html.append("<table class=\"table table-bordered\">");
        html.append("<thead><tr>")
            .append("<th>Email</th>")
            .append("<th>Họ và tên</th>")
            .append("<th>Giới tính</th>")
            .append("<th>Số điện thoại</th>")
            .append("<th>Địa chỉ</th>")
            .append("<th>Người cập nhật</th>")
            .append("<th>Ngày cập nhật</th>")
            .append("</tr></thead>");
        html.append("<tbody>");

        boolean hasValidLog = false;
        for (UserLog log : logs) {
            // Check if the log entry has at least one meaningful field
            if (log.getEmail() != null || log.getFullName() != null || log.getGender() != null ||
                log.getMobile() != null || log.getAddress() != null || log.getUpdatedBy() != null) {
                hasValidLog = true;
                html.append("<tr>");
                html.append("<td>").append(log.getEmail() != null ? log.getEmail() : "").append("</td>");
                html.append("<td>").append(log.getFullName() != null ? log.getFullName() : "").append("</td>");
                html.append("<td>").append(log.getGender() != null ? (log.getGender().equals("Male") ? "Nam" : "Nữ") : "").append("</td>");
                html.append("<td>").append(log.getMobile() != null ? log.getMobile() : "").append("</td>");
                html.append("<td>").append(log.getAddress() != null ? log.getAddress() : "").append("</td>");
                html.append("<td>").append(log.getUpdatedBy() != null ? log.getUpdatedBy() : "").append("</td>");
                html.append("<td>").append(log.getChangeDate() != null ? log.getChangeDate().toString() : "").append("</td>");
                html.append("</tr>");
            }
        }

        if (!hasValidLog) {
            html.append("<tr><td colspan='7'>Không có lịch sử chỉnh sửa nào cho người dùng này.</td></tr>");
        }

        html.append("</tbody></table>");

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.print(html.toString());
        }
    }
}