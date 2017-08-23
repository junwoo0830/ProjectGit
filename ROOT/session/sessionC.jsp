<meta http-=equiv="Content-Type" content="text/thml; charset=UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*" %>

<html>
<head>
</head>
<body >
<%
	String id = null;
	id= (String)session.getAttribute("session_id");
	out.println(id);
%>
</body>
</html>
	
	
	