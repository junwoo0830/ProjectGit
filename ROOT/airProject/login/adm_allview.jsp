<meta http-=equiv="Content-Type" content="text/thml; charset=UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*" %>
<%@ page import="java.net.*,java.io.*,java.util.*,java.text.*"%>


<html>
<head>
<style type = 'text/css'>
a:link {color:black; text-decoration:none;}
a:visited {color:black; text-decoration:none;}
a:hover {color:blue; text-decoration:none;}
a:acvite {color:black; text-decoration:none;}
</style>
<%
	String loginOK=null;
	String jumpURL="adm_login.jsp?jump=adm_allview.jsp";
	
	loginOK = (String)session.getAttribute("login_ok");
	if(loginOK==null){
		response.sendRedirect(jumpURL);
		return;
	}
	if(!loginOK.equals("yes")){
		response.sendRedirect(jumpURL);
		return;
	}
	String loginID = (String)session.getAttribute("login_id");
%>
</head>
<body>
<center>
<h1><%=loginID%>님의 예약정보 입니다.</h1>
<b>출발 날짜 예약상황</b><br>
<table border=1 cellspacing=0>
	<tr bgcolor="#ff6600">
		<td width=200><p align=center>항공</p></td>
		<td width=200><p align=center>여정</p></td>
		<td width=200><p align=center>출발</p></td>
		<td width=200><p align=center>좌석</p></td>
	</tr>
<%
 	Calendar cal = Calendar.getInstance();
	SimpleDateFormat dformat = new SimpleDateFormat("yyyy-MM-dd(E)",Locale.KOREAN);	
	SimpleDateFormat nowformat = new SimpleDateFormat("yyyy-MM-dd");
	String nowdate = nowformat.format(cal.getTime());	
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		ResultSet rset = stmt.executeQuery("select startP,destinationP,startD,direction,sitNum from airReg where regID='"+loginID+"' and direction='go' order by startD asc ;"); 
		
		 
%>

<%
		while(rset.next()){
			out.println("<tr>"
						+"	<td width=200><p align=center>JUNWOOair A380-800</p></td>"
						+"	<td width=200><p align=center>"+rset.getString(1)+" -> "+rset.getString(2)+"</p></td>"
						+"	<td width=200><p align=center>"+rset.getString(3)+"</p></td>"
						+"	<td width=200><p align=center>m"+rset.getString(5)+"</p></td>"
						+"</tr>"
						);
		}
%>
</table>
<%
	rset = stmt.executeQuery("select startP,destinationP,startD,direction,sitNum from airReg where regID='"+loginID+"' and direction='back' order by startD asc ;"); 
	if(rset.next()){		
		out.println("<b>도착 날짜 예약상황</b><br>"
			+"<table border=1 cellspacing=0>"
			+"	<tr bgcolor=\"#ff6600\">"
			+"		<td width=200><p align=center>항공</p></td>"
			+"		<td width=200><p align=center>여정</p></td>"
			+"		<td width=200><p align=center>출발</p></td>"
			+"		<td width=200><p align=center>좌석</p></td>"
			+"	</tr>");
		out.println("<tr>"
						+"	<td width=200><p align=center>JUNWOOair A380-800</p></td>"
						+"	<td width=200><p align=center>"+rset.getString(1)+" -> "+rset.getString(2)+"</p></td>"
						+"	<td width=200><p align=center>"+rset.getString(3)+"</p></td>"
						+"	<td width=200><p align=center>m"+rset.getString(5)+"</p></td>"
						+"</tr>"
						);
		
		while(rset.next()){
				out.println("<tr>"
						+"	<td width=200><p align=center>JUNWOOair A380-800</p></td>"
						+"	<td width=200><p align=center>"+rset.getString(1)+" -> "+rset.getString(2)+"</p></td>"
						+"	<td width=200><p align=center>"+rset.getString(3)+"</p></td>"
						+"	<td width=200><p align=center>m"+rset.getString(5)+"</p></td>"
						+"</tr>"
						);
		}
	}
	
%>
</table>



<%		
		rset.close();
		stmt.close();
		conn.close();		
	}catch (ClassNotFoundException e) {	//클래스가 없으면 에러 출력			
		out.println("클래스에러 발생 : " +e);
	} catch (SQLException e) {			//sql에러가 있을시 에러 출력
		out.println("sql에러 발생 : " +e);
	} 
%>

</table>
<form method="post" action="../main.jsp">
	<input type=submit value="홈으로">
</form>
</center>
</body>
</html>