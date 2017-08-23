<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<%
	String check2="";
	int stdID =0;
	if(request.getParameter("stdName")!=null) {	//학생 이름의 get한 내용이 있는지 확인
		check2 = request.getParameter("stdName");
		String name=new String(check2.getBytes("8859_1"),"utf-8");
	}
	if(request.getParameter("stdID")!=null)    //학생번호의 get한 내용이 있는지 확인
		stdID = Integer.parseInt(request.getParameter("stdID"));		
%>	
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	//TNS Data를 이용해서 서버에 접속!
	Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
	//Query 실행후 결과를 resultSet에 저장
	ResultSet rset = stmt.executeQuery(" select name, student, kor, eng,mat, (kor+eng+mat) as asum,floor((kor+eng+mat)/3)  from examtable order by asum desc");	
	out.println("<p><h1>조회</h1></p>");
%>
<table cellspacing=1 width=600 border=1>	<!--table의 fieldName을 출력한다-->
<tr>
<td width=50><p align=center>이름</p></td>
<td width=50><p align=center>학번</p></td>
<td width=50><p align=center>국어</p></td>
<td width=50><p align=center>영어</p></td>
<td width=50><p align=center>수학</p></td>
<td width=50><p align=center>총점</p></td>
<td width=50><p align=center>평균</p></td>
<td width=50><p align=center>등수</p></td>
</tr>
<%
	int count=1;
	int checkRank=0;
	int preSum=0;
	while(rset.next()){					//조회된 table의 내용을 출력한다. 
		if(stdID==rset.getInt(2))		//만약 get정보로 들어온 학생 정보가 있을경우 그 문단의 색을 바꾼다.
			out.println("<tr bgcolor=#FAED7D>");
		else
			out.println("<tr>");			//1번 컬럼은 하이퍼링크를 이용해서 이름을 눌렀을 경우 이 학생의 정보만 출력되는 주소로 연결!
		out.println("<td width=30><a href=oneview.jsp?stdID="+rset.getInt(2)+"><p align=center>"+rset.getString(1)+"</p></a></td>");
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
		count++;
		preSum=rset.getInt(6);
	}
	rset.close();
	stmt.close();
	conn.close();
%>
</table>
</body>
</html>
