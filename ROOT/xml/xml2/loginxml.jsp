<?xml version="1.0" encoding="UTF-8"?>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>
<% //로그인 채크
	String thispage="loginxml.jsp";
	String login_url="login.jsp?rtn_url="+thispage;
	
	String loginVal = (String) session.getAttribute("loginOk");
	if(loginVal == null || !loginVal.equals("yes") )
		response.sendRedirect(login_url);
%>
<%
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		ResultSet rset = stmt.executeQuery("select *from  examtable;");		
		out.println("<datas>");
		while(rset.next()){
			out.println("<data>");
			
			out.println("<name>"+rset.getString(1)+"</name>");
			out.println("<studentid>"+Integer.parseInt(rset.getString(2))+"</studentid>");
			out.println("<kor>"+rset.getString(3)+"</kor>");
			out.println("<eng>"+rset.getString(4)+"</eng>");
			out.println("<mat>"+rset.getString(5)+"</mat>");
			out.println("</data>");
		}
		out.println("</datas>");
		
		rset.close();
		stmt.close();
		conn.close();
	}catch (ClassNotFoundException e) {	//클래스가 없으면 에러 출력			
		out.println("클래스에러 발생 : " +e);
	} catch (SQLException e) {			//sql에러가 있을시 에러 출력
		out.println("sql에러 발생 : " +e);
	}
%>