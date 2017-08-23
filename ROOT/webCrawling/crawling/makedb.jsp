<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*" %>
<html>
<head></head>
<body>
<%
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		stmt.execute("drop table searchResort;");		
 		stmt.execute("create table searchResort("		//table을 생성한다.
					+ "server_num int,"
					+"login_url Varchar(200),"
					+"uName	Varchar(30),"
					+"uValue Varchar(30),"
					+"pName Varchar(30),"
					+"pValue Varchar(30),"
					+"adm_allview_url Varchar(200),"
					+"empty_room int,"
					+"last_req_time varchar(30),"
					+"last_proc_flag boolean,"
					+"resort_Name varchar(30),"
					+"resort_DName varchar(30),"
					+"resort_Hurl varchar(200))"
					+ "DEFAULT CHARSET=utf8;");	
		File f = new File("/var/lib/tomcat7/webapps/ROOT/webCrawling/resort.csv");
		BufferedReader br = new BufferedReader(new FileReader(f));
		String readtxt;
		if((readtxt = br.readLine())!=null){
			while( (readtxt = br.readLine() ) != null){
				String[] readData = readtxt.split(",");					
				int lasts=0;
				
				if(readData[2].equals("7") || readData[2].equals("18"))
					lasts=readData[3].indexOf("/", 30);
				/* else if(  readData[2].equals("16"))  
					lasts=readData[3].indexOf("/", 30); */
				else
					lasts=readData[3].indexOf("/", 36);
				String home_url = readData[3].substring(0,(lasts+1));		//서버의 홈페이지를 연결한다.
				//빈방 및 마지막 요청 시간을 제외하고 정보를 입력한다.				
				stmt.execute("insert into searchResort(server_num, login_url, uName,uValue,pName,pValue,adm_allview_url,last_proc_flag,resort_Name,resort_DName,resort_Hurl) values("+readData[2]+",'"+readData[3]+"','"+readData[4]+"','"+readData[5]+"','"+readData[6]+"','"+readData[7]+"','"+readData[8]+"',0,'"+readData[0]+"','"+readData[1]+"','"+home_url+"');");
				out.println(home_url);
			}
		}
		stmt.close();
		conn.close();	
		out.println("완료완료");
	}catch (ClassNotFoundException e) {	//클래스가 없으면 에러 출력			
		out.println("클래스에러 발생 : " +e);
	} catch (SQLException e) {			//sql에러가 있을시 에러 출력
		out.println("sql에러 발생 : " +e);
	}
%>
</table>
</body>
</html>

