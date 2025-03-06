<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Feedback List</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <!-- Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="mb-4">Feedback List</h2>
            <!-- Form lọc và tìm kiếm -->
            <form method="get" action="reviews" class="form-inline mb-3">
                <div class="form-group mr-2">
                    <label for="productName" class="mr-2">Product Name:</label>
                    <input type="text" name="productName" value="${param.productName}" class="form-control">
                </div>
                <div class="form-group mr-2">
                    <label for="rating" class="mr-2">Rating:</label>
                    <select name="rating" class="form-control">
                        <option value="">All</option>
                        <option value="5" ${param.rating == '5' ? 'selected' : ''}>5 stars</option>
                        <option value="4" ${param.rating == '4' ? 'selected' : ''}>4 stars</option>
                        <option value="3" ${param.rating == '3' ? 'selected' : ''}>3 stars</option>
                        <option value="2" ${param.rating == '2' ? 'selected' : ''}>2 stars</option>
                        <option value="1" ${param.rating == '1' ? 'selected' : ''}>1 star</option>
                    </select>
                    <label for="status" class="mr-2">Status:</label>
                    <select name="status" class="form-control">
                        <option value="">All</option>
                        <option value="active" ${param.status == 'active' ? 'selected' : ''}>Active</option>
                        <option value="inactive" ${param.status == 'inactive' ? 'selected' : ''}>Inactive</option>
                    </select>
                </div>
                <div class="form-group mr-2">
                    <label for="search" class="mr-2">Search:</label>
                    <input type="text" name="search" value="${param.search}" class="form-control">
                </div>
                <button type="submit" class="btn btn-primary">Filter</button>
            </form>

            <!-- Bảng hiển thị danh sách feedbacks -->
            <table class="table table-hover">
                <thead class="thead-dark">
                    <tr>
                        <th>
                            <a href="?sortColumn=userName&sortOrder=${param.sortOrder == 'asc' ? 'desc' : 'asc'}" class="text-white">Full Name</a>
                        </th>
                        <th>
                            <a href="?sortColumn=productName&sortOrder=${param.sortOrder == 'asc' ? 'desc' : 'asc'}" class="text-white">Product Name</a>
                        </th>
                        <th>
                            <a href="?sortColumn=rating&sortOrder=${param.sortOrder == 'asc' ? 'desc' : 'asc'}" class="text-white">Rating</a>
                        </th>
                        <th>Comment</th>
                        <th>Review Date</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="review" items="${reviewsList}">
                        <tr>
                            <td>${review.userName}</td>
                            <td>${review.productName}</td>
                            <td>${review.rating}</td>
                            <td>${review.comment}</td>
                            <td>${review.reviewDate}</td>  
                            <td>${review.status}</td>
                            <td>
                                <button class="btn btn-info btn-sm view-detail" 
                                        data-reviewid="${review.reviewID}" 
                                        data-username="${review.userName} "
                                        data-email="${review.email}" 
                                        data-phoneNumber="${review.phoneNumber}" 
                                        data-productname="${review.productName}" 
                                        data-rating="${review.rating}" 
                                        data-comment="${review.comment}" 
                                        data-status="${review.status}">
                                    View
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>


            <!-- Phân trang -->
            <div class="pagination-container">
                <c:if test="${currentPage > 1}">
                    <a href="reviews?page=${currentPage - 1}" class="pagination-btn">Previous</a>
                </c:if>

                <span>Page ${currentPage}</span>

                <c:if test="${reviewsList.size() == limit}">
                    <a href="reviews?page=${currentPage + 1}" class="pagination-btn">Next</a>
                </c:if>
            </div>




            <style>
                .table thead th a {
                    text-decoration: none;
                    color: inherit;
                }
                .table tbody tr:hover {
                    background-color: #f1f1f1;
                }
            </style>
            <style>
                .pagination-container {
                    position: fixed;
                    bottom: 20px;
                    right: 20px;
                    text-align: right;
                }
                .pagination-btn {
                    padding: 8px 12px;
                    background-color: #007bff;
                    color: white;
                    border-radius: 5px;
                    text-decoration: none;
                    margin-left: 5px;
                }
                .pagination-btn:hover {
                    background-color: #0056b3;
                }
                .pagination-btn:disabled {
                    background-color: #cccccc;
                }
            </style>

            <!-- Modal -->
            <div class="modal fade" id="feedbackDetailModal" tabindex="-1" aria-labelledby="feedbackDetailModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="feedbackDetailModalLabel">Feedback Details</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p><strong>Full Name:</strong> <span id="modalUserName"></span></p>
                            <p><strong>Email:</strong> <span id="modalEmail"></span></p>
                            <p><strong>Phone Number:</strong> <span id="modalPhoneNumber"></span></p>
                            <p><strong>Product:</strong> <span id="modalProductName"></span></p>
                            <p><strong>Rating:</strong> <span id="modalRating"></span></p>
                            <p><strong>Feedback:</strong> <span id="modalComment"></span></p>
                            <p><strong>Status:</strong> 
                                <select id="modalStatus" class="form-control">
                                    <option value="Active">Active</option>
                                    <option value="Inactive">Inactive</option>
                                </select>
                            </p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary" id="updateStatusBtn">Update Status</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Thêm thư viện jQuery và Bootstrap JS -->
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

            <script>
                $(document).ready(function () {
                    var currentReviewID; // Lưu trữ reviewID của feedback đang được xem

                    // Xử lý sự kiện khi nhấn nút View
                    $('.view-detail').on('click', function () {
                        currentReviewID = $(this).data('reviewid'); // Lấy reviewID
                        var fullName = $(this).data('username');
                        var email = $(this).data('email');
                        var phoneNumber = $(this).data('phonenumber');
                        var productName = $(this).data('productname');
                        var rating = $(this).data('rating');
                        var comment = $(this).data('comment');
                        var status = $(this).data('status');

                        // Đặt dữ liệu vào modal
                        $('#modalUserName').text(fullName);
                        $('#modalEmail').text(email);
                        $('#modalPhoneNumber').text(phoneNumber);
                        $('#modalProductName').text(productName);
                        $('#modalRating').text(rating + ' stars');
                        $('#modalComment').text(comment);
                        $('#modalStatus').val(status); // Đặt giá trị cho dropdown status

                        // Mở modal
                        $('#feedbackDetailModal').modal('show');
                    });

                    // Xử lý sự kiện khi nhấn nút Update Status
                    $('#updateStatusBtn').on('click', function () {
                        var newStatus = $('#modalStatus').val(); // Lấy giá trị status mới

                        // Gửi yêu cầu cập nhật trạng thái đến server
                        $.ajax({
                            url: 'updateFeedbackStatus', // URL của servlet xử lý cập nhật
                            type: 'POST',
                            data: {
                                reviewID: currentReviewID,
                                status: newStatus
                            },
                            success: function (response) {
                                alert('Status updated successfully!');
                                $('#feedbackDetailModal').modal('hide');
                                location.reload(); // Tải lại trang để cập nhật danh sách
                            },
                            error: function (xhr, status, error) {
                                alert('Failed to update status. Please try again.');
                            }
                        });
                    });
                });
            </script>

    </body>
</html>