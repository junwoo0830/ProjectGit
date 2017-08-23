<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*" %>
<html>
<head>
</head>
<body>
<center>
<%
	int[] arrayy = new int[3];
	ArrayList<Integer>arr[] = new ArrayList[3];
	for(int i=0; i< 3; i++){
		arr[i] = new ArrayList<Integer>();
	}
	Calendar cal = Calendar.getInstance();
	SimpleDateFormat dformat = new SimpleDateFormat("yy년MM월");
	SimpleDateFormat month = new SimpleDateFormat("M");
	SimpleDateFormat dday = new SimpleDateFormat("d");
	SimpleDateFormat stToDate = new SimpleDateFormat("yyyy-MM-dd");
	out.println("<h5><b>"+dformat.format(cal.getTime())+"</b></h5>");
	Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
	Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
	ResultSet rset =null;
	java.util.Date preDate;
	int dddd = 0;
	rset= stmt.executeQuery(" select sum(if(a.status='입금',a.cost,0)), sum(if(a.status='출금',a.cost,0)), a.Day from (select *from AcountBook where DATE_FORMAT(Day,'%m') = '08') a group by a.Day;");
	while(rset.next()){
		dddd = Integer.parseInt(dday.format(stToDate.parse(rset.getString(3))));	
		arr[0].add(rset.getInt(1));
		arr[1].add(rset.getInt(2));
		arr[2].add(dddd);		
	}	
	%> 
	
<table border=1 cellpadding=0 cellspacing=0 width=100% >
<tr>
	<td width=14% height=10 align='center' valign='center'><font color="red"><h5>일</h5></FONT></td>
	<td  width=14% height=10 align='center' valign='center'><font color="black"><h5>월</h5></FONT></td>
	<td  width=14% height=10 align='center' valign='center'><font color="black"><h5>화</h5></FONT></td>
	<td  width=14% height=10 align='center' valign='center'><font color="black"><h5>수</h5></FONT></td>
	<td width=14% height=10 align='center' valign='center'><font color="black"><h5>목</h5></FONT></td>
	<td  width=14% height=10 align='center' valign='center'><font color="black"><h5>금</h5></FONT></td>
	<td  width=14% height=10 align='center' valign='center'><font color="blue"><h5>토</h5></FONT></td>	
</tr>

<%
	int y = 2017, m=8, d=1;
	cal.set(y,(m-1),d);//2017.8.1
	int day_count = 1;
	int dayOfmonth =  cal.get(Calendar.DAY_OF_WEEK);  //이달의 1일의 요일
	int maxMonth = cal.getActualMaximum(Calendar.DATE); //이달의 마지막 날짜
	//out.println(cal.getActualMaximum(Calendar.DATE));
	//out.println("date: " + month.format(cal.getTime()));
	int arrayCount=0;
 	for(int i=(2-dayOfmonth); i<=maxMonth;i++){
		if( (day_count%7) == 1){
			out.println("<tr>");
		}
		if( i < 1 ){
			out.println("<td height=4 align='center'> </td>");			
		} else{
			if(day_count%7 ==1){
				out.println("<td height=4><h5><font color='red'>"+i+"</FONT>");
			}
			else if(day_count%7 ==0){
				out.println("<td height=4><h5><font  color='blue'>"+i+"</FONT>");
			}
			else{
				out.println("<td height=4><h5><font color='black'>"+i+"</FONT>");
			}
			
			if((arr[2].size() > arrayCount) && (arr[2].get(arrayCount)==i) ){
				if( (arr[0].get(arrayCount) >0) && (arr[1].get(arrayCount) >0) ){
					out.println("<br><font color='green'>"+arr[0].get(arrayCount)
							+"</font><br><font color='red'>"+arr[1].get(arrayCount)+"</font></h5></td>");
				}else if(arr[0].get(arrayCount) >0){
					out.println("<br><font color='green'>"+arr[0].get(arrayCount)+"</font><br><br></h5></td>");
				}else if(arr[1].get(arrayCount) >0){
					out.println("<br><br><font color='red'>"+arr[1].get(arrayCount)+"</font></h5></td>");
				}else{
					out.println("<font color='red'></font><br></h5></td>");
				}
				arrayCount++;
			}else{    
				out.println("<br><br><br></h5></td>");
			}
			
		} 
		if( (day_count++%7) ==0){
			out.println("</tr>");
		}
	}
	rset.close();
	stmt.close();
	conn.close();		
%>
</tr>
</table>
</center>
</body>
</html>

