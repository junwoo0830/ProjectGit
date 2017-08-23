<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head></head>
<body>
<%
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성	
		stmt.execute("create table airAdminfo("		
						+ "id varchar(20) primary key,"
						+" passwd varchar(20),"
						+" name   varchar(20),"
						+" birth  varchar(20),"
						+" date   date)"
						+ "DEFAULT CHARSET=utf8;");	
		stmt.execute("insert into airAdminfo(id,passwd,name,birth,date) values ('admin','juunwoo','juunwoo','19890408','2017-07-05');");				
		stmt.close();
		conn.close();
		out.println("<p><h1>테이블 만들기 OK</h1></p>");
	}catch (ClassNotFoundException e) {	//클래스가 없으면 에러 출력			
		out.println("클래스에러 발생 : " +e);
	} catch (SQLException e) {			//sql에러가 있을시 에러 출력
		out.println("sql에러 발생 : " +e);
	}
%>
</table>
</body>
</html>

