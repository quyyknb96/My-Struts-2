<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%><html>
<head>
<title>Struts 2 - Login Application | ViralPatel.net</title><s:head/>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
</head>
<body>
	<h2>Struts 2 - Login Application</h2>
	<s:actionerror />
	<s:actionmessage />
	<s:form action="login" method="post">
		<s:textfield autocomplete="off" name="username" key="Username" size="20"/>
		<s:password name="password" key="Password" size="20" />
		<s:submit method="execute" align="center" value="Dang nhap"/>
	</s:form>
</body>
	<script>
		$(document).ready(function () {
			let txt = "<a href=\"register.jsp\"><button type=\"button\">Dang ky</button></a>";
			$("#login__execute").parent().append(txt);
        });
	</script>
</html>
