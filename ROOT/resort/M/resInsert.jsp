<meta http-dquiv="Content-type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.*,java.text.*" %>

<html>
<head>
<%
	String rName="";
	if(request.getParameter("rName")!=null){
		rName=request.getParameter("rName").replaceAll(" ","").replaceAll(",","").replaceAll("<","").replaceAll(">","").replaceAll(">","").replaceAll("&","");
		rName=new String(rName.getBytes("8859_1"),"utf-8");
	}	
	String date="";
	if(request.getParameter("date")!=null)
		date=request.getParameter("date");	
	int resRoom=0;
	if(request.getParameter("resRoom")!=null){
		if(request.getParameter("resRoom").length()!=0)
			resRoom=Integer.parseInt(request.getParameter("resRoom"));
	}
	String address="";
	if(request.getParameter("address")!=null){
		address=request.getParameter("address").replaceAll(" ","").replaceAll(",","").replaceAll("<","").replaceAll(">","").replaceAll(";","").replaceAll("&","");
		address=new String(address.getBytes("8859_1"),"utf-8");	
	}
	String phone="";
	if(request.getParameter("phone")!=null)
		phone=request.getParameter("phone");	
	String money="";
	if(request.getParameter("money")!=null){
		money=request.getParameter("money").replaceAll(" ","").replaceAll(",","").replaceAll("<","").replaceAll(">","").replaceAll(";","").replaceAll("&","");
		money=new String(money.getBytes("8859_1"),"utf-8");
	}	
	String content="";
	if(request.getParameter("content")!=null){
		content=request.getParameter("content").replaceAll(" ","").replaceAll(",","").replaceAll("<","").replaceAll(">","").replaceAll(";","").replaceAll("&","");
		content=new String(content.getBytes("8859_1"),"utf-8");
	}
%>
</head>
<body BACKGROUND="image/bg33.JPG">
<center>
<%
	Calendar cal = Calendar.getInstance();
	SimpleDateFormat dformat = new SimpleDateFormat("yyyy-MM-dd");
	java.util.Date nowdate= dformat.parse(dformat.format(cal.getTime()));
	cal.add(cal.DATE, +29);	
	java.util.Date maxdate= dformat.parse(dformat.format(cal.getTime()));
	java.util.Date Ddate = dformat.parse(date);
	int com1 = Ddate.compareTo(nowdate);
	int com2 = Ddate.compareTo(maxdate);
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		//stmt.execute("insert into roomRes(name,resv_date,room) values('"+rName+"','2017-06-21',1);");
		ResultSet rset = stmt.executeQuery("select *from roomRes where resv_date='"+date+"' and room="+resRoom+";");		
		if(rName.length()==0)
		{
			out.println("<script>alert(\"이름이 없습니다. 다시 입력해 주세요\");history.back();</script>");
		}else if(phone.length()>11)
		{
			out.println("<script>alert(\"전화번호를 다시 입력해 주세요\");history.back();</script>");	
		}else{
			if(rset.next() || (com1<0) || (com2>0)){
				out.println("<script>alert(\"예약이 중복이 되었습니다. 날짜 혹은 방을 바꿔 주세요\");history.back();</script>");				
				out.println("<h1>예약이 중복이 되었습니다.</h1><br>");
			}
			else{
				stmt.execute("insert into roomRes values('"+rName+"','"+date+"',"+resRoom+",'"+address+"','"+phone+"','"+money+"','"+content+"','"+dformat.format(nowdate)+"',1);");
				out.println("<h1>예약이 완료 되었습니다.</h1><br>");
			}
			
		}		
		stmt.close();
		conn.close();		
	}catch (ClassNotFoundException e) {	//클래스가 없으면 에러 출력			
		out.println("클래스에러 발생 : " +e);
	} catch (SQLException e) {			//sql에러가 있을시 에러 출력
		out.println("sql에러 발생 : " +e);
	}

	String loginOK=null;
		
	loginOK = (String)session.getAttribute("login_ok");
	if(loginOK!=null){
		if(loginOK.equals("yes"))
			out.println(" <form method=\"post\" action = \"./login/adm_allview.jsp\"> ");
	}
	else{
		out.println(" <form method=\"post\" action = \"d_01.jsp\"> ");
	}
%>
<input type="submit" value="예약화면으로">
</form>
</center>
</body>
</html>
