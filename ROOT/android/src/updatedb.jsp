<meta http-dquiv="Content-type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.*,java.text.*" %>
<html>
<head>
<%
	String Day = request.getParameter("Day");
	String cost = request.getParameter("cost");
	String storeName =request.getParameter("storeName");	
	String status = request.getParameter("status");	
	String nums  = request.getParameter("num");
	out.println(Day + cost + storeName + status + nums);asdsa
%>
</head>
<body>
<center>
<%			
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		stmt.execute("update AcountBook set Day='"+Day+"',cost="+cost+",storeName='"+storeName+"',status='"+status+"'where num="+nums+";");		
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