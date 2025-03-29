package Controller;
import DAO.ReviewsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/updateFeedbackStatus")
public class UpdateFeedbackStatusServlet extends HttpServlet {

    private ReviewsDAO reviewsDAO;

    @Override
    public void init() {
        reviewsDAO = new ReviewsDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int reviewID = Integer.parseInt(request.getParameter("reviewID"));
        String newStatus = request.getParameter("status");

        // Cập nhật trạng thái trong database
        boolean isUpdated = reviewsDAO.updateReviewStatus(reviewID, newStatus);

        if (isUpdated) {
            response.getWriter().write("success");
        } else {
            response.getWriter().write("error");
        }
    }
}
