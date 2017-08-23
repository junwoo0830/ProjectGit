<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page import="java.util.*, java.text.*"  %>
<html><head>
<script>
	function register(myString){
		if(myString == 'new'){
			myForm.action="gongji_insert.jsp";
			}
		if(myString == 'cancel'){
			myForm.action="gongji_list.jsp";
		}
		if(myString == "insert"){
			myForm.action="gongji_view.jsp?stst=insert";
		}
		if(myString == 'update'){
			myForm.action="gongji_update.jsp";
		}
	myForm.submit();		
	}
</script>
</head>
<body>
<table border=1 cellspacing=1>
<tr>           
	<td width=60  ><p align=center>번호</p></td>
	<td width=300 ><p align=center>제목</p></td>
	<td width=100 ><p align=center>등록일</p></td>
</tr>
<%
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		ResultSet rset = stmt.executeQuery(" select * from gongji order by id desc;");
		while(rset.next()){
			out.println(
			"	<tr>           "+
			"		<td width=60  ><p align=center>"+rset.getInt(1)+"</p></td>"+
			"		<td width=300 ><p align=left><a href=gongji_view.jsp?key="+rset.getInt(1)+">"+rset.getString(2)+"</p></td>"+
			"		<td width=100 ><p align=center>"+rset.getDate(3)+"</p></td>	"+
			"	</tr>	"
			);
		
		}
		rset.close();
		stmt.close();
		conn.close();		
	}catch (ClassNotFoundException e) {	//클래스가 없으면 에러 출력			
		out.println("클래스에러 발생 : " +e);
	} catch (SQLException e) {			//sql에러가 있을시 에러 출력
		out.println("sql에러 발생 : " +e);
	}
%>
</table>
<form method="post" name= myForm>
<table>
<tr><td width= 460><p align=right><input type=button value="신규" onclick="register('new')" ></p></td></tr>
</table>
</form></table></body></html>