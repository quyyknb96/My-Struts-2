<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: quytn
  Date: 31/07/2018
  Time: 09:00
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

<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModalAddNew" >+</button>


<table class="table table-bordered">
    <thead>
    <tr>
        <th scope="col">ID</th>
        <th scope="col">Tên dự án</th>
        <th scope="col">Người tham gia</th>
        <th scope="col">Chức năng</th>
    </tr>
    </thead>
    <tbody>
    <s:iterator value="projectList" var="project" status="st">
        <tr>
            <th scope="row"><s:property value="#project.id"/></th>
            <td><a href="project_get?id=<s:property value="#project.id"/>"><s:property value="#project.name"/></a></td>
            <td>
                <s:if test="#project.assignsById.size==0 || #project.assignsById == null">
                    <span>Chưa có người dùng nào tham gia</span>
                </s:if>
                <s:else>
                    <s:iterator value="#project.assignsById" var="assign">
                        <span>|<a href="user_get?id=<s:property value="#assign.userByUserId.id"/>"><s:property
                                value="#assign.userByUserId.name"></s:property></a>|</span>
                    </s:iterator>
                </s:else>
            </td>
            <td>
                <button type="button" class="btn btn-primary btn-lg addUser" data-toggle="modal" data-target="#myModal" >+</button>
                <s:if test="#project.assignsById.size > 0">
                    <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal<s:property value="#project.id" />">X</button>
                    <div class="modal fade" id="myModal<s:property value="#project.id" />" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                        <div class="modal-dialog" role="document">
                            <form class="modal-content" action="project_deleteUser" method="post">
                                <div class="modal-header">
                                    <h4 class="modal-title" id="myModalLabel">Chọn User cần xóa</h4>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="id" value="<s:property value="#project.id"/>">
                                    <div class="custom-control custom-checkbox">
                                        <s:iterator value="#project.assignsById" var="assign">
                                            <input type="checkbox" name="listUserId" value="<s:property value="#assign.userByUserId.id"/>"><span><s:property value="#assign.userByUserId.name"/></span><br>
                                        </s:iterator>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                    <button type="submit" id="btnDelete" class="btn btn-primary">Delete changes</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </s:if>
            </td>
        </tr>
    </s:iterator>
    </tbody>
</table>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <form class="modal-content" action="project_addUser" method="post">
            <div class="modal-body">
                <input id = "inputAddUser" type="hidden" name="id">
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label">Project</label>
                    <select name="listUserId" id="slUser">
                        <option value="-1">Chọn user</option>
                        <s:iterator value="userList" var="user">
                            <option value="<s:property value="#user.id"/>"><s:property value="#user.name"/></option>
                        </s:iterator>
                    </select>
                </div>
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label">Decription</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" autocomplete="off" id="staticDecription" name="assign.decription" placeholder="Input assign decription">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="submit" id="btnSubmit" disabled class="btn btn-primary">Save changes</button>
            </div>
        </form>
    </div>
</div>


<div class="modal fade" id="myModalAddNew" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <form class="modal-content" id="frmAddNew" action="project_addNew" method="post">
            <div class="modal-body">
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label">Name</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" placeholder="Input name project" name="project.name" autocomplete="off">
                        </div>
                    </div>
            </div>

            <div class="modal-footer">
                <button type="button" id="closeFrmAddNew" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-primary">Save</button>
            </div>
        </form>
    </div>
</div>
</body>
<script>
    $(document).ready(function () {
        $(".addUser").click(function () {
            let a = $(this).parent().parent().children().eq(0).text();
            $("#inputAddUser").val(a);
        });
        $(".modal-footer").find("button[type=button]").click(function () {
            $("form").find("input").val("");
            $("form").find("input[type=checkbox]").prop("checked",false);
        });
        $("#slUser").change(function () {
            if ($(this).val() != -1) {
                $("#btnSubmit").attr("disabled", false);
            } else {
                $("#btnSubmit").attr("disabled", true);
            }
        });
    });
</script>
</html>
