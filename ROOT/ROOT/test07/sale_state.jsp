<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<%
	int id=0;
	if(request.getParameter("id")!=null){
		if(request.getParameter("id").length()!=0)				
			id=Integer.parseInt(request.getParameter("id"));	
	}
	String title="";
	if(request.getParameter("title")!=null){
		title=request.getParameter("title").replaceAll(" ","").replaceAll(",","").replaceAll("<","").replaceAll(">","").replaceAll(">","").replaceAll("&","");
		title=new String(title.getBytes("8859_1"),"utf-8");
	}	
	int storeNum=0;
	if(request.getParameter("storeNum")!=null){
		if(request.getParameter("storeNum").length()!=0)
			storeNum=Integer.parseInt(request.getParameter("storeNum"));
	}
	String date="";
	if(request.getParameter("date")!=null)
		date=request.getParameter("date");		
	String content="";
	if(request.getParameter("content")!=null){
		content=request.getParameter("content").replaceAll(" ","").replaceAll(",","").replaceAll("<","").replaceAll(">","").replaceAll(">","").replaceAll("&","");
		content=new String(content.getBytes("8859_1"),"utf-8");
	}
	String URL="banana.jpg";
	if(request.getParameter("URL")!=null)
		URL=request.getParameter("URL");
	String state="";
	if(request.getParameter("state")!=null)
		state=request.getParameter("state");
%>
</head>
<body>
<%
	String proj="";
	String staus="";
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		
		if(state.equals("insert")) {
			ResultSet rset = stmt.executeQuery("select title from twiceUTong where id="+id+";");
			if(rset.next()){
				out.println("<script>alert(\"번호가 중복 됩니다.\");history.back();</script>");	
			}
			else if((title.length()==0)||(request.getParameter("id").length() == 0)|| (request.getParameter("storeNum") == null)){			
				out.println("<script>alert(\"번호 혹은 이름 또는 재고량이 없습니다.\");history.back();</script>");				
			}
			else{
				stmt.execute("insert into twiceUTong values("+id+",'"+title+"',"+storeNum+",'"+date+"','"+date+"','"+content+"','"+URL+"');");
				proj="(주)트와이스 재고 현황-상품등록";
				staus="["+title+"] 상품이 등록되었습니다. ";
			}
		}
		if(state.equals("update")) {	
			if(request.getParameter("storeNum").length()==0 ){			
				out.println("<script>alert(\"수량을 등록해 주세요.\");history.back();</script>");				
			}
			else{
				stmt.execute("update twiceUTong set store="+storeNum+", storeDate='"+date+"' where id="+id+";");
				ResultSet rset = stmt.executeQuery("select title from twiceUTong where id="+id+";");
				rset.next();
				proj="(주)트와이스 재고 현황-재고수정";
				staus="["+rset.getString(1)+"] 상품의 재고가 수정되었습니다. ";	
			}
		}
		if(state.equals("delete")) {
			ResultSet rset = stmt.executeQuery("select title from twiceUTong where id="+id+";");
			rset.next();
			staus="["+rset.getString(1)+"] 상품이 삭제되었습니다. ";
			stmt.execute("delete from twiceUTong where id="+id+";");			
			proj="(주)트와이스 재고 현황-상품삭제";
			
		}
		stmt.close();
		conn.close();		
	}catch (ClassNotFoundException e) {	//클래스가 없으면 에러 출력			
		out.println("클래스에러 발생 : " +e);
	} catch (SQLException e) {			//sql에러가 있을시 에러 출력
		out.println("sql에러 발생 : " +e);
	}
%>

<table border=1 cellpadding=5 cellspacing=0>
<tr>
	<td width=600><p align=center><%=proj%></p></td>
</tr>
<tr>
	<td><p align=center><table border=0 cellspacing=0 width=600 height=400>
		<tr>           			
			<td width=600 height=60 ><p align=left></p></td>
			
		</tr>
		<tr>           			
			<td width=600 align=center height=100><p ><h1><%=staus%></h1></p></td>			
		</tr>
		<tr>
			<form method="post" name="myForm" action = "sale_view.jsp">
			<td width=600 height=100 valign=top><p align=center><input type=submit value="재고현황"></p></td>
			</form>
		</tr>		
	</table></p></td>
</tr>
</table>
</body>
</html>
