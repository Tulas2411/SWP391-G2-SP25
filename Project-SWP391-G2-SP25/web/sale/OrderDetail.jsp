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
                                <td class="text-danger">${orderDetail.price}</td>
                                <td class="text-muted text-decoration-line-through">${orderDetail.priceProduct}</td>
                                <td><img src="${orderDetail.imgProduct}" alt="Hình ảnh sản phẩm" class="img-thumbnail" width="100"></td>
                                <td>${orderDetail.desProduct}</td>
                                <td>${orderDetail.quantity * orderDetail.price}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </section>

        <!-- Thông tin người nhận -->
        <section class="bg-light p-3 rounded">
            <h3>Thông tin người nhận</h3>
            <p><strong>Ngày đặt hàng:</strong> ${orders.orderDate}</p>
            <p><strong>Địa chỉ giao hàng:</strong> ${orders.deliveryAddress}</p>
            <p><strong>Trạng thái:</strong> ${orders.status}</p>
            <p><strong>Tổng tiền:</strong> ${orders.totalAmount}</p>
            <p><strong>Mã vận đơn:</strong> ${orders.billOfLading}</p>
        </section>

        <!-- Quản lý đơn hàng -->
        <section class="mt-4">
            <h3 class="border-bottom pb-2">Quản lý đơn hàng</h3>
            <form method="POST" action="OrderDetail" class="d-flex align-items-center gap-2">
                <input type="hidden" name="orderId" value="${orders.orderID}">
                <label for="status" class="me-2">Trạng thái:</label>
                <select name="status" class="form-select w-auto">
                    <option value="Pending" ${orders.status == 'Pending' ? 'selected' : ''}>Chờ xử lý</option>
                    <option value="Processing" ${orders.status == 'Processing' ? 'selected' : ''}>Đang xử lý</option>
                    <option value="Shipped" ${orders.status == 'Shipped' ? 'selected' : ''}>Đã giao hàng</option>
                    <option value="Completed" ${orders.status == 'Completed' ? 'selected' : ''}>Hoàn thành</option>
                    <option value="Cancelled" ${orders.status == 'Cancelled' ? 'selected' : ''}>Đã hủy</option>
                </select>
                <button type="submit" class="btn btn-primary">Cập nhật</button>
            </form>
        </section>

        <!-- Gán đơn hàng (chỉ dành cho quản lý) -->
        <c:if test="${user.role == 'Manager'}">
            <section class="mt-4">
                <h3 class="border-bottom pb-2">Gán đơn hàng</h3>
                <form method="POST" action="AssignOrderController" class="d-flex align-items-center gap-2">
                    <input type="hidden" name="orderId" value="${order.id}">
                    <label for="sale" class="me-2">Gán cho nhân viên:</label>
                    <select name="saleId" class="form-select w-auto">
                        <c:forEach var="sale" items="${salesList}">
                            <option value="${sale.id}" ${sale.id == order.sale.id ? 'selected' : ''}>${sale.name}</option>
                        </c:forEach>
                    </select>
                    <button type="submit" class="btn btn-success">Gán</button>
                </form>
            </section>
        </c:if>
    </main>

    <jsp:include page="footer.jsp"></jsp:include>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
