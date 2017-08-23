<meta http-=equiv="Content-Type" content="text/thml; charset=UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*" %>
<%@ page import="java.net.*,java.io.*,java.util.*,java.text.*"%>


<html>
<head>
</head>
<body >
<center>
<%
	request.setCharacterEncoding("utf-8");
	
	String jump = request.getParameter("jump");
	String id = request.getParameter("id");
	String pass = request.getParameter("passwd");
	
	boolean bPassChk=false;
	
	if(id.replaceAll(" ","").equals("admin" ) && pass.replaceAll(" ","").equals("admin"))
	{
		bPassChk=true;
	}else{
		bPassChk=false;
	}
	out.println(jump);
	if(bPassChk){
		session.setAttribute("login_ok","yes");
		session.setAttribute("login_id",id);
		response.sendRedirect(jump);
	}else{
		out.println("<h2>아이디 또는 패스워드 오류.</h2>");
		out.println("<input type=button value='로그인' onClick=\"location.href='login.jsp?jump='"+jump+"'\">");
	}
	
%>


</center>

</body>
</html>
	