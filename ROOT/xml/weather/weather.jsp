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
		nameValuePairs.add(new BasicNameValuePair("gridx", "61")); //1 파라미터 이름  2 파라미터 값
		nameValuePairs.add(new BasicNameValuePair("gridy", "123")); //1 파라미터 이름  2 파라미터 값
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
	
<%
	String ret=goXML("http://www.kma.go.kr/wid/queryDFS.jsp?gridx=61&gridy=123");
	//out.println(ret);
	
	try{	
		//파싱을 위한 준비과정
		//DocumentBuilderFactory 객체 생성
		DocumentBuilderFactory factory=DocumentBuilderFactory.newInstance();
		//DocumentBuilder 객체 생성
		DocumentBuilder docBuilder=factory.newDocumentBuilder();

		ByteArrayInputStream is=new ByteArrayInputStream(ret.getBytes("utf-8"));
		//builder를 이용하여 xml 파싱하여 Document 객체 생성
		Document doc=docBuilder.parse(is);
		String seq="";   //48시간중 몇번째 인지 알려줌
		String hour="";   //동네예보 3시간 단위
		String day="";   //1번째날(0:오늘/1:내일/2:모레)
		String temp="";   //현재시간 온도
		String tmx="";   //최고 온도
		String tmn="";   //최저 온도
		String sky="";   //하늘 상태코드(1:맑음,2:구름조금,3:구름많음,4:흐림)
		String pty="";   //강수 상태코드(0:없음,1:비,2:비/눈,3:눈/비,4:눈)
		String wfKor="";//날씨 한국어
		String pop="";   //강수확률%
		String r12="";   //12시간 예상 강수량
		String s12="";   //12시간 예상 적설량
		String ws="";   //풍속(m/s)
		String wd="";	//풍향 (0~7:북, 북동, 동, 남동, 남, 남서, 서, 북서)
		String reh="";   //습도%
		String r06="";   //6시간 예상 강수량
		String s06="";   //6시간 예상 적설량

		//생성된 document에서 각 요소들을 접근하여 데이터를 저장함
		Element root=doc.getDocumentElement();
		NodeList tag_001=doc.getElementsByTagName("data");		
		/*
		*	header에 있는 오늘의 날짜 시간 정보를 가지고와서 날짜 정보를 추가합니다.
		*   이때 day의 값의 증가에 따라 날짜 및 시간이 나오도록 하였습니다.
		*/
		NodeList tag_002=doc.getElementsByTagName("tm");
		String date = tag_002.item(0).getFirstChild().getNodeValue();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmm");
		SimpleDateFormat sdf1=new SimpleDateFormat("dd");
		SimpleDateFormat sdf2=new SimpleDateFormat("yyyy년 M월");
		SimpleDateFormat dform=new SimpleDateFormat("yyyy년 M월 dd일 HH시 m분에 측정된 ");
		java.util.Date today=sdf.parse(date); 		//String -> date 변환
		out.println("<p><h3>"+dform.format(today)+"</h3></p>");
		out.println("<p><h3>경기도 성남시 수내동의 일기 예보입니다.</h3></p>");
		
		//table 메뉴 내용 표시		
		out.println("<table cellspacing=0 cellpadding=0  border=1>");
		out.println("<tr bgcolor='#BDBDBD'>");
		out.println("<td width=70><p align=center>번호</p></td>");
		out.println("<td width=400><p align=center>날짜 시간</p></td>");
		out.println("<td width=150><p align=center>온도</p></td>");
		out.println("<td width=150><p align=center>최고온도</p></td>");
		out.println("<td width=150><p align=center>최저온도</p></td>");		
		out.println("<td width=180><p align=center>날씨(그림)</p></td>");
		/* out.println("<td width=180><p align=center>강수상태</p></td>");
		out.println("<td width=180><p align=center>날씨</p></td>"); */
		out.println("<td width=180><p align=center>강수확률</p></td>");
	/* 	out.println("<td width=300><p align=center>예상강수량(12시간)</p></td>");
		out.println("<td width=300><p align=center>예상적설량(12시간)</p></td>"); */		
		out.println("<td width=150><p align=center>풍향</p></td>");
		out.println("<td width=150><p align=center>풍속(m/s)</p></td>");
		out.println("<td width=150><p align=center>습도(%)</p></td>");
		/* out.println("<td width=330><p align=center>예상강수량(6시간)</p></td>");
		out.println("<td width=330><p align=center>예상적설량(6시간)</p></td>"); */
		out.println("</tr>");
		
		//내용 표시
 		for(int i=0; i<tag_001.getLength(); i++){
			Element elmt=(Element)tag_001.item(i);
						
			hour = elmt.getElementsByTagName("hour").item(0).getFirstChild().getNodeValue();
			day  = elmt.getElementsByTagName("day").item(0).getFirstChild().getNodeValue();
			int dday = (Integer.parseInt(sdf1.format(today)) + Integer.parseInt(day));	//일자값 + day의 정보를 정수값으로 추출!
			String st = sdf2.format(today)+dday; 	//다시 String으로 변환하여 오늘의 날짜로 변환!
			out.println("<tr>");
			out.println("<td width=70><p align=center>"+tag_001.item(i).getAttributes().getNamedItem("seq").getNodeValue()+"</p></td>");
			out.println("<td width=400><p align=left>"+st+"일 "+hour+"시</p></td>");
			out.println("<td width=150><p align=center>"+elmt.getElementsByTagName("temp").item(0).getFirstChild().getNodeValue()+"°</p></td>");
			//값이 -999.0은 정보가 없을경우를 의미한다.
			tmx=elmt.getElementsByTagName("tmx").item(0).getFirstChild().getNodeValue();
			if(tmx.equals("-999.0")){
				out.println("<td width=150><p align=center>-</p></td>");
			}else{
				out.println("<td width=150><p align=center>"+tmx+"°</p></td>");
			}	
			tmn=elmt.getElementsByTagName("tmn").item(0).getFirstChild().getNodeValue();
			if(tmn.equals("-999.0")){
				out.println("<td width=150><p align=center>-</p></td>");
			}else{
				out.println("<td width=150><p align=center>"+tmn+"°</p></td>");
			}		
			// 시간의 분포가 6시부터 18시까지를 낮으로 추정하여 낮의 날씨 예보 이미지를 사용 
			// 그외 시간은 저녁의 날씨 예보 이미지를 사용
			if( (Integer.parseInt(hour) > 5) && (Integer.parseInt(hour) < 19)){				
				String ssky = "image/n"+elmt.getElementsByTagName("sky").item(0).getFirstChild().getNodeValue()+".png";
				out.println("<td width=180><p align=center><image src=\""+ssky+"\" width=15 height=15></p></td>");
			}
			else{				
				String ssky = "image/d"+elmt.getElementsByTagName("sky").item(0).getFirstChild().getNodeValue()+".png";
				out.println("<td width=180><p align=center><image src=\""+ssky+"\" width=15 height=15></p></td>");
			}
			// 강수상태를 이미지로 표현
/* 			pty=elmt.getElementsByTagName("pty").item(0).getFirstChild().getNodeValue();
			if(pty.equals("0")){
				out.println("<td width=180><p align=center></p></td>");
			}else{
				String ppty = "image/p"+pty+".png";
				out.println("<td width=180><p align=center><image src=\""+ppty+"\" width=15 height=15></p></td>");
			}			
			out.println("<td width=180><p align=center>"+elmt.getElementsByTagName("wfKor").item(0).getFirstChild().getNodeValue()+"</p></td>"); */
			out.println("<td width=180><p align=center>"+elmt.getElementsByTagName("pop").item(0).getFirstChild().getNodeValue()+"%</p></td>");
		/* 	out.println("<td width=300><p align=center>"+elmt.getElementsByTagName("r12").item(0).getFirstChild().getNodeValue()+"mm</p></td>");
			out.println("<td width=300><p align=center>"+elmt.getElementsByTagName("s12").item(0).getFirstChild().getNodeValue()+"cm</p></td>"); */
			out.println("<td width=180><p align=center>"+(elmt.getElementsByTagName("ws").item(0).getFirstChild().getNodeValue()).substring(0,3)+"m/s</p></td>");
			wd=elmt.getElementsByTagName("wd").item(0).getFirstChild().getNodeValue();
			String wwd = "image/wd"+wd+".png";
			out.println("<td width=150><p align=left><image src=\""+wwd+"\" width=15 height=15>"+elmt.getElementsByTagName("wdKor").item(0).getFirstChild().getNodeValue()+"</p></td>");
			//out.println("<td width=150><p align=center>"+elmt.getElementsByTagName("wd").item(0).getFirstChild().getNodeValue()+"</p></td>");
			out.println("<td width=150><p align=center>"+elmt.getElementsByTagName("reh").item(0).getFirstChild().getNodeValue()+"%</p></td>");
			/* out.println("<td width=330><p align=center>"+elmt.getElementsByTagName("r06").item(0).getFirstChild().getNodeValue()+"mm</p></td>");
			out.println("<td width=330><p align=center>"+elmt.getElementsByTagName("s06").item(0).getFirstChild().getNodeValue()+"cm</p></td>"); */
			out.println("</tr>");
		} 
		out.println("</table>");

		//out.println(Integer.parseInt(st));
  	}catch(Exception e){
		e.printStackTrace();
	}

%>
	
</body>
</html>