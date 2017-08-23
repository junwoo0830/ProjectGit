<!--문서 생성 타입 및 한글형태의 JSP 사용 선언-->
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
<%!  //클래스 사용하기!
	private class AA{  
			private int Sum(int i, int j){
					return i+j;
			}
	}
	AA aa = new AA();
%>
</head>
<body>
<% out.println("2+3=" + aa.Sum(2,3)); %><br>
Good..
</body>
</html>