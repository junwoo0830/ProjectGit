<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>

<html>
<head>
<%	
	int stdID = 0;  //get한 정보가 있는지 확인 및 쓰레기 정보를 제거한다.
	String id = request.getParameter("stdID").replaceAll(" ","").replaceAll(",","");
	if(id.length() >7)
	{	
		stdID =Integer.parseInt(id.substring(0,7));
	}
	else if( (id.length()) !=0)
		stdID =Integer.parseInt(id);
	
%>
<!--Form 형식의 버튼에 action의 지정장소를 2곳으로 만들어 주는 함수 설정-->
<script>  
function submitFnc(index){
	if(index==1){
		myForm.action="updateDB.jsp";
		myForm.submit();
	}
	
	if(index==2){
		myForm.action="deleteDB.jsp";
		myForm.submit();
	}
}
</script>

</head>
<body>
<h1>성적 조회후 정정/삭제</h1>
<form method="post" action="showREC.jsp"> <!--form의 형태 지정 및 전달위치 지정-->
	<table border=0 cellspacing=1>
	<tr>
		<td width=100 align=center>조회할 학번</td>
		<td width=100><input type = "number" name="stdID"></td>
		<td width=60 align=right><input type = "submit" value="추가"></td>
	</tr>
	</table><!--전송 버튼 생성!-->
</form>
<%
	try{
		Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	//TNS Data를 이용해서 서버에 접속!
		Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
		ResultSet rset = stmt.executeQuery("select * from examtable where student="+stdID+";");	 // 조회된 stdID를 이용해서 해당 학생의 정보를 가지고온다.		
		if(rset.next()){ 			//만약 조회시 select 한 내용이 있을경우 		
			out.println(
				"	<form method=\"post\" name='myForm' action=\"updateDB.jsp\"> "+
				"	<table border=1 cellspacing=1>"+
				"	<tr>"+
				"	<td width=100><p align=center>이름</p></td>"+   //이름이의 정보를 최대 17자로 제한
				"	<td width=230><p align=center><input type = \"text\" maxlength=\"17\" name=\"stdName\" value="+rset.getString(1).replaceAll(" ","").replaceAll("<","").replaceAll(">","")+" required></p></td>"+
				"	</tr>"+
				"	<tr>"+
				"	<td width=100><p align=center>학번</p></td>"+   //학생번호는 입력받은 값으로 출력
				"	<td width=230><p align=center><input type = \"number\" name=\"stdID\" value="+rset.getInt(2)+" readonly></p></td>"+
				"	</tr>"+
				"	<tr>"+
				"	<td width=100><p align=center>국어</p></td>"+	  //국어성적은 0~100까지 최대 3자리의 숫자만 입력 받는다.
				"	<td width=230><p align=center><input type = \"number\" max=100 min=0 maxlength=\"3\" name=\"kor\" value="+rset.getInt(3)+" required></p></td>"+
				"	</tr>   "+
				"	<tr>"+
				"	<td width=100><p align=center>영어</p></td>"+	  //영어성적은 0~100까지 최대 3자리의 숫자만 입력 받는다.
				"	<td width=230><p align=center><input type = \"number\" max=100 min=0 maxlength=\"3\" name=\"eng\" value="+rset.getString(4)+" required></p></td>"+
				"	</tr>"+
				"	<tr>"+
				"	<td width=100><p align=center>수학</p></td>"+   //수학성적은 0~100까지 최대 3자리의 숫자만 입력 받는다.
				"	<td width=230><p align=center><input type = \"number\" max=100 min=0 maxlength=\"3\" name=\"mat\" value="+rset.getString(5)+" required></p></td>"+
				"	</tr>    "+
				"   </table>"		
				);
			out.println(					
				"	<table border=0 cellspacing=1>"+
				"	<tr><td width=140 align=right><input type = \"submit\" value=\"수정\" ></td>"+ //수정의 타입은 submit으로 한다.
																								  //삭제의 타입은 만든 함수를 이용해서 사용한다. 
				"	<td width=140 align=right><input type = \"button\" value=\"삭제\" onclick=\"submitFnc(2)\"></td></tr></table>"+
				"	</form>"																
			);
		}
		else{				//만약 조회시 select 한 내용이 없을 경우 이름에 해당학번 없음을 출력한다. 
			out.println(				
				"	<table border=1 cellspacing=1>"+
				"	<tr>"+
				"	<td width=100><p align=center>이름</p></td>"+
				"	<td width=230><p align=center><input type = \"text\" value=해당학번없음></p></td>"+
				"	</tr>"+
				"	<tr>"+
				"	<td width=100><p align=center>학번</p></td>"+
				"	<td width=230><p align=center><input type = \"text\"></p></td>"+
				"	</tr>"+
				"	<tr>"+
				"	<td width=100><p align=center>국어</p></td>"+
				"	<td width=230><p align=center><input type = \"text\"></p></td>"+
				"	</tr>   "+
				"	<tr>"+
				"	<td width=100><p align=center>영어</p></td>"+
				"	<td width=230><p align=center><input type = \"text\" ></p></td>"+
				"	</tr>"+
				"	<tr>"+
				"	<td width=100><p align=center>수학</p></td>"+
				"	<td width=230><p align=center><input type = \"text\"></p></td>"+
				"	</tr>    "+
				"   </table>"		
			);			
		}
		rset.close();
		stmt.close();
		conn.close();
	
	}catch (ClassNotFoundException e) {	//클래스가 없으면 에러 출력			
		out.println("클래스에러 발생 : " +e);
	} catch (SQLException e) {		//sql에러가 있을시 에러 출력
		out.println("sql에러 발생 : " +e);
	}
%>
</body>
</html>