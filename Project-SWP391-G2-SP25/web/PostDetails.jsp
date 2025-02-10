<%-- 
    Document   : PostDetails
    Created on : Feb 10, 2025, 1:26:11 AM
    Author     : Tùng Dương
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Model.MarketingPosts" %>

<%
    MarketingPosts post = (MarketingPosts) request.getAttribute("post");
    String errorMessage = (String) request.getAttribute("errorMessage");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Blog Details </title>
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

        <div class="post-container_top" style="margin-top: 10px;">
            <% if (errorMessage != null) {%>
            <h2 style="color: red;"><%= errorMessage%></h2>
            <% } else if (post == null) { %>
            <h2 style="color: red;">Bài viết không tồn tại hoặc đã bị xóa!</h2>
            <% } else {%>
            <div class="post-container" style="margin-top: 10px;">
                <div class="post-header">
                    <h1 class="post-title"><%= post.getTitle()%></h1>
                    <p class="post-meta">
                        🗓 <%= post.getCreateDate()%> &nbsp;&nbsp;
                        ✍️ Tác giả: <%= post.getAuthor()%>
                    </p>
                </div>

                <div class="post-content">
                    <img src="<%= post.getImageLink()%>" alt="<%= post.getTitle()%>" class="post-image">
                    <p class="post-content" style="text-align: left;"><%= post.getContent()%></p>
                </div>
                <% }%>
            </div>

            <%@ include file="./Public/footer.jsp" %>
    </body>
</html>
