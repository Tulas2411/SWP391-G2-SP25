<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<head>
    <meta charset="UTF-8">
    <title>Order Details</title>
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

    <!-- Internal CSS -->
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f7fa;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            margin: 20px auto;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
        }

        section {
            margin-bottom: 30px;
        }

        section h3 {
            color: #2d3e50;
            font-size: 1.5em;
            border-bottom: 2px solid #e2e2e2;
            padding-bottom: 10px;
        }

        p {
            font-size: 1.1em;
            line-height: 1.8;
            margin: 10px 0;
        }

        strong {
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table th, table td {
            padding: 12px;
            text-align: left;
            border: 1px solid #e2e2e2;
        }

        table th {
            background-color: #f4f7fa;
            font-weight: bold;
        }

        table td img {
            width: 50px;
        }

        select, textarea {
            width: 100%;
            padding: 8px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #0056b3;
        }

        form {
            margin-bottom: 20px;
        }

        /* Bill Table */
        .bill-table {
            margin-top: 20px;
            border: 1px solid #e2e2e2;
            border-radius: 4px;
            overflow: hidden;
        }

        .bill-table th, .bill-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #e2e2e2;
        }

        .bill-table th {
            background-color: #f4f7fa;
        }

        /* Receiver Information */
        .receiver-info {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 5px;
            margin-top: 20px;
        }

        .receiver-info p {
            margin: 8px 0;
            font-size: 1.1em;
        }

        .status-update {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .status-update select, .status-update button {
            width: auto;
        }
    </style>
</head>

<body>
    <jsp:include page="header.jsp"></jsp:include>

        <main class="container">
            <h2>Order Details</h2>

            <!-- Basic Order Information -->
            <section>
                <h3>Order Information</h3>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

            <div class="bill-table">
                <table border="1" cellspacing="0" cellpadding="8">
                    <thead>
                        <tr>
                            <th>Order Detail ID</th>
                           
                            
                            <th>Product Name</th>
                            <th>Quantity</th>
                            <th>Unit Price</th>
                           
                            <th>Original Price</th>
                            <th>Image</th>
                            <th>Status</th>
                             <th>Total Cost</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="orderDetail" items="${orderDetailsList}">
                            <tr>
                                <td>${orderDetail.orderDetailID}</td>
                              
                                <td>${orderDetail.nameProduct}</td>
                                <td>${orderDetail.quantity}</td>
                                <td style="color: red";>${orderDetail.price}</td>
                                
                                <td style="color: gray; text-decoration: line-through;">${orderDetail.priceProduct}</td>

                                <td>
                                    <img src="${orderDetail.imgProduct}" alt="Product Image" width="100">
                                </td>
                                <td>${orderDetail.desProduct}</td>
                                <td>${orderDetail.quantity * orderDetail.price}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

        </section>

        <!-- Receiver Information -->
        <section class="receiver-info">
            <h3>Receiver Information</h3>
            <p><strong>Order Date:</strong> ${orders.orderDate}</p>
            <p><strong>Delivery Address:</strong> ${orders.deliveryAddress}</p>
            <p><strong>Status:</strong> ${orders.status}</p>
            <p><strong>Total Amount:</strong> ${orders.totalAmount}</p>
            <p><strong>Bill of Lading:</strong> ${orders.billOfLading}</p>
        </section>

        <!-- Ordered Products -->
        
           
          

        <!-- Order Management -->

        <section>
            <h3>Manage Order</h3>
            <form method="POST" action="OrderDetail">

                <input type="hidden" name="orderId" value="${orders.orderID}">

                <label for="status">Status:</label>
                <select name="status">
                    <option value="Pending" ${orders.status == 'Pending' ? 'selected' : ''}>Pending</option>
                    <option value="Processing" ${orders.status == 'Processing' ? 'selected' : ''}>Processing</option>
                    <option value="Shipped" ${orders.status == 'Shipped' ? 'selected' : ''}>Shipped</option>
                    <option value="Completed" ${orders.status == 'Completed' ? 'selected' : ''}>Completed</option>
                    <option value="Cancelled" ${orders.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                </select>

                <button type="submit">Change</button>
            </form>


            <!--            <form method="POST" action="UpdateSaleNotesController">
                            <input type="hidden" name="orderId" value="${orders.orderID}">
                            <label for="notes">Sale Notes:</label>
                            <textarea name="notes"></textarea>
                            <button type="submit">Save Notes</button>
                        </form>-->
        </section>


        <!-- Assign Order (for Sale Manager) -->
        <c:if test="${user.role == 'Manager'}">
            <section>
                <h3>Assign Order</h3>
                <form method="POST" action="AssignOrderController">
                    <input type="hidden" name="orderId" value="${order.id}">
                    <label for="sale">Assign to Sale:</label>
                    <select name="saleId">
                        <c:forEach var="sale" items="${salesList}">
                            <option value="${sale.id}" ${sale.id == order.sale.id ? 'selected' : ''}>${sale.name}</option>
                        </c:forEach>
                    </select>
                    <button type="submit">Assign</button>
                </form>
            </section>
        </c:if>
    </main>

    <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
