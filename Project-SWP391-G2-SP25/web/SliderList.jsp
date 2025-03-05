<%-- 
    Document   : HomePage
    Created on : Jan 18, 2025, 12:47:06 AM
    Author     : Tung Duong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.Category, Model.Products, Model.MarketingPosts"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
        <style>
            main.container {
                max-width: 1200px;
                margin: 20px auto;
                padding: 20px;
                background: #ffebee; /* Nền hồng nhạt */
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            h2 {
                text-align: center;
                color: #d32f2f; /* Màu đỏ đậm */
            }

            form {
                display: flex;
                justify-content: center;
                gap: 10px;
                margin-bottom: 20px;
            }

            form input, form select, form button {
                padding: 8px 12px;
                border: 1px solid #d32f2f;
                border-radius: 5px;
            }

            form button {
                background: #d32f2f;
                color: white;
                cursor: pointer;
            }

            form button:hover {
                background: #b71c1c;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background: white;
                border-radius: 10px;
                overflow: hidden;
            }

            table, th, td {
                border: 1px solid #d32f2f;
            }

            th, td {
                padding: 10px;
                text-align: center;
            }

            th {
                background: #d32f2f;
                color: white;
            }

            tr:nth-child(even) {
                background: #ffebee;
            }

            a {
                color: #d32f2f;
                text-decoration: none;
                font-weight: bold;
            }

            a:hover {
                color: #b71c1c;
                text-decoration: underline;
            }
        </style>
    </head>

    <body>
        <%@ include file="./Public/header.jsp" %>


        <main class="container">
            <h2>Sliders List aa</h2>

            <!-- Filter and Search -->
            <form method="GET" action="SlidersListController">
                <input type="text" name="search" placeholder="Search by title or backlink" value="${param.search}">
                <select name="status">
                    <option value="">All Status</option>
                    <option value="active" ${param.status == 'active' ? 'selected' : ''}>Active</option>
                    <option value="inactive" ${param.status == 'inactive' ? 'selected' : ''}>Inactive</option>
                </select>
                <button type="submit">Filter</button>
            </form>

            <!-- Sliders Table -->
            <table border="1">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Image</th>
                        <th>TITLE</th>
                        <th>Backlink</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="slider" items="${sliders}">
                        <tr>

                            <td>${slider.getSliderID()}</td>
                            <td><img src="${slider.image}" width="100"></td>
                            <td>${slider.title}</td>
                            <td><a href="${slider.backlink}">${slider.backlink}</a></td>
                            <td>${slider.status}</td>
                            <td>
                             
                                <form action="DetailSlider" method="get">
                                    <input type="hidden" name="sliderID" value="${slider.sliderID}">
                                    <button type="submit">Edit</button>
                                </form>

                                <form action="ToggleSliderStatusController" method="post">
                                    <input type="hidden" name="id" value="${slider.sliderID}">
                                    <button type="submit">
                                        ${slider.status == 'active' ? 'Hide' : 'Show'}
                                    </button>
                                </form>

                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Pagination -->
            <!--        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="SlidersListController?page=${currentPage - 1}&search=${param.search}&status=${param.status}">Previous</a>
            </c:if>
            Page ${currentPage} of ${totalPages}
            <c:if test="${currentPage < totalPages}">
                <a href="SlidersListController?page=${currentPage + 1}&search=${param.search}&status=${param.status}">Next</a>
            </c:if>
        </div>-->
        </main>

        <%@ include file="./Public/footer.jsp" %>
    </body>
</html>
