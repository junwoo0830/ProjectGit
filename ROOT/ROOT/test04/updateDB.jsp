<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<%	//get한 정보가 있는지 확인 및 쓰레기 정보를 제거한다.
	String check2 = request.getParameter("stdName");
	check2=check2.replaceAll(" ","").replaceAll(",","").replaceAll("<","").replaceAll(">","").replaceAll(">","");
	String name=new String(check2.getBytes("8859_1"),"utf-8");	
	int stdID = 0;
	if((request.getParameter("stdID").length())!=0)
		stdID = Integer.parseInt(request.getParameter("stdID"));
	int kor = 0; //정보가 없을경우 국어성적은 0으로 한다.
	if((request.getParameter("kor").length())!=0)
		kor = Integer.parseInt(request.getParameter("kor"));
	int eng = 0; //정보가 없을경우 영어성적은 0으로 한다.
	if((request.getParameter("eng").length())!=0)
		eng = Integer.parseInt(request.getParameter("eng"));
	int mat = 0; //정보가 없을경우 수학성적은 0으로 한다.
	if((request.getParameter("mat").length())!=0)
		mat = Integer.parseInt(request.getParameter("mat"));
%>	
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	//TNS Data를 이용해서 서버에 접속!
	Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성	
	if(check2.length()==0)	//정보가 없을경우 이름은 무명으로 한다. 
	{
		out.println("<script>alert(\"이름이 없습니다.\");history.go(-1);</script>");
	}
	else{
		stmt.execute("update examtable set name='"+name+"',"+
										  "kor ="+kor+"," +
										  "eng ="+eng+"," +
										  "mat ="+mat+" where student="+stdID+";"
		);
	}
	ResultSet rset = stmt.executeQuery(" select name, student, kor, eng,mat, (kor+eng+mat) as asum,floor((kor+eng+mat)/3)  from examtable order by asum desc");	
	out.println("<p><h1>레코드 수정</h1></p>");
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
		if(stdID==rset.getInt(2))
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
