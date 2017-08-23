<meta http-dquiv="Content-type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.*,java.text.*" %>

<html>
<head>
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
	
	String rName="";
	if(request.getParameter("rName")!=null){
		rName=request.getParameter("rName").replaceAll(" ","").replaceAll(",","").replaceAll("<","").replaceAll(">","").replaceAll(">","").replaceAll("&","");
		rName=new String(rName.getBytes("8859_1"),"utf-8");
	}	
	String date="";
	if(request.getParameter("date")!=null)
		date=request.getParameter("date");
	String hdate="";
	if(request.getParameter("hdate")!=null)
		hdate=request.getParameter("hdate");		
	int resRoom=0;
	if(request.getParameter("resRoom")!=null){
		if(request.getParameter("resRoom").length()!=0)
			resRoom=Integer.parseInt(request.getParameter("resRoom"));
	}
	int room=0;
	if(request.getParameter("room")!=null){
		if(request.getParameter("room").length()!=0)
			room=Integer.parseInt(request.getParameter("room"));
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
	String content=" ";
	if(request.getParameter("content")!=null){
		content=request.getParameter("content").replaceAll(",","").replaceAll("<","").replaceAll(">","").replaceAll(";","").replaceAll("&","");
		content=new String(content.getBytes("8859_1"),"utf-8");
	}		
	String subDate="";
	if(request.getParameter("subDate")!=null)
		subDate=request.getParameter("subDate");	
	int status=0;
	if(request.getParameter("status")!=null){		
		status=Integer.parseInt(request.getParameter("status"));
	}
	String inputTyp="";
	if(request.getParameter("inputTyp")!=null)
		inputTyp=request.getParameter("inputTyp");	
%>
</head>
<body BACKGROUND="../image/bg33.JPG">
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
		ResultSet rset=null;	
		if(inputTyp.equals("update")){
			
			if(rName.length()==0)
			{
				out.println("<script>alert(\"이름이 없습니다. 다시 입력해 주세요\");history.back();</script>");
			}else if(phone.length()>11)
			{
				out.println("<script>alert(\"전화번호를 다시 입력해 주세요\");history.back();</script>");	
			}else{
				if( (date.equals(hdate)) && (room == resRoom)){
					stmt.execute(" update roomRes set name='"+rName+"',resv_date='"+date+"',room="+resRoom+",addr='"+address+"',telnum='"+phone+
												"',in_name='"+money+"',comment='"+content+"',processing='"+status+"' where resv_date='"+hdate+"' and room="+room+";");
					out.println("<h1>예약내용이 수정되었습니다.</h1><br>");
				}
				else{
					rset = stmt.executeQuery("select *from roomRes where resv_date='"+date+"' and room="+resRoom+";");		
					if(rset.next() || (com1<0) || (com2>0)){
						out.println("<script>alert(\"예약이 중복이 되었습니다. 날짜 혹은 방을 바꿔 주세요\");history.back();</script>");				
						out.println("<h1>예약이 중복이 되었습니다.</h1><br>");
					}
					else{
						stmt.execute(" update roomRes set name='"+rName+"',resv_date='"+date+"',room="+resRoom+",addr='"+address+"',telnum='"
											+phone+"',in_name='"+money+"',comment='"+content+"',processing='"+status+"' where resv_date='"+hdate+"' and room="+room+";");
						out.println("<h1>예약내용이 수정되었습니다.</h1><br>");
					}	
				}
			}			
		}
		if(inputTyp.equals("delete")){
			stmt.execute("delete from roomRes  where resv_date='"+date+"' and room="+room+";");
			out.println("<h1>예약이 삭제되었습니다.</h1><br>");
		}
		
		
		
		stmt.close();
		conn.close();		
	}catch (ClassNotFoundException e) {	//클래스가 없으면 에러 출력			
		out.println("클래스에러 발생 : " +e);
	} catch (SQLException e) {			//sql에러가 있을시 에러 출력
		out.println("sql에러 발생 : " +e);
	}
%>
<form method="post" action = "adm_allview.jsp">
<input type="submit" value="관리자화면으로">
</form>
</center>
</body>
</html>
