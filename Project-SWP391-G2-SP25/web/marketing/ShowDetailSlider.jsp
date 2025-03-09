<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.Category, Model.Products, Model.MarketingPosts"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="header.jsp"></jsp:include>

<style>
    body {
        font-family: 'Roboto', sans-serif;
        background-color: #eef1f7;
        margin: 0;
        padding: 0;
    }

    .container-fluid {
        max-width: 1100px;
        margin: 30px auto;
        padding: 20px;
        background: white;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    .card-header {
        font-size: 20px;
        font-weight: bold;
        padding: 15px;
        background: #007bff;
        color: white;
        border-radius: 10px 10px 0 0;
    }

    .table {
        width: 100%;
        margin-top: 10px;
        border-radius: 10px;
        overflow: hidden;
    }

    .table th, .table td {
        padding: 12px;
        text-align: center;
        border-bottom: 1px solid #ddd;
    }

    .table th {
        background: #007bff;
        color: white;
    }

    .btn {
        padding: 8px 12px;
        border-radius: 5px;
        font-weight: bold;
        transition: background 0.3s;
    }

    .btn-warning {
        background: #f39c12;
        color: white;
    }

    .btn-warning:hover {
        background: #e67e22;
    }

    .btn-info {
        background: #3498db;
        color: white;
    }

    .btn-info:hover {
        background: #2980b9;
    }
</style>

<main>
    <div class="container-fluid">
        <h1 class="mt-4">Quản lý Sliders</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item active">Danh sách Sliders</li>
        </ol>

        <c:if test="${not empty slider}">
            <div class="card mb-4">
                <div class="card-body">
                    <h2>${slider.title}</h2>
                    <img src="${slider.getImage()}" alt="Slider Image" style="max-width: 100%; height: auto; border-radius: 8px; margin-top: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);" />
                    <p><strong>Backlink:</strong> <a href="${slider.backlink}">${slider.backlink}</a></p>
                    <p><strong>Trạng thái:</strong> ${slider.status == 'active' ? 'Hoạt động' : 'Không hoạt động'}</p>
                    <button type="button" class="btn btn-secondary" onclick="window.location.href='ListSliders';">Quay lại danh sách</button>
                </div>
            </div>
        </c:if>

     
    </div>
</main>

<jsp:include page="footer.jsp"></jsp:include>
