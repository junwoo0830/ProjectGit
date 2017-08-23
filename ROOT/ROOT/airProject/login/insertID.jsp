<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*,java.io.*"%>

<html>
<head>
<%
	String id="";
	if(request.getParameter("id")!=null)
		id=request.getParameter("id");		
	String passwd="";
	if(request.getParameter("passwd")!=null)
		passwd=request.getParameter("passwd");	
	String name="";
	if(request.getParameter("name")!=null){
		name=request.getParameter("name");	
		name=new String(name.getBytes("8859_1"),"utf-8");
	}
	String birth="";
	if(request.getParameter("birth")!=null)
		birth=request.getParameter("birth");	
	String date="";
	if(request.getParameter("date")!=null)
		date=request.getParameter("date");	
	
%>
</head>
<body>
<center>
<%
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		ResultSet rset = stmt.executeQuery("select id from airAdminfo where id = '"+id+"';");
		if(rset.next()){
			out.println("<script>alert(\"ID가 중복됩니다.\");history.back();</script>");	
		}
		else{
			stmt.execute("insert into airAdminfo(id,passwd,name,birth,date) values ('"+id+"','"+passwd+"','"+name+"','"+birth+"','"+date+"');");				
			out.println("<h1>아이디가 생성되었습니다.</h1>");
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

