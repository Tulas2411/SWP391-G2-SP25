<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.Category, Model.Products, Model.MarketingPosts"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết Slider</title>
    <link rel="shortcut icon" href="assets/img/S4EWhite.PNG" type="image/x-icon" />
    <link rel="stylesheet" href="assets/css/reset.css" />
    <link rel="stylesheet" href="assets/css/base.css" />
    <link rel="stylesheet" href="assets/css/main_PC.css" />
    <link rel="stylesheet" href="assets/css/main_Tablet.css" />
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
    <link rel="stylesheet" href="assets/fonts/fontawesome-free-6.0.0-web/css/all.css" />
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap');

            body {
                font-family: 'Roboto', sans-serif;
            }
        .slider-form {
            display: flex;
            flex-direction: column;
            gap: 10px;
            max-width: 450px;
            margin: 20px auto;
            padding: 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
        }
        .slider-form label {
            font-weight: bold;
        }
        .slider-form input, .slider-form select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .slider-form img {
            display: block;
            margin: 10px auto;
            width: 100%;
            max-height: 200px;
            object-fit: contain;
            border-radius: 5px;
        }
        .btn {
            background-color: #3498db;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        .btn:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp"></jsp:include>

<main class="container">
    <c:choose>
        <c:when test="${not empty slider}">
            <form action="DetailSlider" method="post" class="slider-form">
                <input type="hidden" name="sliderID" value="${slider.getSliderID()}">
                <input type="hidden" name="currentImage" value="${slider.getImage()}"> 

                <label for="title">Tiêu đề:</label>
                <input type="text" id="title" name="title" value="${slider.title}" required>
                
                <label>Hình ảnh hiện tại:</label>
                <img src="${slider.getImage()}" alt="Slider Image">
                
                <label for="newImageURL">URL hình ảnh mới:</label>
                <input type="text" id="newImageURL" name="newImageURL" value="${slider.getImage()}" required>

                <label for="backlink">Liên kết:</label>
                <input type="text" id="backlink" name="backlink" value="${slider.backlink}" required>

                <label for="status">Trạng thái:</label>
                <select id="status" name="status">
                    <option value="active" ${slider.status == 'active' ? 'selected' : ''}>Hoạt động</option>
                    <option value="inactive" ${slider.status == 'inactive' ? 'selected' : ''}>Không hoạt động</option>
                </select>

                <button type="submit" class="btn">Lưu thay đổi</button>
                <button type="button" class="btn" onclick="window.location.href='ListSliders';">Quay lại danh sách</button>
            </form>
        </c:when>
        <c:otherwise>
            <p class="error-message">Không tìm thấy slider.</p>
        </c:otherwise>
    </c:choose>
</main>

<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>