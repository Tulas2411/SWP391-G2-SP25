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
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.List;

/**
 *
 * @author manh
 */
@WebServlet(name = "DetailSlider", urlPatterns = {"/DetailSlider"})
public class EditDetailSlider extends HttpServlet {

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
            out.println("<title>Servlet EditDetailSlider</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditDetailSlider at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
    
    Part filePart = request.getPart("newImage"); // Lấy file ảnh mới
    String fileName = filePart.getSubmittedFileName(); // Lấy tên file
    String uploadPath = getServletContext().getRealPath("") + "uploads"; // Thư mục lưu ảnh

    // Tạo thư mục nếu chưa tồn tại
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) {
        uploadDir.mkdir();
    }

    String imagePath = null;
    if (fileName != null && !fileName.isEmpty()) {
        imagePath = "uploads/" + fileName;
        filePart.write(uploadPath + File.separator + fileName); // Lưu ảnh vào thư mục server
    } else {
        imagePath = request.getParameter("currentImage"); // Nếu không upload ảnh mới, giữ ảnh cũ
    }

    // Lấy dữ liệu từ form
    int sliderID = Integer.parseInt(request.getParameter("sliderID"));
    String title = request.getParameter("title");
    String backlink = request.getParameter("backlink");
    String status = request.getParameter("status");

    // Cập nhật slider
    Sliders slider = new Sliders();
    slider.setSliderID(sliderID);
    slider.setTitle(title);
    slider.setImage(imagePath);
    slider.setBacklink(backlink);
    slider.setStatus(status);

    SlidersDAO slidersDAO = new SlidersDAO();
    slidersDAO.updateSlider(slider);

    // Quay lại danh sách sliders
    response.sendRedirect("ListSlider");
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
