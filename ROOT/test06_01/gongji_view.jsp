<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<%
	int key=0;
	if(request.getParameter("key")!=null)
		key=Integer.parseInt(request.getParameter("key"));
	String state="";
	if(request.getParameter("stst")!=null)
		state=request.getParameter("stst");
	String title="";
	if(request.getParameter("title")!=null){
		title=request.getParameter("title").replaceAll(" ","").replaceAll(",","").replaceAll("<","").replaceAll(">","").replaceAll(">","").replaceAll("&","");
		title=new String(title.getBytes("8859_1"),"utf-8");
	}
	int id=0;
	if(request.getParameter("id")!=null)
		id=Integer.parseInt(request.getParameter("id"));	
	String date="";
	if(request.getParameter("date")!=null)
		date=request.getParameter("date");
	String content="";
	if(request.getParameter("content")!=null){
		content=request.getParameter("content").replaceAll(" ","").replaceAll(",","").replaceAll("<","").replaceAll(">","").replaceAll(">","").replaceAll(";","").replaceAll("&","");
		content=new String(content.getBytes("8859_1"),"utf-8");
	}
%>
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
		if(myString == 'update'){
			myForm.action="gongji_update.jsp";
		}
	myForm.submit();		
	}
</script>
</head>
<body>
<%
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		ResultSet rset=null;
		int ssd=0;
		if(state.equals("insert")){
			if(title.length()==0){			
				out.println("<script>alert(\"이름이 없습니다.\");history.back();</script>");
				ssd=1;
			}
			else{
				stmt.execute("insert into gongji(title, date, content) values('"+title+"','"+date+"','"+content+"');");
				rset = stmt.executeQuery(" select * from gongji where id =(select max(id) from gongji);");
			}
		}
		if(state.equals("write")){
			if(title.length()==0){			
				out.println("<script>alert(\"이름이 없습니다.\");history.back();</script>");
				ssd=1;
			}
			else{
				stmt.execute("update gongji set title='"+title+"', date='"+date+"', content='"+content+"' where id = "+id+";");
				rset = stmt.executeQuery(" select * from gongji where id ="+id+";");
			}
		}
		 if(key!=0){
			rset = stmt.executeQuery(" select * from gongji where id ="+key+";");
		} 		
		
		
%>
<form method="post" name= "myForm">
<table border=1 cellspacing=1>
<%
	while((ssd!=1)&&rset.next()){
		String cont = rset.getString(4).replaceAll("\n","<br>");
		out.println(
	"		<tr>           "+
	"			<td width=70  ><p align=center>번호</p></td>"+
	"			<td width=400 ><p align=left>"+rset.getInt(1)+"</p></td>"+
	"			<input type=\"hidden\" name=\"key\" value="+rset.getInt(1)+">"+
	"		</tr>	"+
	"		<tr>	"+
	"			<td width=70 ><p align=center>제목</p></td>"+
	"			<td width=400 ><p align=left>"+rset.getString(2)+"</p></td>"+
	"		</tr>"+
	"		<tr>"+
	"			<td width=70 ><p align=center>일자</p></td>"+
	"			<td width=400 ><p align=left>"+rset.getDate(3)+"</p></td>"+
	"		</tr>"+
	"		<tr>"+
	"			<td width=70 ><p align=center>내용</p></td>"+
	"			<td width=400><p align=left>"+cont+"</p></td>"+
	"		</tr> "
		);
	}
%>
</table>

<table>
<tr>
<td width= 400><p align=right><input type=button value="목록" onclick="register('cancel')" ></p></td>
<td width= 70><p align=right><input type=button value="수정" onclick="register('update')" ></p></td>
</tr>

</table>
</form>
<%
		if(ssd!=1)rset.close();
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
