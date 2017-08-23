<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*" %>
<html>
<head></head>
<body>
<%
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		//stmt.execute("drop table gongji;");		
 		stmt.execute("create table reserveDB("		
					+ "date date not null primary key defalut '2017-06-24' auto_increment,"
					+ "week int,"
					+ "room1 int,"
					+ "room2 int,"
					+ "room3 int)"
					+ "DEFAULT CHARSET=utf8;");	
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat dformat = new SimpleDateFormat("yyyy-MM-dd",Locale.KOREAN);
		ResultSet rset = stmt.executeQuery("select *from reserveDB");
		rset.next();
		for(int i=0; i<30; i++){
			out.println("date: " + dformat.format(rset.getDate(1)));
			//1:일요일 2:월요일...7:토요일						
			stmt.execute("insert into reserveDB(date, week, room1,room2,room3) values('"+dformat.format(cal.getTime() ) +"', "+cal.get(Calendar.DAY_OF_WEEK)+", 1,2,3)");				
			cal.add(cal.DATE, +1);	
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

