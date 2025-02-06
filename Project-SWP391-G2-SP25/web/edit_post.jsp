<form action="MarketingPostServlet" method="post">
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="id" value="${post.id}">
    <label>Title:</label><input type="text" name="title" value="${post.title}"><br>
    <label>Content:</label><textarea name="content">${post.content}</textarea><br>
    <label>Author:</label><input type="text" name="author" value="${post.author}"><br>
    <label>Create Date:</label><input type="datetime-local" name="createDate" value="${post.createDate}"><br>
    <label>Status:</label><input type="text" name="status" value="${post.status}"><br>
    <label>Image Link:</label><input type="text" name="imageLink" value="${post.imageLink}"><br>
    <button type="submit">C?p nh?t bài vi?t</button>
</form>
