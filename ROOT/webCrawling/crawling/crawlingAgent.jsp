<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import= "org.apache.http.HttpEntity" %>
<%@ page import= "org.apache.http.HttpResponse" %>
<%@ page import= "org.apache.http.NameValuePair" %>
<%@ page import= "org.apache.http.ParseException" %>
<%@ page import= "org.apache.http.client.HttpClient" %>
<%@ page import= "org.apache.http.client.entity.UrlEncodedFormEntity" %>
<%@ page import= "org.apache.http.client.methods.HttpGet" %>
<%@ page import= "org.apache.http.client.methods.HttpPost" %>
<%@ page import= "org.apache.http.impl.client.DefaultHttpClient" %>
<%@ page import= "org.apache.http.message.BasicNameValuePair" %>
<%@ page import= "org.apache.http.params.HttpConnectionParams" %>
<%@ page import= "org.apache.http.util.EntityUtils" %>
<%@ page import= "org.apache.http.conn.ClientConnectionManager" %>
<%@ page import= "org.apache.http.params.HttpParams" %>
<%@ page import= "org.apache.http.impl.conn.tsccm.ThreadSafeClientConnManager" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*,java.util.*,java.sql.*,javax.servlet.*,javax.sql.*,javax.naming.*" %>
<%@ page import = "javax.xml.parsers.*,org.w3c.dom.*" %>
<%@ page import = "java.util.regex.Pattern,java.util.regex.Matcher" %>
<html>
<head>
<%!
DefaultHttpClient client;
	/**
	*	HttpClient 재사용 관련 서버 통신시 세션을 유지 하기 위함.. HttpClient 4.5.3 ->https://hc.apache.org/downloads.cqi
	*/
public DefaultHttpClient getThreadSafeClient() {  //JsessionID를 Thread로 만든거다
	if (client != null)
		return client;
	client = new DefaultHttpClient();
	ClientConnectionManager mgr = client.getConnectionManager();
	HttpParams params = client.getParams();
	client = new DefaultHttpClient(new ThreadSafeClientConnManager(params, mgr.getSchemeRegistry()),params);
	return client;
}

public String goLogin(String url,String id,String iid, String passwd, String ppasswd){
	url+="?"+id+"="+iid+"&"+passwd+"="+ppasswd;	
	return goXML(url,false);
}

public String goXML(String getURL) {
	return goXML(getURL,false);
}

public String goXML(String getURL, Boolean loginFlag) {
	String Result = null;
	//세션유지 체크
	HttpClient client = getThreadSafeClient();
	HttpConnectionParams.setConnectionTimeout(client.getParams(),100000); //응답시간 100초
	HttpConnectionParams.setSoTimeout(client.getParams(),100000);   
	HttpPost post = new HttpPost(getURL);   //post방식으로 열어
	
	List <NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
	if(false) { //여기가 post/get 파라메터를 전달하는 곳
		nameValuePairs.add(new BasicNameValuePair("username", "kopoctc")); //1 파라미터 이름  2 파라미터 값
		nameValuePairs.add(new BasicNameValuePair("userpasswd", "kopoctc")); //1 파라미터 이름  2 파라미터 값
	}
	
	try{
		post.setEntity(new UrlEncodedFormEntity(nameValuePairs));
		HttpResponse responsePost = null;
		
		responsePost = client.execute(post);
		HttpEntity resEntity = responsePost.getEntity();
		
		if(resEntity != null) {
			Result = EntityUtils.toString(resEntity).trim();
		}
	}catch(Exception e) {
		e.printStackTrace();
	} finally{
	
	}
	return Result;
}
%>
<%
	int	iauto=2000;
	String s_url ="crawlingAgent.jsp";
	
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
<%
	try{
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat nowformat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
		long start = System.currentTimeMillis();
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		//서브쿼리를 이용해 flag가 0인것 중에 가장 작은 서버 번호를 찾는다.
		ResultSet rset = stmt.executeQuery("select * from searchResort where server_num = (select min(server_num) from searchResort where last_proc_flag =0);");				
		if(rset.next()){			
			cal = Calendar.getInstance();			
			String ret=goLogin(rset.getString(2),rset.getString(3),rset.getString(4),rset.getString(5),rset.getString(6)); 		//login session을 선언한다.
			//out.println(rset.getString(4));				
			ret=goXML(rset.getString(7));						//xml을 받아온다.
			int cnt=0;
			Pattern p = Pattern.compile("예약가능");		//pattern 인스턴스 생성 compile(찾을 패턴)
			Matcher m = p.matcher (ret);				//Matcher 인스턴스 생성 패턴을 찾을 문장
			while(m.find()) {							//패턴과 일치하는 텍스트를 찾느다.
				cnt++;
			}					
			//일치하는 패턴의 갯수를 호출한후 Database를 수정한다.
			stmt.execute("update searchResort set empty_room="+cnt+",last_req_time='"+nowformat.format(cal.getTime())+"',last_proc_flag=1 where server_num="+rset.getInt(1)+";");
		}		
		else		//만약 select 된 값이 없으면 flag를 0으로 초기화 한다.
			stmt.execute("update searchResort set last_proc_flag=0;");			
		long end = System.currentTimeMillis();
		long time = end-start;		
		rset.close();
		stmt.close();
		conn.close();		
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<script>
var timer = setInterval('refresh_start()',<%=iauto%>);
</script>
</center>
</body>
</html>


