<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@page import="com.oreilly.servlet.MultipartRequest" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>


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
		if(myString == "upload"){
			var file=myForm.uploadFile.value;
			if(file!=null){				
				myForm.enctype="multipart/form-data";
				myForm.action="sale_insert.jsp?state=upload";	
			}
			else{
				myForm.action="sale_insert.jsp";
			}			
		}		
		myForm.submit();
	}
</script>
<%
	String title="";
		
	String content="";
	String sstoreNum="";
	String iid="";
	String URL="";
	if(request.getParameter("URL")!=null)
		URL=request.getParameter("URL");
	String state="";
	if(request.getParameter("state")!=null)
		state=request.getParameter("state");		
%>


</head>
<body>

<%
    request.setCharacterEncoding("UTF-8");
 
    // 10Mbyte 제한
    int maxSize  = 1024*1024*10;       
  
    // 파일 저장 경로(ex : /home/tour/web/ROOT/upload)
    String savePath ="/var/lib/tomcat7/webapps/ROOT/twiceMart/";
	// 업로드 파일명
    String uploadFile = "";
	try{
		if(state.length()!=0){
			MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
		   // 파일업로드			  
			uploadFile = multi.getFilesystemName("uploadFile");
			// 업로드된 파일 객체 생성
			File oldFile = new File(savePath + uploadFile);
			//이미지저장후 URL 저장
			URL=uploadFile;	
			if(URL==null)
				URL="";
			if(multi.getParameter("title")!=null){
				title=multi.getParameter("title");
				title=new String(title.getBytes("8859_1"),"utf-8");
			}
			if(multi.getParameter("content")!=null){
				content=multi.getParameter("content");
				content=new String(content.getBytes("8859_1"),"utf-8");
			}
			if(multi.getParameter("id")!=null){
				iid=multi.getParameter("id");
			}
			if(multi.getParameter("storeNum")!=null){
				sstoreNum=multi.getParameter("storeNum");
			}
		}
		
	}catch(Exception e){
        out.println(e);
    }
 
%>

<form method="post" name="myForm" id="myForm">
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
	if(iid!=null){
		if(iid.length()!=0){
			id=Integer.parseInt(iid);
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
	if(sstoreNum!=null){
		if(sstoreNum.length()!=0){		
			storeNum=Integer.parseInt(sstoreNum);
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
			<%				
				 if(URL.length()!=0 )
					out.println("<td width=460 height=400 align =left valign=top><img src="+URL+" width=150 height=150 vspace=10 hspace=10><br>");
				else
					out.println("<td width=460 height=400 align =left valign=top>"); 
			%>
				<input type=hidden name="URL" value="<%=URL%>" >
				<input type="file" name="uploadFile" id="uploadFile">
				
				<input type=button value="Upload" onclick=register("upload")>				
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
