/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.OrdersDAO;
import DAO.SlidersDAO;
import DAO.UsersDAO;
import Model.DailyRevenue;
import Model.Sliders;
import Model.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.List;

/**
 *
 * @author daoducdanh
 */
@WebServlet(name = "SaleStatisticController", urlPatterns = {"/sale/statistics"})
public class SaleStatisticController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
         try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditSliders</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditSlider at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UsersDAO userDAO = new UsersDAO();
        HttpSession session = request.getSession();
        String emailSession = (String) session.getAttribute("email");
        Users user = userDAO.getUserByEmail(emailSession);

        processRequest(request, response);
        if (user != null) {
            if (user.getRole().equalsIgnoreCase("marketing")) {
                int currentPage = 1;
                String pageParam = request.getParameter("page");
                if (pageParam != null && !pageParam.isEmpty()) {
                    try {
                        currentPage = Integer.parseInt(pageParam);
                    } catch (NumberFormatException e) {
                        currentPage = 1;
                    }
                }

                OrdersDAO ordersDAO = new OrdersDAO();

                LocalDate currentDate = LocalDate.now();
                int currentYear = currentDate.getYear();
                int currentMonth = currentDate.getMonthValue();

                String yearParam = request.getParameter("year");
                String monthParam = request.getParameter("month");
        
        
                int year = (yearParam != null) ? Integer.parseInt(yearParam) : currentYear;
                int month = (monthParam != null) ? Integer.parseInt(monthParam) : currentMonth;

                List<DailyRevenue> statistic = ordersDAO.getDailyRevenueByMonthYear(month, year);

                List<Integer> dayArr = statistic.stream()
                        .map((t) -> t.getDay())
                        .toList();
                List<Double> totalArr = statistic.stream()
                        .map((t) -> t.getTotalRevenue())
                        .toList();
                request.setAttribute("dayArr", dayArr);
                request.setAttribute("totalArr", totalArr);
                request.setAttribute("selectedMonth", month);
                request.setAttribute("selectedYear", year);
                request.getRequestDispatcher("Statistics.jsp").forward(request, response);
            } else {
                session.setAttribute("notificationErr", "Bạn không có quyền truy cập vào trang này");
                response.sendRedirect("../Login.jsp");
            }
        } else {
            session.setAttribute("notificationErr", "Bạn cần đăng nhập trước!");
            response.sendRedirect("../Login.jsp");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                SlidersDAO sliderDAO = new SlidersDAO();

        
        String search = request.getParameter("search");
        String status = request.getParameter("status");
        List<Sliders> sliders = sliderDAO.searchSliders(search, status);
        request.setAttribute("sliders", sliders);
        request.setAttribute("search", search);
        request.setAttribute("status", status);
        
        request.getRequestDispatcher("SliderList.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
