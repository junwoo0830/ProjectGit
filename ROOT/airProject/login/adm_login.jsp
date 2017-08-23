<meta http-=equiv="Content-Type" content="text/thml; charset=UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*" %>
<%@ page import="java.net.*,java.io.*,java.util.*,java.text.*"%>


<html>
<head>
<script>
function makeID(){
	myForm.action="makeID.jsp";
	myForm.submit();
}
</script>
<%
	String jump = request.getParameter("jump");
%>

</head>
<body BACKGROUND="../image/bg33.JPG">
<center>

<h1>관리자 로그인</h1>
<form method="post" name="myForm" action="adm_loginck.jsp">
<table boder=1>
<tr>
	<td>
		<table border=1>
			<tr>
				<td>아이디</td>
				<td><input type="text"  name="id" maxlength="15"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password"  name="passwd" maxlength="15"></td>
			</tr>	
		</table>
	</td>
	<td align="left" valign="bottom"><p ><input type="submit" value="전송">
</tr>
<tr><td colspan=2 ><p align="left"><input type="button" onclick="makeID()" value="아이디만들기"></p></td>
<input type="hidden" name="jump" value='<%=jump%>'>
</form>

</center>

</body>
</html>
	