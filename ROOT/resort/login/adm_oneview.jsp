<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*" %>
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
	
	String resDate="";
	if(request.getParameter("resDate")!=null)
		resDate=request.getParameter("resDate");
	int room=0;
	if(request.getParameter("room")!=null)
		room=Integer.parseInt(request.getParameter("room"));
%>
<script>
	function buttonState(index){
		if(index == 'update')
			myForm.action="adm_update.jsp";
		if(index == 'delete')
			myForm.action="adm_state.jsp?inputTyp=delete";
		if(index == 'insert')
			myForm.action="adm_state.jsp?inputTyp=insert";
		myForm.submit();			
	}
</script>


</head>
<body BACKGROUND="../image/bg33.JPG">
<center>
<h1>예약사항[관리자페이지]</h1><br>
<%
	Calendar cal = Calendar.getInstance();
	SimpleDateFormat dformat = new SimpleDateFormat("yyyy-MM-dd");
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		ResultSet rset = stmt.executeQuery("  select * from roomRes where resv_date='"+resDate+"' and room="+room+";");
		rset.next();
		String[] roomName = {"Sweet Room","Privilege Room","Classic Room"};
		String[] statusRoom = {"예약중 결제예정" , "결제 완료", "예약완료"};
%>		
<form method="post" name="myForm" action="adm_allview.jsp">
<table border=1 cellspacing=0>
<tr>
	<td width=150><p align=center>성명</p></td>
	<td width=400><%=rset.getString(1)%></td>
</tr>	

<tr>
	<td width=150><p align=center>예약일자</p></td>
	<td width=400><%=resDate%></td>
	<input type="hidden" name="date" value=<%=resDate%>>
	 
</tr>
<tr>
	<td width=150><p align=center>예약방</p></td>
	<td width=400><%=roomName[(rset.getInt(3)-1)]%></td>
	<input type=hidden name="room" value=<%=rset.getInt(3)%>>
</tr>	
<tr>
	<td width=150><p align=center>주소</p></td>
	<td width=400><%=rset.getString(4)%> </td>
</tr>	
<tr>
	<td width=150><p align=center>전화번호</p></td>
	<td width=400><%=rset.getString(5)%></td>
</tr>	
<tr>
	<td width=150><p align=center>입금자명</p></td>
	<td width=400><%=rset.getString(6)%> </td>
</tr>
<tr>
	<td width=150><p align=center>남기실말</p></td>
	<td width=400 style="word-break:break-all;"><%=rset.getString(7).replaceAll("\n","<br>").replaceAll(" ","&nbsp")%></p></td>
</tr>
<tr>
	<td width=150><p align=center>접수일자</p></td>
	<td width=400><%=rset.getString(8)%> </td>
</tr>
<tr>
	<td width=150><p align=center>진행상황</p></td>
	<td width=400><%=statusRoom[rset.getInt(9)-1]%></td>
</tr>		
<tr>
<td colspan=2><p align= center><input type="submit" value="관리자페이지">
							   <input type="button" value="수정" onClick="buttonState('update')">
							   <input type="button" value="삭제" onClick="buttonState('delete')"></p></td>
</tr>
</table>
</form>
</center>
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
</body>
</html>

