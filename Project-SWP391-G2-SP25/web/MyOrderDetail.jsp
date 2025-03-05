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
        .order-container {
            max-width: 900px;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 2px 10px rgba(0,0,0,0.1);
        }

        /* Header */
        .order-header {
            background: #d32f2f;
            color: white;
            padding: 15px;
            text-align: center;
            font-size: 22px;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        /* Phần chung cho từng section */
        .order-section {
            background: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-bottom: 15px;
        }

        .section-title {
            color: #d32f2f;
            margin-bottom: 10px;
            font-size: 18px;
            border-bottom: 2px solid #d32f2f;
            padding-bottom: 5px;
        }

        /* Thông tin đơn hàng & người nhận */
        .order-info {
            display: flex;
            flex-wrap: wrap;
        }

        .info-item {
            flex: 1 1 50%;
            margin-bottom: 8px;
            font-size: 16px;
        }

        /* Danh sách sản phẩm */
        .product-card {
            display: flex;
            align-items: center;
            background: #fff;
            padding: 10px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-bottom: 10px;
        }

        .product-img {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 5px;
            margin-right: 15px;
        }

        .product-details {
            flex-grow: 1;
        }

        .product-title {
            margin: 0;
            font-size: 16px;
            color: #333;
        }

        .product-category, .product-price, .product-quantity, .product-total {
            margin: 3px 0;
            font-size: 14px;
            color: #777;
        }

        /* Nút hành động */
        .product-actions {
            display: flex;
            gap: 10px;
        }

        .btn {
            padding: 7px 12px;
            text-decoration: none;
            color: white;
            border-radius: 5px;
            font-size: 14px;
            text-align: center;
        }

        .btn-buy-again {
            background: #2e7d32;
        }
        .btn-feedback {
            background: #0288d1;
        }
    </style>
    <body>
        <%@ include file="./Public/header.jsp" %>

        <div class="order-container">
            <h2 class="order-header">Chi Tiết Đơn Hàng</h2>

            <!-- Thông tin đơn hàng -->
            <div class="order-section">
                <h3 class="section-title">Thông Tin Đơn Hàng</h3>
                <div class="order-info">
                    <div class="info-item"><strong>ID:</strong> ${order.orderID}</div>
                    <div class="info-item"><strong>Ngày đặt:</strong> ${order.orderDate}</div>
                    <div class="info-item"><strong>Tổng chi phí:</strong> <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/></div>
                    <div class="info-item"><strong>Trạng thái:</strong> ${order.status}</div>
                </div>
            </div>

            <!-- Thông tin người nhận -->
            <div class="order-section">
                <h3 class="section-title">Thông Tin Người Nhận</h3>
                <div class="order-info">
                    <div class="info-item"><strong>Họ và Tên:</strong> ${user.firstName} ${user.lastName}</div>
                    <div class="info-item"><strong>Giới Tính:</strong> ${user.gender}</div>
                    <div class="info-item"><strong>Email:</strong> ${user.email}</div>
                    <div class="info-item"><strong>Số Điện Thoại:</strong> ${user.phoneNumber}</div>
                </div>
            </div>

            <!-- Danh sách sản phẩm -->
            <div class="order-section">
                <h3 class="section-title">Sản Phẩm Trong Đơn</h3>
                <c:forEach var="item" items="${list}">
                    <div class="product-card">
                        <img src="${item.products.imageLink}" class="product-img">
                        <div class="product-details">
                            <h4 class="product-title">${item.products.productName}</h4>
                            <p class="product-price">Giá: <fmt:formatNumber value="${item.products.price}" type="currency" currencySymbol="₫"/></p>
                            <p class="product-quantity">Số lượng: ${item.orderDetails.quantity}</p>
                            <p class="product-total"><strong>Tổng: <fmt:formatNumber value="${item.orderDetails.quantity * item.products.price}" type="currency" currencySymbol="₫"/></strong></p>
                        </div>
                        <div class="product-actions">
                            <a href="ProductDetailController?id=${item.products.productID}" class="btn btn-buy-again">Mua Lại</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <%@ include file="./Public/footer.jsp" %>
    </body>
</html>