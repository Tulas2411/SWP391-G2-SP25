<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thêm Slider</title>
        <link rel="stylesheet" href="assets/css/style.css">
        <style>
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
                <form action="AddSlider" method="post" class="slider-form">
                    <label for="title">Tiêu đề:</label>
                    <input type="text" id="title" name="title" required>

                    <label for="image">URL hình ảnh:</label>
                    <input type="text" id="image" name="image" required>

                    <label for="backlink">Liên kết:</label>
                    <input type="text" id="backlink" name="backlink" required>

                    <label for="status">Trạng thái:</label>
                    <select id="status" name="status">
                        <option value="active">Hoạt động</option>
                        <option value="inactive">Không hoạt động</option>
                    </select>
                    <label for="blog">Blog:</label>
                    <select id="blog" name="blogID">
                    <c:forEach var="blog" items="${blogs}">
                        <option value="${blog.blogID}">${blog.title}</option>
                    </c:forEach>
                </select>

                <label for="product">Chọn sản phẩm:</label>
                <select id="product" name="productId">
                    <c:forEach var="product" items="${productList}">
                        <option value="${product.productID}">${product.productName}</option>
                    </c:forEach>
                </select>

                <button type="submit" class="btn">Thêm Slider</button>
                <button type="button" class="btn" onclick="window.location.href = 'ListSliders';">Quay lại danh sách</button>
            </form>
        </main>
        <jsp:include page="footer.jsp"></jsp:include>

    </body>
</html>
