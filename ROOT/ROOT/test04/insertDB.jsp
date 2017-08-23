<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<%	//get한 정보가 있는지 확인 및 쓰레기 정보를 제거한다.
	String check2 = request.getParameter("stdName");  
	String name= "";
	check2=check2.replaceAll(" ","").replaceAll(",","").replaceAll("<","").replaceAll(">","").replaceAll("&","");
	name= new String(check2.getBytes("8859_1"),"utf-8");		
	int kor = 0; //정보가 없을경우 국어성적은 0으로 한다.
	String kkor = request.getParameter("kor");
	if((kkor.length())!=0)
		kor = Integer.parseInt(kkor);
	int eng = 0; //정보가 없을경우 영어성적은 0으로 한다.
	String eeng = request.getParameter("eng");
	if((eeng.length())!=0)
		eng = Integer.parseInt(eeng);
	int mat = 0; //정보가 없을경우 수학성적은 0으로 한다.
	String mmat = request.getParameter("mat");
	if((mmat.length())!=0)
		mat = Integer.parseInt(mmat);
%>	
</head>
<body>
<%
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	//TNS Data를 이용해서 서버에 접속!
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		ResultSet rset = stmt.executeQuery("select min(student) from examtable;");	 // 조회된 stdID를 이용해서 해당 학생의 정보를 가지고온다.
		int stdID = 0;
		int minID =0;
		if(rset.next())
			minID = rset.getInt(1);
		while(true){  //비여있는 학생 번호를 찾는다.
			minID++;
			rset = stmt.executeQuery("select student from examtable where student="+minID+";");
			if(!(rset.next()))
			{	
				stdID=minID;
				break;
			}
		}
		if(name.length()==0)	//정보가 없을경우 이름은 무명으로 한다. 
		{
			out.println("<script>alert(\"이름이 없습니다.\");history.back();</script>");
		}
		else{
			stmt.execute("insert into examtable(name,student, kor, eng, mat) values ('"+name+"',"+stdID+","+kor+","+eng+","+mat+");");
		}		
		rset = stmt.executeQuery("select *from examtable where student="+stdID+";");	 // 조회된 stdID를 이용해서 해당 학생의 정보를 가지고온다.

	
		
		while(rset.next()){ 			//추가된 학생의 정보를 출력한다. 
			out.println("<p><h1>성적입력추가완료</h1></p>");
			out.println(  								//뒤로가기 버튼에 AllviewDB를 연결! 
			"	<form method=\"post\" action=\"AllviewDB.jsp\"> "+  
			"	<table border=0 cellspacing=1>"+
			"	<tr><td width=280 align=right><input type = \"submit\" value=\"뒤로가기\" ></td></tr></table>"+
			"	<table border=1 cellspacing=1>"+
			"	<tr>"+
			"	<td width=100><p align=center>이름</p></td>"+
			"	<td width=230><p align=center><input type = \"text\" name=\"stdName\" value="+rset.getString(1)+"></p></td>"+
			"	</tr>"+
			"	<tr>"+
			"	<td width=100><p align=center>학번</p></td>"+
			"	<td width=230><p align=center><input type = \"text\" name=\"stdID\" value="+rset.getInt(2)+"></p></td>"+
			"	</tr>"+
			"	<tr>"+
			"	<td width=100><p align=center>국어</p></td>"+
			"	<td width=230><p align=center><input type = \"text\" name=\"kor\" value="+rset.getInt(3)+"></p></td>"+
			"	</tr>   "+
			"	<tr>"+
			"	<td width=100><p align=center>영어</p></td>"+
			"	<td width=230><p align=center><input type = \"text\" name=\"eng\" value="+rset.getString(4)+"></p></td>"+
			"	</tr>"+
			"	<tr>"+
			"	<td width=100><p align=center>수학</p></td>"+
			"	<td width=230><p align=center><input type = \"text\" name=\"mat\" value="+rset.getString(5)+"></p></td>"+
			"	</tr>      	"+
			"	</form>"
			);		
		}
		rset.close();
		stmt.close();
		conn.close();	
	}catch (ClassNotFoundException e) {	//클래스가 없으면 에러 출력			
		out.println("클래스에러 발생 : " +e);
	} catch (SQLException e) {		//sql에러가 있을시 에러 출력
		out.println("sql에러 발생 : " +e);
	}
%>
</table>
</body>
</html>