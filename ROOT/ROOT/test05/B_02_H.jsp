<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<%	//선택번호 및 나이를 가지고 온다. 
	int choiceID = 0;
	if(request.getParameter("choice")==null){			
		out.println("<script>alert(\"후보가 없습니다.\");history.back();</script>");		
	}
	else
		choiceID=Integer.parseInt(request.getParameter("choice"));

	
	int choiceage = Integer.parseInt(request.getParameter("age"));
%>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	//TNS Data를 이용해서 서버에 접속!
	Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성	
	
%>


<table border=2 cellspacing=0>
<tr>
	<td width=200 height=70 valign=center align=center><a href=A_01_H.jsp><h1>후보등록</h1></td>
	<td width=200 height=70 valign=center align=center bgcolor=#FAED7D><a href=B_01.jsp><h1>투표</h1></td>
	<td width=200 height=70 valign=center align=center><a href=c_01.jsp><h1>개표결과</h1></td>
</tr>
</table>
<table border=2 cellspacing=0>
<%
	try{		//투표DB에 값을 추가한다. 
		stmt.execute("  insert into  Tupyo_table  values("+choiceID+","+choiceage+");");		
		stmt.close();
		conn.close();				
	} catch (SQLException e) {			//sql에러가 있을시 에러 출력
		out.println("sql에러 발생 : " +e);
	}
%>
</table>
<p><h1>투표결과 : 투표하였습니다</h1></p>
</body>
</html>
