<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Product Management</title>
</head>
<body>
<jsp:forward page="/product-servlet?action=view"></jsp:forward>
<h1>Products</h1>
<button>Add product</button>
<table>

</table>
</body>
</html>