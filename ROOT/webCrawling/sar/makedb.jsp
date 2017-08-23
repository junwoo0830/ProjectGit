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
		stmt.execute("drop table searchSar;");		
 		stmt.execute("create table searchSar("			//table 생성
					+ "server_num int,"
					+"sar_url Varchar(200),"
					+"time	Varchar(20),"
					+"CPU Varchar(20),"
					+"user double,"
					+"nice double,"
					+"system double,"
					+"iowait double,"
					+"steal double,"
					+"idle double,"
					+"last_req_time Datetime,"
					+"last_proc_flag boolean)"
					+ "DEFAULT CHARSET=utf8;");	  
		File f = new File("/var/lib/tomcat7/webapps/ROOT/webCrawling/resort.csv");
		BufferedReader br = new BufferedReader(new FileReader(f));
		String readtxt;
		if((readtxt = br.readLine())!=null){
			while( (readtxt = br.readLine() ) != null){
				String[] readData = readtxt.split(",");
				int lasts=readData[3].indexOf("/", 8);
				String sar_url = readData[3].substring(0,lasts)+"/sar.jsp";		//서버 번호 및 sar_url 그리고 flag를 입력한다.		
				stmt.execute("insert into searchSar(server_num, sar_url,last_proc_flag) values("+readData[2]+",'"+sar_url+"',0);");
			}
		}
	 	stmt.close();
		conn.close();	
			out.println("완료 완료");
	}catch(Exception e){
		e.printStackTrace();
	} 	
%>
</body>
</html>

