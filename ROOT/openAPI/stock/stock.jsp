<meta http-dquiv="Content-type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.*,java.text.*,java.net.*" %>
<html>
<head>
</head>
<body>
<center>
<%
	String jongmock ="";
	if(request.getParameter("jongmock")!=null)
		jongmock=request.getParameter("jongmock");
	String startdate ="";
	if(request.getParameter("startdate")!=null)
		startdate=request.getParameter("startdate");
	String enddate = "";
	if(request.getParameter("enddate")!=null)
		enddate=request.getParameter("enddate");
	
	SimpleDateFormat sdf=new SimpleDateFormat("dd-MMM-yy");
	SimpleDateFormat dform=new SimpleDateFormat("yyyy-MM-dd ");
	DecimalFormat df = new DecimalFormat("###,###,###,###");

%>
<form method="post" action="stock.jsp">
<table border =0>
<tr>
	<td width=260 align=center><p><h3>종목코드 <input type ='text' name="jongmock" value="<%=jongmock%>"></h3></p></td>
	<td width=260  align=center><p><h3>시작일자 <input type ='date' name="startdate" value="<%=startdate%>"></h3></p></td>
	<td width=260  align=center><p><h3>종료일자 <input type ='date' name="enddate" value="<%=enddate%>"></h3></p></td>	
	<td width=60  align=center><p><h3> <input type ='submit' value="조회"></h3></p></td>	
</tr>
</table>
<%
	if( (jongmock.length()!=0) && (startdate.length()!=0) && (enddate.length()!=0) ){
		try{
			String urlSt = "http://www.google.com/finance/historical?q=KOSPI:"+jongmock+"&startdate='"+startdate+"'&enddate='"+enddate+"'&num=200&output=csv";
			URL url = new URL(urlSt);
			URLConnection urlConn = url.openConnection();
			InputStreamReader inputStreamReader = new InputStreamReader(urlConn.getInputStream());
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
			String line;

			if( (line = bufferedReader.readLine() ) != null){
				out.println(
					"<table border =1 cellpadding=0 cellspacing=0>"
					+"<tr>"
					+"	<td width=150><p align=center>일자</p></td>"
					+"	<td width=150><p align=center>시가</p></td>"
					+"	<td width=150><p align=center>저가</p></td>"
					+"	<td width=150><p align=center>고가</p></td>"
					+"	<td width=150><p align=center>종가</p></td>"
					+"	<td width=150><p align=center>거래량</p></td>"
					+"</tr>"
				);			
				while( (line = bufferedReader.readLine() ) != null) {
					String[] stockData = line.split(",");
					java.util.Date day=sdf.parse(stockData[0]);
					out.println(
						"<tr>"
						+"	<td width=150><p align=center>"+dform.format(day)+"</p></td>"
						+"	<td width=150><p align=right>"+df.format(Math.round(Double.parseDouble(stockData[1])))+"</p></td>"
						+"	<td width=150><p align=right>"+df.format(Math.round(Double.parseDouble(stockData[2])))+"</p></td>"
						+"	<td width=150><p align=right>"+df.format(Math.round(Double.parseDouble(stockData[3])))+"</p></td>"
						+"	<td width=150><p align=right>"+df.format(Math.round(Double.parseDouble(stockData[4])))+"</p></td>"
						+"	<td width=150><p align=right>"+df.format(Math.round(Double.parseDouble(stockData[5])))+"</p></td>"
						+"</tr>"
					);				
				}
				out.println("</table>");
			} 
			bufferedReader.close();
			inputStreamReader.close();
		}catch( Exception e ){
			e.printStackTrace();
		}
	}
%>
</form>
</center>
</body>
</html>