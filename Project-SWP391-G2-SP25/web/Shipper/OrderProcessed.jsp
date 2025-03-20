<%-- 
    Document   : OrderProcessed
    Created on : Mar 20, 2025, 11:26:43 AM
    Author     : admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<style>
    #datatablesSimple {
        width: 100%;
        border-collapse: collapse;
        font-size: 14px;
    }

    /* Cân đối kích thước các cột */
    #datatablesSimple th,
    #datatablesSimple td {
        padding: 10px 15px;
        text-align: left;
        vertical-align: middle;
        border-bottom: 1px solid #ddd;
    }

    /* Đặt kích thước cụ thể cho từng cột */
    #datatablesSimple th:nth-child(1),
    #datatablesSimple td:nth-child(1) { /* STT */
        width: 5%;
        text-align: center;
    }

    #datatablesSimple th:nth-child(2),
    #datatablesSimple td:nth-child(2) { /* Mã Đơn Hàng */
        width: 10%;
    }

    #datatablesSimple th:nth-child(3),
    #datatablesSimple td:nth-child(3) { /* Tên Khách Hàng */
        width: 20%;
    }

    #datatablesSimple th:nth-child(4),
    #datatablesSimple td:nth-child(4) { /* Địa Chỉ Giao Hàng */
        width: 25%;
    }

    #datatablesSimple th:nth-child(5),
    #datatablesSimple td:nth-child(5) { /* Tổng Giá Trị */
        width: 15%;
        text-align: right;
    }

    #datatablesSimple th:nth-child(6),
    #datatablesSimple td:nth-child(6) { /* Trạng Thái */
        width: 15%;
        text-align: center;
    }

    #datatablesSimple th:nth-child(7),
    #datatablesSimple td:nth-child(7) { /* Hành Động */
        width: 10%;
        text-align: center;
    }

    /* Tinh chỉnh nút "Giao Thành Công" */
    .btn-sm {
        padding: 5px 10px;
        font-size: 12px;
        line-height: 1.5;
    }

    /* Cải thiện màu sắc trạng thái */
    #datatablesSimple td span {
        font-weight: 500;
    }

    /* Hover effect cho hàng */
    #datatablesSimple tbody tr:hover {
        background-color: #f5f5f5;
    }

    /* Đảm bảo bộ lọc trạng thái không bị lệch */
    .container.mb-4 .row {
        display: flex;
        align-items: center;
    }

    .form-select {
        width: 100%;
        max-width: 200px;
    }
</style>
<jsp:include page="header.jsp"></jsp:include>
    <main>
        <div class="container-fluid px-4">
            <h1 class="mt-4">Danh Sách Đơn Hàng Chờ Nhận</h1>
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
        <div class="card mb-4">
            <div class="card-body">
                <table id="datatablesSimple">
                    <div class="container mb-4">
                        <div class="row">
                            <form action="${contextPath}/ShipperOrderPro" method="GET" class="row g-3">
                                <div class="col-md-3">
                                    <label for="statusFilter" class="form-label">Trạng thái</label>
                                    <select name="status" id="statusFilter" class="form-select" onchange="this.form.submit()">
                                        <option value="" ${empty param.status ? 'selected' : ''}>Tất cả</option>
                                        <option value="Delivered" ${param.status eq 'Delivered' ? 'selected' : ''}>Giao hàng thành công</option>
                                        <option value="Shipping" ${param.status eq 'Shipping' ? 'selected' : ''}>Đang giao hàng</option>
                                    </select>
                                </div>
                            </form>
                        </div>
                    </div>
                    <thead>
                        <tr>
                            <th>STT</th>
                            <th>Mã Đơn Hàng</th>
                            <th>Địa Chỉ Giao Hàng</th>
                            <th>Ghi chú</th>
                            <th>Tổng Giá Trị</th>
                            <th>Trạng Thái</th>
                            <th>Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${orders}" var="order" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td><a href="/Project-SWP391-G2-SP25/ShipperOrderDetail?id=${order.orderID}">Order#${order.orderID}</a></td>
                                <td>${order.deliveryAddress}</td>
                                <td>${order.billOfLading}</td>
                                <td><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫" /></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${order.status eq 'Processed'}"><span style="color: blue">Chờ nhận đơn</span></c:when>
                                        <c:when test="${order.status eq 'Delivered'}"><span style="color: green">Giao thành công</span></c:when>
                                        <c:otherwise><span style="color: red">Đã hủy</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:if test="${order.status ne 'Delivered' && order.status ne 'Cancelled'}">
                                        <form action="${contextPath}/ShipperOrderPro" method="POST" style="display:inline"
                                              onsubmit="return confirm('Xác nhận giao hàng thành công?');">
                                            <input type="hidden" name="action" value="updateStatus">
                                            <input type="hidden" name="orderID" value="${order.orderID}">
                                            <button type="submit" class="btn btn-success btn-sm">Nhận đơn hàng</button>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</main>
<jsp:include page="footer.jsp"></jsp:include>
