<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<script>
	function register(state){
		myString = state;
		if(myString == "new"){
			myForm.action="sale_insert_H.jsp";
			myForm.submit();
		}
	}
</script>
</head>
<body>

<table border=1 cellpadding=5 cellspacing=0>
<tr>
	<td width=600><p align=center>(주)트와이스 재고 현황-전체현황</p></td>
</tr>
<tr>
	<td><p align=center><table border=1 cellspacing=0>
		<tr>           
			<td width=60  ><p align=center>번호</p></td>
			<td width=200 ><p align=center>상품명</p></td>
			<td width=100 ><p align=center>현재 재고수</p></td>
			<td width=100 ><p align=center>재고파악일</p></td>
			<td width=100 ><p align=center>상품등록일</p></td>
		</tr>
		<tr>           
			<td width=60  ><p align=center><a href=sale_oneview_H.jsp>1</p></td>
			<td width=200 ><p align=center><a href=sale_oneview_H.jsp>바나나</p></td>
			<td width=100 ><p align=center>10</p></td>
			<td width=100 ><p align=center>2016-06-10</p></td>
			<td width=100 ><p align=center>2017-01-01</p></td>
		</tr>
	</table></p></td>
</tr>
<tr>
	<td><table>
		<tr>
			<td width=30><p align=center><a href=pale_view_H.jsp>1</p></td>	
			<form method="post" name= myForm action="sale_insert_H.jsp">
				<td width= 550><p align=right><input type=submit value="신규등록"></p></td>
			</form>
		</tr>
	</table></td>
</tr>
</table>
</body>
</html>
