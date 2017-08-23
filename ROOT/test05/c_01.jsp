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
	ResultSet rset = stmt.executeQuery(" select * from hubo_table order by id asc");	  //모든 후보의 정보를 가지고온다. 
	int[] iid = new int[100];				//후보 번호를 저장
	String[] iName = new String[100];		//후보 이름을 저장
	int count=0;							//총 후보자의 숫자를 저장
	while(rset.next()){
		iid[count]=rset.getInt(1);
		iName[count++]=rset.getString(2);		
	}
	int maxNum=0;   //총 투표수를 측정한다. 
	rset = stmt.executeQuery(" select count(age) from Tupyo_table");
	if(rset.next()){
		maxNum=rset.getInt(1);
	}
	if(maxNum==0)
		maxNum=1;
%>
<table border=2 cellspacing=0>
<tr>
	<td width=200 height=70 valign=center align=center><a href=A_01_H.jsp><h1>후보등록</h1></td>
	<td width=200 height=70 valign=center align=center><a href=B_01.jsp><h1>투표</h1></td>
	<td width=200 height=70 valign=center align=center bgcolor=#FAED7D><a href=c_01.jsp><h1>개표결과</h1></td>
</tr>
</table>
<p><h1>후보별 특표율</h1></p>
<table border=2 cellspacing=0>
<%
	int nowNum=0;
	for(int i=0; i<count; i++){  //각 후보별 투표율을 측정하기 위해 for문을 작성
		rset = stmt.executeQuery(" select  count(age) from hubo_table  a join Tupyo_table b on a.id = b.id where a.id="+iid[i]+";");
		if(rset.next()){
			nowNum = rset.getInt(1);
			out.println(
			"	<tr>"+  //이름에는 태그를 걸어 이름을 눌렀을때 태그로 이동!
			"	<td width=75><p align=left><a href=c_02.jsp?regID="+iid[i]+">"+iid[i]+"&nbsp"+iName[i]+"</p></td>"+
			"	<td width=500><p align=left><img src='bar.jpg' width="+Math.floor(((double)nowNum/maxNum)*400)+" height=20> "+
																nowNum+"("+(int)Math.floor(((double)nowNum/maxNum)*100)+"%)</p></td>"+
			"	</tr>"
			);			
		}
	}
	rset.close();
	stmt.close();
	conn.close();		
%>
</table>
</body>
</html>
