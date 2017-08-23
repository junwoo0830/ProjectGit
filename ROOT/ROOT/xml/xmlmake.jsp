<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>
<%@ page import="javax.xml.parsers.*,org.w3c.dom.*"%>

<html>
<head>
</head>
<body>
<h1> 성적 조회 </h1>
<%

	//파싱을 위한 준비과정
	DocumentBuilder docBuilder =DocumentBuilderFactory.newInstance().newDocumentBuilder();
	
	//당연히 파일을 읽을때 서버내부 local path(전채경로)로 지정 .. 이 문장이 xml파싱을 한다. 단 위에 xml관련 임포트를 주의하라.
	Document doc = docBuilder.parse(new File("/var/lib/tomcat7/webapps/ROOT/xml/wifi.xml"));
	
	Element root = doc.getDocumentElement();
	NodeList get_fild = doc.getElementsByTagName("field");	
	NodeList tag_wifi[] = new NodeList[get_fild.getLength()];
	
	out.println("<table cellspacing=1 border=1>");
	out.println("<tr>");
	out.println("<td width=200>순번</td>");
	for(int j=0; j<get_fild.getLength(); j++){
		tag_wifi[j] = doc.getElementsByTagName(get_fild.item(j).getFirstChild().getNodeValue());
		out.println("<td width=200>"+get_fild.item(j).getFirstChild().getNodeValue()+"</td>");
	}
	out.println("</tr>");
	for(int i=0; i<tag_wifi[1].getLength(); i++){
		out.println("<tr>");
		out.println("<td width=100>"+i+"</td>");		
		for(int j=0; j<get_fild.getLength(); j++){
			if(tag_wifi[j].item(i).getFirstChild()==null)
				out.println("<td width=200></td>");	
			else
				out.println("<td width=200>"+tag_wifi[j].item(i).getFirstChild().getNodeValue()+"</td>");	
		}
		
		out.println("</tr>");
	}
	out.println("</table>"); 
	
%>
</body>
</html>
