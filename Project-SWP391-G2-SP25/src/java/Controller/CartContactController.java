/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.*;
import Model.*;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;
import jakarta.servlet.http.HttpSession;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;
import org.json.JSONObject;

/**
 *
 * @author admin
 */
@WebServlet(name = "CartContactController", urlPatterns = {"/CartContact"})
public class CartContactController extends HttpServlet {

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
            out.println("<title>Servlet CartContactController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartContactController at " + request.getContextPath() + "</h1>");
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
    public Orders getOrderPendingByID(int userID) {
        // Giả sử bạn có một danh sách đơn hàng
        OrdersDAO oDAO = new OrdersDAO();
        Map<Integer, Orders> orderList = oDAO.getOrdersByCustomerIDasMap(userID);
        for (Orders order : orderList.values()) {
            if ("Pending".equals(order.getStatus())) {
                return order;
            }
        }
        return null; // Trả về null nếu không tìm thấy
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy tổng giá trị giỏ hàng
        //double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));

        // Lấy danh sách sản phẩm đã chọn
        List<Map<String, Object>> selectedItems = new ArrayList<>();
        int index = 0;
        while (true) {
            String productID = request.getParameter("productID" + index);
            String quantity = request.getParameter("quantity" + index);
            String price = request.getParameter("price" + index);

            if (productID == null || quantity == null || price == null) {
                break; // Kết thúc khi không còn tham số
            }

            // Thêm sản phẩm vào danh sách
            Map<String, Object> item = new HashMap<>();
            item.put("productID", Integer.parseInt(productID));
            item.put("quantity", Integer.parseInt(quantity));
            item.put("price", Double.parseDouble(price));
            selectedItems.add(item);

            index++;
        }

        // Xử lý đơn hàng
        HttpSession session = request.getSession();
        OrdersDAO oDAO = new OrdersDAO();
        OrderDetailsDAO odDAO = new OrderDetailsDAO();
        Users user = (Users) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        Orders order = oDAO.getOrderPendingByID(user.getUserID());
        if (order == null) {
            order = new Orders(user.getUserID(), null, null, "Pending", 0, null);
            boolean isAdded = oDAO.addOrder(order);
            if (!isAdded) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể tạo đơn hàng mới.");
                return;
            }
            order = oDAO.getOrderPendingByID(user.getUserID());
        }

        if (order == null) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể lấy thông tin đơn hàng.");
            return;
        }

        int orderID = order.getOrderID();

        // Thêm các sản phẩm vào đơn hàng
        for (Map<String, Object> item : selectedItems) {
            int productID = (int) item.get("productID");
            int quantity = (int) item.get("quantity");
            double price = (double) item.get("price");
            odDAO.addOrderDetail(new OrderDetails(orderID, productID, quantity, (float) price));
        }

        // Chuyển hướng đến trang CartContact.jsp
        Map<Integer, OrderDetails> list = odDAO.getOrderDetailsByOrderIDasMap(orderID);
        request.setAttribute("list", list);
        request.getRequestDispatcher("CartContact.jsp").forward(request, response);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy dữ liệu từ form
        String selectedItemsJson = request.getParameter("selectedItems");

        // Chuyển đổi JSON thành List<Map<String, Object>>
        Gson gson = new Gson();
        Type type = new TypeToken<List<Map<String, Object>>>(){}.getType();
        List<Map<String, Object>> selectedItems = gson.fromJson(selectedItemsJson, type);

        // Lưu vào session
        HttpSession session = request.getSession();
        request.setAttribute("selectedItems", selectedItems);

        // Chuyển hướng đến trang thanh toán
        request.getRequestDispatcher("CartContact.jsp").forward(request, response);
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
