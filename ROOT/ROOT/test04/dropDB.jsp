<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>

<html>
<head></head>
<body>
<%
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	//TNS Data를 이용해서 서버에 접속!		
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
					stmt.execute("drop table examtable;"); //테이블을 drop 한다.
		stmt.close();
		conn.close();
		out.println("<p><h1>테이블 지우기 OK</h1></p>");
	}catch (ClassNotFoundException e) {	//데이터가 없으면 에러 출력			
		out.println("클래스에러 발생 : " +e);
	} catch (SQLException e) {		//sql에러가 있을시 에러 출력
		out.println("sql에러 발생 : " +e);
	}
%>

</table>
</body>
</html>
