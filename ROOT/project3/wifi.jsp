<%@page import="java.io.File"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.IOException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<%
	/*
	*	1.get방식으로 데이터를 받는다 이때 값이 있는지의 유무 확인
	*	2.값이 최대값 보다 큰지 확인
	*	3.값이 최소값보다 작은지 확인
	*	4.마지막 페이지 설정
	*/
	int fromPT =0;
	int cntPT =0;
	if(request.getParameter("from") == null) //값의 유무 확인
			fromPT =0;
	else
	 fromPT = Integer.parseInt(request.getParameter("from"));
	
	if(request.getParameter("cnt") == null) //값의 유무 확인
			cntPT =10;
	else 
	 cntPT = Integer.parseInt(request.getParameter("cnt")); 
	if(cntPT<1)
		cntPT=10;
%>
</head>
<body>
<%
	try{
		//와이파이 데이터를 가지고 온후 설정된 페이지 크기만큼 출력
		File f = new File("/var/lib/tomcat7/webapps/ROOT/project3/wifidata.txt");
		BufferedReader br = new BufferedReader(new FileReader(f));
		String readtxt;
		int maxRow=0;
		if((readtxt = br.readLine())==null){
			out.println("파일이 없습니다.");
			return;
		}
		//파일의 전체 크기를 확인한다. MaxRow에 저장!!
		while((readtxt = br.readLine())!=null){
			maxRow++;
		}
		br.close();
		
		//파일을 다시 열어 내용을 출력한다. 
		br = new BufferedReader(new FileReader(f));
		if((readtxt = br.readLine())==null){
			out.println("파일이 없습니다.");
			return;
		}
		String[] field_name = readtxt.split("\t");
		//필드 이름 출력
	 	out.println("<table border=1 cellspacing=0 cellpadding=0>"+
						"<tr>"+
							"<td width=70>" +"번호"+ "</td>"+
							"<td width=200>" +field_name[8]+ "</td>"+
							"<td width=60>" +field_name[12]+ "</td>"+
							"<td width=60>" +field_name[13]+ "</td>"+
							"<td width=60>" + "거리"+ "</td>"+
						"<tr>");
		int LineCnt=0;
		double lat = 37.3860521;					//융합기술연구원의 위도 저장
		double lng = 127.1214038;					//융합기술연구원의 경도 저장		
		if(	fromPT<0) fromPT=0; //최소값보다 작은지 확인
		int recnt=0;
		int lastCheck=0;
		if( fromPT >= maxRow && maxRow%cntPT==0) 
		{
			
			fromPT=maxRow-cntPT;
		}
		if( fromPT >= maxRow){		//최대값보다 큰지 확인
			recnt=cntPT;
			cntPT=maxRow%cntPT;	
			fromPT=maxRow-cntPT;
			lastCheck=1;				}
		
		//내용 출력!
		while((readtxt = br.readLine())!=null) {
			LineCnt++;
			if(LineCnt <=fromPT) continue;			//이때 page조건 보다 작은 경우 출력 안한다.
			if(LineCnt >(fromPT+cntPT)) break;		//    page조건보다 클경우 루프 탈출
			String[] field_data = readtxt.split("\t");	//구분자를 이용해 자료를 자른다.			
			double dist = Math.sqrt(Math.pow(Double.parseDouble(field_data[12])-lat,2)	
						+ Math.pow(Double.parseDouble(field_data[13])-lng, 2));				
			out.println("<tr>"+				//내용 출력!
							"<td width=70>" +(LineCnt)+ "</td>"+
							"<td width=400>" +field_data[8]+ "</td>"+
							"<td width=80>" +field_data[12]+ "</td>"+
							"<td width=80>" +field_data[13]+ "</td>"+
							"<td width=80>" + (dist)+ "</td>"+
						"<tr>"); 
		}
		out.println("</table>");
		if(lastCheck==1){ //마지막 페이지의 출력이 끝나면 이전의 page조건으로 되돌린다.
			cntPT=recnt;				
		}
		out.println("<table board=1> <tr>"); 
		int myPage = (int)(fromPT/cntPT);
		int minPage=0;
		int maxPage=0;
		if((maxRow%cntPT)!=0)		//page의 마지막 page를 찾는다.
			maxPage=(int)(maxRow/cntPT)+1;
		else
			maxPage=(int)(maxRow/cntPT);		
		int startPage =0;
		int endPage=0;
		if((myPage-5)<minPage) startPage=minPage; //출력 page의 처음값을 설정
		else	startPage=myPage-5;
		
		if((myPage+5)>=maxPage) endPage=maxPage; //출력 page의 마지막값을 설정
		else 	endPage=startPage+10;
		out.println("<td width=30><a href=wifi.jsp?from="+0+"&cnt="+cntPT+"> [&lt] </a></td>");
		out.println("<td width=30><a href=wifi.jsp?from="+(myPage-10)*cntPT+"&cnt="+cntPT+"> &lt </a></td>");
		for(int i=startPage; i<endPage; i++){ //페이지 설정하는 아이콘 출력!
			if(myPage == i)
				out.println("<td width=30><a href=wifi.jsp?from="+i*cntPT+"&cnt="+cntPT+"><H2>["+(i+1)+"]</h2></a></td>");
			else
				out.println("<td width=30><a href=wifi.jsp?from="+i*cntPT+"&cnt="+cntPT+">["+(i+1)+"]</a></td>");
		}
		out.println("<td width=30><a href=wifi.jsp?from="+(myPage+10)*cntPT+"&cnt="+cntPT+"> &gt </a></td>");
		out.println("<td width=30><a href=wifi.jsp?from="+maxRow+"&cnt="+cntPT+"> [&gt] </a></td>");	
		out.println("</tr></table>");
		
		br.close();
	} catch(IOException e){
		out.println("error message : "+e);
	}
%>
</body>
</html>