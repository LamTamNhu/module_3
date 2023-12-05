<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: LamNT
  Date: 12/4/2023
  Time: 10:54 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Products</title>
</head>
<body>
<form action="/product-servlet">
    <button type="submit" name="action" value="add">Add product</button>
</form>

<table border="1px" cellpadding="5px" style="border-collapse: collapse;text-align: center">
    <tr>
        <th>Index</th>
        <th>Name</th>
        <th>Price</th>
        <th>Production date</th>
    </tr>
    <c:forEach items="${products}" var="product" varStatus="loop">
        <tr>
            <td>${loop.count}</td>
            <td>
                <a href="#" onclick="popupDetail('${product.description}')">${product.name}</a>
            </td>
            <td>${product.price}</td>
            <td>${product.productionDate}</td>
            <td>
                <form action="/product-servlet">
                    <input type="hidden" name="id" value="${product.id}">
                    <button type="submit" name="action" value="edit">Edit</button>
                </form>
            </td>
            <td>
                <form action="/product-servlet">
                    <input type="hidden" name="id" value="${product.id}">
                    <button type="submit" name="action" value="remove">Remove</button>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>
<script>
    function popupDetail(description) {
        console.log("Worked!");
        alert(description);
    }
</script>
</body>
</html>
