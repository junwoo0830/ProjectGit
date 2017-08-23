<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<%	int regID=Integer.parseInt(request.getParameter("regID"));%>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	//TNS Data를 이용해서 서버에 접속!
	Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
	//Query 실행후 결과를 resultSet에 저장
	ResultSet rset = stmt.executeQuery(" select * from hubo_table where id="+regID);	 //전달 받은 후보자의 정보를 저장한다. 
	int[] iid = new int[100];
	String[] iName = new String[100];
	int count=0;
	while(rset.next()){						//후보자의 정보를 저장
		iid[count]=rset.getInt(1);
		iName[count++]=rset.getString(2);		
	}
	int maxNum=0;			//한 후보의 투표 수를 받는다.
	rset = stmt.executeQuery(" select count(age) from Tupyo_table where id ="+regID+";");
	if(rset.next()){
		maxNum=rset.getInt(1);
		if(maxNum==0)		//만약 0표의 득표를 했을경우 나눗셈의 오류를 막기위해 1을 준다. 
			maxNum=1;
	}
%>
<table border=2 cellspacing=0>
<tr>
	<td width=200 height=70 valign=center align=center><a href=A_01_H.jsp><h1>후보등록</h1></td>
	<td width=200 height=70 valign=center align=center><a href=B_01.jsp><h1>투표</h1></td>
	<td width=200 height=70 valign=center align=center bgcolor=#FAED7D><a href=c_01.jsp><h1>개표결과</h1></td>
</tr>
</table>
<table border=2 cellspacing=0>
<%
	out.println("<p><h1>"+iid[0]+"."+iName[0]+" 후보 득표성향 분석 </h1></p>");
	int nowNum=0;
	for(int i=0; i<9; i++){  //연령은 10대에서 90대로 루프를 돌게 만든다. 
		rset = stmt.executeQuery(" select  count(age) from Tupyo_table where id="+regID+" and age="+(i+1)+";");
		if(rset.next()){
			nowNum = rset.getInt(1);
			out.println(
			"	<tr>"+
			"	<td width=75><p align=center>"+(i+1)+"0대</p></td>"+
			"	<td width=500><p align=left><img src='bar.jpg' width="+Math.floor(((double)nowNum/maxNum)*400)+
									" height=20> "+nowNum+"("+(int)Math.floor(((double)nowNum/maxNum)*100)+"%)</p></td>"+
			"	</tr>"
			);						
		}
	}
	rset.close();
	stmt.close();
	conn.close();		
%>
</table></body></html>
