<meta http-dquiv="Content-type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.*,java.text.*" %>

<html>
<head>
<%
	String loginOK=null;
	String jumpURL="login/adm_login.jsp?jump=../b_01.jsp";
	
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

	String startp = request.getParameter("startP");
	String destinationP = request.getParameter("destinationP");
	String startD = request.getParameter("startD");
	String destinationD = "";
			if(request.getParameter("destinationD")!=null)
				destinationD=request.getParameter("destinationD");
	String adultN = request.getParameter("adultN");
	String hPay = request.getParameter("hPay");
	String direction = request.getParameter("direction");
	String reg = request.getParameter("reg");
	String[] rreg = reg.split(",");
%>
</head>
<body>
<center>
<%			
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		for(int i=0; i<rreg.length; i++){
			stmt.execute("insert into airReg(regID,startP,destinationP,startD,direction,sitNum,hPay) values('"+loginID+"','"+startp+"','"+destinationP+"','"+startD+"','go','"+rreg[i]+"','"+hPay+"');");
		}
		if(direction.equals("goback")){
			String regB = request.getParameter("regB");
			String[] rregB = regB.split(",");
			for(int i=0; i<rregB.length; i++){
				stmt.execute("insert into airReg(regID,startP,destinationP,startD,direction,sitNum,hPay) values('"+loginID+"','"+destinationP+"','"+startp+"','"+destinationD+"','back','"+rregB[i]+"','"+hPay+"');");
			}
		}
		stmt.close();
		conn.close();	
		out.println("<h1>예약이 완료 되었습니다.</h1>");
	}catch (ClassNotFoundException e) {	//클래스가 없으면 에러 출력			
		out.println("클래스에러 발생 : " +e);
	} catch (SQLException e) {			//sql에러가 있을시 에러 출력
		out.println("sql에러 발생 : " +e);
	}
%>
<form method="post" action="main.jsp">
	<input type=submit value="홈으로">
</form>
</center>
</body>
</html>