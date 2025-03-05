<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
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
</head>
<body>
    <%@ include file="./Public/header.jsp" %>
    
    <main class="container">
        <h2>Order Details</h2>
        
        <!-- Basic Order Information -->
        <section>
            <h3>Order Information</h3>
            <p><strong>Order ID:</strong> ${order.id}</p>
            <p><strong>Customer Name:</strong> ${order.customer.fullName}</p>
            <p><strong>Email:</strong> ${order.customer.email}</p>
            <p><strong>Mobile:</strong> ${order.customer.mobile}</p>
            <p><strong>Order Date:</strong> ${order.orderDate}</p>
            <p><strong>Total Cost:</strong> $${order.totalCost}</p>
            <p><strong>Sale Name:</strong> ${order.sale.name}</p>
            <p><strong>Status:</strong> ${order.status}</p>
        </section>

        <!-- Receiver Information -->
        <section>
            <h3>Receiver Information</h3>
            <p><strong>Full Name:</strong> ${order.receiver.fullName}</p>
            <p><strong>Gender:</strong> ${order.receiver.gender}</p>
            <p><strong>Email:</strong> ${order.receiver.email}</p>
            <p><strong>Mobile:</strong> ${order.receiver.mobile}</p>
            <p><strong>Address:</strong> ${order.receiver.address}</p>
        </section>

        <!-- Ordered Products -->
        <section>
            <h3>Ordered Products</h3>
            <table border="1">
                <thead>
                    <tr>
                        <th>Thumbnail</th>
                        <th>Product Name</th>
                        <th>Category</th>
                        <th>Unit Price</th>
                        <th>Quantity</th>
                        <th>Total Cost</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${order.items}">
                        <tr>
                            <td><img src="${item.product.thumbnail}" width="50"></td>
                            <td>${item.product.name}</td>
                            <td>${item.product.category}</td>
                            <td>$${item.unitPrice}</td>
                            <td>${item.quantity}</td>
                            <td>$${item.totalCost}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </section>
        
        <!-- Order Management -->
        <c:if test="${user.role == 'Sale Manager' || user.id == order.sale.id}">
            <section>
                <h3>Manage Order</h3>
                <form method="POST" action="UpdateOrderStatusController">
                    <input type="hidden" name="orderId" value="${order.id}">
                    <label for="status">Status:</label>
                    <select name="status">
                        <option value="Pending" ${order.status == 'Pending' ? 'selected' : ''}>Pending</option>
                        <option value="Processing" ${order.status == 'Processing' ? 'selected' : ''}>Processing</option>
                        <option value="Shipped" ${order.status == 'Shipped' ? 'selected' : ''}>Shipped</option>
                        <option value="Completed" ${order.status == 'Completed' ? 'selected' : ''}>Completed</option>
                        <option value="Cancelled" ${order.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                    </select>
                    <button type="submit">Update</button>
                </form>

                <form method="POST" action="UpdateSaleNotesController">
                    <input type="hidden" name="orderId" value="${order.id}">
                    <label for="notes">Sale Notes:</label>
                    <textarea name="notes">${order.saleNotes}</textarea>
                    <button type="submit">Save Notes</button>
                </form>
            </section>
        </c:if>
        
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