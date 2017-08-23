<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<meta name="viewport" content="user-scable= no, width=device-width" />
<meta name=”apple-mobile-web-app-capable” content=”yes” />
<meta name=”apple-mobile-web-app-status-bar-style” content=”black” />
<script language='javascript' type='text/javascript'>
var orientationEvent;
var uAgent=navigator.userAgent.toLowerCase();
var mobilePhones= 'android';
if(uAgent.indexOf(mobilePhones)!=-1){
	orientationEvent="resize";   //안드로이드는 resize로 들어옴
}
else orientationEvent="orientationchange"; //아이폰은 이렇게 들어옴
window.addEventListener(orientationEvent, function() 
{
//	alert("회전했어요");
	location.href('#');                
}, false); 

var prevScreen=0;
var sv_prevScreen=0;
function prevShow()
{
	ScreenShow( prevScreen );
}

var muCnt   = 5;  //서브메뉴
var scCnt   = 15; //화면

function fncShow( pos )
{
    var i   = 0;
	for( i=0; i<scCnt; i++ )
    {
        var obj = document.getElementById("s"+i);
	    obj.style.display   = 'none';
    }
    for( i=0; i<muCnt; i++ )
    {
        var obj = document.getElementById("menu"+i);
		var obj2 = document.getElementById("m"+i);

        if( i == pos )
        {
            obj.style.display   = '';
			obj2.style.background="#ff0000";
        }
        else
        {
            obj.style.display   = 'none';
			obj2.style.background="#FFFF00";
        }
    }
}

var scCnt   = 15;
var ScrObj;

var timer1;

