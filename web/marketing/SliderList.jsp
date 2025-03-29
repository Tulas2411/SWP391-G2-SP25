<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.Category, Model.Products, Model.MarketingPosts"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<jsp:include page="header.jsp"></jsp:include>

    <main>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap');

            body {
                font-family: 'Roboto', sans-serif;
            }
        </style>
        <div class="container-fluid px-4">
            <h1 class="mt-4">Bảng điều khiển</h1>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item active">Quản lý Sliders</li>
            </ol>

            <!-- Bộ lọc và tìm kiếm -->
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-filter me-1"></i> Lọc Sliders
                </div>
                <div class="card-body">
                    <form method="post" action="ListSliders" class="row g-3">
                        <div class="col-md-5">
                            <input type="text" name="search" class="form-control" placeholder="Tìm theo tiêu đề hoặc backlink" value="${param.search}">
                    </div>
                    <div class="col-md-3">
                        <select name="status" class="form-control">
                            <option value="">Tất cả trạng thái</option>
                            <option value="active" ${param.status == 'active' ? 'selected' : ''}>Hoạt động</option>
                            <option value="inactive" ${param.status == 'inactive' ? 'selected' : ''}>Không hoạt động</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-success">Lọc</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Bảng danh sách Sliders -->
        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-table me-1"></i> Danh sách Sliders
            </div>

            <form action="AddSlider" method="get" class="slider-form">
                <button type="submit" class="btn btn-success">Thêm Slider</button>
            </form>


            <div class="card-body">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Hình ảnh</th>
                            <th>Tiêu đề</th>
                            <th>Backlink</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
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
                                    <a href="DetailSlider?sliderID=${slider.sliderID}" class="btn btn-warning btn-sm">Chỉnh sửa</a>
                                    <a href="ShowDetailSlider?sliderID=${slider.sliderID}" class="btn btn-info btn-sm">Xem chi tiết</a>
                                    <a href="DeleteSlider?sliderID=${slider.sliderID}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa slider này không?');">Xóa</a>
                                </td>


                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Phân trang -->
        <div class="d-flex justify-content-center">
            <c:if test="${currentPage > 1}">
                <a href="ListSliders?page=${currentPage - 1}&search=${param.search}&status=${param.status}" class="btn btn-secondary me-2">Trước</a>
            </c:if>
            ${currentPage} Trên ${totalPages} Trang
            <c:if test="${currentPage < totalPages}">
                <a href="ListSliders?page=${currentPage + 1}&search=${param.search}&status=${param.status}" class="btn btn-secondary ms-2">Tiếp</a>
            </c:if>
        </div>
    </div>
</main>

<jsp:include page="footer.jsp"></jsp:include>