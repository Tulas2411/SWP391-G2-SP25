<%-- 
    Document   : OrderDetailError
    Created on : Mar 20, 2025, 10:11:31 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%String error = (String) request.getAttribute("errorMessage");%>
        <h1><%=error%></h1>
    </body>
</html>
