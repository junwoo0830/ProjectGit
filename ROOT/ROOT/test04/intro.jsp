<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head></head>
<body>
<h1><center>JSP Database 실습1</center></h1>
<%
	String data = "";
	int cnt=0;					//방문자 수가 저장된 문서를 이용해 방문자 수를 조회한다. 
	FileReader f1 = new FileReader("/var/lib/tomcat7/webapps/ROOT/test04/cnt.txt");
	StringBuffer sb = new StringBuffer();
	int ch =0;
	while( (ch = f1.read())!= -1){ //내용을 읽어 온다.
		sb.append((char)(ch));		//StringBuffer를 이용해 연속적으로 읽는다.
	}
	data=sb.toString().trim().replace("/n",""); //읽어온 정보중 불필요한 정보 제거
	f1.close();	
	cnt=Integer.parseInt(data);					//숫자로 변환해서 cnt에 저장
	cnt++;										
	data=Integer.toString(cnt);					//숫자를 문자로 바꾸어 data에 저장(문서에 저장하기 위해)
	out.println("<br><br>현재 홈페이지 방문조회수는 ["+data+"] 입니다</br>"); //화면에 출력
	//출력후 증가된 값의 정보를 다시 문서에 저장한다 이때 문서는 덮어쓰기 모드로 진행
	FileWriter f2 = new FileWriter("/var/lib/tomcat7/webapps/ROOT/test04/cnt.txt",false);
	f2.write(data);
	f2.close();
%>
</body>
</html>