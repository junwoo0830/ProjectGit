<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*,java.text.*" %>

<html>
<head>
</head>
<body >
<%
	session.setAttribute("session_id","park");
	SimpleDateFormat fmt = new SimpleDateFormat("yy-MM-dd [HH:mm:ss]");
	long createTime = (long)session.getCreationTime();
	long lastTime = (long)session.getLastAccessedTime();
	%>

session 생성시간==> <%=fmt.format(new Date(createTime))%> <br>
session 마지막 처리 시간==> <%=fmt.format(new Date(lastTime))%> <br>
session 유지시간==> <%=(int)session.getMaxInactiveInterval()%> <br>
session 유지시간변경==> <%session.setMaxInactiveInterval(5);%> <br>
session 값 표시==> <%=(String)session.getAttribute("session_id")%> <br>
session id==> <%=session.getId()%> <br>
session 유지시간=> <%=(int)session.getMaxInactiveInterval()%> <br>
</body>
</html>
	
	
	