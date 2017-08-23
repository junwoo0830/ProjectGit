<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<script>
	function register(myString){
		if(myString == "delete"){
			myForm.action="sale_state.jsp?state=delete";
		}
		if(myString == "update"){
			myForm.action="sale_update.jsp";		
		}
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
	String proj="";
	String staus="";
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		ResultSet rset = stmt.executeQuery(" select * from twiceUTong where id = "+id+";");
		rset.next();
		out.println(rset.getString(7));
%>


<table border=1 cellpadding=5 cellspacing=0>
<tr>
	<td width=600><p align=center>(주)트와이스 재고 현황-상품상세</p></td>
</tr>
<form method="post" name="myForm">
<tr>
	<td><p align=center><table border=1 cellspacing=0>
		<tr>           			
			<td width=100 ><p align=left>상품 번호</p></td>
			<td width=460 ><p align=left><%=rset.getInt(1)%></p></td>
			<input type="hidden" name="id" value="<%=rset.getInt(1)%>">
		</tr>
		<tr>           			
			<td width=100 ><p align=left>상품명</p></td>
			<td width=460 ><p align=left><%=rset.getString(2)%></p></td>
		</tr>
		<tr>           			
			<td width=100 ><p align=left>재고 현황</p></td>
			<td width=460 ><p align=left><%=rset.getInt(3)%></p></td>
		</tr>
				<tr>           			
			<td width=100 ><p align=left>상품등록일</p></td>
			<td width=460 ><p align=left><%=rset.getString(4)%></p></td>
		</tr>
				<tr>           			
			<td width=100 ><p align=left>재고등록일</p></td>
			<td width=460 ><p align=left><%=rset.getString(5)%></p></td>
		</tr>
				<tr>           			
			<td width=100 ><p align=left>상품설명</p></td>
			<td width=460 ><p align=left><%=rset.getString(6)%></p></td>
		</tr>
				<tr>           			
			<td width=100 ><p align=left>상품 사진</p></td>
			<td width=460 height=400><p align=left><img src=<%=rset.getString(7)%> width=380 height=380> </p></td>
		</tr>
	</table></p></td>
</tr>
<tr>
	<td><table>
		<tr>			
			
				<td width= 450><p align=right><input type=submit value="상품삭제" onclick=register("delete")></p></td>
				<td width= 50><p align=right><input type=button value="재고수정" onclick=register("update")></p></td>
			
		</tr>
	</table></td>
</tr>
</form>
</table>
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
