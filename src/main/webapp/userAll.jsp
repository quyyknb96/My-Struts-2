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
    <title>Người dùng</title>
</head>
<body>
<s:include value="header.jsp"></s:include>
<s:actionerror/>
<table class="table table-bordered">
    <thead>
    <tr>
        <th scope="col">ID</th>
        <th scope="col">Tên người dùng</th>
        <th scope="col">Dự án</th>
        <th scope="col">Chức năng</th>
    </tr>
    </thead>
    <tbody>
    <s:iterator value="userList" var="user" status="st">
        <tr>
            <th scope="row"><s:property value="#user.id"/></th>
            <td><a href="user_get?id=<s:property value="#user.id"/>"><s:property value="#user.username"/></a></td>
            <td>
                <s:if test="#user.assignsById.size==0 || #user.assignsById == null">
                    <span>Chưa tham gia dự án nào</span>
                </s:if>
                <s:else>
                    <s:iterator value="#user.assignsById" var="assign">
                        <span>|<a href="project_get?id=<s:property value="#assign.projectByProjectId.id"/>"><s:property
                                value="#assign.projectByProjectId.name"></s:property></a>|</span>
                    </s:iterator>
                </s:else>

            </td>
            <td>
                <button type="button" class="btn btn-primary btn-lg addProject" data-toggle="modal" data-target="#myModal" >+</button>
                <s:if test="#user.assignsById.size > 0">
                    <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal<s:property value="#user.id" />">X</button>
                    <div class="modal fade" id="myModal<s:property value="#user.id" />" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                        <div class="modal-dialog" role="document">
                            <form class="modal-content" action="user_deleteProject" method="post">
                                <div class="modal-header">
                                    <h4 class="modal-title" id="myModalLabel">Chọn Project cần xóa</h4>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="id" value="<s:property value="#user.id"/>">
                                    <div class="custom-control custom-checkbox">
                                        <s:iterator value="#user.assignsById" var="assign">
                                           <input type="checkbox" name="listProjectId" value="<s:property value="#assign.projectByProjectId.id"/>"><span><s:property value="#assign.projectByProjectId.name"/></span><br>
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
        <form class="modal-content" action="user_addProject" method="post">
            <div class="modal-body">
                <input id = "inputAddProject" type="hidden" name="id">
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label">Project</label>
                    <select name="listProjectId" id="slProject">
                        <option value="-1">Chọn project</option>
                        <s:iterator value="projectList" var="project">
                            <option value="<s:property value="#project.id"/>"><s:property value="#project.name"/></option>
                        </s:iterator>
                    </select>
                </div>
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label">Decription</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="staticDecription" name="assign.decription" placeholder="Input assign decription">
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
</body>
<script>
    $(document).ready(function () {
        $(".addProject").click(function () {
            let a = $(this).parent().parent().children().eq(0).text();
            $("#inputAddProject").val(a);
        });
        $(".modal-footer").find("button[type=button]").click(function () {
            $("form").find("input").val("");
            $("form").find("input[type=checkbox]").prop("checked",false);
        });
        $("#slProject").change(function () {
            if ($(this).val() != -1) {
                $("#btnSubmit").attr("disabled", false);
            } else {
                $("#btnSubmit").attr("disabled", true);
            }
        });
    });
</script>
</html>
