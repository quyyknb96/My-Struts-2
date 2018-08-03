<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: quytn
  Date: 01/08/2018
  Time: 08:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Người dùng</title>
</head>
<body>
    <s:include value="header.jsp"></s:include>
    <s:actionerror/>
    <s:actionmessage/>
    <form action="user_update" method="post">
        <input type="hidden" name="user.id" value="<s:property value="user.id"/>">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Username</label>
            <div class="col-sm-10">
                <input type="text" readonly class="form-control-plaintext" id="staticUsername" value="<s:property value="user.username"/>">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Name</label>
            <div class="col-sm-10">
                <input type="text" readonly autocomplete="off" class="form-control-plaintext" id="staticName" name="user.name" placeholder="Input your name here" value="<s:property value="user.name"/>">
            </div>
        </div>
        <button type="button" id="submit">Change</button>
        <button type="button" id="cancel">Cancel</button>
        <s:if test="user.id==#session.user.id"><button type="button" id="changpassword">Chang Password</button></s:if>
    </form>

    <form action="user_changepassword" method="post" id="frmchangepassword">
        <input type="hidden" name="user.id" value="<s:property value="user.id"/>">
        <div class="form-group">
            <label>Old Password</label>
            <input type="password" class="form-control" name="user.password"  placeholder="Input Old Password">
        </div>
        <div class="form-group">
            <label>New Password</label>
            <input type="password" class="form-control" name="newPassword" placeholder="Input New Password">
        </div>
        <div class="form-group">
            <label>Repeat New Password</label>
            <input type="password" class="form-control" name="newPasswordRepeat" placeholder="Input Repeat New Password">
        </div>
        <button type="submit">Change Password</button>
        <button type="button" id="cancelchange">Cancel</button>
    </form>
</body>
    <script>
        $(document).ready(function () {
            $("#frmchangepassword").css("display","none");
            $("#changpassword").click(function () {
                $("#frmchangepassword").css("display","block");
            });
            $("#cancelchange").click(function () {
                $("#frmchangepassword").css("display","none");
                $("#frmchangepassword").find("input[type=password]").val("");
            });
            let a = $("#staticName").val();
            let x = 1;
            $("#submit").click(function () {
                $("#submit").text("Update");
                $("#staticName").attr("readonly",false);
                $("#staticName").attr("class","form-control");
                if(x==0) {
                    $("#submit").attr("type", "submit");
                }else {
                    x--;
                }
            });
            $("#cancel").click(function () {
                x++;
                $("#staticName").val(a);
                $("#staticName").attr("readonly",true);
                $("#staticName").attr("class","form-control-plaintext");
                $("#submit").attr("type","button");
                $("#submit").text("Change");
            });
        });
    </script>
</html>
