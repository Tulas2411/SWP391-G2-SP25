<%-- 
    Document   : PostDetails
    Created on : Feb 10, 2025, 1:26:11 AM
    Author     : Tùng Dương
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Model.MarketingPosts" %>

<%
    MarketingPosts post = (MarketingPosts) request.getAttribute("post");
    String errorMessage = (String) request.getAttribute("errorMessage");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Blog Details</title>
        <link rel="shortcut icon" href="assets/img/S4EWhite.PNG" type="image/x-icon" />
        <link rel="stylesheet" href="assets/css/reset.css" />
        <link rel="stylesheet" href="assets/css/base.css" />
        <link rel="stylesheet" href="assets/css/main_PC.css" />
        <link rel="stylesheet" href="assets/css/main_Tablet.css" />
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
        <link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css" />
        <link rel="stylesheet" href="assets/fonts/fontawesome-free-6.0.0-web/css/all.css" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swapsubset=vietnamese" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body>
        <%@ include file="./Public/header.jsp" %>

        <div class="post-container_top" style="margin-top: 10px;">
            <% if (errorMessage != null) {%>
            <h2 style="color: red;"><%= errorMessage%></h2>
            <% } else if (post == null) { %>
            <h2 style="color: red;">Bài viết không tồn tại hoặc đã bị xóa!</h2>
            <% } else {%>
            <div class="post-container" style="margin-top: 10px;">
                <!-- Nút chuyển đổi chế độ chỉnh sửa -->
                <div class="switch-container">
                    <label class="switch">
                        <input type="checkbox" id="edit-toggle">
                        <span class="slider"></span>
                    </label>
                    <span class="switch-label">Chế độ chỉnh sửa</span>
                </div>

                <div class="post-header">
                    <!-- Tiêu đề bài viết -->
                    <h1 id="post-title"><%= post.getTitle()%></h1>
                    <input type="text" id="post-title-input" class="edit-mode-input" style="display: none;" value="<%= post.getTitle()%>">

                    <!-- Thông tin meta -->
                    <p id="post-meta">
                        🗓 <%= post.getCreateDate()%> &nbsp;&nbsp;
                        ✍️ Tác giả: <%= post.getAuthor()%>
                    </p>
                </div>

                <div class="post-content">
                    <!-- Ảnh bài viết -->
                    <img src="<%= post.getImageLink()%>" alt="<%= post.getTitle()%>" id="post-image" class="post-image">
                    <input type="file" id="post-image-input" class="edit-mode-input" style="display: none;" accept="image/*">

                    <!-- Nội dung bài viết -->
                    <p id="post-content" style="text-align: left;"><%= post.getContent()%></p>
                    <textarea id="post-content-input" class="edit-mode-input" style="display: none;"><%= post.getContent()%></textarea>
                </div>

                <!-- Nút Lưu -->
                <button id="save-button" style="display: none;">Lưu</button>
            </div>
            <% }%>
        </div>

        <%@ include file="./Public/footer.jsp" %>

        <script>
            // Bật/tắt chế độ chỉnh sửa
            document.getElementById('edit-toggle').addEventListener('change', function() {
                const isEditMode = this.checked;

                // Ẩn/hiện các trường input và nội dung hiển thị
                document.getElementById('post-title').style.display = isEditMode ? 'none' : 'block';
                document.getElementById('post-title-input').style.display = isEditMode ? 'block' : 'none';

                document.getElementById('post-content').style.display = isEditMode ? 'none' : 'block';
                document.getElementById('post-content-input').style.display = isEditMode ? 'block' : 'none';

                document.getElementById('post-image').style.display = isEditMode ? 'none' : 'block';
                document.getElementById('post-image-input').style.display = isEditMode ? 'block' : 'none';

                document.getElementById('save-button').style.display = isEditMode ? 'block' : 'none';
            });

            // Xử lý khi nhấn nút Lưu
            document.getElementById('save-button').addEventListener('click', function() {
                const formData = new FormData();
                formData.append('postId', '<%= post.getPostID()%>');
                formData.append('title', document.getElementById('post-title-input').value);
                formData.append('content', document.getElementById('post-content-input').value);

                const imageFile = document.getElementById('post-image-input').files[0];
                if (imageFile) {
                    formData.append('image', imageFile);
                }

                // Gửi dữ liệu lên server bằng AJAX
                $.ajax({
                    url: '<%=request.getContextPath()%>/update-post',
                    method: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function(data) {
                        if (data.success) {
                            alert('Cập nhật thành công!');
                            if (data.newImageLink) {
                                document.getElementById('post-image').src = data.newImageLink;
                            }
                            document.getElementById('edit-toggle').checked = false;
                            document.getElementById('edit-toggle').dispatchEvent(new Event('change'));
                        } else {
                            alert('Lỗi: ' + data.error);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('AJAX Error:', error);
                        alert('Lỗi server: ' + xhr.responseText);
                    }
                });
            });
        </script>
    </body>
</html>