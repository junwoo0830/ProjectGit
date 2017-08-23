<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
<head>
<%
	int fromPT =0;
	int cntPT =0;
	if(request.getParameter("from") == null)
			fromPT =0;
	else
	 fromPT = Integer.parseInt(request.getParameter("from"));
	if(request.getParameter("cnt") == null)
			cntPT =0;
	else 
	 cntPT = Integer.parseInt(request.getParameter("cnt"));
	out.println(fromPT +" \n\n\n\n      "+ cntPT);
%>
</head>
<body>

</body>
</html>