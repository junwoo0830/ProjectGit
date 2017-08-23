<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*,java.io.*, java.net.*" %>

<html>
<head>
<%
	int	iauto=2000;
	String s_url =" autoreq.jsp";
	
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
iAuto : <%=iauto%>
flag  : <%=Cflag%>
</center>
<script>
var timer = setInterval('refresh_start()',<%=iauto%>);
</script>
</body>
</html>