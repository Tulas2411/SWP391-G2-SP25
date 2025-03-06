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
            body {
                font-family: 'Roboto', sans-serif;
                background-color: #f4f7fc;
                margin: 0;
                padding: 0;
            }

            .container {
                max-width: 1200px;
                margin: 40px auto;
                padding: 20px;
            }

            .slider-form {
                display: flex;
                flex-direction: column;
                gap: 15px;
                max-width: 600px;
                margin: 0 auto;
                padding: 30px;
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                transition: box-shadow 0.3s ease;
            }

            .slider-form:hover {
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
            }

            .slider-form label {
                font-weight: 600;
                margin-bottom: 5px;
                color: #333;
            }

            .slider-form p {
                font-size: 16px;
                color: #555;
                background: #f9f9f9;
                padding: 10px;
                border-radius: 5px;
                border: 1px solid #ddd;
                cursor: not-allowed;
            }

            .slider-form select, .slider-form input[type="text"] {
                width: 100%;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 14px;
                background: #f9f9f9;
                color: #333;
                transition: border 0.3s ease;
            }

            .slider-form select:focus, .slider-form input[type="text"]:focus {
                border: 1px solid #3498db;
                outline: none;
                background: #fff;
            }

            .readonly {
                background-color: #f9f9f9;
                border: 1px solid #ccc;
                cursor: not-allowed;
            }

            .save-btn {
                background-color: #3498db;
                color: white;
                padding: 12px 20px;
                border: none;
                border-radius: 5px;
                cursor: not-allowed;
                font-size: 16px;
                font-weight: bold;
                transition: background 0.3s ease;
                margin-top: 20px;
            }

            .save-btn:hover {
                background-color: #2980b9;
            }

            .error-message {
                color: red;
                font-size: 16px;
                text-align: center;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>

        <%@ include file="./Public/header.jsp" %> 

        <main class="container">

            <c:if test="${not empty slider}">
                <form class="slider-form">
                    <input type="hidden" name="sliderID" value="${slider.getSliderID()}">
                    <input type="hidden" name="currentImage" value="${slider.getImage()}"> 

                    <label for="title"><strong>Title:</strong></label>
                    <p>${slider.title}</p> <!-- Use <p> to display the title -->

                    <label for="newImageURL"><strong>Image:</strong></label>
                    <img src="${slider.getImage()}" alt="Slider Image" style="max-width: 100%; height: auto; border-radius: 8px; margin-top: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);" />

                    <label for="backlink"><strong>Backlink:</strong></label>
                    <p>${slider.backlink}</p> <!-- Use <p> to display the backlink -->

                    <label for="status"><strong>Status:</strong></label>
                    <p>${slider.status == 'active' ? 'Active' : 'Inactive'}</p> <!-- Use <p> to display the status -->

                   <button type="button" class="save-btn" onclick="window.location.href='ListSliders';">Back to List</button>

                </form>
            </c:if>

            <c:if test="${empty slider}">
                <p class="error-message">Slider not found.</p>
            </c:if>

        </main>

        <%@ include file="./Public/footer.jsp" %>

    </body>
</html>
