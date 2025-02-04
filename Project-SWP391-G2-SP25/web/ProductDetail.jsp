<%-- 
    Document   : HomePage
    Created on : Jan 18, 2025, 12:47:06 AM
    Author     : Tung Duong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DAO.*"%>
<%@page import="Model.*"%>
<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

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

        <!-- Google font -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

        <!-- Bootstrap -->
        <link type="text/css" rel="stylesheet" href="TulasCSS/css/bootstrap.min.css"/>

        <!-- Slick -->
        <link type="text/css" rel="stylesheet" href="TulasCSS/css/slick.css"/>
        <link type="text/css" rel="stylesheet" href="TulasCSS/css/slick-theme.css"/>

        <!-- nouislider -->
        <link type="text/css" rel="stylesheet" href="TulasCSS/css/nouislider.min.css"/>

        <!-- Font Awesome Icon -->
        <link rel="stylesheet" href="TulasCSS/css/font-awesome.min.css">

        <!-- Custom stlylesheet -->
        <link type="text/css" rel="stylesheet" href="TulasCSS/css/style.css"/>

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->

    </head>
    <body>

        <%@ include file="./Public/header.jsp" %>
        <%
            UsersDAO uDAO = new UsersDAO();
            Products p = (Products) request.getAttribute("product");
            Map<Integer, Reviews> listr = (Map<Integer, Reviews>)request.getAttribute("listr");
        %>
        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <!-- Product main img -->
                    <div class="col-md-5 col-md-push-2">
                        <div id="product-main-img">
                            <div class="product-preview">
                                <img src="<%= p.getImageLink() %>" alt="">
                            </div>

                            <div class="product-preview">
                                <img src="<%= p.getImageLink() %>" alt="">
                            </div>

                            <div class="product-preview">
                                <img src="<%= p.getImageLink() %>" alt="">
                            </div>

                            <div class="product-preview">
                                <img src="<%= p.getImageLink() %>" alt="">
                            </div>
                        </div>
                    </div>
                    <!-- /Product main img -->

                    <!-- Product thumb imgs -->
                    <div class="col-md-2  col-md-pull-5">
                        <div id="product-imgs">
                            <div class="product-preview">
                                <img src="<%= p.getImageLink() %>" alt="">
                            </div>

                            <div class="product-preview">
                                <img src="<%= p.getImageLink() %>" alt="">
                            </div>

                            <div class="product-preview">
                                <img src="<%= p.getImageLink() %>" alt="">
                            </div>

                            <div class="product-preview">
                                <img src="<%= p.getImageLink() %>" alt="">
                            </div>
                        </div>
                    </div>
                    <!-- /Product thumb imgs -->

                    <!-- Product details -->
                    <div class="col-md-5">
                        <div class="product-details">
                            <h2 class="product-name"><%= p.getProductName() %></h2>
                            <%
                                double rate = 0;
                                if (listr == null || listr.size() == 0) {
                            %>
                            <div>
                                <div class="product-rating">
                                    <i class="fa fa-star-o"></i>
                                    <i class="fa fa-star-o"></i>
                                    <i class="fa fa-star-o"></i>
                                    <i class="fa fa-star-o"></i>
                                    <i class="fa fa-star-o"></i>
                                </div>
                                <a class="review-link" href="#">0 Review(s) | Add your review</a>
                            </div>
                            <%
                                                            } else {%>
                            <div>
                                <div class="product-rating">
                                    <%
                                            for (int id : listr.keySet()) {
                                                Reviews r = listr.get(id);
                                                rate += r.getRating();
                                            }
                                            rate = rate/listr.size();
                                            for (int i = 0; i < rate; i++) {
                                    %>
                                    <i class="fa fa-star"></i>
                                    <%}
                                    for (int i = 0; i < 5-rate; i++) {
                                    %>
                                    <i class="fa fa-star-o"></i>
                                    <%}%>
                                </div>
                                <a class="review-link" href="#"><%=listr.size()%> Review(s) | Add your review</a>
                            </div>
                            <%}%>
                            <div>
                                <h3 class="product-price"><%= p.getPrice() %><del class="product-old-price">      <%= p.getPrice() %></del></h3>
                                <span class="product-available">Còn Hàng</span>
                            </div>
                            <p><%= p.getDescription() %></p>

                            <div class="add-to-cart">
                                <div class="qty-label">
                                    Số lượng đặt
                                    <div class="input-number">
                                        <input type="number" value="1">
                                        <span class="qty-up">+</span>
                                        <span class="qty-down">-</span>
                                    </div>
                                </div>
                                <button class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> add to cart</button>
                            </div>

                            <ul class="product-btns">
                                <li><a href="#"><i class="fa fa-heart-o"></i> add to wishlist</a></li>
                            </ul>

                            <ul class="product-links">
                                <li>Category:</li>
                                <li><a href="#"><%= p.getCategoryID() %></a></li>
                            </ul>

                            <ul class="product-links">
                                <li>Share:</li>
                                <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                                <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                                <li><a href="#"><i class="fa fa-google-plus"></i></a></li>
                                <li><a href="#"><i class="fa fa-envelope"></i></a></li>
                            </ul>

                        </div>
                    </div>
                    <!-- /Product details -->

                    <!-- Product tab -->
                    <div class="col-md-12">
                        <div id="product-tab">
                            <!-- product tab nav -->
                            <ul class="tab-nav">
                                <li class="active"><a data-toggle="tab" href="#tab1">Description</a></li>
                                <li><a data-toggle="tab" href="#tab2">Details</a></li>
                                <li><a data-toggle="tab" href="#tab3">Reviews (3)</a></li>
                            </ul>
                            <!-- /product tab nav -->

                            <!-- product tab content -->
                            <div class="tab-content">
                                <!-- tab1  -->
                                <div id="tab1" class="tab-pane fade in active">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <p><%= p.getDescription() %></p>
                                        </div>
                                    </div>
                                </div>
                                <!-- /tab1  -->

                                <!-- tab2  -->
                                <div id="tab2" class="tab-pane fade in">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
                                        </div>
                                    </div>
                                </div>
                                <!-- /tab2  -->

                                <!-- tab3  -->
                                <div id="tab3" class="tab-pane fade in">
                                    <div class="row">
                                        <!-- Rating -->
                                        <div class="col-md-3">
                                            <div id="rating">
                                                <div class="rating-avg">
                                                    <span><%=rate%></span>
                                                    <div class="rating-stars">
                                                        <%for (int i = 0; i < rate; i++) {
                                                        %>
                                                        <i class="fa fa-star"></i>
                                                        <%}
                                                        for (int i = 0; i < 5-rate; i++) {
                                                        %>
                                                        <i class="fa fa-star-o"></i>
                                                        <%}%>
                                                    </div>
                                                </div>
                                                <ul class="rating">
                                                    <%
                                                        int count5 = 0;
                                                        int count4 = 0;
                                                        int count3 = 0;
                                                        int count2 = 0;
                                                        int count1 = 0;
                                                        for (int id : listr.keySet()) {
                                                            Reviews r = listr.get(id);
                                                            if(r.getRating()==5){
                                                            count5++;
                                                            }
                                                            if(r.getRating()==4){
                                                            count4++;
                                                            }
                                                            if(r.getRating()==3){
                                                            count3++;
                                                            }
                                                            if(r.getRating()==2){
                                                            count2++;
                                                            }
                                                            if(r.getRating()==1){
                                                            count1++;
                                                            }
                                                        }
                                                        int rate5 = count5/listr.size()*100;
                                                        int rate4 = count4/listr.size()*100;
                                                        int rate3 = count3/listr.size()*100;
                                                        int rate2 = count2/listr.size()*100;
                                                        int rate1 = count1/listr.size()*100;
                                                    %>
                                                    <li>
                                                        <div class="rating-stars">
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                        </div>
                                                        <div class="rating-progress">
                                                            <div style="width: <%=rate5%>%;"></div>
                                                        </div>
                                                        <span class="sum"><%=count5%></span>
                                                    </li>
                                                    <li>
                                                        <div class="rating-stars">
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star-o"></i>
                                                        </div>
                                                        <div class="rating-progress">
                                                            <div style="width: <%=rate4%>%;"></div>
                                                        </div>
                                                        <span class="sum"><%=count4%></span>
                                                    </li>
                                                    <li>
                                                        <div class="rating-stars">
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star-o"></i>
                                                            <i class="fa fa-star-o"></i>
                                                        </div>
                                                        <div class="rating-progress">
                                                            <div style="width: <%=rate3%>%;"></div>
                                                        </div>
                                                        <span class="sum"><%=count3%></span>
                                                    </li>
                                                    <li>
                                                        <div class="rating-stars">
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star-o"></i>
                                                            <i class="fa fa-star-o"></i>
                                                            <i class="fa fa-star-o"></i>
                                                        </div>
                                                        <div class="rating-progress">
                                                            <div style="width: <%=rate2%>%;"></div>
                                                        </div>
                                                        <span class="sum"><%=count2%></span>
                                                    </li>
                                                    <li>
                                                        <div class="rating-stars">
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star-o"></i>
                                                            <i class="fa fa-star-o"></i>
                                                            <i class="fa fa-star-o"></i>
                                                            <i class="fa fa-star-o"></i>
                                                        </div>
                                                        <div class="rating-progress">
                                                            <div style="width: <%=rate1%>%;"></div>
                                                        </div>
                                                        <span class="sum"><%=count1%></span>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        <!-- /Rating -->

                                        <!-- Reviews -->
                                        <div class="col-md-6">
                                            <div id="reviews">
                                                <ul class="reviews">
                                                    <% 
                                                        int reviewsPerPage = 4;
                                                        int totalReviews = listr.size();
                                                        int totalPages = (int) Math.ceil((double) totalReviews / reviewsPerPage);
                
                                                        // Lấy số trang từ request, mặc định là trang 1
                                                        String pageParam = request.getParameter("page");
                                                        int currentPage = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
                
                                                        // Tính toán vị trí bắt đầu và kết thúc
                                                        int startIndex = (currentPage - 1) * reviewsPerPage;
                                                        int endIndex = Math.min(startIndex + reviewsPerPage, totalReviews);
                
                                                        // Chuyển danh sách từ Map sang List để dễ phân trang
                                                        List<Reviews> reviewList = new ArrayList<>(listr.values());
                
                                                        for (int i = startIndex; i < endIndex; i++) {
                                                            Reviews r = reviewList.get(i);
                                                    %>
                                                    <li>
                                                        <div class="review-heading">
                                                            <h5 class="name"><%= uDAO.getUserByID(r.getCustomerID()).getFirstName() %></h5>
                                                            <p class="date"><%= r.getReviewDate() %></p>
                                                            <div class="review-rating">
                                                                <% for (int j = 0; j < r.getRating(); j++) { %>
                                                                <i class="fa fa-star"></i>
                                                                <% } %>
                                                                <% for (int j = 0; j < 5 - r.getRating(); j++) { %>
                                                                <i class="fa fa-star-o"></i>
                                                                <% } %>
                                                            </div>
                                                        </div>
                                                        <div class="review-body">
                                                            <p><%= r.getComment() %></p>
                                                        </div>
                                                    </li>
                                                    <% } %>
                                                </ul>

                                                <!-- Pagination -->
                                                <ul class="reviews-pagination">
                                                    <% if (currentPage > 1) { %>
                                                    <li><a href="?page=<%= currentPage - 1 %>"><i class="fa fa-angle-left"></i></a></li>
                                                            <% } %>

                                                    <% for (int i = 1; i <= totalPages; i++) { %>
                                                    <li class="<%= (i == currentPage) ? "active" : "" %>"><a href="?page=<%= i %>"><%= i %></a></li>
                                                        <% } %>

                                                    <% if (currentPage < totalPages) { %>
                                                    <li><a href="?page=<%= currentPage + 1 %>"><i class="fa fa-angle-right"></i></a></li>
                                                            <% } %>
                                                </ul>
                                            </div>
                                        </div>
                                        <!-- /Reviews -->

                                        <!-- Review Form -->
                                        <div class="col-md-3">
                                            <div id="review-form">
                                                <form class="review-form">
                                                    <input class="input" type="text" placeholder="Your Name">
                                                    <input class="input" type="email" placeholder="Your Email">
                                                    <textarea class="input" placeholder="Your Review"></textarea>
                                                    <div class="input-rating">
                                                        <span>Your Rating: </span>
                                                        <div class="stars">
                                                            <input id="star5" name="rating" value="5" type="radio"><label for="star5"></label>
                                                            <input id="star4" name="rating" value="4" type="radio"><label for="star4"></label>
                                                            <input id="star3" name="rating" value="3" type="radio"><label for="star3"></label>
                                                            <input id="star2" name="rating" value="2" type="radio"><label for="star2"></label>
                                                            <input id="star1" name="rating" value="1" type="radio"><label for="star1"></label>
                                                        </div>
                                                    </div>
                                                    <button class="primary-btn">Submit</button>
                                                </form>
                                            </div>
                                        </div>
                                        <!-- /Review Form -->
                                    </div>
                                </div>
                                <!-- /tab3  -->
                            </div>
                            <!-- /product tab content  -->
                        </div>
                    </div>
                    <!-- /product tab -->
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /SECTION -->

        <!-- Section -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">

                    <div class="col-md-12">
                        <div class="section-title text-center">
                            <h3 class="title">Related Products</h3>
                        </div>
                    </div>

                    <!-- product -->
                    <div class="col-md-3 col-xs-6">
                        <div class="product">
                            <div class="product-img">
                                <img src="./img/product01.png" alt="">
                                <div class="product-label">
                                    <span class="sale">-30%</span>
                                </div>
                            </div>
                            <div class="product-body">
                                <p class="product-category">Category</p>
                                <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                <h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
                                <div class="product-rating">
                                </div>
                                <div class="product-btns">
                                    <button class="add-to-wishlist"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></button>
                                    <button class="add-to-compare"><i class="fa fa-exchange"></i><span class="tooltipp">add to compare</span></button>
                                    <button class="quick-view"><i class="fa fa-eye"></i><span class="tooltipp">quick view</span></button>
                                </div>
                            </div>
                            <div class="add-to-cart">
                                <button class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> add to cart</button>
                            </div>
                        </div>
                    </div>
                    <!-- /product -->

                    <!-- product -->
                    <div class="col-md-3 col-xs-6">
                        <div class="product">
                            <div class="product-img">
                                <img src="./img/product02.png" alt="">
                                <div class="product-label">
                                    <span class="new">NEW</span>
                                </div>
                            </div>
                            <div class="product-body">
                                <p class="product-category">Category</p>
                                <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                <h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
                                <div class="product-rating">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                </div>
                                <div class="product-btns">
                                    <button class="add-to-wishlist"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></button>
                                    <button class="add-to-compare"><i class="fa fa-exchange"></i><span class="tooltipp">add to compare</span></button>
                                    <button class="quick-view"><i class="fa fa-eye"></i><span class="tooltipp">quick view</span></button>
                                </div>
                            </div>
                            <div class="add-to-cart">
                                <button class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> add to cart</button>
                            </div>
                        </div>
                    </div>
                    <!-- /product -->

                    <div class="clearfix visible-sm visible-xs"></div>

                    <!-- product -->
                    <div class="col-md-3 col-xs-6">
                        <div class="product">
                            <div class="product-img">
                                <img src="./img/product03.png" alt="">
                            </div>
                            <div class="product-body">
                                <p class="product-category">Category</p>
                                <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                <h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
                                <div class="product-rating">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star-o"></i>
                                </div>
                                <div class="product-btns">
                                    <button class="add-to-wishlist"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></button>
                                    <button class="add-to-compare"><i class="fa fa-exchange"></i><span class="tooltipp">add to compare</span></button>
                                    <button class="quick-view"><i class="fa fa-eye"></i><span class="tooltipp">quick view</span></button>
                                </div>
                            </div>
                            <div class="add-to-cart">
                                <button class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> add to cart</button>
                            </div>
                        </div>
                    </div>
                    <!-- /product -->

                    <!-- product -->
                    <div class="col-md-3 col-xs-6">
                        <div class="product">
                            <div class="product-img">
                                <img src="./img/product04.png" alt="">
                            </div>
                            <div class="product-body">
                                <p class="product-category">Category</p>
                                <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                <h4 class="product-price">$980.00 <del class="product-old-price">$990.00</del></h4>
                                <div class="product-rating">
                                </div>
                                <div class="product-btns">
                                    <button class="add-to-wishlist"><i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span></button>
                                    <button class="add-to-compare"><i class="fa fa-exchange"></i><span class="tooltipp">add to compare</span></button>
                                    <button class="quick-view"><i class="fa fa-eye"></i><span class="tooltipp">quick view</span></button>
                                </div>
                            </div>
                            <div class="add-to-cart">
                                <button class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> add to cart</button>
                            </div>
                        </div>
                    </div>
                    <!-- /product -->

                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /Section -->

        <%@ include file="./Public/footer.jsp" %>

        <!-- jQuery Plugins -->
        <script src="TulasCSS/js/jquery.min.js"></script>
        <script src="TulasCSS/js/bootstrap.min.js"></script>
        <script src="TulasCSS/js/slick.min.js"></script>
        <script src="TulasCSS/js/nouislider.min.js"></script>
        <script src="TulasCSS/js/jquery.zoom.min.js"></script>
        <script src="TulasCSS/js/main.js"></script>

    </body>
</html>
