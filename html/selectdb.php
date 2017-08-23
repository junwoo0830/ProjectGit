<?php
// 1. 연결 : mysql_connect(호스트명, 아이디, 비밀번호)
$db_host = "localhost";
$db_user = "root";
$db_passwd = "1234";
$db_name = "testdb";
$conn=mysqli_connect($db_host, $db_user, $db_passwd, $db_name); //db 연결부분

	$sql = " select *from AcountBook;";
	$result = mysqli_query($conn,$sql);
	$data = array();
	 
  	if($result){
		while($row = mysqli_fetch_array($result)){
			array_push($data,
				array('num'=>$row[0],
				      'cardCom'=>$row[1],
					  'Day'=>$row[2],
					  'cost'=>$row[3],
					  'storeName'=>$row[4],
					  'status'=>$row[5]
					)
			);
		}
		header('Content-Type: application/json; charset=utf8');
		$json = json_encode(array("webnautes"=>$data), JSON_PRETTY_PRINT+JSON_UNESCAPED_UNICODE);
		echo $json;
		
	}else
		echo "data가 없습니다.";   
   
   mysqli_close($conn);

?>