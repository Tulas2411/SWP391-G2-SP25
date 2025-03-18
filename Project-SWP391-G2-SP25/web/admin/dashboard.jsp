<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<jsp:include page="header.jsp"></jsp:include>

<main>
    <div class="container-fluid px-4">
        <h1 class="mt-4">Dashboard</h1>
        
        <!-- Date Range Form -->
        <div class="row mb-4">
            <div class="col-md-12">
                <form action="${contextPath}/admin/dashboard" method="get" class="form-inline">
                    <label for="startDate">Start Date:</label>
                    <input type="date" id="startDate" name="startDate" value="${startDate}" required />
                    &nbsp;&nbsp;
                    <label for="endDate">End Date:</label>
                    <input type="date" id="endDate" name="endDate" value="${endDate}" required />
                    &nbsp;&nbsp;
                    <button type="submit" class="btn btn-primary">Filter</button>
                </form>
            </div>
        </div>
        
        <!-- Dashboard Cards -->
        <div class="row">
            <!-- Successful Orders Card -->
            <div class="col-xl-3 col-md-6">
                <div class="card bg-primary text-white mb-4">
                    <div class="card-body">
                        Successful Orders: ${orderStats.successOrders}
                    </div>
                    <div class="card-footer d-flex align-items-center justify-content-between">
                        
                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                    </div>
                </div>
            </div>
            <!-- Cancelled Orders Card -->
            <div class="col-xl-3 col-md-6">
                <div class="card bg-warning text-white mb-4">
                    <div class="card-body">
                        Cancelled Orders: ${orderStats.cancelledOrders}
                    </div>
                    <div class="card-footer d-flex align-items-center justify-content-between">
                        
                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                    </div>
                </div>
            </div>
            <!-- Submitted Orders Card -->
            <div class="col-xl-3 col-md-6">
                <div class="card bg-success text-white mb-4">
                    <div class="card-body">
                        Submitted Orders: ${orderStats.submittedOrders}
                    </div>
                    <div class="card-footer d-flex align-items-center justify-content-between">
                        
                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                    </div>
                </div>
            </div>
            <!-- Total Revenue Card -->
            <div class="col-xl-3 col-md-6">
                <div class="card bg-danger text-white mb-4">
                    <div class="card-body">
                        Total Revenue: <fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="$"/>
                    </div>
                    <div class="card-footer d-flex align-items-center justify-content-between">
                        
                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Order Trends Table -->
        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-table me-1"></i>
                Order Trends (from ${startDate} to ${endDate})
            </div>
            <div class="card-body">
                <table class="table table-bordered" id="trendTable">
                    <thead>
                        <tr>
                            <th>Order Day</th>
                            <th>Total Orders</th>
                            <th>Successful Orders</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="trend" items="${orderTrendList}">
                            <tr>
                                <td><fmt:formatDate value="${trend.orderDay}" pattern="yyyy-MM-dd"/></td>
                                <td>${trend.totalOrders}</td>
                                <td>${trend.successOrders}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        
        
    </div>
</main>

<jsp:include page="footer.jsp"></jsp:include>
