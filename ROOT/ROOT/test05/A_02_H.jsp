<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<%
	String check2 = request.getParameter("regName");  //입력들어온 값을 한글로 변환
	String name= new String(check2.getBytes("8859_1"),"utf-8");
	int id = Integer.parseInt(request.getParameter("regID")); 
%>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	//TNS Data를 이용해서 서버에 접속!
	Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
	//Query 실행후 결과를 resultSet에 저장	
%>


<table border=2 cellspacing=0>  
<tr>				 <!--화면 기능 설계 지금 보고 있는 커서는 노란색으로 표시, 하이퍼링크로 화면이동-->
	<td width=200 height=70 valign=center align=center bgcolor=#FAED7D><a href=A_01_H.jsp><h1>후보등록</h1></td>
	<td width=200 height=70 valign=center align=center><a href=B_01.jsp><h1>투표</h1></td>
	<td width=200 height=70 valign=center align=center><a href=c_01.jsp><h1>개표결과</h1></td>
</tr>
</table>
<table border=2 cellspacing=0>
<%
	try{  //후보가 삭제될때 자동으로 투표의 결과도 삭제되도록 한다.
		stmt.execute(" delete from hubo_table where id ="+id+";");
		stmt.execute(" delete from Tupyo_table where id ="+id+";");	
		stmt.close();
		conn.close();		
	} catch (SQLException e) {			//sql에러가 있을시 에러 출력
		out.println("sql에러 발생 : " +e);
	}
%>
</table>
<p><h1>후보등록 결과 : 후보가 삭제 되었습니다. OK</h1></p>
</body>
</html>
