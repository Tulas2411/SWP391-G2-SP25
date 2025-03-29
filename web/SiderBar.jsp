<%-- 
    Document   : SiderBar
    Created on : Mar 3, 2025, 3:43:29 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sidebar</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body>
        <div class="main__left">
                    <!-- Danh mục sản phẩm - Gom các sản phẩm thành các danh mục nhỏ - Hiển thị trên cùng bên trái main trang web -->
                    <h2 class="main__left-title">DANH MỤC SẢN PHẨM</h2>
                    <ul class="main__left-category-list">
                        <c:forEach var="categoryID" items="${['TBQ', 'TBCS', 'CTD', 'TBTM', 'TBSCBT']}">
                            <c:forEach var="category" items="${categories}">
                                <c:if test="${category.categoryID == categoryID}">
                                    <li class="main__left-category-items">
                                        <a href="Category.jsp?id=${category.categoryID}" class="main__left-category-link">
                                            ${category.categoryName}
                                        </a>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </c:forEach>
                    </ul>

                    <!-- Main Left Promotional Products : Sản phẩm khuyến mãi -->
                    <!-- Một số sản phẩm khuyến mãi - Hiển thị dưới Danh mục sản phẩm -->
                    <h2 class="main__left-title main__left-margin-top">SẢN PHẨM KHUYẾN MÃI</h2>
                    <ul class="main__left-product-list">
                        <c:forEach var="product" items="${promotedProducts}" varStatus="status">
                            <c:if test="${status.index < 5}">  <%-- Chỉ hiển thị 5 sản phẩm đầu tiên --%>
                                <li class="main__left-product-items main__left-product-items--vertical">
                                    <a href="/Project-SWP391-G2-SP25/ProductDetailController?id=${product.productID}" class="main__left-product-link">
                                        <img src="${product.imageLink}" alt="${product.productName}" class="main__left-product-img" />
                                        <span class="main__left-product-title">${product.productName}</span>
                                    </a>
                                    <br />
                                    <span class="main__left-product"><del>
                                            <fmt:formatNumber value="${product.oldprice}" type="number" groupingUsed="true"/>đ
                                        </del></span>
                                    <span class="main__right-sensor-price">
                                        <strong><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>đ</strong>
                                    </span>
                                </li>
                            </c:if>
                        </c:forEach>
                    </ul>

                    <!-- Main Left New products : Sản phẩm mới -->
                    <!-- Một số sản phẩm mới của cửa hàng - Hiển thị dưới Sản phẩm khuyến mãi -->
                    <h2 class="main__left-title main__left-margin-top">SẢN PHẨM MỚI</h2>
                    <ul class="main__left-product-list">
                        <c:forEach var="product" items="${newProducts}" varStatus="status">
                            <c:if test="${status.index < 5}">
                                <li class="main__left-product-items main__left-product-items--vertical">
                                    <a href="/Project-SWP391-G2-SP25/ProductDetailController?id=${product.productID}" class="main__left-product-link">
                                        <img src="${product.imageLink}" alt="${product.productName}" class="main__left-product-img" />
                                        <span class="main__left-product-title">${product.productName}</span>
                                    </a>
                                    <br />
                                    <span class="main__right-sensor-price">
                                        <strong><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>đ</strong>
                                    </span>
                                </li>
                            </c:if>
                        </c:forEach>
                    </ul>

                    <!-- Main Left Post -->
                    <!-- Các bài báo mới - Hiển thị dưới Sản phẩm mới -->
                    <h2 class="main__left-title main__left-margin-top">BÀI VIẾT MỚI</h2>
                    <ul class="main__left-posts-list">
                        <c:forEach var="post" items="${latestPosts}">
                            <li class="main__left-posts-items main__left-posts-items--vertical">
                                <img src="${post.imageLink}" alt="${post.title}" class="main__left-posts-img" />
                                <a href="PostDetailsController?postId=${post.postID}" class="main__left-posts-link">
                                    <span class="main__left-posts-title">${post.title}</span>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>

                </div>

    </body>
</html>