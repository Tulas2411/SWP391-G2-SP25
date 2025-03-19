<%-- 
    Document   : ShipperOrder
    Created on : Mar 20, 2025, 4:15:35 AM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@page import="DAO.*"%>
<%@page import="Model.*"%>
<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.text.NumberFormat"%>
<jsp:include page="header.jsp"></jsp:include>
    <main class="container mt-4">
        <h2 class="text-center">Chi tiết đơn hàng</h2>

        <!-- Thông tin đơn hàng -->
        <section class="mb-4">
            <h3 class="border-bottom pb-2">Thông tin đơn hàng</h3>
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead class="table-light">
                        <tr>
                            <th>Hình ảnh</th>
                            <th>Tên sản phẩm</th>
                            <th>Số lượng</th>
                            <th>Đơn giá</th>
                            <th>Thành giá</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                    OrderDetailsDAO odDAO = new OrderDetailsDAO();
                    ProductsDAO pDAO = new ProductsDAO();
                    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                    Map<Integer, OrderDetails> list = (Map<Integer, OrderDetails>) request.getAttribute("list");
                    for(int id : list.keySet()){
                        OrderDetails od = list.get(id);
                        Products p = pDAO.getProductByID(od.getProductID());
                        int quantity = od.getQuantity();
                        // Tính tổng giá tiền
                        double totalPrice = p.getPrice() * od.getQuantity();
                        String formattedTotalPrice = currencyFormat.format(totalPrice);
                    %>
                    <tr>
                        <td><img src="<%=p.getImageLink()%>" alt="Hình ảnh sản phẩm" class="img-thumbnail" width="100"></td>
                        <td><%=p.getProductName()%></td>
                        <td><%=quantity%></td>
                        <td class="text-danger"><%=p.getPriceFormat()%></td>
                        <td class="text-danger"><%=formattedTotalPrice%></td>
                    </tr>
                    <%}%>
                </tbody>
            </table>
        </div>
    </section>
    <%
        Orders o = (Orders) request.getAttribute("o");
        UsersDAO uDAO = new UsersDAO();
    %>
    <!-- Thông tin người nhận -->
    <section class="bg-light p-3 rounded">
        <h3>Thông tin người nhận</h3>
        <p><strong>Ngày đặt hàng:</strong> <%=o.getOrderDate()%></p>
        <p><strong>Địa chỉ giao hàng:</strong> <%=o.getDeliveryAddress()%></p>
        <p><strong>Trạng thái:</strong> 
            <%
                String status = o.getStatus();
                String color;
                String statusText;

                if ("Shipping".equals(status)) {
                    color = "blue";
                    statusText = "Đang giao hàng";
                } else if ("Delivered".equals(status)) {
                    color = "green";
                    statusText = "Giao thành công";
                } else {
                    color = "red";
                    statusText = "Đã hủy"; // Giả định trạng thái khác là "Cancelled"
                }
            %>
            <span style="color: <%=color%>;"><%=statusText%></span>
        </p>
        <p><strong>Tổng tiền:</strong> <%=currencyFormat.format(o.getTotalAmount())%></p>
        <p><strong>Ghi chú:</strong> <%=o.getBillOfLading()%></p>
    </section>
    <%if(o.getStatus().equalsIgnoreCase("Shipping")){%>
    <form action="${contextPath}/ShipperOrderDetail" method="POST" style="display:inline"
          onsubmit="return confirm('Xác nhận giao hàng thành công?');">
        <input type="hidden" name="action" value="updateStatus">
        <input type="hidden" name="orderID" value="<%=o.getOrderID()%>}">
        <button type="submit" class="btn btn-success btn-sm">Giao Thành Công</button>
    </form>
    <%}%>
</main>
<jsp:include page="footer.jsp"></jsp:include>


