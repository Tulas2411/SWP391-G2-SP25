<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<jsp:include page="header.jsp"></jsp:include>
    <main>
        <div class="container-fluid px-4">
            <h1 class="mt-4">${title}</h1>
        <c:if test="${not empty sessionScope.notification}">
            <div class="alert alert-success alert-dismissible fade show" role="alert" style="text-align: center">
                ${sessionScope.notification}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <%
                session.removeAttribute("notification");
            %>
        </c:if>
        <c:if test="${not empty sessionScope.notificationErr}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert" style="text-align: center">
                ${sessionScope.notificationErr}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <%
                session.removeAttribute("notificationErr");
            %>
        </c:if>
        <div class="card mb-4">
            <div class="card-body">
                <table id="datatablesSimple">
                    <div class="container mb-4">
                        <div class="row">
                            <div class="col md-4">
                                <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addPDModal">
                                    Thêm mới
                                </button>
                            </div>
                            <form action="${contextPath}/marketing/customer-management" method="GET" class="row g-3">
                                <div class="col-md-3">
                                    <label for="genderFilter" class="form-label">Trạng thái</label>
                                    <select name="category" id="genderFilter" class="form-select" onchange="this.form.submit()">
                                        <option value="" ${empty param.status ? 'selected' : ''}>Tất cả</option>
                                        <c:forEach items="${listCategory}" var="c">
                                            <option value="${c.customerID}" ${param.category eq c.customerID ? 'selected' : ''}>${c.categoryName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </form>
                        </div>
                    </div>