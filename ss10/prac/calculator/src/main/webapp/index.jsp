<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Calculator</title>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
</head>
<body>
<h1>Simple Calculator</h1>
<form action="/calculator" method="post">
    <label>
        First operand
        <input type="number" name="firstOperand">
    </label>
    <br>
    <label>
        Addition (+)
        <input type="radio" name="operator" value="+">
    </label>
    <label>
        Subtract (-)
        <input type="radio" name="operator" value="-">
    </label>
    <label>
        Multiplication (*)
        <input type="radio" name="operator" value="*">
    </label>
    <label>
        Division (/)
        <input type="radio" name="operator" value="/">
    </label>
    <br>
    <label>
        Second operand
        <input type="number" name="secondOperand">
    </label>
    <br>
    <button type="submit">Calculate</button>
</form>
</body>
</html>