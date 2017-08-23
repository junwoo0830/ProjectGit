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
<center>
<br>
<form method='submit' action='allMap.jsp'>
<h1>도로 공사 정보 <input type='submit' value='전체 지도보기'></h1>
</form>
<table border=1 cellspacing=0 cellpadding=0>
	<tr bgcolor='#bdbdbd'>
		<td width=70><p align=center>번호</p></td>
		
		<td width=150><p align=center>차단방법</p></td>
		<td width=150><p align=center>공사 시작일</p></td>
		<td width=150><p align=center>공사 종료일</p></td>
		<td width=150><p align=center>공사 상황 메시지</p></td>
	
		<td width=150><p align=center>진행방향</p></td>
		<td width=150><p align=center>지도보기</p></td>
	</tr>




<%
	String ret=goXML("http://openapi.its.go.kr/api/NEventIdentity?key=1498271446332&ReqType=2&MinX=123.660043&MaxX=132.497831&MinY=33.052125&MaxY=38.273987&type=its");
	//out.println(ret);
	String DataCount; 			//공사정보 개수
	String type; 				//도로정보
	String Eventld;				//공사 고유 식별번호
	String eventtype; 			//공사정보유형
	String coordx; 				//경도좌표
	String coordy;				//위도좌표
	String lanesblocktype; 		//공사길 차단방법( 0: 통제없음 1:갓길통제 2:차로부분통제 3: 전면통제)
	String lanesblocked;			//공사로 인해 차단된 차로수
	String eventstartday;		//공사 시작일
	String eventendday; 		//공사 종료일
	String eventstatusmsg;			//공사 상황 정보 메시지
	String expectedcnt;			//우회정보개수
	String ExpectedDetourMsg;	//우회정보 메시지
	String eventdirection;
	String[] BlockType = {"통제없음","갓길통제","차로부분통제","전면통제","-","-"};
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
		NodeList tag_001=doc.getElementsByTagName("data");		
		for(int i=0; i<(tag_001.getLength()-35); i++){
			Element elmt=(Element)tag_001.item(i);
			coordx = elmt.getElementsByTagName("coordx").item(0).getFirstChild().getNodeValue();
			coordy = elmt.getElementsByTagName("coordy").item(0).getFirstChild().getNodeValue();
		//	out.println(elmt.getElementsByTagName("eventstatusmsg").item(0).getFirstChild().getNodeValue());
			if(elmt.getElementsByTagName("eventdirection").item(0).getFirstChild()!=null){
				eventdirection=elmt.getElementsByTagName("eventdirection").item(0).getFirstChild().getNodeValue();
			}else{
				eventdirection="-"; 		//진행방향
			}
			eventstatusmsg = elmt.getElementsByTagName("eventstatusmsg").item(0).getFirstChild().getNodeValue();
 			out.println(
			"<form method='post' action='oneMap.jsp'>"
			+"<tr>"
			+"	<td width=150><p align=center>"+(i+1)+"</p></td>"
		/* 	+"	<td width=150><p align=center>"+elmt.getElementsByTagName("eventtype").item(0).getFirstChild().getNodeValue()+"</p></td>" */
			+"	<td width=150><p align=center>"+BlockType[Integer.parseInt(elmt.getElementsByTagName("lanesblocktype").item(0).getFirstChild().getNodeValue())]+"</p></td>"
			+"	<td width=150><p align=center>"+elmt.getElementsByTagName("eventstartday").item(0).getFirstChild().getNodeValue()+"</p></td>"
			+"	<td width=150><p align=center>"+elmt.getElementsByTagName("eventendday").item(0).getFirstChild().getNodeValue()+"</p></td>"
			+"	<td width=150><p align=center>"+eventstatusmsg+"</p></td>"
			/* +"	<td width=150><p align=center>"+elmt.getElementsByTagName("expectedcnt").item(0).getFirstChild().getNodeValue()+"</p></td>" */
			+"	<td width=150><p align=center>"+eventdirection+"</p></td>"
			+"	<input type='hidden' name='eventstatusmsg' value='"+eventstatusmsg+"'>"
			+"	<input type='hidden' name='coordx' value='"+coordx+"'>"
			+"	<input type='hidden' name='coordy' value='"+coordy+"'>"
			+"	<td width=150><p align=center><input type='submit' value='지도보기'></p></td>"
			+"</form></tr>"
			); 
		}
	}catch(Exception e){
		e.printStackTrace();
	} 
%>
</table>
</center>
</body>
</html>