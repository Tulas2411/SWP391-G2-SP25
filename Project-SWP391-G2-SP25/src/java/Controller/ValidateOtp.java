package Controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.Instant;
import java.time.Duration;

@WebServlet("/ValidateOtp")
public class ValidateOtp extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int value = Integer.parseInt(request.getParameter("otp"));
        HttpSession session = request.getSession();
        int otp = (int) session.getAttribute("otp");
        Instant otpGeneratedTime = (Instant) session.getAttribute("otpGeneratedTime"); // Lấy thời gian OTP được tạo
        
        RequestDispatcher dispatcher = null;

        // Kiểm tra xem OTP có hết hạn hay không
        Instant now = Instant.now();
        Duration timeElapsed = Duration.between(otpGeneratedTime, now);

        if (timeElapsed.toMinutes() >= 1) {
            // Nếu quá 1 phút, OTP hết hạn
            request.setAttribute("message", "OTP has expired. Please try again.");
            dispatcher = request.getRequestDispatcher("Login.jsp");
            dispatcher.forward(request, response);
        } else if (value == otp) {
            // Nếu OTP hợp lệ trong thời gian cho phép
            request.setAttribute("email", request.getParameter("email"));
            request.setAttribute("status", "success");
            dispatcher = request.getRequestDispatcher("NewPassword.jsp");
            dispatcher.forward(request, response);
        } else {
            // Nếu OTP không hợp lệ
            request.setAttribute("message", "Wrong OTP. Please try again.");
            dispatcher = request.getRequestDispatcher("EnterOtp.jsp");
            dispatcher.forward(request, response);
        }
    }
}
