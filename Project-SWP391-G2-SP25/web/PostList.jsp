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

        <style>
            body {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                overflow-x: hidden; /* Ngăn chặn tràn ngang */
                font-family: 'Roboto', sans-serif;
            }

            .container {
                width: 75%;
                margin: 0 auto;
                padding-top: 20px;
                max-width: 1100px;
            }

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
        </style>
    </head>
    <%@ include file="./Public/header.jsp" %>


    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CRUD Marketing Posts</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    </head>

    <body class="bg-gray-100 p-6">
        <div class="container mx-auto">
            <h1 class="text-2xl font-bold mb-4"> Marketing Posts</h1>
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
                                <img src="${o.imageLink}" alt="Image for Post Title 2" class="w-12 h-12 object-cover">
                            </td>
                            <td class="py-2 px-4 flex space-x-2">
                                <button class="bg-yellow-500 text-white px-4 py-2 rounded">Edit</button>
                                <button class="bg-red-500 text-white px-4 py-2 rounded">Del</button>
                            </td>
                        </tr>
                    </c:forEach>

                    </tbody>
                </table>
            </div>
            <div class="mt-4 flex space-x-2">
                <button class="bg-green-500 text-white px-4 py-2 rounded">Tạo bài viết mới </button>
            </div>
        </div>
    </body>
</html>
