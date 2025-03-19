<%-- 
    Document   : ShipperDashBoard
    Created on : Mar 19, 2025, 4:56:27 PM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>${title}</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="${contextPath}/admin/css/styles.css" rel="stylesheet" /> 
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
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
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <a class="navbar-brand ps-3" href="ShipperDashBoard">Shipper</a>
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <div class="input-group">
                    <input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
                    <button class="btn btn-primary" id="btnNavbarSearch" type="button"><i class="fas fa-search"></i></button>
                </div>
            </form>
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#!">Settings</a></li>
                        <li><a class="dropdown-item" href="#!">Activity Log</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="${contextPath}/LogoutController">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <a class="nav-link" href="${contextPath}/ShipperDashBoard">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                Danh Sách Đơn Hàng
                            </a>
                        </div>
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Danh Sách Đơn Hàng</h1>
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
                                            <form action="${contextPath}/ShipperDashBoard" method="GET" class="row g-3">
                                                <div class="col-md-3">
                                                    <label for="statusFilter" class="form-label">Trạng thái</label>
                                                    <select name="status" id="statusFilter" class="form-select" onchange="this.form.submit()">
                                                        <option value="" ${empty param.status ? 'selected' : ''}>Tất cả</option>
                                                        <option value="Pending" ${param.status eq 'Pending' ? 'selected' : ''}>Đang xử lý</option>
                                                        <option value="Shipped" ${param.status eq 'Shipped' ? 'selected' : ''}>Đã giao</option>
                                                        <option value="Delivered" ${param.status eq 'Delivered' ? 'selected' : ''}>Giao thành công</option>
                                                        <option value="Cancelled" ${param.status eq 'Cancelled' ? 'selected' : ''}>Đã hủy</option>
                                                    </select>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                    <thead>
                                        <tr>
                                            <th>STT</th>
                                            <th>Mã Đơn Hàng</th>
                                            <th>Tên Khách Hàng</th>
                                            <th>Địa Chỉ Giao Hàng</th>
                                            <th>Tổng Giá Trị</th>
                                            <th>Trạng Thái</th>
                                            <th>Hành Động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${orders}" var="order" varStatus="status">
                                            <tr>
                                                <td>${status.index + 1}</td>
                                                <td>Order#${order.orderID}</td>
                                                <td>${order.customerFirstName}</td>
                                                <td>${order.deliveryAddress}</td>
                                                <td><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫" /></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${order.status eq 'Pending'}"><span style="color: orange">Đang xử lý</span></c:when>
                                                        <c:when test="${order.status eq 'Shipped'}"><span style="color: blue">Đã giao</span></c:when>
                                                        <c:when test="${order.status eq 'Delivered'}"><span style="color: green">Giao thành công</span></c:when>
                                                        <c:otherwise><span style="color: red">Đã hủy</span></c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:if test="${order.status ne 'Delivered' && order.status ne 'Cancelled'}">
                                                        <form action="${contextPath}/ShipperDashBoard" method="POST" style="display:inline"
                                                              onsubmit="return confirm('Xác nhận giao hàng thành công?');">
                                                            <input type="hidden" name="action" value="updateStatus">
                                                            <input type="hidden" name="orderID" value="${order.orderID}">
                                                            <button type="submit" class="btn btn-success btn-sm">Giao Thành Công</button>
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
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright © Shop For Electric</div>
                            <div>
                                <a href="#">Privacy Policy</a>
                                ·
                                <a href="#">Terms & Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="./js/scripts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="./js/datatables-simple-demo.js"></script>
    </body>
</html>