<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<script>
	function register(state){
		myString = state;
		if(myString == "new"){
			myForm.action="gongji_insert_H.jsp";
			myForm.submit();
		}
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
<tr>           
	<td width=60  ><p align=center>5</p></td>
	<td width=300 ><p align=left><a href=c_01.jsp>공지사항4</p></td>
	<td width=100 ><p align=center>2017-02-28</p></td>	
</tr>
</table>

<form method="post" name= myForm>
<table>
<tr><td width= 460><p align=right><input type=button value="신규" onclick="register('new')" ></p></td></tr>
</table>
</form>


</table>
</body>
</html>
