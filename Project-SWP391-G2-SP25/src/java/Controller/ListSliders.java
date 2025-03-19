/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.SlidersDAO;
import DAO.UsersDAO;
import Model.Sliders;
import Model.Users;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author manh
 */
@WebServlet(name = "ListSliders", urlPatterns = {"/marketing/ListSliders"})
public class ListSliders extends HttpServlet {

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
        String search = request.getParameter("search");
        String status = request.getParameter("status");

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

                int pageSize = 5;

                SlidersDAO slidersDAO = new SlidersDAO();
                int totalRecords = slidersDAO.countSliders(search, status);
                int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

                List<Sliders> sliders = slidersDAO.getSlidersByPage(search, status, currentPage, pageSize);

                request.setAttribute("sliders", sliders);
                request.setAttribute("currentPage", currentPage);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("search", search);
                request.setAttribute("status", status);
                 request.getRequestDispatcher("SliderList.jsp").forward(request, response);
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

        String search = request.getParameter("search");
        String status = request.getParameter("status");

        SlidersDAO sliderDAO = new SlidersDAO();

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
