<meta http-=equiv="Content-Type" content="text/thml; charset=UTF-8" />
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
	if(request.getParameter("date")!=null)
		resDate=request.getParameter("date");
	int room=0;
	if(request.getParameter("room")!=null)
		room=Integer.parseInt(request.getParameter("room"));
%>

<script>
	function buttonState(index){
		if(index == 'delete')
			myForm.action="adm_state.jsp?inputTyp=delete";
		if(index == 'update')
			myForm.action="adm_state.jsp?inputTyp=update";
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
	String nowdate= dformat.format(cal.getTime());
	cal.add(cal.DATE, +29);	
	String maxdate= dformat.format(cal.getTime());	
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		ResultSet rset = stmt.executeQuery("  select * from roomRes where resv_date='"+resDate+"' and room="+room+";");
		rset.next();		
		String[] choise = {"","",""};
		choise[(rset.getInt(3)-1)]+="selected = \"selected\" ";
		String[] stausChoise = {"","",""};
		stausChoise[(rset.getInt(9)-1)]+="selected = \"selected\" ";		
%>		
<form method="post" name="myForm" action="adm_allview.jsp">
<table border=1 cellspacing=0>
<tr>
	<td width=150><p align=center>성명</p></td>
	<td width=400><input type=text name="rName"  maxlength="17" value=<%=rset.getString(1)%> required></td>
</tr>	

<tr>
	<td width=150><p align=center>예약일자</p></td>
	<td width=400><input type="date" maxlength='10' name="date" max="<%=maxdate%>" min="<%=nowdate%>" value=<%=resDate%> required></td>
	<input type=hidden name=hdate value=<%=resDate%> >
</tr>
<tr>
	<td width=150><p align=center>예약방</p></td>
	<td width=400><select name=resRoom><option value=1 <%=choise[0]%>>Sweet Room
									   <option value=2 <%=choise[1]%>>Privilege Room
									   <option value=3 <%=choise[2]%>>Classic Room
				<input type=hidden name="room" value=<%=rset.getInt(3)%>>					   
	</select></td>
</tr>	
<tr>
	<td width=150><p align=center>주소</p></td>
	<td width=400><input type=text name="address" size=60  maxlength="50" value=<%=rset.getString(4)%> required></td>
</tr>	
<tr>
	<td width=150><p align=center>전화번호(-생략)</p></td>
	<td width=400><input type=text name="phone" maxlength='11'  onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;"  value=<%=rset.getString(5)%> required></td>
</tr>	
<tr>
	<td width=150><p align=center>입금자명</p></td>
	<td width=400><input type=text name="money"  maxlength="17" value=<%=rset.getString(6)%> required></td>
</tr>
<tr>
	<td width=150><p align=center>남기실말</p></td>
	<td width=400><p align=left><textarea style ='width:350px; height:100px;' name = "content" maxlength=200 cols=70 row=600 ><%=rset.getString(7)%></textarea></p></td>
</tr>
<tr>
	<td width=150><p align=center>접수일자</p></td>
	<td width=400><input type=date name="subDate" value='<%=rset.getString(8)%>' readonly></td>
</tr>
<tr>
	<td width=150><p align=center>진행상황</p></td>
	<td width=400><select name=status><option value=1 <%=choise[0]%>>예약중 결제예정
									  <option value=2 <%=choise[1]%>>결제 완료
									  <option value=3 <%=choise[2]%>>예약완료	
	</td>
</tr>		
<tr>
<td colspan=2><p align= center><input type="submit" value="취소">
							   <input type="button" value="내용수정" onClick="buttonState('update')">							
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