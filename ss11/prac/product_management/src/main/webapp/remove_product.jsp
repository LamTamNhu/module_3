<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: OS
  Date: 5/12/2023
  Time: 2:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<c:if test="${id != 'N/A'}">
    <form action="/product-servlet?action=remove" method="post">
        Delete this product?
        <br>
        <button type="submit" name="id" value="${id}">YES</button>
        <button type="submit" formaction="/product-servlet" formmethod="get" name="action" value="view">NO</button>
    </form>
</c:if>
<c:if test="${id == 'N/A'}">
    response.sendRedirect(request.getContextPath() + "/product-servlet?action=view");
</c:if>
</body>
</html>
