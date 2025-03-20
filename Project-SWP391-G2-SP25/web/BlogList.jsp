
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <link rel="stylesheet" href="assets/css/TaiKhoan/TinTuc.css" />
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
        <link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css" />
        <link rel="stylesheet" href="assets/fonts/fontawesome-free-6.0.0-web/css/all.css" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swapsubset=vietnamese" />
    </head>
    <style>
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
        <main class="main">
            <div class="main__gird gird"> <!-- Cái khung của trang web -->
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

                    <!-- Main Left New products : Sản phẩm mới -->
                    <!-- Một số sản phẩm mới của cửa hàng - Hiển thị dưới Sản phẩm khuyến mãi -->
                    <h2 class="main__left-title main__left-margin-top">SẢN PHẨM MỚI</h2>
                    <ul class="main__left-product-list">
                        <c:forEach var="product" items="${newProducts}" varStatus="status">
                            <c:if test="${status.index < 5}">
                                <li class="main__left-product-items main__left-product-items--vertical">
                                    <a href="/Project-SWP391-G2-SP25/ProductDetailControllerCustomer?id=${product.productID}" class="main__left-product-link">
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
                                <img src="${post.thumbnail}" alt="${post.title}" class="main__left-posts-img" />
                                <a href="PostDetailsController?postId=${post.blogID}" class="main__left-posts-link">
                                    <span class="main__left-posts-title">${post.title}</span>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>

                </div>

                <!-- Main Right -->
                <!-- Đây là phần thân bên phải của trang web -->
                <div class="main__right">


                    <c:forEach var="blog" items="${blogs}">
                        <div class="mainTT__right-items">
                            <div class="mainTT__right-img">
                                <img src="${blog.thumbnail}" alt="Hình ảnh ...." />
                                <div class="mainTT__right-date">
                                    <fmt:formatDate value="${blog.createDate}" pattern="dd"/> <br />
                                    th<fmt:formatDate value="${blog.createDate}" pattern="MM"/>
                                </div>
                            </div>
                            <div class="mainTT__right-title">
                                <h3 class="mainTT__right-heading">${blog.title}</h3>
                                <p class="mainTT_right-content">${blog.briefInfor} ...</p>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </c:forEach>

                    <!-- Pagination -->
                    <div class="pagination">
                        <c:if test="${currentPage > 1}">
                            <a href="blogs?page=${currentPage - 1}&limit=${limit}" class="pagination-link">Previous</a>
                        </c:if>

                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <a href="blogs?page=${i}&limit=${limit}" class="pagination-link ${i == currentPage ? 'active-page' : ''}">${i}</a>
                        </c:forEach>

                        <c:if test="${currentPage < totalPages}">
                            <a href="blogs?page=${currentPage + 1}&limit=${limit}" class="pagination-link">Next</a>
                        </c:if>
                    </div>




                </div>
                <div class="clear"></div>

            </div>
        </main>
        <%@ include file="./Public/footer.jsp" %>
    </body>
</html>
