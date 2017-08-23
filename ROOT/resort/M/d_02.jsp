<meta http-=equiv="Content-Type" content="text/thml; charset=UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*" %>
<html>
<head>
<%
	String resDate="";
	if(request.getParameter("resDate")!=null)
		resDate=request.getParameter("resDate");
	int room=0;
	if(request.getParameter("room")!=null)
		room=Integer.parseInt(request.getParameter("room"));
%>
</head>
<body BACKGROUND="image/bg33.JPG">
<center>
<%
	String loginOK=null;
		
	loginOK = (String)session.getAttribute("login_ok");
	if(loginOK!=null){
		if(loginOK.equals("yes"))
			out.println(" <h1>예약사항[관리자페이지]</h1><br> ");
	}
	else{
		out.println(" <h1>예약하기</h1><br> ");
	}
%>

<form method="post" action="resInsert.jsp">
<table border=1 cellspacing=0>
<tr>
	<td width=40%><p align=center>성명</p></td>
	<td width=60%><input type=text name="rName"  maxlength=17 value="" required></td>
</tr>	
<%
	Calendar cal = Calendar.getInstance();
	SimpleDateFormat dformat = new SimpleDateFormat("yyyy-MM-dd");
	String nowdate= dformat.format(cal.getTime());
	cal.add(cal.DATE, +29);	
	String maxdate= dformat.format(cal.getTime());	
	if(resDate.length()==0)
		resDate=nowdate;

	String[] choise = {"","",""};
	if(room!=0)
		choise[room-1]+="selected = \"selected\" ";		
%>	
<tr>
	<td width=40%><p align=center>예약일자</p></td>
	<td width=60%><input type="date" maxlength='10' name="date" max="<%=maxdate%>" min="<%=nowdate%>" value=<%=resDate%> required></td>
	 
</tr>
<tr>
	<td width=40%><p align=center>예약방</p></td>
	<td width=60%><select name=resRoom><option value=1 <%=choise[0]%>>Sweet Room
									   <option value=2 <%=choise[1]%>>Privilege Room
									   <option value=3 <%=choise[2]%>>Classic Room
	</select></td>
</tr>	
<tr>
	<td width=40%><p align=center>주소</p></td>
	<td width=60%><input type=text name="address" size= 30% maxlength="50" value="" required></td>
</tr>	
<tr>
	<td width=40%><p align=center>전화번호</p></td>
	<td width=60%><input type=text name="phone" maxlength='11'  onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;" value="" required></td>	
</tr>	
<tr>
	<td width=40%><p align=center>입금자명</p></td>
	<td width=60%><input type=text name="money" maxlength="17" value="" required></td>
</tr>
<tr>
	<td width=40%><p align=center>남기실말</p></td>
	<td width=60%><p align=left><textarea style ='width:100%; height:20%;' maxlength=400 name = "content" cols=70 row=600 ></textarea></p></td>
</tr>		
<tr>
<td colspan=2><p align= center><input type="submit" value="전송"></p></td>
</tr>
</table>
</center>
</body>
</html>