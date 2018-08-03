<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: quytn
  Date: 02/08/2018
  Time: 08:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Đăng kí người dùng</title>
</head>
<body>
    <s:actionerror/>
    <s:form action="user_addNew" method="POST">
        <s:textfield name="user.name" key="Name" size="30"  autocomplete="off" />
        <s:textfield name="user.username" key="Username" size="30"  autocomplete="off" />
        <s:password name="user.password" key="Password" size="30" />
        <s:submit key="Register" align="center"/>
    </s:form>
</body>
</html>
