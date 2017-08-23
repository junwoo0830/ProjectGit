<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*" %>
<html>
<head>
<%
	int	iauto=4000;
	String s_url ="moni.jsp";
	
	String Cflag = request.getParameter("flag");
	
	if(Cflag == null) Cflag="0";
	
	int icnt = Integer.parseInt(Cflag) +1;
	
	if(icnt >10 ) icnt=1;
	s_url = String.format("%s?flag=%d",s_url,icnt);

%>
<script>
	function refresh_start(){
		location.href='<%=s_url%>'
	}
</script>
</head>
<body>
<center>
<h2>KOPO ENTERPRISE SYSTEM MONITORING</H2>
<table border=1 cellpadding=0 cellspacing =0>
<tr bgcolor='#bdbdbd'>
	<td width=100><p align=center><b>Server Num</b></p></td>
	<td width=100><p align=center><b>time</b></p></td>
	<td width=70><p align=center><b>CPU</b></p></td>
	<td width=70><p align=center><b>%User</b></p></td>
	<td width=70><p align=center><b>%NICE</b></p></td>
	<td width=70><p align=center><b>%System</b></p></td>
	<td width=70><p align=center><b>%iowait</b></p></td>
	<td width=70><p align=center><b>%steal</b></p></td>
	<td width=70><p align=center><b>IDLE</b></p></td>
	<td width=70><p align=center><b>STATUS</b></p></td>
</tr>
<%
	try{
 		 Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		ResultSet rset = stmt.executeQuery("select *from searchSar;");		//table의 내용을 조회한다.
 		while(rset.next()){					
			double idle = Double.parseDouble(rset.getString(10));	
			int rgb=0;
			if(idle <40.0){			//idle이 40보다 작으면 row를 빨간색으로 출력
				out.println("<tr bgcolor ='#ff0000'>");	
				rgb=3;
			}else if(idle <70.0){  //idle이 40보다 크고 70보다 작으면 status에 노란색 원 출력
				out.println("<tr>");
				rgb=2;
			}else{					//idle이 70보다 크면 status에 파란색 원 출력
				out.println("<tr>");
				rgb=1;
			}		
			out.println(			//내용 출력
			"		<td width=100><p align=left>Server "+rset.getInt(1)+"</p></td>"
			+"		<td width=100><p align=left>"+rset.getString(3)+"</p></td>"
			+"		<td width=70><p align=right>"+rset.getString(4)+"</p></td>"
			+"		<td width=70><p align=right>"+String.format("%.2f",rset.getDouble(5))+"</p></td>"
			+"		<td width=70><p align=right>"+String.format("%.2f",rset.getDouble(6))+"</p></td>"
			+"		<td width=70><p align=right>"+String.format("%.2f",rset.getDouble(7))+"</p></td>"
			+"		<td width=70><p align=right>"+String.format("%.2f",rset.getDouble(8))+"</p></td>"
			+"		<td width=70><p align=right>"+String.format("%.2f",rset.getDouble(9))+"</p></td>"
			+"		<td width=70><p align=right>"+String.format("%.2f",idle)+"</p></td>"
			+"		<td width=70><p align=center><image src=rgb"+rgb+".png width=10 height=10></p></td>"
			+"	</tr>");

		}
		rset.close();		
	 	stmt.close();
		conn.close();				
	}catch(Exception e){
		e.printStackTrace();
	} 	
%>
</table>
<script>
var timer = setInterval('refresh_start()',<%=iauto%>);
</script>

</body>
</html>

