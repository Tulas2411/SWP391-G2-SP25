<%-- 
    Document   : header
    Created on : Jan 18, 2025, 12:55:54 AM
    Author     : Tung Duong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="DAO.*"%>
<%@page import="Model.*"%>
<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>

    <header class="header">
        <!-- Header introduce -->
        <!-- Thông tin sđt và email -->
        <div class="header__introduce  gird">
            <div class="header__introduce-info">
                <ul class="header__introduce-info-list">
                    <li class="header__introduce-info-items header__introduce-info-items--vertical">
                        <strong>Hotline: 0969.995.633</strong>
                    </li>
                    <li class="header__introduce-info-items">
                        <strong>Email: shop4electric@gmail.com</strong>
                    </li>
                </ul>
            </div>

            <!-- Tạo tài khoản, chính sách bảo mât và đăng nhập -->
            <div class="header__introduce-account">
                <ul class="header__introduce-account-list">
                    <li class="header__introduce-account-items">
                        <a href="/Project-SWP391-G2-SP25/TestNoLogin" class="header__introduce-account-link"> Test</a>
                    </li>
                    <li class="header__introduce-account-items">
                        <a href="UserProfile.jsp" class="header__introduce-account-link"> Tài khoản</a>
                    </li>
                    <li class="header__introduce-account-items header__introduce-account-items--vertical">
                        <a href="BaoMat.jsp"  class="header__introduce-account-link"> Chính sách bảo mật</a>
                    </li>
                    <li class="header__introduce-account-items">
                        <a href="Login.jsp"  class="header__introduce-account-link"></a>
                        <%
                    // Lấy thông tin username từ session
                    String username = (String) session.getAttribute("username");
                    Users user = (Users) session.getAttribute("user");
                    if (username != null) {
                        // Nếu người dùng đã đăng nhập, hiển thị Hello, [Username] và nút Đăng xuất
                        out.println("Hello, " + username + "!");
                        out.println("<a href='LogoutController' class='header__introduce-account-link'>Đăng xuất</a>"); // Nút đăng xuất
                    } else {
                        // Nếu chưa đăng nhập, hiển thị Đăng Nhập
                        out.println("<a href='Login.jsp' class='header__introduce-account-link'>Đăng nhập</a>");
                    }
                        %>
                    </li>

                </ul>
            </div>



        </div>
        <!-- Header Shop -->
        <div class="header__shop">
            <div class="gird">
                <!-- MENU Tablet và Mobile - Start -->
                <!-- Các Icon -->
                <!-- Các icon sẽ hiển thị trên header trong table và mobile -->
                <div class="table-icon">
                    <div>
                        <!-- Đây là icon khi người dùng click vào sẽ hiện ra menu -->
                        <i id="header__mobile-menu" class="fa fa-bars table-icon header__mobile-menu"></i>
                    </div>
                    <!-- Đây là icon tìm kiếm và giỏ hàng -->
                    <i class="fa-solid fa-magnifying-glass header__mobile-search table-icon"></i>
                    <i class="fa-solid fa-cart-shopping header__mobile-cart table-icon"></i>
                </div>

                <!-- Menu chính -->
                <!-- Đây là menu trên tablet và mobile -->
                <nav class="header__table" id="header__table">
                    <div class="header__table-menu" id="header__table-menu">
                    </div>
                    <ul class="header__table-list">
                        <li class="header__table-items header__table-items-underlined">
                            <a href="${pageContext.request.contextPath}/home" class="header__table-link">
                                TRANG CHỦ
                            </a>
                        </li>
                        <li class="header__table-items header__table-items-underlined">
                            <a href="GioiThieu.jsp" class="header__table-link">
                                GIỚI THIỆU
                            </a>
                        </li>
                        <li class="header__table-items header__table-items-underlined">
                            <a id="SP" href="#" class="header__table-link">
                                SẢN PHẨM
                            </a>
                            <i id="header__table-items2-icon" class="fa-solid fa-angle-down header__table-items2-icon"></i>
                            <!-- Đây là menu cấp 2 trong tablet và mobile -->
                            <ul id="header__table-list2" class="header__table-list2">

                                <c:forEach var="cate" items="${categories}">
                                    <li class="header__table-items2">
                                        <a href="/Project-SWP391-G2-SP25/productsList?category=${cate.categoryID}" class="header__table-link2">${cate.categoryName}</a>
                                    </li>
                                </c:forEach>


                            </ul>
                        </li>
                        <li class="header__table-items header__table-items-underlined">
                            <a href="/blogs" class="header__table-link">
                                TIN TỨC
                            </a>
                        </li>
                        <li class="header__table-items header__table-items-underlined">
                            <a href="LienHe.jsp" class="header__table-link">
                                LIÊN HỆ
                            </a>
                        </li>
                        <li class="header__table-items">
                            <a href="#" class="header__table-link">
                                ĐĂNG NHẬP
                            </a>
                        </li>
                    </ul>
                </nav>
                <!-- <div id="header__mobile">
                </div> -->
                <!-- MENU Tablet và Mobile - End -->

                <!-- Logo của website - Hiển thị bên trái header -->
                <div class="header__shop-logo">
                    <a href="${pageContext.request.contextPath}/home"> 
                        <img src="assets/img/S4EWhite.png" class="header__shop-logo-img" alt="Logo linh kiện điện tử" />
                    </a>
                </div>
                <!-- Các icon và thông tin sẽ hiển thị bên phải của header -->
                <div class="header__cart">
                    <ul class="header__cart-list">
                        <c:if test="${not empty sessionScope.user}">
                            <li class="header__cart-items">
                                <a href="/Project-SWP391-G2-SP25/my-order" class="header__cart-link">
                                    <div class="icon">
                                        <i class="icon-i fa-solid fa-list"></i>
                                    </div>
                                    Đơn hàng
                                </a>
                            </li>
                        </c:if>

                        <li class="header__cart-items">
                            <a href="/Project-SWP391-G2-SP25/Cart" class="header__cart-link">
                                <div class="icon">
                                    <i class="icon-i fa-solid fa-cart-shopping"></i>
                                </div>
                                Giỏ hàng
                            </a>
                        </li>
                        <li class="header__cart-items">
                            <a href="#" class="header__cart-link">
                                <div class="icon">
                                    <i class="icon-i fa-solid fa-phone"></i>
                                </div>
                                <p style="display: inline-block; line-height: 16px; vertical-align: middle;">
                                    <span>0969.995.633</span> <br />
                                    <span style="font-size: 1.2rem; color: #d3d0d0;">Hotline mua hàng</span>
                                </p>
                            </a>
                        </li>
                        <li class="header__cart-items">
                            <a href="#" class="header__cart-link">
                                <div class="icon">
                                    <i class="icon-i fa-solid fa-location-dot"></i>
                                </div>
                                <p style="display: inline-block; line-height: 16px; vertical-align: middle;">
                                    <span">Thời gian làm việc</span> <br />
                                    <span style="font-size: 1.2rem; color: #d3d0d0;">Mở cửa: 8:00 - 22:00</span>
                                </p>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <nav class="header__nav gird">
            <!-- Header Navbar -->
            <!-- Đây là menu sẽ hiện thị trên PC -->
            <div class="header__navbar">
                <ul class="header__navbar-list">
                    <li class="header__navbar-items header__navbar-items-vertical">
                        <a style="color: #666;" href="${pageContext.request.contextPath}/home" class="header__navbar-link">
                            Trang chủ
                        </a>
                    </li>
                    <li class="header__navbar-items header__navbar-items-vertical">
                        <a href="GioiThieu.jsp" class="header__navbar-link">
                            Giới thiệu
                        </a>
                    </li>
                    <li class="header__navbar-items header__navbar-items-vertical header__navbar-has-child">
                        <a href="productsList" class="header__navbar-link">
                            Sản phẩm
                            <div class=" icon-none">
                                <i class="fa-solid fa-angle-down"></i>
                            </div>
                        </a>
                        <!-- Header Navbar Navbar -->
                        <div class="header__navbar-nav">
                            <ul class="header__navbar-nav-list">
                                <c:forEach var="cate" items="${categories}">
                                    <li class="header__navbar-nav-items">
                                        <a href="/Project-SWP391-G2-SP25/productsList?category=${cate.categoryID}" class="header__navbar-nav-link">${cate.categoryName}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </li>
                    <li class="header__navbar-items header__navbar-items-vertical">
                        <a href="blogs" class="header__navbar-link">
                            Tin tức
                        </a>
                    </li>
                    <li class="header__navbar-items">
                        <a href="LienHe.jsp" class="header__navbar-link">
                            Liên hệ
                        </a>
                    </li>
                </ul>
            </div>
            <!-- Header Search -->
            <!-- Phần tìm kiếm bên phải menu -->
            <div class="header__search">
                <div class="search-container">
                    <input type="text" class="header__search-input" id="searchInput" placeholder="Bạn cần tìm gì?" />
                    <button class="header__search-shop" type="button" id="searchButton">
                        <i class="header__search-shop-icon fa-solid fa-magnifying-glass"></i>
                    </button>
                    <!-- Thêm div cho kết quả gợi ý -->
                    <div id="searchResults" class="search-results"></div>
                </div>
            </div>
        </nav>

    </header>
    <style>
        .search-container {
            position: relative;
        }
        .search-results {
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            background: white;
            border: 1px solid #ddd;
            max-height: 200px;
            overflow-y: auto;
            display: none;
            z-index: 1000;
        }
        .search-results a {
            display: block;
            padding: 8px 12px;
            text-decoration: none;
            color: #333;
        }
        .search-results a:hover {
            background: #f5f5f5;
        }
    </style>                       
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $(document).ready(function () {
            let timeout = null;

            $('#searchInput').on('input', function () {
                clearTimeout(timeout);
                let searchTerm = $(this).val().trim();

                if (searchTerm.length >= 2) { // Tìm kiếm khi có ít nhất 2 ký tự
                    timeout = setTimeout(function () {
                        searchProducts(searchTerm);
                    }, 300); // Delay 300ms để tránh gửi request liên tục
                } else {
                    $('#searchResults').hide().empty();
                }
            });

            // Xử lý khi click nút tìm kiếm
            $('#searchButton').click(function () {
                let searchTerm = $('#searchInput').val().trim();
                if (searchTerm.length > 0) {
                    window.location.href = '/Project-SWP391-G2-SP25/productsList?name=' + encodeURIComponent(searchTerm);
                }
            });

            // Xử lý khi nhấn Enter
            $('#searchInput').keypress(function (e) {
                if (e.which == 13) { // Enter key
                    let searchTerm = $(this).val().trim();
                    if (searchTerm.length > 0) {
                        window.location.href = '/Project-SWP391-G2-SP25/productsList?name=' + encodeURIComponent(searchTerm);
                    }
                }
            });

            // Ẩn kết quả khi click ra ngoài
            $(document).click(function (e) {
                if (!$(e.target).closest('.search-container').length) {
                    $('#searchResults').hide();
                }
            });
        });

        function searchProducts(query) {
            $.ajax({
                url: '/Project-SWP391-G2-SP25/SearchBar', // Đường dẫn đến servlet xử lý tìm kiếm
                type: 'GET',
                data: {search: query},
                dataType: 'json',
                success: function (response) {
                    displayResults(response);
                },
                error: function (xhr, status, error) {
                    console.log('Error: ' + error);
                    $('#searchResults').hide().empty();
                }
            });
        }

        function displayResults(products) {
            let $results = $('#searchResults');
            $results.empty();

            if (products && products.length > 0) {
                $.each(products, function (index, product) {
                    $results.append(
                            '<a href="/Project-SWP391-G2-SP25/productsList?name=' + product.productName + '">' +
                            product.productName + '</a>'
                            );
                });
                $results.show();
            } else {
                $results.hide();
            }
        }
    </script>
</html>