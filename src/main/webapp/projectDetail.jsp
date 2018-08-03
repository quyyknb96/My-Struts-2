<%--
  Created by IntelliJ IDEA.
  User: quytn
  Date: 02/08/2018
  Time: 10:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dự án</title>
</head>
<body>
<s:include value="header.jsp"></s:include>
<s:actionerror/>
<s:actionmessage/>
<form action="project_update" method="post">
    <input type="hidden" name="project.id" value="<s:property value="project.id"/>">
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Name</label>
        <div class="col-sm-10">
            <input type="text" readonly autocomplete="off" class="form-control-plaintext" id="staticName" name="project.name" placeholder="Input your name here" value="<s:property value="project.name"/>">
        </div>
    </div>
    <button type="button" id="submit">Change</button>
    <button type="button" id="cancel">Cancel</button>
</form>
</body>
<script>
    $(document).ready(function () {
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
