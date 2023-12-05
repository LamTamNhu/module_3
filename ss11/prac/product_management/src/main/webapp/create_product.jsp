<%--
  Created by IntelliJ IDEA.
  User: OS
  Date: 5/12/2023
  Time: 10:43 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create Product</title>
</head>
<body>
<form action="/product-servlet?action=add" method="post">
    <label>
        ID <input type="text" name="id">
    </label>
    <label>
        Name <input type="text" name="name">
    </label>
    <label>
        Price <input type="number" name="price">
    </label>
    <label>
        Production date <input type="date" name="production_date">
    </label>
    <label>
        Description <input type="text" name="description">
    </label>
    <button type="submit">Add</button>
</form>
</body>
</html>
