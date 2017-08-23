<%@ page contentType= "text/html; charset=UTF-8"%>

<html>
<head>
</head>

<body>
<%
	String myName="YANG.SJCU";
	Cookie cookieName= new Cookie("name", myName);
	cookieName.setMaxAge(-1);
	response.addCookie(cookieName);
%>
쿠키사용
</body>
</html>	