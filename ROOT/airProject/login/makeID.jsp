<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*,java.io.*"%>

<html>
<head>
<script>
	function buttonState(){	
		myForm.action="insertID.jsp";
		myForm.submit();			
	}

</script>
</head>
<body BACKGROUND="../image/bg33.JPG">
<center>
<h1>신규 아이디 생성해 주세요</h1><br>
<form method=post name="myForm" action="adm_allview.jsp">
<table border=1 cellspacing=1>
<tr>
	<td width = 150><p align = left>ID</p></td>
	<td width = 300><p align = left><input type=text size=50 maxlength=20 name="id" value="" required></p></td>
</tr>
<tr>
	<td width = 150><p align = left>PASSWORD</p></td>
	<td width = 300><p align = left><input type=password size=50 maxlength=20 name="passwd" value="" required></p></td>
</tr>
<tr>
	<td width = 150><p align = left>이름</p></td>
	<td width = 300><p align = left><input type=text size=50 maxlength=20 name="name" value="" required></p></td>
</tr>
<tr>
	<td width = 150><p align = left>생년월일(ex19890408)</p></td>
	<td width = 300><p align = left><input type=text size=50 maxlength=20 name="birth" value="" required></p></td>
</tr>
<%
	 java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
	 String today = formatter.format(new java.util.Date());
%>
<tr>
	<td width = 150><p align = left>생성일자</p></td>
	<td width = 300><p align = left><%=today%></p></td>
	<input type=hidden name="date" value=<%=today%>>
</tr>
</table>
<table>
<tr>	
	<td width = 300><p align = right><input type=submit value="취소"></td>
	<td width = 40><p align = center><input type=button value="쓰기" onclick="buttonState()"></td>
</tr>
</table>
</form>
</center>
</body>
</html>

