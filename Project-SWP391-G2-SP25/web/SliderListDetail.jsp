<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.Category, Model.Products, Model.MarketingPosts"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Slider List Details</title>
        <link rel="shortcut icon" href="assets/img/S4EWhite.PNG" type="image/x-icon" />
        <link rel="stylesheet" href="assets/css/reset.css" />
        <link rel="stylesheet" href="assets/css/base.css" />
        <link rel="stylesheet" href="assets/css/main_PC.css" />
        <link rel="stylesheet" href="assets/css/main_Tablet.css" />
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
        <link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css" />
        <link rel="stylesheet" href="assets/fonts/fontawesome-free-6.0.0-web/css/all.css" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swapsubset=vietnamese" />
        <style>
            .slider-form {
                display: flex;
                flex-direction: column;
                gap: 15px;
                max-width: 500px;
                margin: 0 auto;
                padding: 20px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .slider-form label {
                font-weight: bold;
                margin-bottom: 5px;
            }

            .slider-form input, .slider-form select {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            .slider-form input[type="file"] {
                border: none;
            }

            .slider-form img {
                display: block;
                margin: 10px auto;
                border-radius: 5px;
                border: 1px solid #ccc;
            }

            .save-btn {
                background-color: #3498db;
                color: white;
                padding: 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background 0.3s ease;
            }

            .save-btn:hover {
                background-color: #2980b9;
            }

        </style>
    </head>
    <body>

        <%@ include file="./Public/header.jsp" %> 

        <main class="container">


            <c:if test="${not empty slider}">
                <form action="EditDetailSlider" method="post" enctype="multipart/form-data" class="slider-form">
                    <input type="hidden" name="sliderID" value="${slider.getSliderID()}">
                    <input type="hidden" name="currentImage" value="${slider.getImage()}"> <!-- Ảnh cũ -->

                    <label for="title"><strong>Title:</strong></label>
                    <input type="text" id="title" name="title" value="${slider.title}" required>

                    <label for="image"><strong>Current Image:</strong></label>
                    <img src="${slider.getImage()}" width="300">

                    <label for="newImage"><strong>Upload New Image:</strong></label>
                    <input type="file" id="newImage" name="newImage">

                    <label for="backlink"><strong>Backlink:</strong></label>
                    <input type="text" id="backlink" name="backlink" value="${slider.backlink}" required>

                    <label for="status"><strong>Status:</strong></label>
                    <select id="status" name="status">
                        <option value="active" ${slider.status == 'active' ? 'selected' : ''}>Active</option>
                        <option value="inactive" ${slider.status == 'inactive' ? 'selected' : ''}>Inactive</option>
                    </select>
                    <button type="submit" class="button save-btn">Save Changes</button>
                </form>
                        
            </c:if>

            <c:if test="${empty slider}">
                <p class="error-message">Slider not found.</p>
            </c:if>

            <a href="SlidersListController" class="back-button">Back to List</a>
        </main>


        <%@ include file="./Public/footer.jsp" %>

    </body>
</html>
