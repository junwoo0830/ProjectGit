<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<%
	int startPage=0;
	if(request.getParameter("startPage") !=null)
		startPage=Integer.parseInt(request.getParameter("startPage"));
	if(startPage<0)
		startPage=0;
	int pageNum=10;
	if(request.getParameter("pageNum") !=null)
		pageNum=Integer.parseInt(request.getParameter("pageNum"));	
%>
</head>
<body>
<%
	long start = System.currentTimeMillis();
	 java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
	 String today = formatter.format(new java.util.Date());
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		ResultSet rset = stmt.executeQuery(" select * from twiceUTong;");	
		int maxRow= 0;
		while(rset.next()){
			maxRow++;
		}
		rset = stmt.executeQuery(" select * from twiceUTong;");			
		if(startPage>maxRow){
			if((maxRow%pageNum)==0)
				startPage=maxRow-pageNum;
			else
				startPage=maxRow-(maxRow%pageNum);			
		}
%>
<table border=1 cellpadding=5 cellspacing=0>
<tr>
	<td width=600><p align=center>(주)트와이스 재고 현황-전체현황</p></td>
</tr>
<tr>
	<td><p align=center><table border=1 cellspacing=0>
		<tr>           
			<td width=60  ><p align=center>번호</p></td>
			<td width=200 ><p align=center>상품명</p></td>
			<td width=100 ><p align=center>현재 재고수</p></td>
			<td width=100 ><p align=center>재고파악일</p></td>
			<td width=100 ><p align=center>상품등록일</p></td>
		</tr>
<%
	int count=0;
	while(rset.next()) {
		count++;
		if(startPage>=count) continue;
		if( (startPage+pageNum)< count) break;
		out.println(
		"<tr>           "+
		"	<td width=60  ><p align=center><a href=sale_oneview.jsp?id="+rset.getInt(1)+">"+rset.getInt(1)+"</p></td> "+
		"	<td width=200 ><p align=center><a href=sale_oneview.jsp?id="+rset.getInt(1)+">"+rset.getString(2)+"</p></td> "+
		"	<td width=100 ><p align=center>"+rset.getInt(3)+"</p></td> "+
		"	<td width=100 ><p align=center>"+rset.getString(4)+"</p></td> "+
		"	<td width=100 ><p align=center>"+rset.getString(5)+"</p></td> "+
		"</tr> ");
	}
%>

	</table></p></td>
</tr>
<tr>
	<td align=center><table>
		<tr>
<%
	int firtpage=1;
	int maxpage=(maxRow/pageNum)+1;
	if((maxRow%pageNum)!=0)
		maxpage+=1;
	int nowPage= (startPage/pageNum);
	int minPage=1;
	if(firtpage > (nowPage-5)) minPage=firtpage;
	else minPage= (nowPage-5);
	if(maxpage < (minPage+10)) maxpage=maxpage;
	else maxpage=minPage+10;
	out.println("<td width=30><p align=center><a href=sale_view.jsp?startPage="+((nowPage-10)*pageNum)+"&pageNum="+pageNum+"><<</p></td>");	
	for(int i=minPage; i<maxpage; i++){
		out.println("<td width=30><p align=center><a href=sale_view.jsp?startPage="+((i-1)*pageNum)+"&pageNum="+pageNum+">"+i+"</p></td>");	
	}
	out.println("<td width=30><p align=center><a href=sale_view.jsp?startPage="+((nowPage+10)*pageNum)+"&pageNum="+pageNum+">>></p></td>");		
	
%>			
			<form method="post" name= myForm action="sale_insert.jsp">
				<td width= 60><p align=right><input type=submit value="신규등록"></p></td>
			</form>
		</tr>
	</table></td>
</tr>
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
	long end = System.currentTimeMillis();
	long time = end-start;
	out.println("작동시간 : " +time/1000.0);
%>
</body>
</html>
