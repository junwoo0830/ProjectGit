<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>

<html>
<head></head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	//TNS Data를 이용해서 서버에 접속!
	out.println("연결 성공!");				//연결 확인 상태 출력
	Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
	ResultSet rset = stmt.executeQuery("select *from examtable");	//Query 실행후 결과를 resultSet에 저장
			
%>
<table cellspacing=1 width=600 border=1>
<%
	while(rset.next()){
		out.println("<tr>");		
		out.println("<td width=50><p align=center>"+rset.getString(1)+"</p></td>");
		out.println("<td width=50><p align=center>"+rset.getInt(2)+"</p></td>");
		out.println("<td width=50><p align=center>"+rset.getInt(3)+"</p></td>");
		out.println("<td width=50><p align=center>"+rset.getInt(4)+"</p></td>");
		out.println("<td width=50><p align=center>"+rset.getInt(5)+"</p></td>");		 
		out.println("</tr>");		
	}
	rset.close();
	stmt.close();
	conn.close();
%>
</table>
</body>
</html>
