﻿<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*,java.io.*"%>

<html>
<head>
</head>
<body BACKGROUND="../image/bg33.JPG">
<center>
<%
	String loginOK=null;
		
	loginOK = (String)session.getAttribute("login_ok");
	if(loginOK!=null){
		if(loginOK.equals("yes"))
			out.println(" <h1>JUNWOOair 공지사항</h1><br> ");
	}
	else{
		out.println(" <h1>JUNWOOair 공지사항</h1><br><br> ");
	}
	
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		ResultSet rset = stmt.executeQuery("select *from resortGongji order by id desc;");		
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
		String today = formatter.format(new java.util.Date());
%>
<table border=1 cellspacing=0>
<tr>
	<td width = 40><p align = center>번호</p></td>
	<td width = 300><p align = center>제목</p></td>
	<td width = 80><p align = center>조회수</p></td>
	<td width = 120><p align = center>등록일</p></td>
</tr>
<%
	while(rset.next()){
		out.println(
		"	<tr>"+
		"		<td width = 40><p align = center>"+rset.getInt(1)+"</p></td>"+
		"<td width = 300><p align = left ><a href=\"gongji_oneview.jsp?id="+rset.getInt(1)+"\">"+rset.getString(2)+"</p></td>"+			
		"		<td width = 80><p align = center>"+rset.getInt(5)+"</p></td>"+
		"		<td width = 120><p align = center>"+rset.getString(3)+"</p></td>"+
		"	</tr>"
		);	
	}
%>
</table>
<table>
<tr>
	<form method=post action="gongji_rootInsert.jsp">
<%	
	if(loginOK==null){
		out.println("<td></td>");		
	}else {
		if(loginOK.equals("yes")){
			out.println("<td width = 460><p align = right><input type=submit value=\"신규\"></td>");		
		}
	}
%>
	
</tr>
</table>
<%
		rset.close();
		stmt.close();
		conn.close();		
	}catch (ClassNotFoundException e) {	//클래스가 없으면 에러 출력			
		out.println("클래스에러 발생 : " +e);
	} catch (SQLException e) {			//sql에러가 있을시 에러 출력
		out.println("sql에러 발생 : " +e);
	}
%>
</center>
</body>
</html>


