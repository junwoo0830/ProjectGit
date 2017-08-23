<!--문서 생성 타입 및 한글형태의 JSP 사용 선언-->
<%@ page contentType="text/html; charset=UTF-8" %>
<!--get방식으로 데이터 받기-->
<%
	String check2 = request.getParameter("username");
	String name=new String(check2.getBytes("8859_1"),"utf-8");
	String password = request.getParameter("userpasswd");
%>
<html>
<head>
	<TITLE>로그인</TITLE>
</head>
<body>
	이름:<%=name%><br>
	비밀번호:<%=password%><br>
</body>
</html>
