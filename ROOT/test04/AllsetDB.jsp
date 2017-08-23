<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head></head>
<body>
<%
	try{
		
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	//TNS Data를 이용해서 서버에 접속!		
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		stmt.execute("insert into examtable(name,student, kor, eng, mat) values ('지효',209901,95,100,95);");	//테이블 내용 삽입
		stmt.execute("insert into examtable(name,student, kor, eng, mat) values ('나연',209902,95,95,95);");	//내용 삽입
		stmt.execute("insert into examtable(name,student, kor, eng, mat) values ('정연',209903,100,100,100);");	//내용 삽입
		stmt.execute("insert into examtable(name,student, kor, eng, mat) values ('모모',209904,100,95,90);");	//내용 삽입
		stmt.execute("insert into examtable(name,student, kor, eng, mat) values ('사나',209905,80,100,70);");	//내용 삽입
		stmt.execute("insert into examtable(name,student, kor, eng, mat) values ('미나',209906,100,100,70);");	//내용 삽입
		stmt.execute("insert into examtable(name,student, kor, eng, mat) values ('다현',209907,100,100,100);");	//내용 삽입
		stmt.execute("insert into examtable(name,student, kor, eng, mat) values ('채영',209908,100,90,70);");	//내용 삽입
		stmt.execute("insert into examtable(name,student, kor, eng, mat) values ('쯔위',209909,100,75,77);");	//내용 삽입
		stmt.close();
		conn.close();
		out.println("<p><h1>실습 데이터 입력 OK</h1></p>");
	}catch (ClassNotFoundException e) {	//데이터가 없으면 에러 출력			
		out.println("클래스에러 발생 : " +e);
	} catch (SQLException e) {		//sql에러가 있을시 에러 출력
		out.println("sql에러 발생 : " +e);
	}
%>
</table>
</body>
</html>
