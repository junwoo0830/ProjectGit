<%@ page contentType="text/html; charset=UTF-8" %>
<!--문서 생성 타입 및 한글형태의 JSP 사용 선언-->
<html>
<head></head>
<body>
<%  //구분자를 이용해 문자열을 자르기
	String arr[] = new String[]{"111","222","333"};
	String str="abc,efg,hij";
	String str_arr[] = str.split(",");
%>
	arr[0]:<%=arr[0]%><br>
	arr[1]:<%=arr[1]%><br>
	arr[2]:<%=arr[2]%><br>
	str_arr[0]:<%=str_arr[0]%><br>
	str_arr[1]:<%=str_arr[1]%><br>
	str_arr[2]:<%=str_arr[2]%><br>
	Good...
</body>
</html>
