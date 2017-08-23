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
		stmt.execute("drop table twiceUTong;");		
		stmt.execute("create table twiceUTong("		
						+ "id int not null primary key,"
						+ "title varchar(70),"
						+ "store int,"
						+ "storeDate date,"
						+ "regDate date, "
						+ "content text,"
						+ "URL     text)"
						+ "DEFAULT CHARSET=utf8;");	
		for(int i=0; i<100; i++){				
			stmt.execute("insert into twiceUTong values("+i+",'"+i+"번째상품',10,'2017-06-10','2017-06-10','트둥이트트트둥이','tiwce"+(i%5)+".jpg');");	
		}
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
