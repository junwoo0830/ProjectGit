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
%>
<table border=2 cellspacing=0>
<tr>            <!--화면 기능 설계 지금 보고 있는 커서는 노란색으로 표시, 하이퍼링크로 화면이동-->
	<td width=200 height=70 valign=center align=center bgcolor=#FAED7D><a href=A_01_H.jsp><h1>후보등록</h1></td>
	<td width=200 height=70 valign=center align=center><a href=B_01.jsp><h1>투표</h1></td>
	<td width=200 height=70 valign=center align=center><a href=c_01.jsp><h1>개표결과</h1></td>
</tr>
</table>
<table border=2 cellspacing=0>
<%	
	ResultSet rset = stmt.executeQuery(" select * from hubo_table");	//현재 후보들의 목록을 다 보여줍니다. 				
	while(rset.next()){													//삭제 버튼이 눌러질경우 해당 번호를 post해서
		out.println( 													//A_02_H에 보내집니다. 
		"	<tr>"+
		"	<td>"+
		"		<form method=\"post\" action=\"A_02_H.jsp\">"+
		"		<table border=0 cellspacing=0>"+
		"		<tr>"+
		" 			<td width=250 align=left>기호번호 : "+rset.getInt(1)+"</td>"+
		"			<input type=\"hidden\" name=\"regID\" value="+rset.getInt(1)+">"+
		"			<td width=250 align=left>후보명 : "+rset.getString(2)+"</td>"+
		"			<input type=\"hidden\" name=\"regName\" value="+rset.getString(2)+">"+
		"			<td width=150><p align=center><input type = \"submit\" value=\"삭제\"></p></td>"+
		"		</tr>"+		
		"		</table>"+
		"		</form>"+
		"	</td>"+
		"	</tr>"
		);
	}
%>
<tr>
<td>
	<form method="post" action="A_03_H.jsp">  <!--후보 추가 시 A_03_H에 번호랑 이름을 전달합니다.-->
	<table border=0 cellspacing=0>
	<tr>
<%
		int minID=0;
		int regID=0;
		while(true){  //비여있는 학생 번호를 찾는다. 단 최초번호는 1번으로 설정!
			minID++;
			rset = stmt.executeQuery("select * from hubo_table where id="+minID+";");
			if(!(rset.next()))
			{	
				regID=minID;
				break;
			}
		}
		out.println(		//기호번호는 자동 할당! 이며 readonly입니다.
			"<td width=250 align=left>기호번호 : <input type = \"number\" name=regID value="+regID+" readonly></td>"
		);
		rset.close();
		stmt.close();
		conn.close();
		
%>		
		<td width=250 align=left>후보명 : <input type = "text" name=regName maxlength=17 value="" required></td>
		<td width=150><p align=center><input type = "submit" value="추가"></p></td>
	</tr>
	</table>
	</form>	
</td>
</tr>
</table>
</body>
</html>
