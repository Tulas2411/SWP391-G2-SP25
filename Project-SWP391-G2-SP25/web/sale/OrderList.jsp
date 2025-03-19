<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách đơn hàng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="bg-light">
    <jsp:include page="header.jsp"></jsp:include>
    
    <main class="container mt-4 p-4 bg-white rounded shadow">
        <h2 class="text-center mb-4">Danh sách đơn hàng</h2>
        
        <!-- Bộ lọc và tìm kiếm -->
        <form method="GET" action="OrdersList" class="row g-3 mb-4">
            <div class="col-md-4">
                <label for="fromDate" class="form-label">Từ ngày:</label>
                <input type="date" id="fromDate" name="fromDate" value="${param.fromDate}" class="form-control">
            </div>
            <div class="col-md-4">
                <label for="toDate" class="form-label">Đến ngày:</label>
                <input type="date" id="toDate" name="toDate" value="${param.toDate}" class="form-control">
            </div>
            <div class="col-md-4">
                <label for="status" class="form-label">Trạng thái:</label>
                <select id="status" name="status" class="form-select">
                    <option value="">Tất cả trạng thái</option>
                    <option value="Pending" ${param.status == 'Pending' ? 'selected' : ''}>Chờ xử lý</option>
                    <option value="Cancelled" ${param.status == 'Cancelled' ? 'selected' : ''}>Đã hủy</option>
                    <option value="Shipped" ${param.status == 'Shipped' ? 'selected' : ''}>Đã giao hàng</option>
                    <option value="Delivered" ${param.status == 'Delivered' ? 'selected' : ''}>Đã giao thành công</option>
                    <option value="Processing" ${param.status == 'Processing' ? 'selected' : ''}>Đang xử lý</option>
                    <option value="Completed" ${param.status == 'Completed' ? 'selected' : ''}>Thành công</option>
                </select>
            </div>
            <div class="col-12 text-center">
                <button type="submit" class="btn btn-primary">Lọc</button>
            </div>
        </form>
        
        <!-- Bảng danh sách đơn hàng -->
        <div class="table-responsive">
            <table class="table table-bordered table-hover">
                <thead class="table-primary">
                    <tr>
                        <th>ID</th>
                        <th>Ngày đặt hàng</th>
                        <th>Tên khách hàng</th>
                        <th>Địa chỉ giao hàng</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td>
                                <button class="btn btn-link" onclick="window.location.href='OrderDetail?id=${order.orderID}'">
                                    ${order.orderID}
                                </button>
                            </td>
                            <td>${order.orderDate}</td>
                            <td>${order.customerFirstName} ${order.customerLastName}</td>
                            <td>${order.deliveryAddress}</td>
                            <td>${order.totalAmount}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${order.status eq 'Pending'}">Chờ xử lý</c:when>
                                    <c:when test="${order.status eq 'Cancelled'}">Đã hủy</c:when>
                                    <c:when test="${order.status eq 'Shipped'}">Đã giao hàng</c:when>
                                    <c:when test="${order.status eq 'Delivered'}">Đã giao thành công</c:when>
                                    <c:when test="${order.status eq 'Processing'}">Đang xử lý</c:when>
                                    <c:when test="${order.status eq 'Completed'}">Thành công</c:when>
                                </c:choose>
                            </td>
                            <td>
                                <button class="btn btn-info btn-sm" onclick="window.location.href='OrderDetail?id=${order.orderID}'">
                                    Xem chi tiết
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Phân trang -->
        <nav aria-label="Phân trang" class="mt-4">
            <ul class="pagination justify-content-center">
                <c:if test="${currentPage > 1}">
                    <li class="page-item">
                        <a class="page-link" href="OrdersList?page=${currentPage - 1}&search=${param.search}&fromDate=${param.fromDate}&toDate=${param.toDate}&saleName=${param.saleName}&status=${param.status}">
                            Trước
                        </a>
                    </li>
                </c:if>
                <li class="page-item disabled">
                    <span class="page-link">Trang ${currentPage} trên ${totalPages}</span>
                </li>
                <c:if test="${currentPage < totalPages}">
                    <li class="page-item">
                        <a class="page-link" href="OrdersList?page=${currentPage + 1}&search=${param.search}&fromDate=${param.fromDate}&toDate=${param.toDate}&saleName=${param.saleName}&status=${param.status}">
                            Tiếp
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </main>
    
    <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
