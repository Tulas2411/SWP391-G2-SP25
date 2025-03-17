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

        // Lấy toàn bộ log từ database (nên cải tiến bằng cách tạo phương thức getLogsByUserId)
        UserLogDAO userLogDAO = new UserLogDAO();
        List<UserLog> logs = userLogDAO.getAllUserLogs();
        
        // Lọc ra các log của user có userID tương ứng
        StringBuilder html = new StringBuilder();
        html.append("<table class=\"table table-bordered\">");
        html.append("<thead><tr><th>ID</th><th>Nội dung Log</th><th>Ngày thay đổi</th></tr></thead>");
        html.append("<tbody>");
        boolean found = false;
        for (UserLog log : logs) {
            if (log.getUserId() == userId) {
                found = true;
                html.append("<tr>");
                html.append("<td>").append(log.getId()).append("</td>");
                html.append("<td>").append(log.getLog()).append("</td>");
                html.append("<td>").append(log.getChange_date()).append("</td>");
                html.append("</tr>");
            }
        }
        if (!found) {
            html.append("<tr><td colspan='3'>Không có log nào cho người dùng này.</td></tr>");
        }
        html.append("</tbody></table>");

        response.setContentType("text/html;charset=UTF-8");
        try(PrintWriter out = response.getWriter()){
            out.print(html.toString());
        }
    }
}
