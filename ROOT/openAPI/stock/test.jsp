<meta http-dquiv="Content-type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.*,java.text.*,java.net.*" %>
<html>
<head>
</head>
<body>
<%
	try{
		URL url = new URL("http://www.google.com/finance/historical?q=KOSPI:005930&startdate='2017-01-01'&enddate='2017-07-12'&num=200&output=csv");
		URLConnection urlConn = url.openConnection();
		InputStreamReader inputStreamReader = new InputStreamReader(urlConn.getInputStream());
		BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
		String line;
		while( (line = bufferedReader.readLine() ) != null) {
			out.println(line+"<br>");
		}
		bufferedReader.close();
		inputStreamReader.close();
	}catch( Exception e ){
		e.printStackTrace();
	}


%>

</body>
</html>