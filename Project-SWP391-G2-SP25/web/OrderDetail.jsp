<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <%@ include file="./Public/header.jsp" %>

    <main class="container">
        <h2>Order Details</h2>

        <!-- Basic Order Information -->
        <section>
            <h3>Order Information</h3>
            <div class="bill-table">
                <table>
                    <tr>
                        <th>Order ID</th>
                        <td>${orderDetails.orderDetailID}</td>
                    </tr>
                    <tr>
                        <th>Order</th>
                        <td>${orderDetails.orderID}</td>
                    </tr>
                    <tr>
                        <th>Product</th>
                        <td>${orderDetails.productID}</td>
                    </tr>
                    <tr>
                        <th>Quantity</th>
                        <td>${orderDetails.quantity}</td>
                    </tr>
                    <tr>
                        <th>Order Date</th>
                        <td>${orderDetails.price}</td>
                    </tr>
                    <tr>
                        <th>Total Cost</th>
                        <td>${orderDetails.productID}</td>
                    </tr>
                    <tr>
                        <th>Sale Name</th>
                        <td>${orderDetails.productID}</td>
                    </tr>
                    <tr>
                        <th>Status</th>
                        <td>${orderDetails.productID}</td>
                    </tr>
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
        <section>
            <h3>Ordered Products</h3>
            <table>
                <thead>
                    <tr>
                        <th>Thumbnail</th>
                        <th>cartItemID</th>
                        <th>cartID</th>
                        <th>productID</th>
                        <th>Quantity</th>

                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${cartItems}">
                        <tr>
                            <td><img src="" width="50"></td>
                            <td>${item.cartItemID}</td>
                            <td>${item.cartID}</td>
                            <td>$${item.productID}</td>
                            <td>${item.quantity}</td>

                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </section>

        <!-- Order Management -->

        <section>
            <h3>Manage Order</h3>
            <form method="POST" action="UpStatus">
              
                <input type="text" name="orderId" value="${orders.orderID}">

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


            <form method="POST" action="UpdateSaleNotesController">
                <input type="hidden" name="orderId" value="${orders.orderID}">
                <label for="notes">Sale Notes:</label>
                <textarea name="notes"></textarea>
                <button type="submit">Save Notes</button>
            </form>
        </section>


        <!-- Assign Order (for Sale Manager) -->
        <c:if test="${user.role == 'Sale Manager'}">
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

    <%@ include file="./Public/footer.jsp" %>
</body>
</html>
