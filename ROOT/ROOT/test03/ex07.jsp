<%@ page contentType="text/html; charset=UTF-8" %>
<!--문서 생성 타입 및 한글형태의 JSP 사용 선언-->
<html>
<head></head>
<body>
<%	//JSP 예외처리 실습
	String arr[] = new String[]{"111","222","333"};
	try{
			out.println(arr[4] + "<br>");
	}catch(Exception e){
		out.println("error==>"+e+"<======<br>");
	} 
%>
Good...
</body>
</html>