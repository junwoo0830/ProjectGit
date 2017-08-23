<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*,java.util.*,java.sql.*,javax.servlet.*,javax.sql.*,javax.naming.*" %>
<html>
<head>
<%
	int	iauto=2000;
	String s_url ="emptyRoom.jsp";
	
	String Cflag = request.getParameter("flag");
	
	if(Cflag == null) Cflag="0";
	
	int icnt = Integer.parseInt(Cflag) +1;
	
	if(icnt >10 ) icnt=1;
	s_url = String.format("%s?flag=%d",s_url,icnt);

%>
<script>
	function refresh_start(){
		location.href='<%=s_url%>'
	}
</script>
</head>
<body>
<center>
<h2>1등 호텔 예약 사이트[호텔 코파유]</h1>
<table border=1 cellpadding=0 cellspacing =0>
<tr bgcolor='#BDBDBD'>
	<td width=200><p align=center><b>리조트명</b></p></td>
	<td width=70><p align=center><b>대표</b></p></td>
	<td width=70><p align=center><b>예약하기</b></p></td>
	<td width=70><p align=center><b>빈방</b></p></td>
	<td width=200><p align=center><b>조회시간</b></p></td>
</tr>
<%
	try{	
		long start = System.currentTimeMillis();
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		ResultSet rset = stmt.executeQuery("select * from searchResort;");			//db의 내용을 조회한다.
		while(rset.next()){			
			out.println(			//조회된 내용을 출력한다.
				"<tr>"
				+"<form method='post' action='"+rset.getString(13)+"'>"
				+"	<td width=200><p align=left>"+rset.getString(11)+"</p></td>"
				+"	<td width=70><p align=center>"+rset.getString(12)+"</p></td>"
				+"	<td width=70><p align=center><input type='submit' value='홈페이지'></p></td>"
				+"	<td width=70><p align=right>"+rset.getString(8)+"개</p></td>"
				+"	<td width=200><p align=left>"+rset.getString(9)+"</p></td>"
				+"</form>"
				+"</tr>"	
			);				 
		
		}
		out.println("</table>");
		long end = System.currentTimeMillis();
		long time = end-start;
		out.println("작동시간 : " +time/1000.0);
		rset.close();
		stmt.close();
		conn.close();			
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<script>
var timer = setInterval('refresh_start()',<%=iauto%>);
</script>
</center>
</body>
</html>