<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>User Management Application</title>
</head>
<body>
<center>
    <a href="/users" style="text-decoration: none"><h1>User Management</h1></a>

    <form action="/users">
        <button type="submit" name="action" value="create">Add New User</button>
    </form>
    <br>
    <form action="/users">
        <input type="text" name="country" placeholder="country name">
        <button type="submit" name="action" value="search_by_country">Search user by country</button>
    </form>
    <br>
    <form action="/users">
        <input type="text" name="name" placeholder="user name">
        <button type="submit" name="action" value="search_by_name">Search user by name</button>
    </form>

</center>
<div align="center">
    <table border="1" cellpadding="5">
        <caption><h2>List of Users</h2></caption>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Country</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="user" items="${listUser}">
            <tr>
                <td><c:out value="${user.id}"/></td>
                <td><c:out value="${user.name}"/></td>
                <td><c:out value="${user.email}"/></td>
                <td><c:out value="${user.country}"/></td>
                <td>
                    <a href="/users?action=edit&id=${user.id}">Edit</a>
                    <a href="/users?action=delete&id=${user.id}">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>