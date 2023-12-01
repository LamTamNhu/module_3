<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Discount Calculator</title>
</head>
<body>
<form action="/calc" method="post">
    <h1>Product Discount Calculator</h1>
    <p>Product description <input type="text" name="description"></p>
    <p>List price <input type="number" name="price"></p>
    <p>Discount percent <input type="number" name="discount percent"></p>
    <button type="submit">Submit</button>
</form>
</body>
</html>