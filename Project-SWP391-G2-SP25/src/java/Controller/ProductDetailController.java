package Controller;

import DAO.ProductsDAO;
import DAO.ReviewsDAO;
import Model.Products;
import Model.Reviews;
import java.io.IOException;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet xử lý hiển thị chi tiết sản phẩm và đánh giá
 * @author Admin
 */
@WebServlet(name = "ProductDetailController", urlPatterns = {"/product-detail"})
public class ProductDetailController extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request HttpServletRequest
     * @param response HttpServletResponse
     * @throws ServletException nếu có lỗi Servlet
     * @throws IOException nếu có lỗi IO
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy tham số ID sản phẩm từ request
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                redirectToErrorPage(request, response, "ID sản phẩm không hợp lệ.");
                return;
            }

            int productId = Integer.parseInt(idParam);

            // Khởi tạo DAO
            ProductsDAO pDAO = new ProductsDAO();
            ReviewsDAO rDAO = new ReviewsDAO();

            // Lấy thông tin sản phẩm và danh sách đánh giá từ DB
            Products product = pDAO.getProductByID(productId);
            Map<Integer, Reviews> reviewsList = rDAO.getAllReviewsByProductID(productId);

            // Kiểm tra nếu sản phẩm không tồn tại
            if (product == null) {
                redirectToErrorPage(request, response, "Sản phẩm không tồn tại.");
                return;
            }

            // Gán dữ liệu vào request
            request.setAttribute("product", product);
            request.setAttribute("reviewsList", reviewsList);

            // Chuyển hướng đến trang chi tiết sản phẩm
            request.getRequestDispatcher("ProductDetail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            redirectToErrorPage(request, response, "ID sản phẩm không hợp lệ.");
        } catch (Exception e) {
            e.printStackTrace();
            redirectToErrorPage(request, response, "Có lỗi xảy ra khi tải chi tiết sản phẩm.");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request HttpServletRequest
     * @param response HttpServletResponse
     * @throws ServletException nếu có lỗi Servlet
     * @throws IOException nếu có lỗi IO
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * Chuyển hướng đến trang lỗi với thông báo cụ thể
     * @param request HttpServletRequest
     * @param response HttpServletResponse
     * @param errorMessage Thông báo lỗi
     * @throws ServletException nếu có lỗi Servlet
     * @throws IOException nếu có lỗi IO
     */
    private void redirectToErrorPage(HttpServletRequest request, HttpServletResponse response, String errorMessage)
            throws ServletException, IOException {
        request.setAttribute("errorMessage", errorMessage);
        request.getRequestDispatcher("error.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet hiển thị chi tiết sản phẩm";
    }
}

///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
// */
//
//package Controller;
//
//import DAO.*;
//import Model.Products;
//import Model.Reviews;
//import java.io.IOException;
//import java.io.PrintWriter;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.util.Map;
///**
// *
// * @author admin
// */
//@WebServlet(name="ProductDetailController", urlPatterns={"/ProductDetailController"})
//public class ProductDetailController extends HttpServlet {
//   
//    /** 
//     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//    throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet ProductDetailController</title>");  
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet ProductDetailController at " + request.getContextPath () + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
//    } 
//
//    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
//    /** 
//     * Handles the HTTP <code>GET</code> method.
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//    throws ServletException, IOException {
//        int id = Integer.parseInt(request.getParameter("id"));
//        ProductsDAO pDAO = new ProductsDAO();
//        ReviewsDAO r = new ReviewsDAO();
//        Products p = pDAO.GetProductbyID(id);
//        Map<Integer, Reviews> listr = r.getAllReviewsbyProductID(id);
//        request.setAttribute("product", p);
//        request.setAttribute("listr", listr);
//        request.getRequestDispatcher("ProductDetail.jsp").forward(request, response);
//    } 
//
//    /** 
//     * Handles the HTTP <code>POST</code> method.
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//    throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    /** 
//     * Returns a short description of the servlet.
//     * @return a String containing servlet description
//     */
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }// </editor-fold>
//
//}
