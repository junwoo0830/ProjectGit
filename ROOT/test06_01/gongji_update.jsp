<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<script>
	function register(myString){
		if(myString == 'new'){
			myForm.action="gongji_insert.jsp";
			}
		if(myString == 'cancel'){
			myForm.action="gongji_list.jsp";
		}
		if(myString == "insert"){
			myForm.action="gongji_view.jsp?stst=insert";
		}
		if(myString == "write"){
			myForm.action="gongji_view.jsp?stst=write";
		}
		if(myString == 'update'){
			myForm.action="gongji_update.jsp";
		}
		if(myString == 'del'){
			myForm.action="gongji_delete.jsp";
		}
		myForm.submit();		
	}
</script>
<%
	int key=0;
	if(request.getParameter("key")!=null)
		key=Integer.parseInt(request.getParameter("key"));
	String state="";
	if(request.getParameter("stst")!=null)
		state=request.getParameter("stst");
	String title="무제";
	if(request.getParameter("title")!=null){
		title=request.getParameter("title");
		title=new String(title.getBytes("8859_1"),"utf-8");
	}
	if(title.length()==0)
		title="무제";
	int id=0;
	if(request.getParameter("id")!=null)
		id=Integer.parseInt(request.getParameter("id"));	
	String date="";
	if(request.getParameter("date")!=null)
		date=request.getParameter("date");
	String content="";
	if(request.getParameter("content")!=null){
		content=request.getParameter("content");
		content=new String(content.getBytes("8859_1"),"utf-8");
	}
	
%>
</head>
<body>
<%
	 java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
	 String today = formatter.format(new java.util.Date());
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		ResultSet rset = stmt.executeQuery(" select * from gongji where id ="+key+";");		
		rset.next();
%>


<form method="post" name= "myForm">
<table border=1 cellspacing=1>
<tr>           
	<td width=70  ><p align=center>번호</p></td>
	<td width=550 ><p align=left><input type=text name = "id" size=70 maxlength=70 value="<%=rset.getInt(1)%>" readonly></p></td>
</tr>	
<tr>	
	<td width=70 ><p align=center>제목</p></td>
	<td width=550 ><p align=left><input type=text name = "title" size=70 maxlength=70 value="<%=rset.getString(2)%>" required></p></td>
</tr>
	<td width=70 ><p align=center>일자</p></td>
	<td width=400 ><p align=left><%=today%></p></td>
	<input type=hidden name = "date" value=<%=today%>>	
</tr>
</tr>
	<td width=70 ><p align=center>내용</p></td>
	<td width=550><textarea style ='width:500px; height:250px;' name = "content" cols=70 row=600 ><%=rset.getString(4)%></textarea></td>
</tr>
</table>

<table>
<tr>
<td width= 480><p align=right><input type=button value="취소" onclick="register('cancel')" ></p></td>
<td width= 70><p align=right><input type=button value="쓰기" onclick="register('write')" ></p></td>
<td width= 70><p align=right><input type=button value="삭제" onclick="register('del')" ></p></td>
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

</table>
</body>
</html>
