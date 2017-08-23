<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<script>
	function register(myString){
		if(myString == "delete"){
			myForm.action="sale_delete_H.jsp";
		}
		if(myString == "update"){
			myForm.action="sale_update_H.jsp";		
		}
		if(myString == "state"){
			myForm.action="sale_state_H.jsp?state=update";		
		}
		if(myString == "Allview"){
			myForm.action="sale_view_H.jsp";		
		}
		myForm.submit();
	}
</script>
</head>
<body>

<table border=1 cellpadding=5 cellspacing=0>
<tr>
	<td width=600><p align=center>(주)트와이스 재고 현황-상품삭제</p></td>
</tr>
<tr>
	<td><p align=center><table border=0 cellspacing=0 width=600 height=400>
		<tr>           			
			<td width=600 height=60 ><p align=left></p></td>
			
		</tr>
		<tr>           			
			<td width=600 align=center height=100><p ><h1>[바나나]상품이 삭제되었습니다.</h1></p></td>			
		</tr>
		<tr>
			<form method="post" name="myForm">
			<td width=600 height=100 valign=top><p align=center><input type=button value="재고현황" onclick=register("Allview")></p></td>
			</form>
		</tr>		
	</table></p></td>
</tr>
</table>
</body>
</html>
