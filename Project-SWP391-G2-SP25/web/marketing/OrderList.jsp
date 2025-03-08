<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Orders List</title>
    <link rel="stylesheet" href="assets/css/style.css">
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
            background-color: #f4f4f4;
            color: #333;
            margin: 0;
            padding: 20px;
        }
        main.container {
            max-width: 1200px;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #444;
        }
        form {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            justify-content: center;
            margin-bottom: 20px;
        }
        input, select, button {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        button {
            background: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background: #0056b3;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background: #007bff;
            color: white;
        }
        .pagination {
            text-align: center;
            margin-top: 20px;
        }
        .pagination a {
            padding: 8px 12px;
            margin: 0 5px;
            background: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        .pagination a:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>
    
    <main class="container">
        <h2>Orders List</h2>
        
        <!-- Filter and Search -->
        <form method="GET" action="OrdersList">
            <input type="text" name="search" placeholder="Search by Order ID or Customer Name" value="${param.search}">
            <input type="date" name="fromDate" value="${param.fromDate}">
            <input type="date" name="toDate" value="${param.toDate}">
<!--            <input type="text" name="saleName" placeholder="Sale Name" value="${param.saleName}">-->
            <select name="status">
                <option value="">All Status</option>
                <option value="pending" ${param.status == 'pending' ? 'selected' : ''}>Pending</option>
                <option value="Cancelled" ${param.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                <option value="Shipped" ${param.status == 'Shipped' ? 'selected' : ''}>Shipped</option>
                <option value="Delivered" ${param.status == 'Delivered' ? 'selected' : ''}>Delivered</option>
                <option value="Processing" ${param.status == 'Processing' ? 'selected' : ''}>Processing</option>
            </select>
            <button type="submit">Filter</button>
        </form>
        
        <!-- Orders Table -->
       <table border="1">
    <thead>
        <tr>
            <th>ID</th>
            <th>Ordered Date</th>
            <th>Customer Name</th>
            <th>Address</th>
            
            <th>Total Cost</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="order" items="${orders}">
            <tr>
                <td><button onclick="window.location.href='OrderDetail?id=${order.orderID}'">${order.orderID}</button></td>
                <td>${order.orderDate}</td>
                <td>${order.customerFirstName} ${order.customerLastName}</td>
                <td>${order.deliveryAddress}</td>
                <td>${order.totalAmount}</td>
                <td>${order.status}</td>
                <td>
                    <button onclick="window.location.href='OrderDetail?id=${order.orderID}'">Chi tiết</button>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

        <!-- Pagination -->
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="OrdersList?page=${currentPage - 1}&search=${param.search}&fromDate=${param.fromDate}&toDate=${param.toDate}&saleName=${param.saleName}&status=${param.status}">Previous</a>
            </c:if>
            Page ${currentPage} of ${totalPages}
            <c:if test="${currentPage < totalPages}">
                <a href="OrdersList?page=${currentPage + 1}&search=${param.search}&fromDate=${param.fromDate}&toDate=${param.toDate}&saleName=${param.saleName}&status=${param.status}">Next</a>
            </c:if>
        </div>
    </main>
    
    <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>