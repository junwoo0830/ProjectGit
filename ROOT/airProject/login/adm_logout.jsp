<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*" %>
<%@ page import="java.net.*,java.io.*,java.util.*,java.text.*"%>


<html>
<head>
</head>
<body BACKGROUND="../image/bg33.JPG">
<center>
<%
	session.invalidate();
	out.println("<h2>로그아웃 되었습니다.</h2>");
	out.println("<input type=button value='메인페이지' onClick=\"location.href='../main.jsp'\">");	
%>


</center>

</body>
</html>
	