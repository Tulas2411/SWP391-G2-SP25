/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.SlidersDAO;
import Model.Sliders;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author manh
 */
@WebServlet(name = "ListSliders", urlPatterns = {"/ListSliders"})
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
    // Lấy tham số tìm kiếm và trạng thái từ request
    String search = request.getParameter("search");
    String status = request.getParameter("status");

    // Lấy trang hiện tại từ request, mặc định là trang 1
    int currentPage = 1;
    String pageParam = request.getParameter("page");
    if (pageParam != null && !pageParam.isEmpty()) {
        currentPage = Integer.parseInt(pageParam);
    }

    // Số bản ghi mỗi trang
    int pageSize = 10;

    // Tạo DAO và tính toán số lượng bản ghi
    SlidersDAO sliderDAO = new SlidersDAO();
    int totalRecords = sliderDAO.countSliders(search, status);  // Phương thức đếm số bản ghi
    int totalPages = (int) Math.ceil((double) totalRecords / pageSize);  // Tính số trang

    // Lấy danh sách slider cho trang hiện tại
    List<Sliders> sliders = sliderDAO.getSlidersByPage(search, status, currentPage, pageSize);

    // Đưa các giá trị vào request
    request.setAttribute("sliders", sliders);
    request.setAttribute("currentPage", currentPage);
    request.setAttribute("totalPages", totalPages);
    request.setAttribute("search", search);
    request.setAttribute("status", status);

    // Chuyển tiếp đến trang JSP để hiển thị
    request.getRequestDispatcher("SliderList.jsp").forward(request, response);
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
