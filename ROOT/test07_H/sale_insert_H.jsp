<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html><head>
<script>
	function register(myString){
		if(myString == "delete"){
			myForm.action="sale_delete_H.jsp";
		}
		if(myString == "update"){
			myForm.action="sale_update_H.jsp";		
		}
		if(myString == "complete"){
			myForm.action="sale_state_H.jsp?state=insert";		
		}
		myForm.submit();
	}
</script>
</head><body>
<form method="post" name="myForm">
<table border=1 cellpadding=5 cellspacing=0>
<tr>
	<td width=600><p align=center>(주)트와이스 재고 현황-상품등록</p></td>
</tr>
<tr>
	<td><p align=center><table border=1 cellspacing=0>
		<tr>           			
			<td width=100 ><p align=left>상품 번호</p></td>
			<td width=460 ><p align=left><input type="text" size=50 maxlength=50 name="id" value="1212122"></p></td>
		</tr>
		<tr>           			
			<td width=100 ><p align=left>상품명</p></td>
			<td width=460 ><p align=left><input type="text" size=50 maxlength=50 name="title" value="바나나"></p></td>
		</tr>
		<tr>           			
			<td width=100 ><p align=left>재고 현황</p></td>
			<td width=460 ><p align=left><input type="number" size=50 maxlength=50 name="storeNum" value="10"></p></td>
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
			<td width=460 ><p align=left><input type="text" size=70 maxlength=70 name="content" value="알래스카산 바나나로 맘모스의 아침식사"></p></td>
		</tr>
		<tr>           			
			<td width=100 ><p align=left>상품 사진</p></td>
			<td width=460 height=400 align =left valign=top><img src="twice0.jpg" width=150 height=150 vspace=10 hspace=10>
				<input type=button value="Upload" onclick=register("upload")>
				<p align=left>   <input type="text" size=70 maxlength=70 name="URL" value="twice0.jpg"></p>
			</td>		
		</tr>
	</table></p></td>
</tr>
<tr>
	<td><table>
		<tr>
			<td width= 550><p align=right><input type=button value="완료" onclick=register("complete")></p></td>			
		</tr>	</table></td></tr></table></form></body></html>
