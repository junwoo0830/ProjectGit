<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*" %>
<html>

<head>
    <title>Line Chart</title>
    <script src="/library/Chart.bundle.js"></script>
     <script src="/library/samples/utils.js"></script> 
 <script>
	function refresh_start(){
		location.href='http://192.168.23.98:8080/android/char.jsp'
	} 
</script>
</head>

<body>
<center>
<%
	Class.forName("com.mysql.jdbc.Driver");		//연결할 driver 이름 설정
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb","root","1234");	
	Statement stmt = conn.createStatement();		//스테이트먼트 클래스 생성
	ResultSet rset = stmt.executeQuery("select a.storeName, sum(a.cost) from (select *from AcountBook where DATE_FORMAT(Day,'%m') = '08' and status = '출금') a group by a.storeName;");
	ArrayList<Integer>arrInt = new ArrayList<Integer>();
	ArrayList<String>arrStr = new ArrayList<String>();
	while(rset.next()){
		arrStr.add(rset.getString(1));
		arrInt.add(rset.getInt(2));		
	}
%>
    <div style="width:100%;">
        <canvas id="canvas"></canvas>
    </div>
	<script>
		
		var config = {
			type : 'pie',
			data: {
				labels:[
				<%
					for( int i=0; i<arrStr.size(); i++){
				%>
					"<%=arrStr.get(i)%>" , 
				<%		
					}
				%>
				],
				datasets: [{
					label: "My First dataset",					
					backgroundColor: [
						window.chartColors.red,
						window.chartColors.orange,
						window.chartColors.yellow,
						window.chartColors.green,
						window.chartColors.blue,
						],
					borderColor: [
						window.chartColors.red,
						window.chartColors.orange,
						window.chartColors.yellow,
						window.chartColors.green,
						window.chartColors.blue,
					],
					 segmentShowStroke : true,
					data:[
					<%
						for( int i=0; i<arrStr.size(); i++){
					%>
						<%=arrInt.get(i)%> , 
					<%		
						}
					%>
					]					
				}]
			},
			 options: {
				legend: {
					labels: {
						fontSize: 4
					}
				},
				responsive: true,
				animationSteps : 1000
			}
		};
		
	   window.onload = function() {
			var ctx = document.getElementById("canvas").getContext("2d");
            window.myLine = new Chart(ctx, config);
        };
		
	</script>
	<script>
		var timer = setInterval('refresh_start()',3000);
	</script>
	<% 
		rset.close();
		stmt.close();
		conn.close();
	%>
</center>

</body>

</html>
