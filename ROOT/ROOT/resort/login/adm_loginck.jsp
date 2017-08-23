<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*" %>
<%@ page import="java.net.*,java.io.*,java.util.*,java.text.*"%>


<html>
<head>

</head>
<body BACKGROUND="../image/bg33.JPG">
<center>
<%
	request.setCharacterEncoding("utf-8");
	
	String jump = request.getParameter("jump");
	String id = request.getParameter("id");
	String pass = request.getParameter("passwd");
	
	boolean bPassChk=false;
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성	
		ResultSet rset = stmt.executeQuery("select * from adminfo where id='"+id+"' and pass='"+pass+"';");		
		if(rset.next()){
			bPassChk=true;
		}
		else{
			bPassChk=false;
		}	

		if(bPassChk){
			session.setAttribute("login_ok","yes");
			session.setAttribute("login_id",id);
			response.sendRedirect(jump);
		}else{
			out.println("<h2>아이디 또는 패스워드 오류.</h2>");
			out.println("<input type=button value='로그인' onClick=\"location.href='adm_allview.jsp?jump="+jump+"'\">");
		}
		rset.close();
		stmt.close();
		conn.close();	
	}catch (ClassNotFoundException e) {	//클래스가 없으면 에러 출력			
		out.println("클래스에러 발생 : " +e);
	} catch (SQLException e) {			//sql에러가 있을시 에러 출력
		out.println("sql에러 발생 : " +e);
	}
%>

</center>

</body>
</html>	