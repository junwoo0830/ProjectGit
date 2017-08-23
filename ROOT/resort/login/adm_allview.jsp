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
%>
</head>
<body BACKGROUND="../image/bg33.JPG">
<center>
<h1>현재 예약 상황 [관리자페이지]</h1><br>
<table border=1 cellspacing=0>
<tr bgcolor='#BDBDBD'>
	<td width=150><p align=center>날짜</p></td>
	<td width=200><p align=center>Sweet Room</p></td>
	<td width=200><p align=center>Privilege Room</p></td>
	<td width=200><p align=center>Classic Room</p></td>
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
		ResultSet  	rset = stmt.executeQuery("  select r.date, r.week, max(if(r.room1=d.room,d.name,null)),max(if(r.room2=d.room,d.name,null)),"
				+"max(if(r.room3=d.room,d.name,null)) from reserveDB r left join roomRes d on r.date=d.resv_date where r.date>='"+nowdate+"' group by r.date order by r.date asc;");

		while(rset.next()){
			if((rset.getInt(2)==1)||(rset.getInt(2)==7)){
				out.println(
				"<tr>"+
				"	<td width=150><p align=center><font color='#ff0000'>"+(dformat.format(rset.getDate(1)))+"</font></p></td>");
			}
			else{
				out.println(
				"<tr>"+
				"	<td width=150><p align=center>"+(dformat.format(rset.getDate(1)))+"</p></td>");
			}
			for(int i=0; i<3; i++){
				if(rset.getString(3+i)!=null){					
					out.println("<td width=200><p align=center><a href=adm_oneview.jsp?resDate="+(rset.getDate(1))+"&room="+(i+1)+">"+rset.getString(3+i)+"</p></td>");
				}
				else
					out.println("<td width=200><p align=center><a href=../d_02.jsp?resDate="+(rset.getDate(1))+"&room="+(i+1)+"><font color='#ff0000'>예약가능</font></p></td>");
			}
			out.println("</tr>" );
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

</table>
</center>
</body>
</html>