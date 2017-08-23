<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<script>
	function register(myString){
		if(myString == "delete"){
			myForm.action="sale_state_H.jsp?state=delete";
		}
		if(myString == "update"){
			myForm.action="sale_update_H.jsp";		
		}
		myForm.submit();
	}
</script>
</head>
<body>

<table border=1 cellpadding=5 cellspacing=0>
<tr>
	<td width=600><p align=center>(주)트와이스 재고 현황-상품상세</p></td>
</tr>
<tr>
	<td><p align=center><table border=1 cellspacing=0>
		<tr>           			
			<td width=100 ><p align=left>상품 번호</p></td>
			<td width=460 ><p align=left>1212122</p></td>
			<input type="hidden" name="id" value="1212122">
		</tr>
		<tr>           			
			<td width=100 ><p align=left>상품명</p></td>
			<td width=460 ><p align=left>바나나</p></td>
		</tr>
		<tr>           			
			<td width=100 ><p align=left>재고 현황</p></td>
			<td width=460 ><p align=left>10</p></td>
		</tr>
				<tr>           			
			<td width=100 ><p align=left>상품등록일</p></td>
			<td width=460 ><p align=left>2017-06-10</p></td>
		</tr>
				<tr>           			
			<td width=100 ><p align=left>재고등록일</p></td>
			<td width=460 ><p align=left>2017-06-10</p></td>
		</tr>
				<tr>           			
			<td width=100 ><p align=left>상품설명</p></td>
			<td width=460 ><p align=left>알래스카산 바나나로 맘모스의 아침식사</p></td>
		</tr>
				<tr>           			
			<td width=100 ><p align=left>상품 사진</p></td>
			<td width=460 height=400><p align=left><img src="twice0.jpg" width=380 height=380> </p></td>
		</tr>
	</table></p></td>
</tr>
<tr>
	<td><table>
		<tr>			
			<form method="post" name="myForm">
				<td width= 250><p align=right><input type=submit value="상품삭제" onclick=register("delete")></p></td>
				<td width= 250><p align=right><input type=button value="재고수정" onclick=register("update")></p></td>
			</form>
		</tr>
	</table></td>
</tr>
</table>
</body>
</html>
