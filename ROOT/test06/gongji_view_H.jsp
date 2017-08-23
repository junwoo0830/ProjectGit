<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<script>
	function register(state){
		myString = state;
		if(myString == 'new'){
			myForm.action="gongji_insert_H.jsp";
			myForm.submit();
		}
		if(myString == 'cancel'){
			myForm.action="gongji_list_H.jsp";
			myForm.submit();
		}
		if(myString == 'insert'){
			myForm.action="gongji_view_H.jsp";
			myForm.submit();
		}
		if(myString == 'update'){
			myForm.action="gongji_update_H.jsp";
			myForm.submit();
		}		
	}
</script>
</head>
<body>
<table border=1 cellspacing=1>
<tr>           
	<td width=70  ><p align=center>번호</p></td>
	<td width=400 ><p align=left>2</p></td>
</tr>	
<tr>	
	<td width=70 ><p align=center>제목</p></td>
	<td width=400 ><p align=left>공지사항2</p></td>
</tr>
	<td width=70 ><p align=center>일자</p></td>
	<td width=400 ><p align=left>2017-03-06</p></td>
</tr>
</tr>
	<td width=70 ><p align=center>내용</p></td>
	<td width=400><p align=left>공지사항내용2</p></td>
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
</table>
</body>
</html>
