<%--
  Created by IntelliJ IDEA.
  User: OS
  Date: 5/12/2023
  Time: 11:41 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Editing</title>
</head>
<body>
<form action="/product-servlet?action=edit" method="post">
    <input type="hidden" name="id" value="${product.id}">
    <label>
        Name <input type="text" name="name" placeholder="${product.name}" value="${product.name}">
    </label>
    <label>
        Price <input type="number" name="price" placeholder="${product.price}" value="${product.price}">
    </label>
    <label>
        Production date <input type="date" name="production_date" placeholder="${product.productionDate}" value="${product.productionDate}">
    </label>
    <label>
        Description <input type="text" name="description" placeholder="${product.description}" value="${product.description}">
    </label>
    <button type="submit">Edit</button>
</form>
</body>
</html>
