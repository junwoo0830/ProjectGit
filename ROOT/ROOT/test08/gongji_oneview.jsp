<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*,java.io.*"%>

<html>
<head>
<script>
	function buttonState(index){
		if(index == 'update')
			myForm.action="gongji_update.jsp";
		if(index == 'delete')
			myForm.action="gongji_stateview.jsp?inputTyp=delete";
		if(index == 'insert')
			myForm.action="gongji_nodeInsert.jsp";
		myForm.submit();			
	}
</script>
<%
	int id=0;
	if(request.getParameter("id")!=null)
		id=Integer.parseInt(request.getParameter("id"));
%>
</head>
<body>
<%
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		ResultSet rset = stmt.executeQuery("select *from gongji where id="+id+";");
		rset.next();
%>
<form method=post name="myForm" action="gongji_view.jsp">
<table border=1 cellspacing=1>
<tr>
	<td width = 60><p align = left>번호</p></td>
	<td width = 440><p align = left><%=rset.getInt(1)%></p></td>
	<input type="hidden" name="id" value="<%=rset.getInt(1)%>">	
</tr>
<tr>
	<td width = 60><p align = left>제목</p></td>
	<td width = 440><p align = left><%=rset.getString(2)%></p></td>
</tr>
<tr>
	<td width = 60><p align = left>일자</p></td>
	<td width = 440><p align = left><%=rset.getString(3)%></p></td>
</tr>
<tr>
	<td width = 60><p align = left>조회수</p></td>
	<td width = 440><p align = left><%=rset.getInt(7)%></p></td>
</tr>
<tr>
	<td width = 60><p align = left>내용</p></td>
	<td width = 440><p align = left><%=rset.getString(4).replaceAll("\n","<br>")%></p></td>
</tr>
<tr>
	<td width = 60><p align = left>원글</p></td>
	<td width = 440><p align = left><%=rset.getInt(5)%></p></td>
	<input type="hidden" name="rootid" value="<%=rset.getInt(5)%>">
</tr>
<tr>
	<td width = 60><p align = left>댓글수준</p></td>
	<td width = 440><p align = left><%=rset.getInt(6)%></p></td>
	<input type="hidden" name="nodeid" value="<%=rset.getInt(6)%>">
	<input type="hidden" name="viewRank" value="<%=rset.getInt(8)%>">
</tr>
</table>
<%
	stmt.execute("update gongji set viewcnt="+(rset.getInt(7)+1)+" where id="+id+";");
%>
<table>
<tr>	
	<td width = 300><p align = right><input type=submit value="목록"></td>
	<td width = 40><p align = center><input type=button value="수정" onclick="buttonState('update')"></td>
	<td width = 40><p align = center><input type=button value="삭제" onclick="buttonState('delete')"></td>
	<td width = 40><p align = center><input type=button value="댓글추가" onclick="buttonState('insert')"></td>
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
</body>
</html>

