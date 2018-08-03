<%--
  Created by IntelliJ IDEA.
  User: quytn
  Date: 30/07/2018
  Time: 14:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>Home</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</head>
<body>
<p>Hello <a href="user_get?id=<s:property value="#session.user.id"/>"><s:property value="#session.user.name" /></a> | <a href="logout" >Logout</a> </p>
    <ul class="nav">
        <li class="nav-item">
            <a class="nav-link" href="index.jsp">Trang chủ</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="user_getAll">Người dùng</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="project_getAll">Dự án</a>
        </li>
    </ul>
</body>
</html>
