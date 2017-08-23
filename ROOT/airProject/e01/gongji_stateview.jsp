<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*,java.io.*"%>

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

	int id=0;
	if(request.getParameter("id")!=null)
		id=Integer.parseInt(request.getParameter("id"));
	String inputTyp="";
	if(request.getParameter("inputTyp")!=null)
		inputTyp=request.getParameter("inputTyp");	
	String title="";
	if(request.getParameter("title")!=null) {
		title=request.getParameter("title").replaceAll(" ","").replaceAll(",","").replaceAll("<","").replaceAll(">","").replaceAll(">","").replaceAll("&","");
		title=new String(title.getBytes("8859_1"),"utf-8");
	}
	String Tdate="";
	if(request.getParameter("date")!=null)
		Tdate=request.getParameter("date");
	String content="";
	if(request.getParameter("content")!=null){
		content=request.getParameter("content").replaceAll(" ","").replaceAll(",","").replaceAll("<","").replaceAll(">","").replaceAll(">","").replaceAll("&","");
		content=new String(content.getBytes("8859_1"),"utf-8");
	}	
%>
</head>
<body BACKGROUND="../image/bg33.JPG">
<center>
<%
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		ResultSet rset =null;
		
		if(inputTyp.equals("rootinsert")){
			if(title.length()==0) {
				out.println("<script>alert(\"제목이 없습니다.\");history.back();</script>");	
				rset= stmt.executeQuery("select *from resortGongji;");							
			}
			else{
				rset= stmt.executeQuery("select ifnull(max(id),0) from resortGongji;");
				if(rset.next())
					id =rset.getInt(1)+1;
				stmt.execute("insert into resortGongji(title, date, content,viewcnt) values('"+title+"','"+Tdate+"','"+content+"',0);");
				rset= stmt.executeQuery("select *from resortGongji where id="+id+";");
				rset.next();
				out.println("<h1>추가되었습니다.</h1>");
			}
		}		

	 	if(inputTyp.equals("update")){
			if(title.length()==0) {
				out.println("<script>alert(\"제목이 없습니다.\");history.back();</script>");	
				rset= stmt.executeQuery("select *from resortGongji where id=1;");
				rset.next();				
			}
			else{
				stmt.execute("update resortGongji set title='"+title+"', date='"+Tdate+"', content='"+content+"' where id ="+id+";");
				rset= stmt.executeQuery("select *from resortGongji where id="+id+" ;");
				rset.next();
				out.println("<h1>수정되었습니다.</h1>");		
			}
		}
		if(inputTyp.equals("delete")){
			rset= stmt.executeQuery("select *from resortGongji where id="+id+";");
			rset.next();
		} 
		
%>

<form method=post name="myForm" action="e_01.jsp">
<table border=1 cellspacing=1 style="table-layout:fixed;">
<tr>
	<td width = 60><p align = left>번호</p></td>
	<td width = 440><p align = left><%=rset.getInt(1)%></p></td>	
</tr>
<tr>
	<td width = 60><p align = left>제목</p></td>
	<td width = 440><p align = left><%=rset.getString(2)%></p></td>
</tr>
<tr>
	<td width = 60><p align = left>일자</p></td>
	<td width = 440><p align = left><%=rset.getString(3)%></p></td>
</tr>
<tr>
	<td width = 60><p align = left>조회수</p></td>
	<td width = 440><p align = left><%=rset.getInt(5)%></p></td>
</tr>
<tr>
	<td width = 60><p align = left>내용</p></td>
	<td width = 440 style="word-break:break-all;"><p align = left><%=rset.getString(4).replaceAll("\n","<br>")%></p></td>
</tr>
</table>
<%
		 if(inputTyp.equals("delete")){			
			stmt.execute("delete from resortGongji where id="+id+";");
			out.println("<h1>위 내용이 삭제되었습니다.</h1>");
		} 
%>
<table>
<tr>	
	<td width = 300><p align = right><input type=submit value="목록"></td>
</tr>
</table>
</form>
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
</center>
</body>
</html>

