<meta http-dquiv="Content-type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.*,java.text.*" %>


<html>
<body>

<%
	String one = "kkk";
	String strb = one;
	if(strb.length()==2)
		strb.replaceAll(strb.substring(1,2),"*"); 	
	if(strb.length()>2){
		String star="";
		for(int c=0; c<(strb.length()-2); c++)
			star+="*";
		strb=strb.replaceAll(strb.substring(1,(strb.length()-1)),star);
		out.println(one.replaceAll(strb.substring(1,2),"*").length() +"\t"+ strb.length());
		if(one.replaceAll(strb.substring(1,2),"*").length()==strb.length())
			strb=one.replaceAll(strb.substring(1,2),"*"); 
	}
	out.println(strb);
	
	out.println(strb.length());
	
%>
</body>
</html>