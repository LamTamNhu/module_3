<%--
  Created by IntelliJ IDEA.
  User: OS
  Date: 4/12/2023
  Time: 11:29 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Display List</title>
</head>
<body>
<table border="1px" cellpadding="4px" style="border-collapse: collapse; table-layout: fixed">
    <tr>
        <th>Name</th>
        <th>Birthday</th>
        <th>Address</th>
        <th>Profile</th>
    </tr>
    <c:forEach items="${customers}" var="customer" varStatus="loop">
        <tr>
            <td>${customer.getName()}</td>
            <td>${customer.getBirthday()}</td>
            <td>${customer.getAddress()}</td>
            <td><img src="${customer.getProfilePic()}" style="max-width: 100px" alt="pic"></td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
