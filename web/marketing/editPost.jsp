<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa bài viết</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="bg-light">
    <div class="container mt-5">
        <h2 class="text-center">Chỉnh sửa bài viết</h2>
        <form action="EditPost" method="post">
            <input type="hidden" name="postID" value="${post.postID}">
            
            <div class="mb-3">
                <label for="title" class="form-label">Tiêu đề</label>
                <input type="text" class="form-control" id="title" name="title" value="${post.title}" required>
            </div>
            
            <div class="mb-3">
                <label for="content" class="form-label">Nội dung</label>
                <textarea class="form-control" id="content" name="content" required>${post.content}</textarea>
            </div>
            
            <div class="mb-3">
                <label for="createDate" class="form-label">Ngày tạo</label>
                <input type="datetime-local" class="form-control" id="createDate" name="createDate" value="${post.createDate}" required>
            </div>
            
            <div class="mb-3">
                <label for="status" class="form-label">Trạng thái</label>
                <select class="form-select" id="status" name="status">
                    <option value="Published" ${post.status == 'Published' ? 'selected' : ''}>Published</option>
                    <option value="Draft" ${post.status == 'Draft' ? 'selected' : ''}>Draft</option>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="imageLink" class="form-label">Link hình ảnh</label>
                <input type="url" class="form-control" id="imageLink" name="imageLink" value="${post.imageLink}">
            </div>
            
            <div class="d-flex justify-content-between">
                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                <a href="PostList" class="btn btn-secondary">Hủy</a>
            </div>
        </form>
    </div>
</body>
</html>
