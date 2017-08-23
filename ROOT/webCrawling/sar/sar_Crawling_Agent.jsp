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
	client = new DefaultHttpClient();  //HttpClient의 가장 기본적은 인스턴스를 생성한다.
	ClientConnectionManager mgr = client.getConnectionManager();
	HttpParams params = client.getParams(); //HttpClient의 매게변수를 받는다.
	//DefaultHttpClient는 표준 HttpClient이며 HTTP 연결을 처리
	//ThreadSafeClientConnManager는 client를 운영하며 서버 연결의 다중thread를 가능하도록 설정한다.
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
	HttpClient client = getThreadSafeClient();		//HttpClient의 다중 thread서버를 연결한다.	
	HttpConnectionParams.setConnectionTimeout(client.getParams(),100000); //응답시간 100초
	HttpConnectionParams.setSoTimeout(client.getParams(),100000);   
	HttpPost post = new HttpPost(getURL);   //post방식으로 열어
	
	List <NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
	if(false) { //여기가 post/get 파라메터를 전달하는 곳
		nameValuePairs.add(new BasicNameValuePair("username", "kopoctc")); //1 파라미터 이름  2 파라미터 값
		nameValuePairs.add(new BasicNameValuePair("userpasswd", "kopoctc")); //1 파라미터 이름  2 파라미터 값
	}
	
	try{
		post.setEntity(new UrlEncodedFormEntity(nameValuePairs));		//ArrayList의 post정보를 URL폼에 추가한다.
		HttpResponse responsePost = null;
		
		responsePost = client.execute(post);		//post(URL)을 실행 시킨다.
		HttpEntity resEntity = responsePost.getEntity();	//실행후 출력된 결과를 저장한다.
		
		if(resEntity != null) {		//만약 결과가 없지 않으면 출력 리턴한다.
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
	String s_url ="sar_Crawling_Agent.jsp";
	
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
		SimpleDateFormat nowformat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		long start = System.currentTimeMillis();
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		//서브쿼리를 이용해 flag가 0인것 중에 가장 작은 서버 번호를 찾는다.
		ResultSet rset = stmt.executeQuery("select * from searchSar where server_num = (select min(server_num) from searchSar where last_proc_flag =0);");			
		if(rset.next()){			
			cal = Calendar.getInstance();				
			String ret=goXML(rset.getString(2));	//server_url의 내용을 실행한다. => 결과인 xml을 가져온다.			
			//파싱을 위한 준비과정
			//DocumentBuilderFactory 객체 생성
			DocumentBuilderFactory factory=DocumentBuilderFactory.newInstance();
			//DocumentBuilder 객체 생성
			DocumentBuilder docBuilder=factory.newDocumentBuilder();

			ByteArrayInputStream is=new ByteArrayInputStream(ret.getBytes("utf-8"));
			//builder를 이용하여 xml 파싱하여 Document 객체 생성
			Document doc=docBuilder.parse(is);
			//생성된 document에서 각 요소들을 접근하여 데이터를 저장함
			Element root=doc.getDocumentElement();
			NodeList tag_001=doc.getElementsByTagName("data");	//data로 시작된 노드를 가지고 온다.
			Element elmt=(Element)tag_001.item(0);				//노드의 0번째 element를 가지고 온다.				
			//sar에서 출력되는 내용을 DB table에 update한다.
			stmt.execute("update searchSar set time='"+elmt.getElementsByTagName("time").item(0).getFirstChild().getNodeValue()+"',CPU='"+elmt.getElementsByTagName("CPU").item(0).getFirstChild().getNodeValue()+"',user='"+elmt.getElementsByTagName("user").item(0).getFirstChild().getNodeValue()+"',nice='"+elmt.getElementsByTagName("nice").item(0).getFirstChild().getNodeValue()+"',system='"+elmt.getElementsByTagName("system").item(0).getFirstChild().getNodeValue()+"',iowait='"+elmt.getElementsByTagName("iowait").item(0).getFirstChild().getNodeValue()+"',steal='"+elmt.getElementsByTagName("steal").item(0).getFirstChild().getNodeValue()+"',idle='"+elmt.getElementsByTagName("idle").item(0).getFirstChild().getNodeValue()+"', last_req_time='"+nowformat.format(cal.getTime())+"',last_proc_flag=1 where server_num="+rset.getInt(1)+";");
		}		
		else					//만약 select 된 값이 없으면 flag를 0으로 초기화 한다.
			stmt.execute("update searchSar set last_proc_flag=0;");	
		//out.println(rset.getInt(1));
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


