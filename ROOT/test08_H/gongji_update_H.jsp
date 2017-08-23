<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*,java.io.*"%>

<html>
<head>
<script>
	function buttonState(index){
		if(index == 'update')
			myForm.action="gongji_update_H.jsp";
		if(index == 'delete')
			myForm.action="gongji_delete_H.jsp";
		if(index == 'insert')
			myForm.action="gongji_insert_H.jsp?inputTyp=node";
		if(index == 'nodeinsert')
			myForm.action="gongji_oneview_H.jsp?inputTyp=nodeinsert";
		myForm.submit();			
	}

</script>
</head>
<body>
<form method=post name="myForm" action="gongji_view_H.jsp">
<table border=1 cellspacing=1>
<tr>
	<td width = 60><p align = left>번호</p></td>
	<td width = 440><p align = left>1</p></td>
	<input type=hidden name="id" value="1" >
</tr>
<tr>
	<td width = 60><p align = left>제목</p></td>
	<td width = 440><p align = left><input type=text size=50 maxlength=20 value="" required></p></td>
</tr>
<%
	 java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
	 String today = formatter.format(new java.util.Date());
%>
<tr>
	<td width = 60><p align = left>일자</p></td>
	<td width = 440><p align = left><%=today%></p></td>
	<input type=hidden name="date" value=<%=today%>>
</tr>
<tr>
	<td width = 60><p align = left>내용</p></td>
	<td width = 440><textarea style ='width:500px; height:250px;' name= "content" cols=70 row=600 ></textarea></td>
</tr>
<tr>
	<td width = 60><p align = left>원글</p></td>
	<td width = 440><p align = left><input type=number size=5 name=rootid value="2" readonly></p></td>
</tr>
<tr>
	<td width = 60><p align = left>댓글수준</p></td>
	<td width = 440><p align = left><input type=number size=5 name=nodeid value="1" readonly></p></td>
</tr>
</table>
<table>
<tr>	
	<td width = 440><p align = right><input type=submit value="취소"></td>
	<td width = 40><p align = center><input type=button value="쓰기" onclick="buttonState('nodeinsert')"></td>
</tr>
</table>
</form>
</body>
</html>

