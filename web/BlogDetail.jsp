<%-- 
    Document   : BlogDetail
    Created on : Mar 24, 2025, 3:07:31 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DAO.*"%>
<%@page import="Model.*"%>
<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Bài Viết</title>

        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

        <meta content="Metronic Shop UI description" name="description">
        <meta content="Metronic Shop UI keywords" name="keywords">
        <meta content="keenthemes" name="author">

        <meta property="og:site_name" content="-CUSTOMER VALUE-">
        <meta property="og:title" content="-CUSTOMER VALUE-">
        <meta property="og:description" content="-CUSTOMER VALUE-">
        <meta property="og:type" content="website">
        <meta property="og:image" content="-CUSTOMER VALUE-"><!-- link to image for socio -->
        <meta property="og:url" content="-CUSTOMER VALUE-">

        <link rel="shortcut icon" href="favicon.ico">

        <!-- Fonts START -->

        <!-- Fonts END -->

        <!-- Global styles START -->          
        <link href="TulasCSS/assets/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet">
        <link href="TulasCSS/assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <!-- Global styles END --> 

        <!-- Page level plugin styles START -->
        <link href="TulasCSS/assets/plugins/fancybox/source/jquery.fancybox.css" rel="stylesheet">
        <link href="TulasCSS/assets/plugins/owl.carousel/assets/owl.carousel.css" rel="stylesheet">
        <link href="TulasCSS/assets/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css">
        <link href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" rel="stylesheet" type="text/css"><!-- for slider-range -->
        <link href="TulasCSS/assets/plugins/rateit/src/rateit.css" rel="stylesheet" type="text/css">
        <!-- Page level plugin styles END -->

        <!-- Theme styles START -->
        <link href="TulasCSS/assets/corporate/css/style.css" rel="stylesheet">
        <link href="TulasCSS/assets/pages/css/style-shop.css" rel="stylesheet" type="text/css">
        <link href="TulasCSS/assets/corporate/css/style-responsive.css" rel="stylesheet">
        <link href="TulasCSS/assets/corporate/css/themes/red.css" rel="stylesheet" id="style-color">
        <link href="TulasCSS/assets/corporate/css/custom.css" rel="stylesheet">
        <!-- Theme styles END -->
        <link rel="shortcut icon" href="assets/img/S4EWhite.PNG" type="image/x-icon" />
        <link rel="stylesheet" href="assets/css/reset.css" />
        <link rel="stylesheet" href="assets/css/base.css" />
        <link rel="stylesheet" href="assets/css/main_PC.css" />
        <link rel="stylesheet" href="assets/css/main_Tablet.css" />
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
        <link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css" />
        <link rel="stylesheet" href="assets/fonts/fontawesome-free-6.0.0-web/css/all.css" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swapsubset=vietnamese" />



        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
        <style>
            /* General Styles */
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
                color: #333;
            }

            .container {
                display: flex;
                max-width: 1200px;
                margin: 20px auto;
                padding: 20px;
                background-color: #fff;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .main-content {
                flex: 3;
                margin-right: 20px;
            }

            .sidebar {
                flex: 1;
            }

            /* Post Details */
            .post-details {
                margin-bottom: 40px;
            }

            .post-title {
                font-size: 2em;
                margin-bottom: 10px;
                color: #333;
            }

            .post-meta {
                font-size: 0.9em;
                color: #777;
                margin-bottom: 20px;
            }

            .post-meta span {
                margin-right: 15px;
            }

            .post-content {
                line-height: 1.6;
                font-size: 1em;
                color: #555;
            }

            /* Sidebar Styles */
            .search-box {
                margin-bottom: 20px;
            }

            .search-box input {
                width: calc(100% - 90px);
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }

            .search-box button {
                width: 80px;
                padding: 10px;
                background-color: #333;
                color: #fff;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            .categories, .static-links {
                margin-bottom: 30px;
            }

            .categories h3, .static-links h3 {
                font-size: 1.2em;
                margin-bottom: 15px;
                color: #333;
            }

            .categories ul, .static-links ul {
                list-style: none;
                padding: 0;
            }

            .categories ul li, .static-links ul li {
                margin-bottom: 10px;
            }

            .categories ul li a, .static-links ul li a {
                text-decoration: none;
                color: #555;
                font-size: 0.9em;
            }

            .categories ul li a:hover, .static-links ul li a:hover {
                color: #333;
                text-decoration: underline;
            }
        </style>
    </head>
    <body class="ecommerce">
        <%@ include file="./Public/header.jsp" %>
        <main class="main">
            <div class="main__gird gird">
                <jsp:include page="getSidebarData" />
                <div class="main">
                    <div class="main__right">
                        <div class="container">
                            <!-- Main Content -->
                            <div class="main-content">
                                <%
                                    MarketingPosts post = (MarketingPosts) request.getAttribute("post");
                                    UsersDAO uDAO = new UsersDAO();
                                    String cate = "";
                                    Users author = uDAO.getUserByUserID(post.getAuthor());
                                    Map<String, PostCategory> list = (Map<String, PostCategory>) request.getAttribute("list");
                                    for (String id : list.keySet()) {
                                          PostCategory pc = list.get(id);
                                          if(pc.getCategoryID().equalsIgnoreCase(post.getCategory())){
                                           cate = pc.getCategoryName();
                                        }
                                    }
                                %>
                                <article class="post-details">
                                    <h1 class="post-title"><%=post.getTitle()%></h1>
                                    <div class="post-meta">
                                        <span class="author">Tác giả: <%=author.getFirstName()%> <%=author.getLastName()%></span>
                                        <span class="updated-date">Viết vào ngày: <%=post.getCreateDate()%></span>
                                        <span class="category">Danh mục: <%=cate%></span>
                                    </div>
                                    <div class="post-content">
                                        <img src="<%=post.getImageLink()%>" alt="Ảnh minh họa bài viết" class="post-image">
                                        <p><%=post.getContent()%></p>
                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam scelerisque ipsum vitae velit sagittis, a tincidunt nunc tincidunt. Donec euismod, nisl eget aliquam ultricies, nunc nisl aliquet nunc, eget aliquam nisl nunc eget nisl.</p>
                                    </div>
                                </article>
                            </div>

                            <!-- Sidebar -->
                            <aside class="sidebar">
                                <div class="search-box">
                                    <form action="/Project-SWP391-G2-SP25/blogs" method="GET">
                                        <input type="text" name="search" placeholder="Tìm kiếm bài viết..." value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                                        <button type="submit">Tìm kiếm</button>
                                    </form>
                                </div>
                                <div class="categories">
                                    <h3>Danh mục</h3>
                                    <ul>
                                        <%
                                            for (String id1 : list.keySet()) {
                                              PostCategory pc1 = list.get(id1);
                                            
                                        %>
                                        <li><a href="/Project-SWP391-G2-SP25/blogs?cate=<%=id1%>"><%=pc1.getCategoryName()%></a></li>
                                            <%}%>
                                    </ul>
                                </div>
                            </aside>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <%@ include file="./Public/footer.jsp" %>
</html>
