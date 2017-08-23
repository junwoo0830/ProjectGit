<!--문서 생성 타입 및 한글형태의 JSP 사용 선언-->
<%@ page contentType="text/html; charset=UTF-8" %> 
<html>
<head>
<%! //함수나 변수 선언시 ! 붙인다		
	private String call1(){	
		String a= "abc";	
		String b = "efg";
		return (a+b);
	}
	private Integer call2() {
		Integer a =1;
		Integer b =2;
		return (a+b);	
	}
%>
</head>
<body>
	String연산:<%=call1()%><br>
	Integer연산:<%=call2()%><br>
	Good..
</body>
</html>