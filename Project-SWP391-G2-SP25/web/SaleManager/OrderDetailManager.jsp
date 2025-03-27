<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="shortcut icon" href="assets/img/S4EWhite.PNG" type="image/x-icon" />
</head>

<body>
    <jsp:include page="header.jsp"></jsp:include>

        <main class="container mt-4">
            <h2 class="text-center">Chi tiết đơn hàng</h2>
        <c:if test="${not empty sessionScope.notification}">
            <div class="alert alert-success alert-dismissible fade show" role="alert" style="text-align: center">
                ${sessionScope.notification}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% session.removeAttribute("notification"); %>
        </c:if>
        <c:if test="${not empty sessionScope.notificationErr}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert" style="text-align: center">
                ${sessionScope.notificationErr}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% session.removeAttribute("notificationErr");%>
        </c:if>
        <!-- Thông tin đơn hàng -->
        <section class="mb-4">
            <h3 class="border-bottom pb-2">Thông tin đơn hàng</h3>
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead class="table-light">
                        <tr>
                            <th>ID Chi tiết</th>
                            <th>Tên sản phẩm</th>
                            <th>Số lượng</th>
                            <th>Đơn giá</th>
                            <th>Giá gốc</th>
                            <th>Hình ảnh</th>
                            <th>Chi tiết</th>
                            <th>Tổng tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="orderDetail" items="${orderDetailsList}">
                            <tr>
                                <td>${orderDetail.orderDetailID}</td>
                                <td>${orderDetail.nameProduct}</td>
                                <td>${orderDetail.quantity}</td>
                                <td class="text-danger">
                                    <fmt:formatNumber value="${orderDetail.price}" pattern="#,##0"/> đ
                                </td>
                                <td class="text-muted text-decoration-line-through">
                                    <fmt:formatNumber value="${orderDetail.priceProduct}" pattern="#,##0"/> đ
                                </td>
                                <td><img src="${orderDetail.imgProduct}" alt="Hình ảnh sản phẩm" class="img-thumbnail" width="100"></td>
                                <td>${orderDetail.desProduct}</td>
                                <td>
                                    <fmt:formatNumber value="${orderDetail.quantity * orderDetail.price}" pattern="#,##0"/> đ
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </section>

        <!-- Thông tin người nhận -->
        <section class="bg-light p-3 rounded">
            <h3>Thông tin người nhận</h3>
            <p><strong>Ngày đặt hàng:</strong> ${order.orderDate}</p>
            <p><strong>Địa chỉ giao hàng:</strong> ${order.deliveryAddress}</p>
            <p><strong>Trạng thái:</strong>
                <c:choose>
                    <c:when test="${order.status eq 'Submitted'}">Chờ xử lý</c:when>
                    <c:when test="${order.status eq 'Cancelled'}">Đã hủy</c:when>
                    <c:when test="${order.status eq 'Shipping'}">Đang giao hàng</c:when>
                    <c:when test="${order.status eq 'Delivered'}">Đã giao thành công</c:when>
                    <c:when test="${order.status eq 'Processing'}">Đang xử lý</c:when>
                    <c:when test="${order.status eq 'Processed'}">Đang chờ Shipper nhận đơn</c:when>
                </c:choose></p>
            <p><strong>Tổng tiền:</strong> 
                <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/> đ
            </p>
            <p><strong>Ghi chú:</strong> ${order.billOfLading}</p>
        </section>

        <!-- Quản lý đơn hàng -->
        <section class="mt-4">
            <c:if test="${order.status eq 'Submitted'}">
                <h3 class="border-bottom pb-2">Gán đơn hàng</h3>
                <form method="POST" action="${pageContext.request.contextPath}/AssignOrderController" class="d-flex align-items-center gap-2">
                    <input type="hidden" name="orderId" value="${order.orderID}">
                    <label for="sale" class="me-2">Gán cho nhân viên:</label>
                    <select name="saleId" class="form-select w-auto" required>
                        <option value="">-- Chọn nhân viên --</option>
                        <c:forEach var="sale" items="${salesList}">
                            <option value="${sale.userID}">${sale.firstName} ${sale.lastName}</option>
                        </c:forEach>
                    </select>
                    <button type="submit" class="btn btn-success">Gán đơn hàng</button>
                </form>
            </c:if>
        </section>


    </main>

    <jsp:include page="footer.jsp"></jsp:include>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
