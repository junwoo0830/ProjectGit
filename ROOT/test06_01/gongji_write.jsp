<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<%	
	String state="";
	if(request.getParameter("state")==null)
		state=request.getParameter("state");
	String title="";
	if(request.getParameter("title")==null)
		state=request.getParameter("title");
	int iid=0;
	if(request.getParameter("iid")==null)
		iid=Integer.parseInt(request.getParameter("iid"));	
	String date="";
	if(request.getParameter("date")==null)
		state=request.getParameter("date");
	String content="";
	if(request.getParameter("content")==null)
		state=request.getParameter("content");
%>
<script>
	function register(state){
		myString = state;
		if(myString == 'new'){
			myForm.action="gongji_insert.jsp";
			myForm.submit();
		}
		if(myString == 'cancel'){
			myForm.action="gongji_list.jsp";
			myForm.submit();
		}
		if(myString == 'insert'){
			myForm.action="gongji_view.jsp";
			myForm.submit();
		}
		if(myString == 'update'){
			myForm.action="gongji_update.jsp";
			myForm.submit();
		}		
	}
</script>
</head>
<body>
<%
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		ResultSet rset = stmt.executeQuery(" select * from gongji where id ="+iid+";");
		rset.next();
%>
<table border=1 cellspacing=1>
<tr>           
	<td width=70  ><p align=center>번호</p></td>
	<td width=400 ><p align=left><%=rset.getInt(1)%></p></td>
</tr>	
<tr>	
	<td width=70 ><p align=center>제목</p></td>
	<td width=400 ><p align=left><%=rset.getString(2)%></p></td>
</tr>
	<td width=70 ><p align=center>일자</p></td>
	<td width=400 ><p align=left><%=rset.getDate(3)%></p></td>
</tr>
</tr>
	<td width=70 ><p align=center>내용</p></td>
	<td width=400><p align=left><%=rset.getString(4)%></p></td>
</tr>
</table>
<form method="post" name= "myForm">
<table>
<tr>
<td width= 400><p align=right><input type=button value="목록" onclick="register('cancel')" ></p></td>
<td width= 70><p align=right><input type=button value="수정" onclick="register('update')" ></p></td>
</tr>

</table>
</form>
<%
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
</body>
</html>
