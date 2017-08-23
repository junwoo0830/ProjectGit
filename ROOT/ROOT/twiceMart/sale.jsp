<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<script>
	function register(myString){
		if(myString == "cancle"){
			myForm.action="sale_view.jsp";
		}
		if(myString == "sale"){
			myForm.action="sale_state.jsp?state=sale";		
		}
		myForm.submit();
	}
</script>
<%
	String id="";
	if(request.getParameter("id")!=null)
		id=request.getParameter("id");
%>
</head>
<body>
<%
	String proj="";
	String staus="";
	String Sid="";
	String Sname="";
	int Sstore=0;
	String sdate="";
	String gdate="";
	String Scontent="";
	String UURl="";
	
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		ResultSet rset = stmt.executeQuery(" select * from twiceUTong where id = "+id+";");
		if(rset.next()){
			//Sid=rset.getString(1);
			Sname=rset.getString(2);
			Sstore=rset.getInt(3);
			sdate=rset.getString(4);
			gdate=rset.getString(5);
			Scontent=rset.getString(6);
			UURl=rset.getString(7);			
		}
%>


<table border=1 cellpadding=5 cellspacing=0>
<tr>
	<td width=600><p align=center>(주)트와이스 재고 현황-상품상세</p></td>
</tr>
<form method="post" name="myForm" action="sale.jsp">
<tr>
	<td><p align=center><table border=1 cellspacing=0>
		<tr>           			
			<td width=100 ><p align=left>상품 번호</p></td>
			<td width=460 ><p align=left><input type="text" name="id" value="<%=Sid%>"><input type=submit value="검색"></p></td>			
		</tr>
		<tr>           			
			<td width=100 ><p align=left>상품명</p></td>
			<td width=460 ><p align=left><%=Sname%></p></td>
		</tr>
		<tr>           			
			<td width=100 ><p align=left>재고 현황</p></td>
			<td width=460 ><p align=left><%=Sstore%></p></td>
		</tr>
				<tr>           			
			<td width=100 ><p align=left>상품등록일</p></td>
			<td width=460 ><p align=left><%=sdate%></p></td>
		</tr>
				<tr>           			
			<td width=100 ><p align=left>재고등록일</p></td>
			<td width=460 ><p align=left><%=gdate%></p></td>
		</tr>
				<tr>           			
			<td width=100 ><p align=left>상품설명</p></td>
			<td width=460 ><p align=left><%=Scontent%></p></td>
		</tr>
				<tr>           			
			<td width=100 ><p align=left>상품 사진</p></td>
		<% 
			if(!(Sid.equals("")))
				out.println("<td width=460 height=400><p align=left><img src="+UURl+"  width=380 height=380> </p></td>");
			else
				out.println("<td width=460 height=400><p align=left></p></td>");
		%>
		</tr>
	</table></p></td>
</tr>
<tr>
	<td><table>
		<tr>			
			
				<td width= 450><p align=right><input type=button value="취소" onclick=register("cancle")></p></td>
				<td width= 50><p align=right><input type=button value="판매" onclick=register("sale")></p></td>
			
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
