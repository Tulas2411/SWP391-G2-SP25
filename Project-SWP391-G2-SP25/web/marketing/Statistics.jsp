<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thống kê</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            body {
                background-color: #f8f9fa;
            }
            .stat-table {
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
                padding: 20px;
                margin-bottom: 30px;
                height: 400px;
                display: flex;
                flex-direction: column;
            }
            .table-container {
                flex-grow: 1;
                overflow-y: auto;
            }
            .table th {
                background-color: #007bff;
                text-align: center;
            }
            .table td {
                text-align: center;
            }
            h2 {
                color: #007bff;
                text-align: center;
                margin-bottom: 15px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>

            <main class="container mt-4">
                <div class="row">
                    <!-- Top 5 bài viết có lượt xem cao nhất -->
                    <div class="col-md-6">
                        <div class="stat-table">
                            <h2>📚 Top 5 bài viết</h2>
                            <div class="table-container">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>STT</th>
                                            <th>Tiêu đề</th>
                                            <th>Lượt xem</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="art" items="${topViewedArticles}" varStatus="loop">
                                        <tr>
                                            <td>${loop.index + 1}</td>
                                            <td>${art.title}</td>
                                            <td>${art.numberOfAccess}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Top 5 sản phẩm bán chạy nhất -->
                <div class="col-md-6">
                    <div class="stat-table">
                        <h2>🛒 Top 5 sản phẩm bán chạy</h2>
                        <div class="table-container">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>STT</th>
                                        <th>Sản phẩm</th>
                                        <th>Số lượng bán</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="sProduct" items="${topSellingProducts}" varStatus="loop">
                                        <tr>
                                            <td>${loop.index + 1}</td>
                                            <td>${sProduct.productName}</td>
                                            <td>${sProduct.totalSold}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Top 5 khách hàng chi tiêu nhiều nhất -->
                <div class="col-md-6">
                    <div class="stat-table">
                        <h2>👤 Top 5 khách hàng</h2>
                        <div class="table-container">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>STT</th>
                                        <th>Khách hàng</th>
                                        <th>Tổng chi tiêu</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="cus" items="${topSpendingCustomers}" varStatus="loop">
                                        <tr>
                                            <td>${loop.index + 1}</td>
                                            <td>${cus.customerName}</td>
                                            <td>
                                                <fmt:formatNumber value="${cus.totalSpent}" groupingUsed="true"/> ₫
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Top 5 sản phẩm được đánh giá cao nhất -->
                <div class="col-md-6">
                    <div class="stat-table">
                        <h2>⭐ Top 5 sản phẩm đánh giá cao</h2>
                        <div class="table-container">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>STT</th>
                                        <th>Sản phẩm</th>
                                        <th>Đánh giá trung bình</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="pRate" items="${topRatedProducts}" varStatus="loop">
                                        <tr>
                                            <td>${loop.index + 1}</td>
                                            <td>${pRate.productName}</td>
                                            <td>${pRate.avgRating} ⭐</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
