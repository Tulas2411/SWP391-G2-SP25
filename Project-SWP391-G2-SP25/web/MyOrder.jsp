<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Orders List</title>
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="shortcut icon" href="assets/img/S4EWhite.PNG" type="image/x-icon" />
        <link rel="stylesheet" href="assets/css/reset.css" />
        <link rel="stylesheet" href="assets/css/base.css" />
        <link rel="stylesheet" href="assets/css/main_PC.css" />
        <link rel="stylesheet" href="assets/css/main_Tablet.css" />
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
        <link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css" />
        <link rel="stylesheet" href="assets/fonts/fontawesome-free-6.0.0-web/css/all.css" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swapsubset=vietnamese" />
        <style>

        </style>
    </head>
    <style>
        /* Container chính */
        .orders-container {
            width: 90%;
            margin: 30px auto;
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        /* Tiêu đề */
        .orders-title {
            text-align: center;
            color: #D50000; /* Màu đỏ */
            font-size: 28px;
            font-weight: bold;
            text-transform: uppercase;
            margin-bottom: 20px;
        }

        /* Bảng đơn hàng */
        .orders-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 18px;
        }

        .orders-table th, .orders-table td {
            padding: 14px;
            text-align: center;
            border: 1px solid #ddd;
        }

        /* Tiêu đề bảng */
        .orders-table th {
            background-color: #D50000; /* Đỏ */
            color: white;
            font-weight: bold;
        }

        /* Các hàng chẵn */
        .orders-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        /* Hover vào hàng */
        .orders-table tr:hover {
            background-color: #FFE0E0; /* Đỏ nhạt */
            transition: 0.3s;
        }

        /* Link "View" */
        .orders-view-link {
            color: #D50000;
            font-size: 16px;
            font-weight: bold;
            text-decoration: none;
            padding: 6px 14px;
            border: 2px solid #D50000;
            border-radius: 6px;
            display: inline-block;
        }

        .orders-view-link:hover {
            background-color: #D50000;
            color: white;
            transition: 0.3s;
        }

        /* Phân trang */
        .pagination {
            text-align: center;
            margin-top: 20px;
        }

        .pagination-link {
            display: inline-block;
            padding: 10px 16px;
            margin: 5px;
            text-decoration: none;
            color: #D50000;
            font-weight: bold;
            border: 2px solid #D50000;
            border-radius: 6px;
        }

        .pagination-link:hover {
            background-color: #D50000;
            color: white;
            transition: 0.3s;
        }

        /* Trang hiện tại */
        .active-page {
            background-color: #D50000;
            color: white;
        }

    </style>
    <body>
        <%@ include file="./Public/header.jsp" %>
        
        <form action="feed-back" method="POST">
            <button type="submit">Send Feedback</button>
        </form>

        <main class="orders-container">
            <h2 class="orders-title">My Orders</h2>

            <!-- Orders Table -->
            <table class="orders-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Ordered Date</th>
                        <th>Delivery Address</th>
                        <th>Total Cost</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${ordersList}">
                        <tr>
                            <td>${order.orderID}</td>
                            <td>${order.orderDate}</td>
                            <td>${order.deliveryAddress}</td>
                            <td>${order.totalAmount}</td>
                            <td>${order.status}</td>
                            <td>
                                <a href="my-order-detail?orderId=${order.orderID}" class="orders-view-link">View</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Pagination -->
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="my-order?page=${currentPage - 1}&limit=${limit}" class="pagination-link">Previous</a>
                </c:if>

                <c:forEach var="i" begin="1" end="${totalPages}">
                    <a href="my-order?page=${i}&limit=${limit}" class="pagination-link ${i == currentPage ? 'active-page' : ''}">${i}</a>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <a href="my-order?page=${currentPage + 1}&limit=${limit}" class="pagination-link">Next</a>
                </c:if>
            </div>
        </main>

        <%@ include file="./Public/footer.jsp" %>
    </body>
</html>