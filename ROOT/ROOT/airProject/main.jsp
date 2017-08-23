<meta http-=equiv="Content-Type" content="text/thml; charset=UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*" %>

<html>
<head>
<title>조아조아조아버려~</title>

</head>
<body BACKGROUND="image/bg33.JPG">
<center>

<img src="soge.jpg" width=500 height=450>
<br>
<h2>JUNWOOair에 오신것을 환영합니다.</h2><br>
.
<%
	Calendar cal = Calendar.getInstance();
	SimpleDateFormat dformatY = new SimpleDateFormat("yyyy");
	SimpleDateFormat dformatM = new SimpleDateFormat("MM");
	SimpleDateFormat dformatD = new SimpleDateFormat("dd");
	SimpleDateFormat dformatH = new SimpleDateFormat("h");
	SimpleDateFormat dformatmin = new SimpleDateFormat("m");
	SimpleDateFormat dformatS = new SimpleDateFormat("s");	

	String dateSt ="";
 	Cookie[] cookies = request.getCookies();
	if(request.getCookies()==null)
		dateSt+="처음 방문 입니다.";
	else{	
		for(int i=0; i< cookies.length; i++)
		{
			Cookie thisCookie = cookies[i];
			if("year".equals(thisCookie.getName()))
			{
				dateSt+="최근 방문일은 (" + thisCookie.getValue()+"년 ";
			}
			if("mon".equals(thisCookie.getName()))
			{
				dateSt+=thisCookie.getValue()+"월 ";
			}
			if("day".equals(thisCookie.getName()))
			{
				dateSt+=thisCookie.getValue()+"일 ";
			}
			if("hour".equals(thisCookie.getName()))
			{
				dateSt+=thisCookie.getValue()+"시 ";
			}
			if("min".equals(thisCookie.getName()))
			{
				dateSt+=thisCookie.getValue()+"분";
			}
			if("sec".equals(thisCookie.getName()))
			{
				dateSt+=thisCookie.getValue()+"초 )입니다.";
			}
		} 
	}
	out.println("<p><h1>"+dateSt+"</h1></p>");
	Cookie cookieName= new Cookie("year", dformatY.format(cal.getTime()));
	response.addCookie(cookieName);	
	cookieName= new Cookie("mon", dformatM.format(cal.getTime()));
	response.addCookie(cookieName);
	cookieName= new Cookie("day", dformatD.format(cal.getTime()));
	response.addCookie(cookieName);
	cookieName= new Cookie("hour", dformatH.format(cal.getTime()));
	response.addCookie(cookieName);
	cookieName= new Cookie("min", dformatmin.format(cal.getTime()));
	response.addCookie(cookieName);
	cookieName= new Cookie("sec", dformatS.format(cal.getTime()));
	response.addCookie(cookieName);
	
	cookieName.setMaxAge(0);

%>
</center>
</body>
</html>
	
	
	