
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="DAO.*"%>
<%@page import="Model.*"%>
<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
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
    <body>
        <%@ include file="./Public/header.jsp" %>
        <main class="main">
            <div class="main__gird gird"> <!-- Cái khung của trang web -->
                <jsp:include page="getSidebarData" />
                <!-- Main Right -->
                <!-- Đây là phần thân bên phải của trang web -->
                <div class="main__right">
                    <%
                       String result = request.getParameter("search");
                       if(result != null && !result.trim().isEmpty()) {
                    %>
                    <h3 class="mainTT__right-heading">Kết quả tìm kiếm cho "<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>"</h3>
                    <%}%>
                    <%
                        List<MarketingPosts> blogs = (List<MarketingPosts>) request.getAttribute("blogs");
                        for(int i = 0; i<blogs.size();i++){
                            MarketingPosts blog = blogs.get(i);
                    %>
                    <div class="mainTT__right-items">
                        <div class="mainTT__right-img">
                            <a href="/Project-SWP391-G2-SP25/BlogDetail?id=<%=blog.getPostID()%>"><img src="<%=blog.getImageLink()%>" alt="Hình ảnh ...." /></a>
                            <div class="mainTT__right-date">
                                <fmt:formatDate value="<%=blog.getCreateDate()%>" pattern="dd"/> <br />
                                th<fmt:formatDate value="<%=blog.getCreateDate()%>" pattern="MM"/>
                            </div>
                        </div>
                        <div class="mainTT__right-title">
                            <a href="/Project-SWP391-G2-SP25/BlogDetail?id=<%=blog.getPostID()%>"><h3 class="mainTT__right-heading"><%=blog.getTitle()%></h3></a>
                            <p class="mainTT_right-content"><%=blog.getContent()%></p>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <%}%>

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
                                    Map<String, PostCategory> list = (Map<String, PostCategory>) request.getAttribute("list");
                                    for (String id1 : list.keySet()) {
                                      PostCategory pc1 = list.get(id1);
                                            
                                %>
                                <li><a href="/Project-SWP391-G2-SP25/blogs?cate=<%=id1%>"><%=pc1.getCategoryName()%></a></li>
                                    <%}%>
                            </ul>
                        </div>
                    </aside>
                </div>
                <div class="clear"></div>

            </div>
        </main>
        <%@ include file="./Public/footer.jsp" %>
    </body>
</html>
