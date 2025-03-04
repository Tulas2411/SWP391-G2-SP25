<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<div id="layoutSidenav_content">
    <jsp:include page="header.jsp"></jsp:include>
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">${title}</h1>
            <c:if test="${not empty sessionScope.notification}">
                <div class="alert alert-success alert-dismissible fade show" role="alert" style="text-align: center">
                    ${sessionScope.notification}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <% session.removeAttribute("notification"); %>
            </c:if>
            <c:if test="${not empty sessionScope.notificationErr}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert" style="text-align: center">
                    ${sessionScope.notificationErr}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <% session.removeAttribute("notificationErr");%>
            </c:if>
            <div class="card mb-4">
                <div class="card-body">
                    <table id="datatablesSimple">
                        <div class="container mb-4">
                            <div class="row">
                                <div class="col-md-4">
                                    <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addCustomerModal">
                                        Thêm mới
                                    </button>
                                </div>
                                <form action="${contextPath}/marketing/customer-management" method="GET" class="row g-3">
                                    <div class="col-md-3">
                                        <label for="statusFilter" class="form-label">Trạng thái</label>
                                        <select name="status" id="statusFilter" class="form-select" onchange="this.form.submit()">
                                            <option value="" ${empty param.status ? 'selected' : ''}>Tất cả</option>
                                            <option value="Active" ${param.status eq 'Active' ? 'selected' : ''}>Hoạt động</option>
                                            <option value="Deactive" ${param.status eq 'Deactive' ? 'selected' : ''}>Không hoạt động</option>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        <label for="search" class="form-label">Tìm kiếm</label>
                                        <input type="text" class="form-control" id="search" name="search" value="${param.search}" placeholder="Tên, Email, SĐT">
                                    </div>
                                </form>
                            </div>
                        </div>
                        <thead>
                            <tr>
                                <th>STT</th>
                                <th>ID</th>
                                <th>Họ và tên <a href="?sort=fullName">↑↓</a></th>
                                <th>Giới tính <a href="?sort=gender">↑↓</a></th>
                                <th>Email <a href="?sort=email">↑↓</a></th>
                                <th>Số điện thoại <a href="?sort=phoneNumber">↑↓</a></th>
                                <th>Trạng thái <a href="?sort=status">↑↓</a></th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${customers}" var="u" varStatus="status">
                                <tr>
                                    <td>${status.index + 1}</td>
                                    <td>${u.userID}</td>
                                    <td>${u.firstName} ${u.lastName}</td>
                                    <td>${u.gender}</td>
                                    <td>${u.email}</td>
                                    <td>${u.phoneNumber}</td>
                                    <td>
                                        <span style="color: ${u.status eq 'Active' ? 'green' : 'red'}">
                                            ${u.status eq 'Active' ? 'Hoạt động' : 'Không hoạt động'}
                                        </span>
                                    </td>
                                    <td>
                                        <a class="btn btn-secondary btn-sm" href="${contextPath}/marketing/customer-management?action=detail&id=${u.userID}"><i class="fa fa-eye"></i></a>
                                        <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#editCustomerModal"
                                                data-id="${u.userID}"
                                                data-firstname="${u.firstName}"
                                                data-lastname="${u.lastName}"
                                                data-gender="${u.gender}"
                                                data-email="${u.email}"
                                                data-phonenumber="${u.phoneNumber}"
                                                data-address="${u.address}"
                                                data-status="${u.status}">
                                            <i class="fa fa-pen" style="color: white"></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <!-- Pagination -->
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center">
                            <c:forEach begin="1" end="${totalPages}" var="page">
                                <li class="page-item ${page == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="${contextPath}/marketing/customer-management?page=${page}&status=${param.status}&search=${param.search}">${page}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </main>

    <!-- Add Customer Modal -->
    <div class="modal fade" id="addCustomerModal" tabindex="-1" aria-labelledby="addCustomerModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="${contextPath}/marketing/customer-management" method="POST" class="needs-validation" novalidate>
                    <input type="hidden" name="action" value="add">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addCustomerModalLabel">Thêm Khách Hàng Mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="addFirstName" class="form-label">Tên</label>
                            <input type="text" class="form-control" id="addFirstName" name="firstName" required>
                            <div class="invalid-feedback">Vui lòng nhập tên.</div>
                        </div>
                        <div class="mb-3">
                            <label for="addLastName" class="form-label">Họ</label>
                            <input type="text" class="form-control" id="addLastName" name="lastName" required>
                            <div class="invalid-feedback">Vui lòng nhập họ.</div>
                        </div>
                        <div class="mb-3">
                            <label for="addEmail" class="form-label">Email</label>
                            <input type="email" class="form-control" id="addEmail" name="email" required>
                            <div class="invalid-feedback">Vui lòng nhập email hợp lệ.</div>
                        </div>
                        <div class="mb-3">
                            <label for="addPhoneNumber" class="form-label">Số điện thoại</label>
                            <input type="text" class="form-control" id="addPhoneNumber" name="phoneNumber" required pattern="^0\d{9}$">
                            <div class="invalid-feedback">Số điện thoại phải có 10 chữ số và bắt đầu bằng 0.</div>
                        </div>
                        <div class="mb-3">
                            <label for="addGender" class="form-label">Giới tính</label>
                            <select class="form-select" id="addGender" name="gender" required>
                                <option value="">Chọn giới tính</option>
                                <option value="Male">Nam</option>
                                <option value="Female">Nữ</option>
                            </select>
                            <div class="invalid-feedback">Vui lòng chọn giới tính.</div>
                        </div>
                        <div class="mb-3">
                            <label for="addAddress" class="form-label">Địa chỉ</label>
                            <textarea class="form-control" id="addAddress" name="address" required></textarea>
                            <div class="invalid-feedback">Vui lòng nhập địa chỉ.</div>
                        </div>
                        <input type="hidden" name="role" value="Customer">
                        <input type="hidden" name="status" value="Active">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-success">Thêm</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Customer Modal -->
    <div class="modal fade" id="editCustomerModal" tabindex="-1" aria-labelledby="editCustomerModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="${contextPath}/marketing/customer-management" method="POST" class="needs-validation" novalidate>
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="id" id="editUserId">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editCustomerModalLabel">Chỉnh sửa Khách Hàng</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="editFirstName" class="form-label">Tên</label>
                            <input type="text" class="form-control" id="editFirstName" name="firstName" required>
                            <div class="invalid-feedback">Vui lòng nhập tên.</div>
                        </div>
                        <div class="mb-3">
                            <label for="editLastName" class="form-label">Họ</label>
                            <input type="text" class="form-control" id="editLastName" name="lastName" required>
                            <div class="invalid-feedback">Vui lòng nhập họ.</div>
                        </div>
                        <div class="mb-3">
                            <label for="editEmail" class="form-label">Email</label>
                            <input type="email" class="form-control" id="editEmail" name="email" required>
                            <div class="invalid-feedback">Vui lòng nhập email hợp lệ.</div>
                        </div>
                        <div class="mb-3">
                            <label for="editPhoneNumber" class="form-label">Số điện thoại</label>
                            <input type="text" class="form-control" id="editPhoneNumber" name="phoneNumber" required pattern="^0\d{9}$">
                            <div class="invalid-feedback">Số điện thoại phải có 10 chữ số và bắt đầu bằng 0.</div>
                        </div>
                        <div class="mb-3">
                            <label for="editGender" class="form-label">Giới tính</label>
                            <select class="form-select" id="editGender" name="gender" required>
                                <option value="Male">Nam</option>
                                <option value="Female">Nữ</option>
                            </select>
                            <div class="invalid-feedback">Vui lòng chọn giới tính.</div>
                        </div>
                        <div class="mb-3">
                            <label for="editAddress" class="form-label">Địa chỉ</label>
                            <textarea class="form-control" id="editAddress" name="address" required></textarea>
                            <div class="invalid-feedback">Vui lòng nhập địa chỉ.</div>
                        </div>
                        <div class="mb-3">
                            <label for="editStatus" class="form-label">Trạng thái</label>
                            <select class="form-select" id="editStatus" name="status" required>
                                <option value="Active">Hoạt động</option>
                                <option value="Deactive">Không hoạt động</option>
                            </select>
                            <div class="invalid-feedback">Vui lòng chọn trạng thái.</div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var editCustomerModal = document.getElementById('editCustomerModal');
            editCustomerModal.addEventListener('show.bs.modal', function (event) {
                var button = event.relatedTarget;
                document.getElementById('editUserId').value = button.getAttribute('data-id');
                document.getElementById('editFirstName').value = button.getAttribute('data-firstname');
                document.getElementById('editLastName').value = button.getAttribute('data-lastname');
                document.getElementById('editGender').value = button.getAttribute('data-gender');
                document.getElementById('editEmail').value = button.getAttribute('data-email');
                document.getElementById('editPhoneNumber').value = button.getAttribute('data-phonenumber');
                document.getElementById('editAddress').value = button.getAttribute('data-address');
                document.getElementById('editStatus').value = button.getAttribute('data-status');
            });

            // Bootstrap validation
            (function () {
                'use strict';
                var forms = document.querySelectorAll('.needs-validation');
                Array.prototype.slice.call(forms).forEach(function (form) {
                    form.addEventListener('submit', function (event) {
                        if (!form.checkValidity()) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    }, false);
                });
            })();
        });
    </script>

    <jsp:include page="footer.jsp"></jsp:include>
</div>
</div>
</body>
</html>