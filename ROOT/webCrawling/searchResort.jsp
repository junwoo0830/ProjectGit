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

</head>
<body>
<center>
<h2>1등 호텔 예약 사이트[호텔 코파유]</h1>
<table border=1 cellpadding=0 cellspacing =0>
<tr>
	<td width=200><p align=center>리조트명</p></td>
	<td width=100><p align=center>빈방</p></td>
	<td width=200><p align=center>조회시간</p></td>
</tr>
<%
	try{
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat nowformat = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss.SSS");
		long start = System.currentTimeMillis();
		File f = new File("/var/lib/tomcat7/webapps/ROOT/webCrawling/resort.csv");
		BufferedReader br = new BufferedReader(new FileReader(f));
		String readtxt;
		if((readtxt = br.readLine())!=null){
			while( (readtxt = br.readLine() ) != null){
				cal = Calendar.getInstance();
				String[] readData = readtxt.split(",");
				String ret=goLogin(readData[3],readData[4],readData[5],readData[6],readData[7]);
				//out.println(ret);
				ret=goXML(readData[8]);				
				int cnt=0;
				Pattern p = Pattern.compile("예약가능");
				Matcher m = p.matcher (ret);
				while(m.find()) {
					cnt++;
				}
				out.println(
					"<tr>"
					+"	<td width=200><p align=left>"+readData[0]+"</p></td>"
					+"	<td width=100><p align=rigth>"+cnt+"</p></td>"
					+"	<td width=200><p align=left>"+nowformat.format(cal.getTime())+"</p></td>"
					+"</tr>"
				);				
			}
		}
		out.println("</table>");
		long end = System.currentTimeMillis();
		long time = end-start;
		out.println("작동시간 : " +time/1000.0);
	}catch(Exception e){
		e.printStackTrace();
	} 	
%>
</center>
</body>
</html>