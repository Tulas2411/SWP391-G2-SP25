<form action="MarketingPostServlet" method="post">
    <input type="hidden" name="action" value="add">
    <label>Title:</label><input type="text" name="title"><br>
    <label>Content:</label><textarea name="content"></textarea><br>
    <label>Author:</label><input type="text" name="author"><br>
    <label>Create Date:</label><input type="datetime-local" name="createDate"><br>
    <label>Status:</label><input type="text" name="status"><br>
    <label>Image Link:</label><input type="text" name="imageLink"><br>
    <button type="submit">Thêm bài vi?t</button>
</form>
