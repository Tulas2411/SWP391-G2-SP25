<%-- 
    Document   : HomePage
    Created on : Jan 18, 2025, 12:47:06 AM
    Author     : Tung Duong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.Category, Model.Products, Model.MarketingPosts"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Cửa hàng đồ diện - S4E</title>
        <link rel="shortcut icon" href="assets/img/S4EWhite.PNG" type="image/x-icon" />
        <link rel="stylesheet" href="assets/css/reset.css" />
        <link rel="stylesheet" href="assets/css/base.css" />
        <link rel="stylesheet" href="assets/css/main_PC.css" />
        <link rel="stylesheet" href="assets/css/main_Tablet.css" />
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
        <link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css" />
        <link rel="stylesheet" href="assets/fonts/fontawesome-free-6.0.0-web/css/all.css" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swapsubset=vietnamese" />

    </head>
    <body>
        <%@ include file="./Public/header.jsp" %>

        <!-- MAIN -->
        <main class="main">
            <div class="main__gird gird"> <!-- Cái khung của trang web -->
                <div class="main__left">
                    <!-- Danh mục sản phẩm - Gom các sản phẩm thành các danh mục nhỏ - Hiển thị trên cùng bên trái main trang web -->
                    <form method="GET" action="productsList">
                        <h2 class="main__left-title" style="margin-top: 50px">Tìm kiếm</h2>
                        <input type="text" class="main__left-search-box" name="name" placeholder="Bạn cần tìm gì?" />
                        <h6>Danh mục</h6>
                        <ul>
                            <c:forEach var="category" items="${categories}">
                                <li>
                                    <input type="checkbox" name="category" value="${category.categoryID}"/>
                                    ${category.categoryName}
                                </li>
                            </c:forEach>
                        </ul>
                        <h6>Sắp xếp theo</h6>
                        <select name="orderBy">
                            <c:forEach items="${orderByList}" var="order">
                                <option value="${order.value}">${order.label}</option>
                            </c:forEach>
                        </select>

                        <button>Tìm kiếm</button>

                        <!--<ul class="main__left-category-list">
                        <c:forEach var="category" items="${categories}">
                            <li class="main__left-category-items">
                                <a href="Category.jsp?id=${category.categoryID}" class="main__left-category-link">
                            ${category.categoryName}
                        </a>
                    </li>
                        </c:forEach>
                    </ul>-->
                        <input type="hidden" name="index" value="${index}"/>
                    </form>
                </div>

                <!-- Main Right -->
                <!-- Đây là phần thân bên phải của trang web -->
                <div class="main__right">
                    <!-- Danh mục các sản phẩm -->
                    <div class="main__right-sensor">
                        <h3 class="main__right-heading">
                            <span class="main__right-heading-title">Sản phẩm</span>
                            <!--                            <a href="Category.jsp?id=TBQ" class="main__right-heading-link">
                                                            Xem thêm
                                                            <i class="main__right-heading-icon fa-solid fa-angle-right"></i>
                                                        </a>-->
                        </h3>

                        <div class="main__right-sensor-list">
                            <c:forEach var="product" items="${products}">
                                <div class="main__right-sensor-items">
                                    <a href="product-detail?id=${product.productID}" class="main__right-sensor-link">
                                        <img src="${product.imageLink}" height="200px" alt="${product.productName}" class="main__right-sensor-img" />
                                        <div class="main__right-sensor-title">${product.productName}</div>
                                    </a>
                                    <!-- Hiển thị giá sản phẩm -->
                                    <span class="main__right-sensor-price">
                                        <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="đ"/>
                                    </span>
                                    <!--<button type="button" class="main__right-sensor-button"/>Mua ngay</button>-->
                                </div>
                            </c:forEach>

                        </div>
                        <div class="pagination" style="font-size: 2em">
                            <a href="productsList?index=${index-1}">&laquo;</a>
                            <c:choose>
                                <c:when test="${index <= 4}">
                                    <c:choose>
                                        <c:when test="${total <= 5}">
                                            <c:forEach begin="1" end="${total}" step="1" var="i">
                                                <a href="productsList?index=${i}" <c:if test="${i == index}"> class="active" </c:if> >
                                                    ${i}
                                                </a>
                                            </c:forEach>
                                        </c:when>
                                        <c:when test="${total > 5}">
                                            <c:forEach begin="1" end="${5}" step="1" var="i">
                                                <a href="productsList?index=${i}" <c:if test="${i == index}"> class="active" </c:if> >
                                                    ${i}
                                                </a>
                                            </c:forEach>
                                            <a>...</a>
                                            <a href="productsList?index=${total}">${total}</a>
                                        </c:when>
                                    </c:choose>
                                </c:when>
                                <c:when test="${total > 5 and index > 4 and index < (total-3)}">
                                    <a href="productsList?index=${1}">${1}</a>
                                    <a>...</a>
                                    <c:forEach begin="${index-2}" end="${index+2}" step="1" var="i">
                                        <a href="productsList?index=${i}" <c:if test="${i == index}"> class="active" </c:if> >
                                            ${i}
                                        </a>
                                    </c:forEach>
                                    <a>...</a>
                                    <a href="productsList?index=${total}">${total}</a>
                                </c:when>
                                <c:when test="${total > 5 and index >= (total-3)}">
                                    <a href="productsList?index=${1}">${1}</a>
                                    <a>...</a>
                                    <c:forEach begin="${total - 4}" end="${total}" step="1" var="i">
                                        <a href="productsList?index=${i}" <c:if test="${i == index}"> class="active" </c:if> >
                                            ${i}
                                        </a>
                                    </c:forEach>
                                </c:when>
                            </c:choose>
                            <a href="productsList?index=${index+1}">&raquo;</a>
                        </div>
                    </div>
                </div>
                <div class="clear"></div>

                <!-- Thông tin vận chuyển, giao hàng, thanh toán và chăm sóc khách hàng của cửa hàng -->
                <div class="main__installation clear">
                    <div class="main__installation-box">
                        <img src="assets/img/KT-1.png" alt="Hình ảnh minh họa cho chức năng" />
                        <br />
                        <strong class="main__installation-strong">Lắp đặt chuyên nghiệp</strong>
                        <br />
                        <span class="main__installation-title">Đội ngũ lắp đặt giàu kinh nghiệm</span>
                    </div>
                    <div class="main__installation-box">
                        <img src="assets/img/KT-2.png" alt="Hình ảnh minh họa cho chức năng" />
                        <br />
                        <strong class="main__installation-strong">Giao nhận tiện lợi</strong>
                        <br />
                        <span class="main__installation-title">Giao nhận trong ngày nhanh</span>
                    </div>
                    <div class="main__installation-box">
                        <img src="assets/img/KT-3.png" alt="Hình ảnh minh họa cho chức năng" />
                        <br />
                        <strong class="main__installation-strong">Thanh toán linh hoạt</strong>
                        <br />
                        <span class="main__installation-title">Phương thức thanh toán đa dạng</span>
                    </div>
                    <div class="main__installation-box">
                        <img src="assets/img/KT-4.png" alt="Hình ảnh minh họa cho chức năng" />
                        <br />
                        <strong class="main__installation-strong">Hậu mãi chu đáo</strong>
                        <br />
                        <span class="main__installation-title">Chăm sóc khách hàng tận tình</span>
                    </div>
                    <div class="clear"></div>
                </div>
            </div>
        </main>

        <%@ include file="./Public/footer.jsp" %>

        <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
        <script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
        <script src="assets/Javascript/main.js"></script>
    </body>
</html>
