<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page import="java.util.*, java.text.*"  %>
<html>
<head>
<script>
	function register(myString){
		if(myString == 'new'){
			myForm.action="gongji_insert.jsp";
			}
		if(myString == 'cancel'){
			myForm.action="gongji_list.jsp";
		}
		if(myString == "insert"){
			myForm.action="gongji_view.jsp?stst=insert";
		}
		if(myString == 'update'){
			myForm.action="gongji_update.jsp";
		}
	myForm.submit();		
	}
</script>
</head>
<body>
<%
	 java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
	 String today = formatter.format(new java.util.Date());
%>
<form method="post" name= "myForm">
<table border=1 cellspacing=1>
<tr>           
	<td width=70  ><p align=center>번호</p></td>
	<td width=400 ><p align=left>신규</p></td>
</tr>	
<tr>	
	<td width=70 ><p align=center>제목</p></td>
	<td width=550 ><p align=left><input type="text" name="title" size=70 maxlength=70 value="" required></p></td>
</tr>
	<td width=70 ><p align=center>일자</p></td>
	<td width=400 ><p align=left><%=today%></p></td>
	<input type=hidden name = "date" value=<%=today%>>	
</tr>
<tr>
	<td width=70 ><p align=center>내용</p></td>
	<td width=550><textarea style ='width:500px; height:250px;' name= "content" cols=70 row=600 ></textarea></td>
</tr>
</table>

<table>
<tr>
<td width= 550><p align=right><input type=button value="취소" onclick="register('cancel')" ></p></td>
<td width= 70><p align=right><input type=button value="쓰기" onclick="register('insert')" ></p></td>
</tr>

</table>
</form>

</table>
</body>
</html>
