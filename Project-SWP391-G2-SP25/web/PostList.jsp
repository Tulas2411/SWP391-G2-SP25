<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Liên hệ - S4E</title>
        <link rel="shortcut icon" href="assets/img/S4EWhite.png" type="image/x-icon" />
        <link rel="stylesheet" href="assets/css/reset.css" />
        <link rel="stylesheet" href="assets/css/base.css" />
        <link rel="stylesheet" href="assets/css/main_PC.css" />
        <link rel="stylesheet" href="assets/css/main_Tablet.css" />
        <link rel="stylesheet" href="assets/css/TaiKhoan/LienHe.css" />
        <link rel="stylesheet" href="assets/fonts/fontawesome-free-6.0.0-web/css/all.css" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap&subset=vietnamese" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            body {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                overflow-x: hidden; /* Ngăn chặn tràn ngang */
                font-family: 'Roboto', sans-serif;
            }

/*            .container {
                width: 75%;
                margin: 0 auto;
                padding-top: 20px;
                max-width: 1100px;
            }*/

            .contact-container {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                margin-top: 20px;
                flex-wrap: wrap;
            }

            .contact-form {
                flex: 1;
                max-width: 50%;
                padding-right: 50px;
            }

            .contact-info {
                flex: 1;
                max-width: 50%;
            }

            .contact-form input,
            .contact-form textarea {
                width: 100%;
                padding: 10px;
                font-size: 15px;
                margin-bottom: 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
                outline: none;
                box-sizing: border-box;
            }

            .contact-form button {
                font-size: 16px;
                padding: 12px 20px;
                font-weight: 600;
                color: #fff;
                background-color: #dc0021;
                border: none;
                cursor: pointer;
                border-radius: 5px;
                width: 100%;
                max-width: 250px;
            }

            .contact-info p {
                margin-bottom: 12px;
                font-size: 16px;
                line-height: 1.6;
            }

            .contact-info p strong {
                color: #222;
                font-weight: bold;
            }

            /* Điều chỉnh kích thước phần input email và số điện thoại */
            .form-row {
                display: flex;
                gap: 10px;
            }

            .form-row input {
                flex: 1;
            }

            h1 {
                text-align: center;
                font-size: 28px;
                font-weight: bold;
                margin-bottom: 30px;
            }

            h3 {
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 20px;
            }

            /* Điều chỉnh container để thẳng hàng với menu */
            .main {
                margin-left: auto;
                margin-right: auto;
                width: 100%;
                max-width: 1100px;
                padding: 20px;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .contact-container {
                    flex-direction: column;
                    align-items: center;
                }

                .contact-form, .contact-info {
                    max-width: 100%;
                    padding-right: 0;
                    text-align: center;
                }

                .contact-form button {
                    width: 100%;
                }
            }
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f9f9f9;
            }

            .container {
                width: 80%;
                max-width: 800px;
                margin: 20px auto;
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            h1 {
                font-size: 1.2rem;
                color: #333;
            }

            label {
                display: block;
                margin-top: 15px;
                font-size: 0.9rem;
                color: #555;
            }

            input, textarea, select {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 0.9rem;
            }

            textarea {
                resize: none;
                height: 100px;
            }

            .input-group {
                display: flex;
                justify-content: space-between;
                gap: 15px;
            }

            .input-group input {
                flex: 1;
            }

            .status {
                margin-top: 20px;
                font-size: 0.9rem;
                color: #666;
            }

            button {
                display: inline-block;
                margin-top: 20px;
                padding: 10px 20px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            button:hover {
                background-color: #0056b3;
            }
            .open-button {
                background-color: #555;
                color: white;
                padding: 20px 30px;
                border: none;
                cursor: pointer;
                opacity: 0.8;
                position: fixed;
                left: 50%;
                bottom: 45px;
                transform: translateX(-50%);
                width: 280px;
            }
            .close-button {
                position: fixed;
                bottom: 45px; /* Khoảng cách từ đáy màn hình */
                right: 80px;   /* Khoảng cách từ cạnh trái màn hình */
                background-color: #f44336;
                color: white;
                padding: 5px 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 10px;
                opacity: 0.9;
            }

            .close-button:hover {
                opacity: 1; /* Hiệu ứng hover */
            }

        </style>

        <%@ include file="./Public/header.jsp" %>


    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    </head>


    <body class="bg-gray-100 p-6">


        <div class="container mx-auto">
            <h1 class="text-2xl font-bold mb-4"> Quản lý bài viết </h1>
            <div class="overflow-x-auto">
                <table class="min-w-full bg-white border border-gray-500">
                    <thead>

                        <tr class="w-full bg-gray-200 border-b">
                            <th class="py-2 px-4 border-r font-bold ">ID</th>
                            <th class="py-2 px-4 border-r font-bold">Tiêu đề</th>
                            <th class="py-2 px-4 border-r font-bold">Nội dung</th>
                            <th class="py-2 px-4 border-r font-bold">Tác giả</th>
                            <th class="py-2 px-4 border-r font-bold">Ngày tạo</th>
                            <th class="py-2 px-4 border-r font-bold">Trạng thái</th>
                            <th class="py-2 px-4 border-r font-bold">Link hình ảnh</th>
                            <th class="py-2 px-4 font-bold"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${posts}" var="o">

                            <tr class="border-b">
                                <td class="py-2 px-4 border-r">${o.postID}</td>
                                <td class="py-2 px-4 border-r">${o.title}</td>
                                <td class="py-2 px-4 border-r">${o.content}</td>
                                <td class="py-2 px-4 border-r">${o.author}</td>
                                <td class="py-2 px-4 border-r">${o.createDate}</td>
                                <td class="py-2 px-4 border-r">${o.status}</td>
                                <td class="py-2 px-4 border-r">
                                    <img src="${o.imageLink}" alt="Image for Post Title 2" class="w-20 h-20 object-cover">
                                </td>
                                <td class="py-2 px-4 flex space-x-2">
                                    <button class="bg-yellow-500 text-white px-4 py-2 rounded " data-bs-toggle="modal" data-bs-target="#postModal"">Sửa</button>

                                    <a href="DeletePost?postID=${o.postID}" 
                                       class="bg-red-500 text-white px-4 py-2 rounded"
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa bài viết này?');">
                                        Xóa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>

                    </tbody>
                </table>
            </div>

            <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#postModal">
                Tạo bài viết mới
            </button>

            <!-- Popup Modal -->
            <div class="modal fade" id="postModal" tabindex="-1" aria-labelledby="postModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="postModalLabel">Bài viết mới</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="AddPost" method="post">
                                <input type="hidden" name="postID" value="${post.postID}">

                                <!-- Tiêu đề -->
                                <div class="mb-3">
                                    <label for="title" class="form-label">Tiêu đề</label>
                                    <input type="text" class="form-control" id="title" name="title" placeholder="Nhập tiêu đề..." value="${post.title}" required>
                                </div>

                                <!-- Nội dung -->
                                <div class="mb-3">
                                    <label for="description" class="form-label">Nội dung</label>
                                    <textarea class="form-control" id="description" name="content" placeholder="Nhập nội dung..." required>${post.content}</textarea>
                                </div>

                                <div class="row">
                                    <!-- Ngày tạo -->
                                    <div class="col-md-6 mb-3">
                                        <label for="createDate" class="form-label">Ngày tạo</label>
                                        <input type="datetime-local" class="form-control" id="createDate" name="createDate" value="${post.createDate}" required>
                                    </div>

                                    <!-- Trạng thái -->
                                    <div class="col-md-6 mb-3">
                                        <label for="status" class="form-label">Trạng thái</label>
                                        <select class="form-select" id="status" name="status">
                                            <option value="Published" ${post.status == 'Published' ? 'selected' : ''}>Published</option>
                                            <option value="Draft" ${post.status == 'Draft' ? 'selected' : ''}>Draft</option>
                                        </select>
                                    </div>
                                </div>

                                <!-- Link hình ảnh -->
                                <div class="mb-3">
                                    <label for="imageLink" class="form-label">Link hình ảnh</label>
                                    <input type="url" class="form-control" id="imageLink" name="imageLink" value="${post.imageLink}">
                                </div>

                                <!-- Nút cập nhật -->
                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-primary">Cập nhật bài viết</button>
                                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Đóng</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

    </body>
</html>

</div>



</body>
</html>
