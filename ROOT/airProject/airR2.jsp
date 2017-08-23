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
<script>
function next(state){
	if(state=="cancel"){
		myForm.action="b_01.jsp";
	}
	else{
		myForm.action="insertReg.jsp";
	}
	myForm.submit();
}
</script>
<%
	String startp = request.getParameter("startP");
	String destinationP = request.getParameter("destinationP");
	String startD = request.getParameter("startD");
	String destinationD = "";
			if(request.getParameter("destinationD")!=null)
				destinationD=request.getParameter("destinationD");
	String adultN = request.getParameter("adultN");
	String hPay = request.getParameter("hPay");
	String direction = request.getParameter("direction");
	String reg = request.getParameter("reg");
	String[] rreg = reg.split(",");
	String regB = "";
	if(request.getParameter("regB")!=null)
		regB=request.getParameter("regB");
%>
</head>
<body>
<center>
<h1>예약확인</h1>
<b>출발 날짜 예약상황</b><br>
	<table border=1 cellspacing=0>
		<tr bgcolor="#ff6600">
			<td width=200><p align=center>항공</p></td>
			<td width=200><p align=center>여정</p></td>
			<td width=200><p align=center>출발</p></td>
			<td width=200><p align=center>좌석</p></td>
		</tr>
<%
		for(int i=0; i<rreg.length; i++){
			out.println("<tr>"
						+"	<td width=200><p align=center>JUNWOOair A380-800</p></td>"
						+"	<td width=200><p align=center>"+startp+" -> "+destinationP+"</p></td>"
						+"	<td width=200><p align=center>"+startD+"</p></td>"
						+"	<td width=200><p align=center>m"+rreg[i]+"</p></td>"
						+"</tr>"
						);
		}
%>
</table>
<%
	if(direction.equals("goback")){		
		String[] rregB = regB.split(",");
		out.println("<b>도착 날짜 예약상황</b><br>"
			+"<table border=1 cellspacing=0>"
			+"	<tr bgcolor=\"#ff6600\">"
			+"		<td width=200><p align=center>항공</p></td>"
			+"		<td width=200><p align=center>여정</p></td>"
			+"		<td width=200><p align=center>출발</p></td>"
			+"		<td width=200><p align=center>좌석</p></td>"
			+"	</tr>");
		
		for(int i=0; i<rregB.length; i++){
			out.println("<tr>"
						+"	<td width=200><p align=center>JUNWOOair A380-800</p></td>"
						+"	<td width=200><p align=center>"+startp+" -> "+destinationP+"</p></td>"
						+"	<td width=200><p align=center>"+startD+"</p></td>"
						+"	<td width=200><p align=center>m"+rregB[i]+"</p></td>"
						+"</tr>"
						);
		}
	}
%>
</table>



	<form method="post" name="myForm" >
		<input type="button" value="취소하기" onclick="next('cancel')">
		<input type="button" value="예약하기" onclick="next('reg')">
		<input type="hidden" name="startP" value="<%=startp%>" >
		<input type="hidden" name="destinationP" value="<%=destinationP%>" >
		<input type="hidden" name="startD" value="<%=startD%>" >
		<input type="hidden" name="destinationD" value="<%=destinationD%>" >
		<input type="hidden" name="adultN" value="<%=adultN%>" >
		<input type="hidden" name="direction" value="<%=direction%>" >
		<input type="hidden" name="hPay" value="<%=hPay%>" >		
		<input type="hidden" name="reg" value="<%=reg%>" >
		<input type="hidden" name="regB" value="<%=regB%>" >
	</form>		
</table>
</center>
</body>
</html>