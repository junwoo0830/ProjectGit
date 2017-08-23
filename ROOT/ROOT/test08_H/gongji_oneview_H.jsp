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
			myForm.action="gongji_nodeInsert_H.jsp";
		myForm.submit();			
	}

</script>
</head>
<body>
<form method=post name="myForm" action="gongji_view_H.jsp">
<table border=1 cellspacing=1>
<tr>
	<td width = 60><p align = left>번호</p></td>
	<td width = 440><p align = left>10</p></td>
	<input type="hidden" name="id" value="10">
</tr>
<tr>
	<td width = 60><p align = left>제목</p></td>
	<td width = 440><p align = left>난 댓글입니다.</p></td>
</tr>
<tr>
	<td width = 60><p align = left>일자</p></td>
	<td width = 440><p align = left>2017-03-07</p></td>
</tr>
<tr>
	<td width = 60><p align = left>조회수</p></td>
	<td width = 440><p align = left>2</p></td>
</tr>
<tr>
	<td width = 60><p align = left>내용</p></td>
	<td width = 440><p align = left>난 댓글입니다.난 댓글입니다.난 댓글입니다.난 댓글입니다.</p></td>
</tr>
<tr>
	<td width = 60><p align = left>원글</p></td>
	<td width = 440><p align = left>2</p></td>
</tr>
<tr>
	<td width = 60><p align = left>댓글수준</p></td>
	<td width = 440><p align = left>1</p></td>
</tr>
</table>
<table>
<tr>	
	<td width = 300><p align = right><input type=submit value="목록"></td>
	<td width = 40><p align = center><input type=button value="수정" onclick="buttonState('update')"></td>
	<td width = 40><p align = center><input type=button value="삭제" onclick="buttonState('delete')"></td>
	<td width = 40><p align = center><input type=button value="댓글추가" onclick="buttonState('insert')"></td>
</tr>
</table>
</form>
</body>
</html>

