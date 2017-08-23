<?xml version="1.0" encoding="UTF-8"?>
<%@ page contentType="text/xml; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*"%>
<data>
<%
{
	String command = "sar 1 1";
	int linecount=1;
	
	String line = "";
	
	Runtime rt = Runtime.getRuntime(); //자바프로그램이 돌아가는 시스템 (윈도우즈, 리눅스, 유닉스 등)의 명령어를 
	Process ps = null;					//자바에서 실행시킨후 그 결과를 받아 올수 있다.
										//EX) Runtime.getRuntime().exec("시스템 명령어");
	try{
		ps = rt.exec(command);
		//ps = command를 실행한다.
		
		BufferedReader br = new BufferedReader(		//버퍼에 들어오는 입력된 값을 읽는다
								new InputStreamReader(	//스트림으로 들어오는 값을 읽는다
									new SequenceInputStream(ps.getInputStream(), ps.getErrorStream() ) ) );
										//연속 바이트 입력 스트림을 읽는다.(1번째 2번째)매게변수를 연속으로 들어오는 것처럼 읽느다.
		String retval[];
		
		while( (line = br.readLine() ) !=null) {
			if(linecount ==4 ) { 	//5번째 줄이 Average가 보이는 줄
				retval = line.split(" ");		//구분자로 나눈다.
				int iCnt=0;
				for(int i=0; i<retval.length; i++){		//결과 값을 출력한다. 
					retval[i] = retval[i].replaceAll(" ","");	//값중에 &nbsp가 있을경우 없앤다.
					if(retval[i].isEmpty()) continue;	//만약 값이 없으면  for문으로 돌아간다.
					iCnt++;
					if(iCnt ==1 ) out.println("<time>" + retval[i] + "</time>");  		//측정 시간
					else if(iCnt ==2 ) out.println("<apm>" + retval[i] + "</apm>");		//Apache, PHP, Mysql의 첫글자
					else if(iCnt ==3 ) out.println("<CPU>" + retval[i] + "</CPU>");		//사용중이 CPU???
					else if(iCnt ==4 ) out.println("<user>" + retval[i] + "</user>");	//사용자 레벨에서 실행중일때 의 cpu 사용률(%)
					else if(iCnt ==5 ) out.println("<nice>" + retval[i] + "</nice>");	//사용자 레벨에서 nice 가중치를 준 cpu 사용률(%)
					else if(iCnt ==6 ) out.println("<system>" + retval[i] + "</system>");	//시스템 레벨(kernal)에서 실행중일때 cpu 사용률
					else if(iCnt ==7 ) out.println("<iowait>" + retval[i] + "</iowait>");	//system이 IO요청을 처리하지 못한 상태에서의 idle 상태인 시간의 비율(%)
					else if(iCnt ==8 ) out.println("<steal>" + retval[i] + "</steal>");		//virtual processer에 의한 작업이 진행되는 동안 virtual CPU에 의해 뜻하지 않은 대기시간이 생기는 시간의 비율(%)
					else if(iCnt ==9 ) out.println("<idle>" + retval[i] + "</idle>");		//CPU가 쉬고 있는 시간의 %
				}
			}
			linecount++;	//결과 값이 4번째부터 값이 나오므로 값을 증가시킨다.
		}
		br.close();
	}catch(Exception e) {
		e.printStackTrace();
	}
}
%>
</data>