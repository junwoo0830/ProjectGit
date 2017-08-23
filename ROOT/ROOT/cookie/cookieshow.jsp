<%@ page contentType= "text/html; charset=UTF-8"%>

<html>
<head>
</head>

<body>
<%
	Cookie[] cookies = request.getCookies();
	for(int i=0; i< cookies.length; i++)
	{
		Cookie thisCookie = cookies[i];
		if("name".equals(thisCookie.getName()))
		{
			out.println("이름: " + thisCookie.getValue()+"<br>");
		}
	}
%>
</body>
</html>	