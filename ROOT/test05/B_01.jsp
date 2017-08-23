<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head></head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	//TNS Data를 이용해서 서버에 접속!
	Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
	//Query 실행후 결과를 resultSet에 저장
	ResultSet rset = stmt.executeQuery(" select * from hubo_table order by id asc");	
	
%>
<table border=2 cellspacing=0>
<tr>
	<td width=200 height=70 valign=center align=center><a href=A_01_H.jsp><h1>후보등록</h1></td>
	<td width=200 height=70 valign=center align=center bgcolor=#FAED7D><a href=B_01.jsp><h1>투표</h1></td>
	<td width=200 height=70 valign=center align=center><a href=c_01.jsp><h1>개표결과</h1></td>
</tr>
</table>
<table border=2 cellspacing=0>
<tr>
<td>
	<form method="post" action="B_02_H.jsp"> 
	<table border=0 cellspacing=0>
	<tr>
		<td width=250><p align=center><select name=choice>
<%		//후보 번호 이름 선택지 출력!
	while(rset.next()){
		out.println("<option value="+rset.getInt(1)+">"+rset.getInt(1)+"&nbsp&nbsp"+rset.getString(2));
	}
	rset.close();
	stmt.close();
	conn.close();		
%>				</select></p></td>
		<!--연련별 투표 나이 선택지 등록-->
		<td width=250><p align=center><select name=age>   <option value=1>10대
														  <option value=2>20대
														  <option value=3>30대
														  <option value=4>40대
														  <option value=5>50대
														  <option value=6>60대
														  <option value=7>70대
														  <option value=8>80대
														  <option value=9>90대
		</select></p></td>
		<td width=150><p align=center><input type = "submit" value="투표하기"></p></td>
	</tr>
	</table>
	</form>	
</td>
</tr>
</table>
</body>
</html>
