<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*,java.io.*"%>

<html>
<head>
<%
	String loginOK=null;
	String jumpURL="adm_login.jsp?jump=adm_allview.jsp";
	
	loginOK = (String)session.getAttribute("login_ok");
	if(loginOK==null){
		response.sendRedirect(jumpURL);
		return;
	}
	if(!loginOK.equals("yes")){
		response.sendRedirect(jumpURL);
		return;
	}
	int id=0;
	if(request.getParameter("id")!=null)
		id=Integer.parseInt(request.getParameter("id"));
	int rootid=0;
	if(request.getParameter("rootid")!=null)
		rootid=Integer.parseInt(request.getParameter("rootid"));
	int nodeid=0;
	if(request.getParameter("nodeid")!=null)
		nodeid=Integer.parseInt(request.getParameter("nodeid"));
	int viewRank=0;
	if(request.getParameter("viewRank")!=null)
		viewRank=Integer.parseInt(request.getParameter("viewRank"));
%>


<script>
	function buttonState(index){
		if(index == 'update')
			myForm.action="gongji_update.jsp";
		if(index == 'delete')
			myForm.action="gongji_delete.jsp";
		if(index == 'insert')
			myForm.action="gongji_insert.jsp?inputTyp=node";
		if(index == 'nodeinsert')
			myForm.action="gongji_stateview.jsp?inputTyp=nodeinsert";
		myForm.submit();			
	}

</script>

</head>
<body BACKGROUND="../image/bg33.JPG">
<center>
<h1>댓글을 입력해 주세요.</h1><br>
<form method=post name="myForm" action="e_02.jsp">
<table border=1 cellspacing=1>
<tr>
	<td width = 60><p align = left>번호</p></td>
	<td width = 440><p align = left>댓글 <input type=text value="INSERT" readonly></p></td>
</tr>
<tr>
	<td width = 60><p align = left>제목</p></td>
	<td width = 440><p align = left><input type=text size=50 maxlength=20 name="title" value="" required></p></td>
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
	<td width = 440><textarea style ='width:500px; height:250px;' maxlength=200 name= "content" cols=70 row=600 ></textarea></td>
</tr>
<tr>
	<td width = 60><p align = left>원글</p></td>
	<td width = 440><p align = left><input type=number size=5 name="rootid" value="<%=rootid%>" readonly></p></td>
</tr>
<tr>
	<td width = 60><p align = left>댓글수준</p></td>
	<td width = 440><p align = left><input type=number size=5 name="nodeid" value="<%=(nodeid+1)%>" readonly></p></td>
	<input type="hidden" name="viewRank" value="<%=viewRank+1%>">
</tr>
</table>
<table>
<tr>	
	<td width = 440><p align = right><input type=submit value="취소"></td>
	<td width = 40><p align = center><input type=button value="쓰기" onclick="buttonState('nodeinsert')"></td>
</tr>
</table>
</form>
</center>
</body>
</html>

