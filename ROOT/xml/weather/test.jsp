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


public String goXML(String getURL) {
	String Result = null;
	//세션유지 체크
	HttpClient client = getThreadSafeClient();
	HttpConnectionParams.setConnectionTimeout(client.getParams(),100000); //응답시간 100초
	HttpConnectionParams.setSoTimeout(client.getParams(),100000);   
	HttpPost post = new HttpPost(getURL);   //post방식으로 열어
	
	List <NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
	if(false) { //여기가 post/get 파라메터를 전달하는 곳
		nameValuePairs.add(new BasicNameValuePair("input1", "kopotc")); //1 파라미터 이름  2 파라미터 값
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
<h1>성적 조회</h1>
<%
	String ret=goXML("http://www.kma.go.kr/wid/queryDFS.jsp?gridx=61&gridy=123");
	//out.println(ret);
	
	try{
		//DocumentBuilderFactory 객체 생성
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		//DocumentBuilder 객체 생성
		DocumentBuilder builder = factory.newDocumentBuilder();
		
		ByteArrayInputStream is = new ByteArrayInputStream(ret.getBytes("utf-8"));
		//builder를 이용한 XML 파싱하여 Document 객체 생성
		Document doc = builder.parse(is);
		
		//생성된 document에서 각 요소들을 접근하여 데이터를 저장함
		Element root = doc.getDocumentElement();		
		NodeList tag_001 = doc.getElementsByTagName("data"); //xml의 루트를 기준으로  data테그를 찾는다.
		String seq ="";
		String hour ="";
		for(int i=0; i<tag_001.getLength(); i++) {	
			Element elmt=(Element)tag_001.item(i);		
			seq=tag_001.item(i).getAttributes().getNamedItem("seq").getNodeValue();			
			
			hour=elmt.getElementsByTagName("hour").item(0).getFirstChild().getNodeValue();
			out.println(seq + hour);
		}

	}catch(Exception e){
		e.printStackTrace();
	}
%>
</body>
</html>