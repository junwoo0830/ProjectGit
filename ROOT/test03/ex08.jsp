<%@ page contentType="text/html; charset=UTF-8" %>
<!--문서 생성 타입 및 한글형태의 JSP 사용 선언-->
<%@ page errorPage="error.jsp" %>
<!--에러가 발생할경우 error.jsp파일을 연결한다.-->
<html>
<head></head>
<body>
<%	//에러 유발 코드
	String arr[] = new String[]{"111","222","333"};
	//try{
			out.println(arr[4] + "<br>");
	/* }catch(Exception e){
		out.println("error==>"+e+"<======<br>");
	} */
%>
Good...
</body>
</html>