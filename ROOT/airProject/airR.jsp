<meta http-dquiv="Content-type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.*,java.text.*" %>

<html>
<head>
<%
	String loginOK=null;
	String jumpURL="login/adm_login.jsp?jump=../b_01.jsp";
	
	loginOK = (String)session.getAttribute("login_ok");
	if(loginOK==null){
		response.sendRedirect(jumpURL);
		return;
	}
	if(!loginOK.equals("yes")){
		response.sendRedirect(jumpURL);
		return;
	}
	String loginID = (String)session.getAttribute("login_id");
%>
<script>
var st="";
var count=0;
function checkI(num,click){
	var obj = document.getElementById("m"+num);
	if(click>count){
		obj.src="choosed.png";
		if((click-1)==count)
			st+=""+num;
		else
			st+=""+num+",";
		count++;
	}
}
var stB="";
var countB=0;
function checkIB(num,click){
	var obj = document.getElementById("b"+num);
	if(click>countB){
		obj.src="choosed.png";
		if((click-1)==countB)
			stB+=""+num;
		else
			stB+=""+num+",";
		countB++;
	}
}
function next(){
	myForm.action="airR2.jsp?reg="+st+"&regB="+stB;
	myForm.submit();
}
</script>
<%
	String startp = request.getParameter("startP");
	String destinationP = request.getParameter("destinationP");
	String startD = request.getParameter("startD");
	String destinationD = "";
			if(request.getParameter("destinationD")!=null)
				destinationD=request.getParameter("destinationD");
	String adultN = request.getParameter("adultN");
	String hPay = request.getParameter("hPay");
	String direction = request.getParameter("direction");
	
%>
</head>
<body>
<%
	try{
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat dformat = new SimpleDateFormat("yyyy-MM-dd");
		String nowdate= dformat.format(cal.getTime());		
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성	
		stmt.execute("delete from airReg where startd < '"+nowdate+"' ;");		
%>
<center>
<h1>자리확인</h1>	
<%		
		out.println("<b>출발 날짜</b><br>");
		ResultSet rset = stmt.executeQuery(" select startP,destinationP,startD,sitNum from airReg where startD='"+startD+"' and startp='"+startp+"' and destinationP='"+destinationP+"' order by sitNum asc;");
		int rsetCh=0;
		if(rset.next())
			rsetCh=1;
		int click=Integer.parseInt(adultN);		
 		for(int i=0; i<10; i++){
			out.println( "<table><tr>");
			out.println("<td>m"+i+"1</td>");
			for(int j=0; j<10; j++){				
				String ccc = ""+i+j;
				if(rsetCh==1){					
					if(rset.getString(4).equals(ccc)){					
						out.println("  <td><image src=\"nosit.png\" width=20 height=20></td> ");
						if(rset.next())
							rsetCh=1;
						else
							rsetCh=0;
					}
					else{
						out.println("  <td><image src=\"choose.png\" width=20 height=20 id='m"+i+j+"' onclick=\"checkI('"+i+j+"',"+click+");\"></td> ");
					}
				}
				else{
					out.println("  <td><image src=\"choose.png\" width=20 height=20 id='m"+i+j+"' onclick=\"checkI('"+i+j+"',"+click+");\"></td> ");
				}
				
				if( (j==1) || (j==7) )
					out.println("<td>|  |</td>");
			}
			out.println("<td>m"+i+"9</td>");
			out.println( "</tr>	</table>");
		}
		if(direction.equals("goback")){
			out.println("<br><br><b>돌아오는 날짜</b><br>");
				rset = stmt.executeQuery(" select startP,destinationP,startD,sitNum from airReg where startD='"+destinationD+"' and startp='"+destinationP+"' and destinationP='"+startp+"' order by sitNum asc;");
				rsetCh=0;
				if(rset.next())
					rsetCh=1;
				click=Integer.parseInt(adultN);		
				for(int i=0; i<10; i++){
					out.println( "<table><tr>");
					out.println("<td>b"+i+"1</td>");
					for(int j=0; j<10; j++){				
						String ccc = ""+i+j;
						if(rsetCh==1){					
							if(rset.getString(4).equals(ccc)){					
								out.println("  <td><image src=\"nosit.png\" width=20 height=20></td> ");
								if(rset.next())
									rsetCh=1;
								else
									rsetCh=0;
							}
							else{
								out.println("  <td><image src=\"choose.png\" width=20 height=20 id='b"+i+j+"' onclick=\"checkIB('"+i+j+"',"+click+");\"></td> ");
							}
						}
						else{
							out.println("  <td><image src=\"choose.png\" width=20 height=20 id='b"+i+j+"' onclick=\"checkIB('"+i+j+"',"+click+");\"></td> ");
						}
						
						if( (j==1) || (j==7) )
							out.println("<td>|  |</td>");
					}
					out.println("<td>b"+i+"9</td>");
					out.println( "</tr>	</table>");
				}
		
		
		}
		
		
		rset.close();
		stmt.close();
		conn.close();		
	}catch (ClassNotFoundException e) {	//클래스가 없으면 에러 출력			
		out.println("클래스에러 발생 : " +e);
	} catch (SQLException e) {			//sql에러가 있을시 에러 출력
		out.println("sql에러 발생 : " +e);
	}	
%>

	<form method="post" name="myForm" >
		<input type="button" value="다음" onclick="next()">
		<input type="hidden" name="startP" value="<%=startp%>" >
		<input type="hidden" name="destinationP" value="<%=destinationP%>" >
		<input type="hidden" name="startD" value="<%=startD%>" >
		<input type="hidden" name="destinationD" value="<%=destinationD%>" >
		<input type="hidden" name="direction" value="<%=direction%>" >
		<input type="hidden" name="adultN" value="<%=adultN%>" >
		<input type="hidden" name="hPay" value="<%=hPay%>" >		
	</form>
</center>
</body>
</html>