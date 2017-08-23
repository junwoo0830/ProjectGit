<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*,java.io.*"%>

<html>
<head>
</head>
<body>
<%
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		ResultSet rset = stmt.executeQuery("select *from gongji order by rootid desc, viewRank asc, id asc;");		
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
		String today = formatter.format(new java.util.Date());
%>
<table border=1 cellspacing=1>
<tr>
	<td width = 40><p align = center>번호</p></td>
	<td width = 300><p align = center>제목</p></td>
	<td width = 80><p align = center>조회수</p></td>
	<td width = 80><p align = center>등록일</p></td>
</tr>
<%
	while(rset.next()){
		out.println(
		"	<tr>"+
		"		<td width = 40><p align = center>"+rset.getInt(1)+"</p></td>");
		String plusSt="";
		for(int i=0; i<rset.getInt(6); i++)
			 plusSt +="-";
		if(rset.getInt(6) != 0)
			plusSt +=">[Re]";
		if(today.equals(rset.getString(3)))
			out.println("<td width = 300><p align = left ><a href=\"gongji_oneview.jsp?id="+rset.getInt(1)+"\">"+plusSt+rset.getString(2)+"[New]</p></td>");
		else
			out.println("<td width = 300><p align = left ><a href=\"gongji_oneview.jsp?id="+rset.getInt(1)+"\">"+plusSt+rset.getString(2)+"</p></td>");
		out.println(		
		"		<td width = 80><p align = center>"+rset.getInt(7)+"</p></td>"+
		"		<td width = 80><p align = center>"+rset.getString(3)+"</p></td>"+
		"	</tr>"
		);	
	}
%>
</table>
<table>
<tr>
	<form method=post action="gongji_rootInsert.jsp">
	<td width = 460><p align = right><input type=submit value="신규"></td>
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
</body>
</html>



