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
		stmt.execute("drop table hubo_table;");	
		stmt.execute("drop table Tupyo_table;");	
		stmt.execute("create table hubo_table("		
						+ "id int primary key,"
						+ "name varchar(20))"
						+ "DEFAULT CHARSET=utf8;");	
		stmt.execute("create table Tupyo_table("		
						+ "id int,"
						+ "age int)"
						+ "DEFAULT CHARSET=utf8;");	
		//stmt.execute("ALTER table Tupyo_table add constraint hubo_ID_tupyo_id_fk foreign key(id) references hubo_table(id) on delete cascade; ");
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
