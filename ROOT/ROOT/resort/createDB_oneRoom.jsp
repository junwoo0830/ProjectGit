<meta http-dquiv="Content-type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.*,java.text.*" %>

<html>
<head></head>
<body>
<% 
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();
		stmt.execute("create table roomRes("
					+"name varchar(20),"
					+"resv_date date not null,"
					+"room int not null,"
					+"addr varchar(100),"
					+"telnum varchar(20),"
					+"in_name varchar(20),"
					+"comment text,"
					+"write_date date,"
					+"processing int)"
					+"DEFAULT CHARSET=UTF8;");
		stmt.close();
		conn.close();
		out.println("<p><h1>테이블 만들기 OK</h1></p>");
	}catch(ClassNotFoundException e){
		out.println("클래스에러 발생 : " +e);
	} catch (SQLException e) {			//sql에러가 있을시 에러 출력
		out.println("sql에러 발생 : " +e);
	}


%>
</body>
</html>