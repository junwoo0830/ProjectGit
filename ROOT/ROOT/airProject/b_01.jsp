<meta http-dquiv="Content-type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.*,java.text.*" %>

<html>
<head>
<%
	String loginOK=null;
	String jumpURL="login/adm_login.jsp?jump=../b_01.jsp";
	
	loginOK = (String)session.getAttribute("login_ok");
	if(loginOK==null){
		response.sendRedirect(jumpURL);
		return;
	}
	if(!loginOK.equals("yes")){
		response.sendRedirect(jumpURL);
		return;
	}
	String loginID = (String)session.getAttribute("login_id");	
%>
</head>
<body BACKGROUND="image/bg33.JPG">
<center>
<form method="post" action="airR.jsp">
<table border=2 width=600>
<tr><td>
	<table border=1 cellspacing=0>
	<tr>
		<td width=100 height=100 bgcolor=#ff6600><a href="b_01.jsp"><h1>편도</h1></a></td>
		<td width=100 height=100 ><a href="b_02.jsp"><h1>왕복</h1></a></td>
		<input type="hidden" name="direction" value="go">
	</tr>
	</table>
</td></tr>
<tr><td>
	<table border=0>
	<tr>
		<td width=100><p align=left>>구간1 </p></td>
		<td width=100><p align=left><select name=startP><option value="">출발지
														  <option value=seoul>서울
														  <option value=jeju>제주
		</select></td>
		<td width=100><p align=left><select name=destinationP><option value="">도착지
															<option value=seoul>서울
															<option value=jeju>제주													  
		</select></td>
<%
	Calendar cal = Calendar.getInstance();
	SimpleDateFormat dformat = new SimpleDateFormat("yyyy-MM-dd");
	String nowdate= dformat.format(cal.getTime());
	cal.add(cal.DATE, +29);	
	String maxdate= dformat.format(cal.getTime());
%>		
		<td width=200><p align=left>가는날 : <input type=date name=startD max="<%=maxdate%>" min="<%=nowdate%>" value="<%=nowdate%>"</td>
	</tr>
	</table>
</td></tr>
<tr><td>
	<table border=0>
	<tr>
		<td width=100><p align=left>>인원 </p></td>
		<td width=400><p align=left><select name=adultN>  <option value=1>성인 1명
														  <option value=2>성인 2명
														  <option value=3>성인 3명
														  <option value=4>성인 4명
														  <option value=5>성인 5명
														  <option value=6>성인 6명
		</select></td>		
	</tr>
	</table>
</td></tr>
<tr><td>
	<table border=0>
	<tr>
		<td width=100><p align=left>>결제 </p></td>
		<td width=100><p align=left><input type="radio" name="hPay" value="nomal">일반결제</p></td>
		<td width=300><p align=left><input type="radio" name="hPay" value="mileage">마일리지</p></td>	
	</tr>
	</table>
</td></tr>
<tr><td>
	<table border=0>
	<tr>
		<td width=500><p align=center><input type="submit" value="항공권 검색"></p></td>
		
	</tr>
	</table>
</td></tr>
</table>
</form>
</center>	
</body>
</html>