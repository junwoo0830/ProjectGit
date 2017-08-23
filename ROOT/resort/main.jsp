<meta http-=equiv="Content-Type" content="text/thml; charset=UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*" %>

<html>
<head>
<title>조아조아조아버려~</title>
<script language="javascript" type="text/javascript">
<!-- Begin
var imagepath = "image/image1/"
NewImg = new Array (
"i1.jpg",
"i2.jpg",
"i3.jpg",
"i4.jpg"
);
var ImgNum = 0;
var ImgLength = NewImg.length - 1;

var delay = 2000; //자동전환시 시간설정(1000=1초)

var lock = false;
var run;

function chgImg(direction) {
	if (document.images) {
		ImgNum = ImgNum + direction;
	if (ImgNum > ImgLength) {
		ImgNum = 0;
	}
	if (ImgNum < 0) {
		ImgNum = ImgLength;
	}
	document.slideshow.src = imagepath+NewImg[ImgNum];
   }
}

function auto() {
	if (lock == true) {
		lock = false;
		window.clearInterval(run);
	}
	else if (lock == false) {
		lock = true;
		run = setInterval("chgImg(1)", delay);
   }
}
//  End -->
</script>

</head>
<body BACKGROUND="image/bg33.JPG">
<center>
<B>
<a href="javascript:chgImg(-1)">Previous</a>
| <a href="javascript:auto()">Auto/Stop</a>
| <a href="javascript:chgImg(1)">Next</a>
</B><p>
<img src="image/image1/i1.jpg" name="slideshow" width=500 height=450>
<br>
<h2>Hotel Eurotel</h2><br>
16 층짜리 호텔 몽트뢰 (Hotel Montreux)은 제네바 호수와 알프스의 절경을 발코니에서 볼 수 있습니다.<br>
파노라마는 숨 막힐 정도로 짧지 않습니다.<Br>
넓고 세련되게 꾸며진이 특별한 리조트는 진정 기억에 남을 체류를 원 하시거나 방문객을 스타일에 맞게 꾸미기에 완벽한 장소입니다.
<%
	Calendar cal = Calendar.getInstance();
	SimpleDateFormat dformatY = new SimpleDateFormat("yyyy");
	SimpleDateFormat dformatM = new SimpleDateFormat("MM");
	SimpleDateFormat dformatD = new SimpleDateFormat("dd");
	SimpleDateFormat dformatH = new SimpleDateFormat("h");
	SimpleDateFormat dformatmin = new SimpleDateFormat("m");
	SimpleDateFormat dformatS = new SimpleDateFormat("s");	

	String dateSt ="";
 	Cookie[] cookies = request.getCookies();
	if(request.getCookies()==null)
		dateSt+="처음 방문 입니다.";
	else{	
		for(int i=0; i< cookies.length; i++)
		{
			Cookie thisCookie = cookies[i];
			if("year".equals(thisCookie.getName()))
			{
				dateSt+="최근 방문일은 (" + thisCookie.getValue()+"년 ";
			}
			if("mon".equals(thisCookie.getName()))
			{
				dateSt+=thisCookie.getValue()+"월 ";
			}
			if("day".equals(thisCookie.getName()))
			{
				dateSt+=thisCookie.getValue()+"일 ";
			}
			if("hour".equals(thisCookie.getName()))
			{
				dateSt+=thisCookie.getValue()+"시 ";
			}
			if("min".equals(thisCookie.getName()))
			{
				dateSt+=thisCookie.getValue()+"분";
			}
			if("sec".equals(thisCookie.getName()))
			{
				dateSt+=thisCookie.getValue()+"초 )입니다.";
			}
		} 
	}
	out.println("<p><h1>"+dateSt+"</h1></p>");
	Cookie cookieName= new Cookie("year", dformatY.format(cal.getTime()));
	response.addCookie(cookieName);	
	cookieName= new Cookie("mon", dformatM.format(cal.getTime()));
	response.addCookie(cookieName);
	cookieName= new Cookie("day", dformatD.format(cal.getTime()));
	response.addCookie(cookieName);
	cookieName= new Cookie("hour", dformatH.format(cal.getTime()));
	response.addCookie(cookieName);
	cookieName= new Cookie("min", dformatmin.format(cal.getTime()));
	response.addCookie(cookieName);
	cookieName= new Cookie("sec", dformatS.format(cal.getTime()));
	response.addCookie(cookieName);
	
	cookieName.setMaxAge(0);

%>
</center>
</body>
</html>
	
	
	