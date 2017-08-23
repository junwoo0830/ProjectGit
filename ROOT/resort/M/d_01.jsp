<meta http-=equiv="Content-Type" content="text/thml; charset=UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*" %>
<html>
<head></head>
<body BACKGROUND="image/bg33.JPG">
<center>
<h1>현재 예약 상황</h1><br>
<table border=1 cellspacing=0>
<tr bgcolor='#BDBDBD'>
	<td><p align=center>날짜</p></td>
	<td><p align=center>SweetRoom</p></td>
	<td><p align=center>PrivilegeRoom</p></td>
	<td ><p align=center>ClassicRoom</p></td>
</tr>
<%
	Calendar cal = Calendar.getInstance();
	SimpleDateFormat dformat = new SimpleDateFormat("MM-dd(E)",Locale.KOREAN);
	SimpleDateFormat nowformat = new SimpleDateFormat("yyyy-MM-dd");
	String nowdate = nowformat.format(cal.getTime());	
	int monCount=0;
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		ResultSet rset = stmt.executeQuery(" select * from  reserveDB where date>='"+nowdate+"';");
		while(rset.next())
			monCount++;
		if(monCount < 30){
			cal.add(cal.DATE, +monCount);
			for(int input=0; input<30-monCount;input++){
				stmt.execute("insert into reserveDB(date, week, room1,room2,room3) values('"+nowformat.format(cal.getTime() ) +"', "+cal.get(Calendar.DAY_OF_WEEK)+", 1,2,3)");
				cal.add(cal.DATE, +1);	
			}
		}		
		
	 	rset = stmt.executeQuery("  select r.date, r.week, max(if(r.room1=d.room,d.name,null)),max(if(r.room2=d.room,d.name,null)),max(if(r.room3=d.room,d.name,null)) from reserveDB r left join roomRes d on r.date=d.resv_date where r.date>='"+nowdate+"' group by r.date order by r.date asc;");
		while(rset.next()){
			if((rset.getInt(2)==1)||(rset.getInt(2)==7)){
				out.println(
				"<tr>"+
				"	<td style='word-break:break-all'><p align=center><font color='#ff0000'>"+(dformat.format(rset.getDate(1)))+"</font></p></td>");
			}
			else{
				out.println(
				"<tr>"+
				"	<td style='word-break:break-all'><p align=center>"+(dformat.format(rset.getDate(1)))+"</p></td>");
			}
			for(int i=0; i<3; i++){
				if(rset.getString(3+i)!=null){					
					String strb = rset.getString(3+i);
					if(strb.length()==2)
						strb=strb.substring(0,1) + "*";
					if(strb.length()>2){
						String star="";
						for(int c=0; c<(strb.length()-2); c++)
							star+="*";
						
						strb=strb.substring(0,1)+star+strb.substring( (strb.length()-1), strb.length());
					}				
					out.println("<td style='word-break:break-all'><p align=center>"+strb+"</p></td>");
				}
				else
					out.println("<td ><p align=center><a href=d_02.jsp?resDate="+(rset.getDate(1))+"&room="+(i+1)+">예약가능</p></td>");
			}
			out.println("</tr>" );
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

</table>
</center>
</body>
</html>