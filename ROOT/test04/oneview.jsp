<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<%
	int stdiid=0; 
	if(request.getParameter("stdID")==null) //get방식으로 data를 가지고 온다. 
		stdiid=209907;						//이때 data가 없을경우 다현의 stdID를 준다!
	else
		stdiid=Integer.parseInt(request.getParameter("stdID"));
	
%>	
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	//TNS Data를 이용해서 서버에 접속!
	Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
	ResultSet rset = stmt.executeQuery(" select name, student, kor, eng,mat, (kor+eng+mat) as asum,floor((kor+eng+mat)/3)  from examtable order by asum desc");	
			
%>
<%
	int count=1;
	int checkRank=0;
	int preSum=0;
	while(rset.next()){ //조회 된 학생의 정보를 출력한다.
		if(rset.getInt(2) == stdiid) {
			out.println("<p><h1>["+rset.getString(1)+"]조회</h1></p>");	
			out.println(
			"<table cellspacing=1 width=600 border=1>"+
			"	<tr>"+
			"	<td width=50><p align=center>이름</p></td>"+
			"	<td width=50><p align=center>학번</p></td>"+
			"	<td width=50><p align=center>국어</p></td>"+
			"	<td width=50><p align=center>영어</p></td>"+
			"	<td width=50><p align=center>수학</p></td>"+
			"	<td width=50><p align=center>총점</p></td>"+
			"	<td width=50><p align=center>평균</p></td>"+
			"	<td width=50><p align=center>등수</p></td>"+
			"</tr>");
			out.println("<tr>");
			out.println("<td width=50><p align=center>"+rset.getString(1)+"</p></td>");
			out.println("<td width=50><p align=center>"+rset.getInt(2)+"</p></td>");
			out.println("<td width=50><p align=center>"+rset.getInt(3)+"</p></td>");
			out.println("<td width=50><p align=center>"+rset.getInt(4)+"</p></td>");
			out.println("<td width=50><p align=center>"+rset.getInt(5)+"</p></td>");		 
			out.println("<td width=50><p align=center>"+rset.getInt(6)+"</p></td>");
			out.println("<td width=50><p align=center>"+rset.getInt(7)+"</p></td>");
			if(rset.getInt(6)==preSum)
				out.println("<td width=50><p align=center>"+checkRank+"</p></td>");	
			else
			{	
				out.println("<td width=50><p align=center>"+count+"</p></td>");	
				checkRank=count;
			}			
			out.println("</tr>");
		}
		if(rset.getInt(6)!=preSum)
		{				
			checkRank=count;
		}
		count++;
		preSum=rset.getInt(6);
		out.println("</tr>");	
	}
	rset.close();
	stmt.close();
	conn.close();
%>
</table>
</body>
</html>
