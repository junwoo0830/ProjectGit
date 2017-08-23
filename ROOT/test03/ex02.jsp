<%@ page import="java.sql.*, 
	javax.mail.*,javax.mail.internet.*"
	contentType = "text/html; charset=UTF-8" %> <!--문서 생성 타입 및 한글형태의 JSP 사용 선언-->
<html>											<!--자바의 라이브러리를 import 해준다.-->
<body>
	<% String myUrl = "http://www.kopo.ac.kr"; %><!--URL 저장-->
	<a href="<%=myUrl%>">Hello</a>World.		 <!--링크 선언-->
</body>
</html>