/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAO.CartItemsDAO;
import DAO.CartsDAO;
import Model.CartItems;
import Model.Users;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
import org.json.JSONObject;
/**
 *
 * @author admin
 */
@WebServlet(name="AddToCartController", urlPatterns={"/add-to-cart"})
public class AddToCartController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet AddToCartController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddToCartController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JSONObject jsonResponse = new JSONObject();
        CartItemsDAO ciDAO = new CartItemsDAO();
        CartsDAO cDAO = new CartsDAO();

        try {
            // Lấy dữ liệu từ request
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            // Kiểm tra số lượng hợp lệ
            if (quantity < 1) {
                jsonResponse.put("success", false);
                jsonResponse.put("error", "Số lượng không hợp lệ");
                response.getWriter().write(jsonResponse.toString());
                return;
            }

            // Lấy giỏ hàng từ session
            HttpSession session = request.getSession();
            Users user = (Users) session.getAttribute("user");
            if(user!=null){
            Map<Integer, CartItems> list = ciDAO.getCartItemsByCartIDasMap(cDAO.getCartByCustomerID(user.getUserID()).getCartID());
            // Thêm sản phẩm vào giỏ hàng
            if(list.size() !=0 ){
            for (int id : list.keySet()) {
                // Nếu sản phẩm đã có trong giỏ hàng, cộng thêm số lượng
               CartItems ci = list.get(id);
               if(ci.getProductID() == productId){
                   int old = ciDAO.getCartItemByID(id).getQuantity();
                   ciDAO.updateQuantityCartItem(old + quantity, id);
                   break;
               }else{
                   ciDAO.addCartItem(new CartItems(cDAO.getCartByCustomerID(user.getUserID()).getCartID(), productId, quantity));
                   break;
               }
            }
            }else{
                ciDAO.addCartItem(new CartItems(cDAO.getCartByCustomerID(user.getUserID()).getCartID(), productId, quantity));
            }
                
            } else {
                request.setAttribute("loginError", "Bạn cần phải đăng nhập trước");
                response.sendRedirect("LoginServlet");
            }
            

            // Trả về kết quả thành công
            jsonResponse.put("success", true);
        } catch (NumberFormatException e) {
            jsonResponse.put("success", false);
            jsonResponse.put("error", "Dữ liệu không hợp lệ");
        } catch (Exception e) {
            jsonResponse.put("success", false);
            jsonResponse.put("error", "Lỗi hệ thống: " + e.getMessage());
        }

        response.getWriter().write(jsonResponse.toString());
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
