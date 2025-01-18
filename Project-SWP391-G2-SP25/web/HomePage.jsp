<%-- 
    Document   : HomePage
    Created on : Jan 18, 2025, 12:47:06 AM
    Author     : Tung Duong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                    <ul class="main__left-category-list">
                        <h2 class="main__left-title">DANH MỤC SẢN PHẨM</h2>
                        <li class="main__left-category-items">
                            <a href="#" class="main__left-category-link">
                                Thiết bị quạt
                            </a>
                        </li>
                        <li class="main__left-category-items">
                            <a href="#" class="main__left-category-link">
                                Thiết bị chiếu sáng
                            </a>
                        </li>
                        <li class="main__left-category-items">
                            <a href="#" class="main__left-category-link">
                                Công tắc điện
                            </a>
                        </li>
                        <li class="main__left-category-items">
                            <a href="#" class="main__left-category-link">
                                Thiết bị thông minh
                            </a>
                        </li>
                        <li class="main__left-category-items">
                            <a href="#" class="main__left-category-link">
                                Phụ kiện & linh kiện
                            </a>
                        </li>
                        <li class="main__left-category-items">
                            <a href="#" class="main__left-category-link">
                                Thiết bị sửa chữa và bảo trì
                            </a>
                        </li>
                    </ul>
                    <!-- Main Left Promotional Products : Sản phẩm khuyến mãi -->

                    <!-- Một số sản phẩm khuyến mãi - Hiển thị dưới Danh mục sản phẩm -->
                    <h2 class="main__left-title main__left-margin-top">SẢN PHẨM KHUYẾN MÃI</h2>
                    <ul class="main__left-product-list">
                        <li class="main__left-product-items main__left-product-items--vertical">
                            <img src="assets/img/SPKM-1.jpg" alt="Quạt điều hoà" class="main__left-product-img" />
                            <a href="#" class="main__left-product-link">
                                <span class="main__left-product-title">Quạt điều hoà</span>
                            </a>
                            <br />
                            <span class="main__left-product">999.000đ</span>
                            <span class="main__left-product-omount"><strong>499.000đ</strong></span>
                        </li>
                        <li class="main__left-product-items main__left-product-items--vertical  main__left-new">
                            <a href="#" class="main__left-product-link">
                                <img src="assets/img/SPKM-2.jpg" alt="Quạt cây" class="main__left-product-img" />
                                <span class="main__left-product-title">Quạt cây</span>
                            </a>
                            <br />
                            <span class="main__left-product">359.000đ</span>
                            <span class="main__left-product-omount"><strong>159.000đ</strong></span>
                        </li>
                        <li class="main__left-product-items main__left-product-items--vertical  main__left-new">
                            <a href="#" class="main__left-product-link">
                                <img src="assets/img/SPKM-3.jpg" alt="Đèn led trang trí" class="main__left-product-img" />
                                <span class="main__left-product-title">Đèn led trang trí</span>
                            </a>
                            <br />
                            <span class="main__left-product">99.000đ</span>
                            <span class="main__left-product-omount"><strong>45.000đ</strong></span>
                        </li>
                        <li class="main__left-product-items main__left-product-items--vertical">
                            <a href="#" class="main__left-product-link">
                                <img src="assets/img/SPKM-4.jpg" alt="Ổ cắm điện" class="main__left-product-img" />
                                <span class="main__left-product-title">Ổ cắm điện</span>
                            </a>
                            <br />
                            <span class="main__left-product">66.000đ</span>
                            <span class="main__left-product-omount"><strong>52.000đ</strong></span>
                        </li>
                        <li class="main__left-product-items main__left-product-items--vertical">
                            <a href="#" class="main__left-product-link">
                                <img src="assets/img/SPKM-5.jpg" alt="Bộ tua vít chất lượng cao" class="main__left-product-img" />
                                <span class="main__left-product-title">Bộ tua vít chất lượng cao</span>
                            </a>
                            <br />
                            <span class="main__left-product">95.000đ</span>
                            <span class="main__left-product-omount"><strong>88.000đ</strong></span>
                        </li>
                    </ul>

                    <!-- Main Left New products : Sản phẩm mới -->
                    <!-- Một số sản phẩm mới của cửa hàng - Hiển thị dưới Sản phẩm khuyến mãi -->
                    <h2 class="main__left-title main__left-margin-top">SẢN PHẨM MỚI</h2>
                    <ul class="main__left-product-list">
                        <li class="main__left-product-items main__left-product-items--vertical  main__left-new">
                            <img src="assets/img/SPM-1.jpg" alt="Quạt phun sương tạo ẩm" class="main__left-product-img" />
                            <a href="#" class="main__left-product-link">
                                <span class="main__left-product-title">Quạt phun sương tạo ẩm</span>
                            </a>
                            <br />
                            <span class="main__left-product-omount"><strong>3.050.000đ</strong></span>
                        </li>
                        <li class="main__left-product-items main__left-product-items--vertical">
                            <a href="#" class="main__left-product-link">
                                <img src="assets/img/SPM-2.jpg" alt="Đèn chùm pha lê trang trí phòng khách" class="main__left-product-img" />
                                <span class="main__left-product-title">Đèn chùm pha lê trang trí phòng khách</span>
                            </a>
                            <br />
                            <span class="main__left-product-omount"><strong>6.500.000đ</strong></span>
                        </li>
                        <li class="main__left-product-items main__left-product-items--vertical">
                            <a href="#" class="main__left-product-link">
                                <img src="assets/img/SPM-3.jpg" alt="Aptomat MCB" class="main__left-product-img" />
                                <span class="main__left-product-title">Aptomat MCB</span>
                            </a>
                            <br />
                            <span class="main__left-product-omount"><strong>115.000đ</strong></span>
                        </li>
                        <li class="main__left-product-items main__left-product-items--vertical">
                            <a href="#" class="main__left-product-link">
                                <img src="assets/img/SPM-4.jpg" alt="Khoá cửa thông minh tích hợp khuôn mặt" class="main__left-product-img" />
                                <span class="main__left-product-title">Khoá cửa thông minh tích hợp khuôn mặt</span>
                            </a>
                            <br />
                            <span class="main__left-product">6.500.000đ</span>
                            <span class="main__left-product-omount"><strong>5.500.000đ</strong></span>
                        </li>
                        <li class="main__left-product-items main__left-product-items--vertical">
                            <a href="#" class="main__left-product-link">
                                <img src="assets/img/SPM-5.jpg" alt="Công tắc gạc 6 chân 6A (2 trạng thái)" class="main__left-product-img" />
                                <span class="main__left-product-title">Công tắc điện mạ vàng mặt vuông</span>
                            </a>
                            <br />
                            <span class="main__left-product-omount"><strong>289.000đ</strong></span>
                        </li>
                    </ul>
                    
                    <!-- Main Left Post -->
                    <!-- Các bài báo mới - Hiển thị dưới Sản phẩm mới -->
                    <h2 class="main__left-title main__left-margin-top">BÀI VIẾT MỚI</h2>
                    <ul class="main__left-posts-list">
                        <li class="main__left-posts-items main__left-posts-items--vertical">
                            <img src="assets/img/BV-1.jpg" alt="Phim siêu anh hùng" class="main__left-posts-img" />
                            <a href="#" class="main__left-posts-link">
                                <span class="main__left-posts-title">Anh em đạo diễn Russo: Sức hút của 
                                    "Avengers: Endgame quá lớn, không cần bỏ tiền marketing</span>
                            </a>
                        </li>
                        <li class="main__left-posts-items main__left-posts-items--vertical">
                            <img src="assets/img/BV-2.jpg" alt="Tổng thống Trump" class="main__left-posts-img" />
                            <a href="#" class="main__left-posts-link">
                                <span class="main__left-posts-title">Tổng thống Trump: “Tôi sẽ không bao giờ bước vào trong một chiếc xe tự lái”</span>
                            </a>
                        </li>
                        <li class="main__left-posts-items main__left-posts-items--vertical">
                            <img src="assets/img/BV-3.jpg" alt="Hình ảnh Facebook" class="main__left-posts-img" />
                            <a href="#" class="main__left-posts-link">
                                <span class="main__left-posts-title">Facebook bổ sung thêm tab Gaming vào ứng dụng trên smartphone</span>
                            </a>
                        </li>
                        <li class="main__left-posts-items" style="padding-bottom: 20px;"> <!-- Nội tuyến -->
                            <img src="assets/img/BV-4.jpg" alt="Hình ảnh Galaxy S10" class="main__left-posts-img" />
                            <a href="#" class="main__left-posts-link">
                                <span class="main__left-posts-title">Đôi điều về gốm trên Galaxy S10</span>
                            </a>
                        </li>
                    </ul>
                </div>

                
            </div>
        </main>

        <%@ include file="./Public/footer.jsp" %>
    </body>
</html>