function ScrAnimation() {
	var offset = -50;

		if (parseInt(ScrObj.style.left) > 10 ) 
		{
            ScrObj.style.left = parseInt(ScrObj.style.left) + offset + "px";
            timer1 = setTimeout("ScrAnimation()", 1);
		} else {
			ScrObj.style.left=5;
		    clearTimeout(timer1);
      	}
}
function ScreenShow( pos )
{
    var i   = 0;
	
	//모든 메뉴페이지는 막는다.
	for( i=0; i<muCnt; i++ )
    {
        var obj = document.getElementById("menu"+i);
	    obj.style.display   = 'none';
    }

    for( i=0; i<scCnt; i++ )
    {
		var obj = document.getElementById("s"+i);

        if( i == pos )
        {
			prevScreen = sv_prevScreen;
			sv_prevScreen=i;
			
            obj.style.display   = '';

			obj.style.position="relative";
			obj.style.top=35;
			obj.style.left=screen.width;
			obj.style.height=screen.height-120;

			ScrObj=obj;
			ScrAnimation();
        }
        else
        {
            obj.style.display   = 'none';
        }
    }
}
</script>
<style type="text/css">
li {text-align:left;vertical-align:middle; margin:2; padding:10; height:20; background-color:#aaaa00; border:2px; solid:red; font-size:16px}
ul {text-align:left;vertical-align:middle; margin:2; padding:10; height:20; background-color:#bbaabb; border:2px; solid:red; font-size:16px}
#wrap {
      width: 100%;
      height: 80%;
      position: relative;
      overflow-x: hidden;
      overflow-y: scroll;
      -webkit-overflow-scrolling: touch;
   }
</style> 

</head>
<body onload='ScreenShow(0);'>
<center>
	<div id="container" style="width:device-width;height:device-height scrolling=no;">
		<div id="header1" style="background-color:#00FFFF;height:35px;width:15%;float:left;" onclick='ScreenShow();'><center>
			<img src="main.JPG" width=40px height=32px></center></div>
		<div id="header2" style="background-color:#00FFFF;height:35px;width:70%;float:left;"><center style="margin:10px;"><B>Hotel Eurotel</B></center></div>
		<div id="header3" style="background-color:#00FFFF;height:35px;width:15%;float:left;" onclick='prevShow(0);'><center>
			<img src="image/image1/back.png" width=40px height=32px></center></div>

		<div id="menu0" style="background-color:#EEEEEE;display:none;width:device-width">
		리조트 소개
			<li onclick='ScreenShow(0);'>Hotel Eurotel</li>
			<li onclick='ScreenShow(1);'>Sweet Room</li>
			<li onclick='ScreenShow(2);'>Privilege Room</li>
			<li onclick='ScreenShow(3);'>Classic Room</li>
		</div>
		<div id="menu1" style="background-color:#EEEEEE;display:none;width:device-width">
		찾아오기
			<li onclick='ScreenShow(4);'>찾아오는길</li>
			<li onclick='ScreenShow(5);'>대중교통이용</li>
			<li onclick='ScreenShow(6);'>자가용이용</li>
		</div>
		<div id="menu2" style="background-color:#eeeeee;display: none;">
		주변명소
			<li onclick='ScreenShow(7);'>알프스 산맥</li>
			<li onclick='ScreenShow(8);'>레만호</li>
			<li onclick='ScreenShow(9);'>스위스 국립박물관</li>
		</div>
		<div id="menu3" style="background-color:#eeeeee;display: none;">
		예약하기
			<li onclick='ScreenShow(10);'>예약상황</li>
			<li onclick='ScreenShow(11);'>예약하기</li>			
		</div>
		<div id="menu4" style="background-color:#eeeeee;display: none;">
		리조트 소개
			<li onclick='ScreenShow(12);'>리조트소식</li>
			<br>
		</div>


		<div id="s0" style="background-image:url(image/bg33.JPG);display:none;width=device-width">
			<center>
			<img src="image/image1/backg.jpg" width=200px height=150px>
			<br>Hotel Eurotel에 놀러오세요
			</center>		
		</div>
			<div id="s1" style="background-image:url(image/bg33.JPG);display:none;width=device-width">
			<center>
			<img src="image/image1/ii2.jpg" width=200px height=150px>
			<br>THE SWEET ROOM – A VERY SPECIAL PLACE
			</center>		
		</div>
		<div id="s2" style="background-image:url(image/bg33.JPG);display:none;width=device-width">
			<center>
			<img src="image/image1/ii2.jpg" width=200px height=150px>
			<br>THE SWEET ROOM – A VERY SPECIAL PLACE
			</center>		
		</div>
		<div id="s3" style="background-image:url(image/bg33.JPG);display:none;width=device-width">
			<center>
			<img src="image/image1/ii2.jpg" width=200px height=150px>
			<br>THE SWEET ROOM – A VERY SPECIAL PLACE
			</center>		
		</div>
		<div id="s4" style="background-image:url(image/bg33.JPG);display:none;width=device-width;height=device-height;">
				<div id="wrap"><iframe src="b_01.html"frameborder="0" border="0" bordercolor="white" width=320px height=420px marginwidth="0" marginheight="0" scroling="yes"></iframe></div>
		</div>
		<div id="s5" style="background-image:url(image/bg33.JPG);display:none;">
			<img src= "image/image1/map.JPG" width=200px height=150px>
  			<br>멀지 않아요 비행기로 16시간 15분~!
		</div>
		<div id="s6" style="background-image:url(image/bg33.JPG);display:none;">
			<img src= "image/image1/map2.JPG" width=200px height=150px>
  			<br>스위스에서는 쉽게 오실수 있습니다.
		</div>
		<div id="s7" style="background-image:url(image/bg33.JPG);display:none;">
			<img src= "image/image1/c01.jpg" width=200px height=150px>
  			<br>떠나요~ 알프스 산맥~
		</div>  
		<div id="s8" style="background-image:url(image/bg33.JPG);display:none;">
			<img src= "image/image1/c02.JPG" width=200px height=150px>
  			<br>레만 호
		</div>
		<div id="s9" style="background-image:url(image/bg33.JPG);display:none;">
			<img src= "image/image1/c03.jpg" width=200px height=150px>
  			<br>스위스 국립박물관
		</div>
		<div id="s10" style=" background-image:url(image/bg33.JPG);display:none;">
			<div id="wrap"><iframe src="d_01.jsp" frameborder="0" border="0" bordercolor="white" width=320px height=420px marginwidth="0" marginheight="0" scroling="yes"></iframe></div>
		</div>
		<div id="s11"  style="background-image:url(image/bg33.JPG);display:none;">
			<div id="wrap"><iframe src="d_02.jsp"  frameborder="0" border="0" bordercolor="white" width=320px height=420px marginwidth="0" marginheight="0" scroling="yes"></iframe></div>
		</div>
		<div id="s12" style="background-image:url(image/bg33.JPG);display:none;">
		 나 메뉴4_1에 대한 화면
		</div>
		<div id="s13" style="background-image:url(image/bg33.JPG);display:none;">
		 나 메뉴4_2에 대한 화면
		</div>
		<div id="s14" style="background-image:url(image/bg33.JPG);display:none;">
		 나 메뉴4_3에 대한 화면
		</div>

		<div id="m0" onclick='fncShow(0);' 
		style="position:absolute;bottom:0px;position:absolute;left:1%;background-color:#FF0000;height:60px;width:18%;float:left;">
				<center>
				<img src= "image/image1/hotel.png" width=40px height=40px><br>
				<font size=2>호텔소개</font></center></div>
		<div id="m1" onclick='fncShow(1);' 
		style="position:absolute;bottom:3px;position:absolute;left:21%;background-color:#FFFF00;height:60px;width:18%;float:left;">
				<center>
				<img src= "image/image1/search.png" width=40px height=40px><br>
				<font size=2>찾아오기</font></center></div>
		<div id="m2" onclick='fncShow(2);' 
		style="position:absolute;bottom:3px;position:absolute;left:41%;background-color:#FFFF00;height:60px;width:18%;float:left;">
				<center>
				<img src= "image/image1/beach.png" width=40px height=40px><br>
				<font size=2>주변명소</font></center></div>
		<div id="m3" onclick='fncShow(3);' 
		style="position:absolute;bottom:3px;position:absolute;left:61%;background-color:#FFFF00;height:60px;width:18%;float:left;">
				<center>
				<img src= "image/image1/book.png" width=40px height=40px><br>
				<font size=2>예약하기</font></center></div>
		<div id="m4" onclick='fncShow(4);' 
		style="position:absolute;bottom:3px;position:absolute;left:81%;background-color:#FFFF00;height:60px;width:18%;float:left;">
				<center>
				<img src= "image/image1/infor.png" width=40px height=40px><br>
				<font size=2>호텔소식</font></center></div>		
	</div>
</center>
</body>
</html> 