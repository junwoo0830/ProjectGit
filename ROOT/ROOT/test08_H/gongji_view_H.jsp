<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*,java.io.*"%>

<html>
<head></head>
<body>
<table border=1 cellspacing=1>
<tr>
	<td width = 40><p align = center>번호</p></td>
	<td width = 300><p align = center>제목</p></td>
	<td width = 80><p align = center>조회수</p></td>
	<td width = 80><p align = center>등록일</p></td>
</tr>
<tr>
	<td width = 40><p align = center>5</p></td>
	<td width = 300><p align = left ><a href="gongji_oneview_H.jsp">공지사항5</p></td>
	<td width = 80><p align = center>0</p></td>
	<td width = 80><p align = center>2017-02-28</p></td>
</tr>
</table>
<table>
<tr>
	<form method=post action="gongji_rootInsert_H.jsp">
	<td width = 460><p align = right><input type=submit value="신규"></td>
</tr>
</table>
</body>
</html>

