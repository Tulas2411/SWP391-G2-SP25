<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Danh sách Marketing Posts</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Danh sách Marketing Posts</h1>
    <a href="add_post.jsp">Thêm bài vi?t m?i</a>
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Content</th>
                <th>Author</th>
                <th>Create Date</th>
                <th>Status</th>
                <th>Image</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="post" items="${posts}">
                <tr>
                    <td>${post.id}</td>
                    <td>${post.title}</td>
                    <td>${post.content}</td>
                    <td>${post.author}</td>
                    <td>${post.createDate}</td>
                    <td>${post.status}</td>
                    <td><img src="${post.imageLink}" width="50" /></td>
                    <td>
                        <a href="MarketingPostServlet?action=edit&id=${post.id}">S?a</a>
                        <a href="MarketingPostServlet?action=delete&id=${post.id}">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
