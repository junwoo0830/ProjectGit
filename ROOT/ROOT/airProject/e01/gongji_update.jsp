<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*,java.io.*"%>

<html>
<head>
<script>
	function buttonState(index){		
		if(index == 'update')
			myForm.action="gongji_stateview.jsp?inputTyp=update";
		myForm.submit();			
	}

</script>
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
%>
</head>
<body BACKGROUND="../image/bg33.JPG">
<center>
<h1>수정하실 내용을 입력해 주세요[관리자페이지]</h1><br>
<%
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		ResultSet rset = stmt.executeQuery("select * from resortGongji where id="+id+";");
		rset.next();		
%>
<form method=post name="myForm" action="e_01.jsp">
<table border=1 cellspacing=1>
<tr>
	<td width = 60><p align = left>번호</p></td>
	<td width = 440><p align = left><input type=text name="id" value="<%=rset.getInt(1)%>" readonly></p></td>
</tr>
<tr>
	<td width = 60><p align = left>제목</p></td>
	<td width = 440><p align = left><input type=text size=50 maxlength=20 name="title" value="<%=rset.getString(2)%>" required></p></td>
</tr>
<%
	 java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
	 String today = formatter.format(new java.util.Date());
%>
<tr>
	<td width = 60><p align = left>일자</p></td>
	<td width = 440><p align = left><%=rset.getString(3)%></p></td>
	<input type=hidden name="date" value=<%=today%>>
</tr>
<tr>
	<td width = 60><p align = left>내용</p></td>
	<td width = 440><textarea style ='width:500px; height:250px;' maxlength=200 name= "content" cols=70 row=600 ><%=rset.getString(4)%></textarea></td>
</tr>
</table>
<table>
<tr>	
	<td width = 440><p align = right><input type=submit value="취소"></td>
	<td width = 40><p align = center><input type=button value="쓰기" onclick="buttonState('update')"></td>
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

