<?php
// 1. 연결 : mysql_connect(호스트명, 아이디, 비밀번호)
$db_host = "localhost";
$db_user = "root";
$db_passwd = "1234";
$db_name = "testdb";
$conn=mysqli_connect($db_host, $db_user, $db_passwd, $db_name); //db 연결부분

     if(mysqli_connect_errno($conn)) 
      echo "db연결실패";
     else
      echo "db연결 성공"; 
   
   $sql = "create table AcountBook(
	num int primary key auto_increment,
	cardCom varchar(20),
	Day		date,
	cost	int,
	storeName varchar(40),
	status varchar(10))DEFAULT CHARSET=utf8";
	if(!mysqli_query($conn,$sql))
   {
		echo("Error description: " . mysqli_error($conn));
   }
   
   /* if(!mysqli_query($conn,"INSERT INTO Person(name,address) VALUES('길동','서울');"))
   {
		echo("Error description: " . mysqli_error($conn));
   }
 */   
   mysqli_close($conn);

?>