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

                <!-- Main Right -->
                <!-- Đây là phần thân bên phải của trang web -->
                <div class="main__right">
                    <!-- Panel của trang web - Có thể lướt qua lại, dùng để quảng cáo làm cho trang web nổi bật hơn -->
                    <!-- Imgage Slider start -->
                    <div class="main__right-panel">
                        <div class="swiper swiper-panel">
                            <!-- Additional required wrapper -->
                            <div class="swiper-wrapper">
                                <!-- Slides -->
                                <div class="swiper-slide"><img src="./assets/img/Panel1.jpg" alt="" class="main__right-panel-img"></div>
                                <div class="swiper-slide"><img src="./assets/img/Panel2.png" alt="" class="main__right-panel-img"></div>
                                <div class="swiper-slide"><img src="./assets/img/Panel3.png" alt="" class="main__right-panel-img"></div>
                                <div class="swiper-slide"><img src="./assets/img/Panel4.png" alt="" class="main__right-panel-img"></div>
                            </div>

                            <div class="panel-prev">
                                <i class="fa-solid fa-angle-left button-prev"></i>
                            </div>
                            <div class="panel-next">
                                <i class="fa-solid fa-angle-right button-next"></i>
                            </div>

                        </div>
                    </div>   
                    <!-- Imgage Slider end -->
                    <!-- Danh mục các sản phẩm quạt điện -->
                    <!-- Fan Equipment - Quạt điện -->
                    <div class="main__right-sensor">
                        <!-- Tiêu đề cho danh mục Thiết bị quạt -->
                        <h3 class="main__right-heading">
                            <span class="main__right-heading-title">Thiết bị quạt</span>
                            <a href="#" class="main__right-heading-link">
                                Xem thêm
                                <i class="main__right-heading-icon fa-solid fa-angle-right"></i>
                            </a>
                        </h3>

                        <!-- Các sản phẩm của danh mục Thiết bị quạt -->
                        <div class="main__right-sensor-list">
                            <div class="main__right-sensor-items">
                                <a href="#" class="main__right-sensor-link">
                                    <img src="assets/img/TBQ-1.jpg" alt="" class="main__right-sensor-img" />
                                    <div class="main__right-sensor-title">Quạt tích điện</div>
                                </a>
                                <span class="main__right-sensor-price">195.000đ</span>
                            </div>
                            <div class="main__right-sensor-items">
                                <a href="#" class="main__right-sensor-link">
                                    <img src="assets/img/TBQ-2.jpg" alt="" class="main__right-sensor-img" />
                                    <div class="main__right-sensor-title">Quạt hơi nước</div>
                                </a>
                                <span class="main__right-sensor-price">499.000đ</span>
                            </div>
                            <div class="main__right-sensor-items">
                                <a href="#" class="main__right-sensor-link">
                                    <img src="assets/img/TBQ-3.jpg" alt="" class="main__right-sensor-img" />
                                    <div class="main__right-sensor-title">Quạt điều hoà</div>
                                </a>
                                <span class="main__right-sensor-price">499.000đ</span>
                            </div>
                            <div class="main__right-sensor-items">
                                <a href="#" class="main__right-sensor-link">
                                    <img src="assets/img/TBQ-4.jpg" alt="" class="main__right-sensor-img" />
                                    <div class="main__right-sensor-title">Quạt trần treo tường</div>
                                </a>
                                <span class="main__right-sensor-price">800.000đ</span>
                            </div>
                            <div class="main__right-sensor-items">
                                <a href="#" class="main__right-sensor-link">
                                    <img src="assets/img/TBQ-5.jpg" alt="" class="main__right-sensor-img" />
                                    <div class="main__right-sensor-title">Quạt treo tường</div>
                                </a>
                                <span class="main__right-sensor-price">180.000đ</span>
                            </div>
                            <div class="main__right-sensor-items">
                                <a href="#" class="main__right-sensor-link">
                                    <img src="assets/img/TBQ-6.jpg" alt="" class="main__right-sensor-img" />
                                    <div class="main__right-sensor-title">Quạt cây</div>
                                </a>
                                <span class="main__right-sensor-price">159.000đ</span>
                            </div>
                            <div class="main__right-sensor-items">
                                <a href="#" class="main__right-sensor-link">
                                    <img src="assets/img/TBQ-7.jpg" alt="" class="main__right-sensor-img" />
                                    <div class="main__right-sensor-title">Quạt phun sương tạo ẩm</div>
                                </a>
                                <span class="main__right-sensor-price">3.050.000đ</span>
                            </div>
                            <div class="main__right-sensor-items">
                                <a href="#" class="main__right-sensor-link">
                                    <img src="assets/img/TBQ-8.jpg" alt="" class="main__right-sensor-img" />
                                    <div class="main__right-sensor-title">Quạt sàn</div>
                                </a>
                                <span class="main__right-sensor-price">785.000đ</span>
                            </div>
                        </div>
                    </div>

                    <!-- Danh mục Thiết bị chiếu sáng -->
                    <!-- Lighting equipment : Thiết bị chiếu sáng - Start -->
                    <div class="main__right-sensor">
                        <!-- Tiêu đề cho danh mục Thiết bị chiếu sáng -->
                        <h3 class="main__right-heading">
                            <span class="main__right-heading-title">Thiết bị chiếu sáng</span>
                            <a href="#" class="main__right-heading-link">
                                Xem thêm
                                <i class="main__right-heading-icon fa-solid fa-angle-right"></i>
                            </a>
                        </h3>
                        <!-- Các sản phẩm là Thiết bị chiếu sáng - Người dùng có thể trượt qua phải, trái để xem nhiều hơn -->
                        <!-- Danh sách các sản phẩm theo thanh trượt -->
                        <div class="main__right-sensor-list swiper mySwiper1">
                            <div class="swiper-wrapper">
                                <div class="swiper-slide">
                                    <div class="main__right-sensor-item">
                                        <a href="#" class="main__right-sensor-link">
                                            <img src="assets/img/TBCS-1.jpg" alt="" class="main__right-sensor-img" />
                                            <div class="main__right-sensor-title">Bóng đèn LED MPE LBD-50V 50W</div>
                                        </a>
                                        <span class="main__right-sensor-promotion">399.000đ</span>
                                        <span class="main__right-sensor-price">290.000đ</span>
                                    </div>
                                </div>
                                <div class="swiper-slide">
                                    <div class="main__right-sensor-item">
                                        <a href="#" class="main__right-sensor-link">
                                            <img src="assets/img/TBCS-2.jpg" alt="" class="main__right-sensor-img" />
                                            <div class="main__right-sensor-title">Đèn Led âm trần chống chói 7W</div>
                                        </a>
                                        <span class="main__right-sensor-price">115.000đ</span>
                                    </div>
                                </div>
                                <div class="swiper-slide">
                                    <div class="main__right-sensor-item">
                                        <a href="#" class="main__right-sensor-link">
                                            <img src="assets/img/TBCS-3.jpg" alt="" class="main__right-sensor-img" />
                                            <div class="main__right-sensor-title">Đèn pha LED 200w cao cấp ngoài trời</div>
                                        </a>
                                        <span class="main__right-sensor-promotion">900.000đ</span>
                                        <span class="main__right-sensor-price">795.000đ</span>
                                    </div>
                                </div>
                                <div class="swiper-slide">
                                    <div class="main__right-sensor-item">
                                        <a href="#" class="main__right-sensor-link">
                                            <img src="assets/img/TBCS-4.jpg" alt="" class="main__right-sensor-img" />
                                            <div class="main__right-sensor-title">Bộ đèn led tuýp T8 thuỷ tinh 1,2m</div>
                                        </a>
                                        <span class="main__right-sensor-price">160.000đ</span>
                                    </div>
                                </div>
                                <div class="swiper-slide">
                                    <div class="main__right-sensor-item">
                                        <a href="#" class="main__right-sensor-link">
                                            <img src="assets/img/TBCS-5.jpg" alt="" class="main__right-sensor-img" />
                                            <div class="main__right-sensor-title">Bóng đèn LED kẹp bàn 60 bóng LED</div>
                                        </a>
                                        <span class="main__right-sensor-price">96.000đ</span>
                                    </div>
                                </div>
                                <div class="swiper-slide">
                                    <div class="main__right-sensor-item">
                                        <a href="#" class="main__right-sensor-link">
                                            <img src="assets/img/TBCS-6.jpg" alt="" class="main__right-sensor-img" />
                                            <div class="main__right-sensor-title">Đèn LED âm đất 36W</div>
                                        </a>
                                        <span class="main__right-sensor-price">860.000đ</span>
                                    </div>
                                </div>
                                <div class="swiper-slide">
                                    <div class="main__right-sensor-item">
                                        <a href="#" class="main__right-sensor-link">
                                            <img src="assets/img/TBCS-7.jpg" alt="" class="main__right-sensor-img" />
                                            <div class="main__right-sensor-title">Đèn LED thanh hắt</div>
                                        </a>
                                        <span class="main__right-sensor-price">640.000đ</span>
                                    </div>
                                </div>
                                <div class="swiper-slide">
                                    <div class="main__right-sensor-item">
                                        <a href="#" class="main__right-sensor-link">
                                            <img src="assets/img/TBCS-8.jpg" alt="" class="main__right-sensor-img" />
                                            <div class="main__right-sensor-title">Đèn LED rọi 12W mắt ếch</div>
                                        </a>
                                        <span class="main__right-sensor-price">270.000đ</span>
                                    </div>
                                </div>                           
                            </div>                            

                            <!-- Các nút bấm để người dùng kích vào xem những sản phẩm trong thanh trượt -->
                            <div class="main__right-sensor-prev">
                                <i class="fa-solid fa-angle-left sensor-button-prev"></i>
                            </div>
                            <div class="main__right-sensor-next">
                                <i class="fa-solid fa-angle-right sensor-button-next"></i>
                            </div>

                        </div>                   

                    </div>
                    <!-- Lighting equipment : Thiết bị chiếu sáng - End -->

                    <!-- Danh mục các sản phẩm Công tắc điện -->
                    <!-- Electronic Switch : Công tắc điện - Start -->
                    <div class="main__right-sensor">
                        <!-- Tiêu đề của Công tắc điện -->
                        <h3 class="main__right-heading">
                            <span class="main__right-heading-title">Công tắc điện</span>
                            <a href="#" class="main__right-heading-link">
                                Xem thêm
                                <i class="main__right-heading-icon fa-solid fa-angle-right"></i>
                            </a>
                        </h3>
                        <!-- Các sản phẩm Công tắc điện - Người dùng có thể trượt qua phải, trái để xem nhiều hơn -->
                        <!-- Danh sách các sản phẩm theo thanh trượt -->
                        <div class="main__right-sensor-list swiper mySwiper2">
                            <div class="swiper-wrapper">
                                <div class="swiper-slide">
                                    <div class="main__right-sensor-item">
                                        <a href="#" class="main__right-sensor-link">
                                            <img src="assets/img/CTD-1.jpg" alt="" class="main__right-sensor-img" />
                                            <div class="main__right-sensor-title">Bộ 3 công tắc điện 1 chiều Size S</div>
                                        </a>
                                        <span class="main__right-sensor-price">175.000đ</span>
                                    </div>
                                </div>
                                <div class="swiper-slide">
                                    <div class="main__right-sensor-item">
                                        <a href="#" class="main__right-sensor-link">
                                            <img src="assets/img/CTD-2.jpg" alt="" class="main__right-sensor-img" />
                                            <div class="main__right-sensor-title">Công tắc 2 nút và 1 ổ cắm đôi âm tường</div>
                                        </a>
                                        <span class="main__right-sensor-price">180.000đ</span>
                                    </div>
                                </div>
                                <div class="swiper-slide">
                                    <div class="main__right-sensor-item">
                                        <a href="#" class="main__right-sensor-link">
                                            <img src="assets/img/CTD-3.jpg" alt="" class="main__right-sensor-img" />
                                            <div class="main__right-sensor-title">Công tắc điện quả nhót</div>
                                        </a>
                                        <span class="main__right-sensor-price">9.000đ</span>
                                    </div>
                                </div>
                                <div class="swiper-slide">
                                    <div class="main__right-sensor-item">
                                        <a href="#" class="main__right-sensor-link">
                                            <img src="assets/img/CTD-4.jpg" alt="" class="main__right-sensor-img" />
                                            <div class="main__right-sensor-title">Công tắc ON-OFF điện 3 pha</div>
                                        </a>
                                        <span class="main__right-sensor-price">125.000đ</span>
                                    </div>
                                </div>
                                <div class="swiper-slide">
                                    <div class="main__right-sensor-item">
                                        <a href="#" class="main__right-sensor-link">
                                            <img src="assets/img/CTD-5.jpg" alt="" class="main__right-sensor-img" />
                                            <div class="main__right-sensor-title">Công tắc điện điều khiển từ xa qua remote</div>
                                        </a>
                                        <span class="main__right-sensor-price">550.000đ</span>
                                    </div>
                                </div>
                                <div class="swiper-slide">
                                    <div class="main__right-sensor-item">
                                        <a href="#" class="main__right-sensor-link">
                                            <img src="assets/img/CTD-6.jpg" alt="" class="main__right-sensor-img" />
                                            <div class="main__right-sensor-title">Công tắc bập bênh 2 chân</div>
                                        </a>
                                        <span class="main__right-sensor-price">8.000đ</span>
                                    </div>
                                </div>

                            </div>                            

                            <!-- Các nút bấm để người dùng kích vào xem những sản phẩm trong thanh trượt -->
                            <div class="main__right-electrical-prev">
                                <i class="fa-solid fa-angle-left electrical-button-prev"></i>
                            </div>
                            <div class="main__right-electrical-next">
                                <i class="fa-solid fa-angle-right electrical-button-next"></i>
                            </div>

                        </div>                   

                    </div>
                    <!-- Electronic Switch : Công tắc điện - End -->

                    <!-- Thiết bị thông minh - Start -->
                    <div class="main__right-sensor">
                        <h3 class="main__right-heading">
                            <span class="main__right-heading-title">Thiết bị thông minh</span>
                            <a href="#" class="main__right-heading-link">
                                Xem thêm
                                <i class="main__right-heading-icon fa-solid fa-angle-right"></i>
                            </a>
                        </h3>

                        <div class="main__right-sensor-list">
                            <div class="main__right-sensor-items">
                                <a href="#" class="main__right-sensor-link">
                                    <img src="assets/img/TBTM-1.jpg" alt="" class="main__right-sensor-img" />
                                    <div class="main__right-sensor-title">Đèn LED sạc không dây cảm ứng siêu mỏng</div>
                                </a>
                                <span class="main__right-sensor-promotion">299.000đ</span>
                                <span class="main__right-sensor-price">190.000đ</span>
                            </div>
                            <div class="main__right-sensor-items">
                                <a href="#" class="main__right-sensor-link">
                                    <img src="assets/img/TBTM-2.jpg" alt="" class="main__right-sensor-img" />
                                    <div class="main__right-sensor-title">Đèn LED cảm ứng chuyển động PIR</div>
                                </a>
                                <span class="main__right-sensor-price">115.000đ</span>
                            </div>
                            <div class="main__right-sensor-items">
                                <a href="#" class="main__right-sensor-link">
                                    <img src="assets/img/TBTM-3.jpg" alt="" class="main__right-sensor-img" />
                                    <div class="main__right-sensor-title">Công tắc điện cảm ứng</div>
                                </a>
                                <span class="main__right-sensor-promotion">666.000đ</span>
                                <span class="main__right-sensor-price">520.000đ</span>
                            </div>
                            <div class="main__right-sensor-items">
                                <a href="#" class="main__right-sensor-link">
                                    <img src="assets/img/TBTM-4.jpg" alt="" class="main__right-sensor-img" />
                                    <div class="main__right-sensor-title">Khoá cửa thông minh tích hợp camera AB-24K</div>
                                </a>
                                <span class="main__right-sensor-price">4.160.000đ</span>
                            </div>
                            <div class="main__right-sensor-items">
                                <a href="#" class="main__right-sensor-link">
                                    <img src="assets/img/TBTM-5.jpg" alt="" class="main__right-sensor-img" />
                                    <div class="main__right-sensor-title">Cảm biến khói Panasonic</div>
                                </a>
                                <span class="main__right-sensor-price">960.000đ</span>
                            </div>
                            <div class="main__right-sensor-items">
                                <a href="#" class="main__right-sensor-link">
                                    <img src="assets/img/Module-6.jpg" alt="" class="main__right-sensor-img" />
                                    <div class="main__right-sensor-title">Cảm biến chuyển động</div>
                                </a>
                                <span class="main__right-sensor-price">360.000đ</span>
                            </div>
                            <div class="main__right-sensor-items">
                                <a href="#" class="main__right-sensor-link">
                                    <img src="assets/img/TBTM-7.jpg" alt="" class="main__right-sensor-img" />
                                    <div class="main__right-sensor-title">Rèm thông minh điều khiển từ xa</div>
                                </a>
                                <span class="main__right-sensor-price">2.140.000đ</span>
                            </div>
                            <div class="main__right-sensor-items">
                                <a href="#" class="main__right-sensor-link">
                                    <img src="assets/img/TBTM-8.jpg" alt="" class="main__right-sensor-img" />
                                    <div class="main__right-sensor-title">Cảm biến cửa SmartLock</div>
                                </a>
                                <span class="main__right-sensor-price">700.000đ</span>
                            </div>
                        </div>
                    </div>
                    <!-- Thiết bị thông minh - End -->
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
    </body>
</html>
