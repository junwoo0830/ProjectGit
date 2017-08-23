<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<script>
	function register(myString){
		if(myString == "delete"){
			myForm.action="sale_delete.jsp";
		}
		if(myString == "update"){
			myForm.action="sale_update.jsp";		
		}
		if(myString == "complete"){
			myForm.action="sale_state.jsp?state=insert";		
		}
		myForm.submit();
	}
</script>
<%
	String title="";
	if(request.getParameter("title")!=null){
		title=request.getParameter("title");
		title=new String(title.getBytes("8859_1"),"utf-8");
	}	
	String date="";
	if(request.getParameter("date")!=null)
		date=request.getParameter("date");		
	String content="";
	if(request.getParameter("content")!=null){
		content=request.getParameter("content");
		content=new String(content.getBytes("8859_1"),"utf-8");
	}
	String URL="twice0.jpg";
	if(request.getParameter("URL")!=null)
		URL=request.getParameter("URL");	
%>


</head>
<body>
<form method="post" name="myForm">
<table border=1 cellpadding=5 cellspacing=0>
<tr>
	<td width=600><p align=center>(주)트와이스 재고 현황-상품등록</p></td>
</tr>
<tr>
	<td><p align=center><table border=1 cellspacing=0>
		<tr>           			
			<td width=100 ><p align=left>상품 번호</p></td>
<%	
	int id=0;
	if(request.getParameter("id")!=null){
		if(request.getParameter("id").length()!=0){
			id=Integer.parseInt(request.getParameter("id"));
			out.println("<td width=460 ><p align=left><input type=\"number\" size=50 maxlength=9 name=\"id\" required value="+id+"></p></td>");			
		}
		else
			out.println("<td width=460 ><p align=left><input type=\"number\" size=50 maxlength=9 name=\"id\" required value=\"\"></p></td>");
	}
	else
		out.println("<td width=460 ><p align=left><input type=\"number\" size=50 maxlength=9 name=\"id\" required value=\"\"></p></td>");

%>
		</tr>
		<tr>           			
			<td width=100 ><p align=left>상품명</p></td>
			<td width=460 ><p align=left><input type="text" size=50 maxlength=50 name="title" required value=<%=title%>  ></p></td>
		</tr>
		<tr>           			
			<td width=100 ><p align=left>재고 현황</p></td>

<%	
	int storeNum=0;
	if(request.getParameter("storeNum")!=null){
		if(request.getParameter("storeNum").length()!=0){		
			storeNum=Integer.parseInt(request.getParameter("storeNum"));
			out.println("<td width=460 ><p align=left><input type=\"number\" size=50 maxlength=9 name=\"storeNum\" required value="+storeNum+"></p></td>");			
		}
		else
			out.println("<td width=460 ><p align=left><input type=\"number\" size=50 maxlength=9 name=\"storeNum\" value=\"\"></p></td>");
	}
	else
		out.println("<td width=460 ><p align=left><input type=\"number\" size=50 maxlength=9 name=\"storeNum\" value=\"\"></p></td>");

%>			
		</tr>
<%
	 java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
	 String today = formatter.format(new java.util.Date());
%>	 
		<tr>           			
			<td width=100 ><p align=left>상품등록일</p></td>
			<td width=460 ><p align=left><%=today%></p></td>
			<input type="hidden" name="date" value=<%=today%>>
		</tr>
				<tr>           			
			<td width=100 ><p align=left>재고등록일</p></td>
			<td width=460 ><p align=left><%=today%></p></td>			
		</tr>
				<tr>           			
			<td width=100 ><p align=left>상품설명</p></td>
			<td width=460 ><p align=left><textarea style ='width:400px; height:20px;' name = "content" cols=70 row=600 ><%=content%></textarea></p></td>
		</tr>
		<tr>           			
			<td width=100 ><p align=left>상품 사진</p></td>
			<td width=460 height=400 align =left valign=top><img src=<%=URL%> width=150 height=150 vspace=10 hspace=10>
				<input type=button value="Upload" onclick=register("upload")>
				<p align=left>  <select name = "URL"> <option value="twice0.jpg">twice0.jpg
													  <option value="twice1.jpg">twice1.jpg
													  <option value="twice2.jpg">twice2.jpg
													  <option value="twice3.jpg">twice3.jpg
													  <option value="twice4.jpg">twice4.jpg
													  <option value="banana.jpg">banana.jpg
				</select></p>
			</td>
			
		
		</tr>
	</table></p></td>
</tr>
<tr>
	<td><table>
		<tr>
			<td width= 550><p align=right><input type=button value="완료" onclick=register("complete")></p></td>			
		</tr>
	</table></td>
</tr>
</table>
</form>
</body>
</html>
