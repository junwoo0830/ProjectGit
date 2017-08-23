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
   
   //POST 값을 가져온다
   $cardN = isset($_POST['cardCom']) ? $_POST['cardCom']: '';
   $costN = isset($_POST['cost']) ? $_POST['cost']: '';
   $dateN = isset($_POST['Day']) ? $_POST['Day']: '';
   $storeN = isset($_POST['storeName']) ? $_POST['storeName']: '';
   $statusN = isset($_POST['status']) ? $_POST['status']: '';
   echo $cardN;
   $sql = "INSERT INTO AcountBook(cardCom,Day,cost,storeName,status)
		VALUES('$cardN','$dateN',$costN,'$storeN','$statusN')";
   echo mysqli_query($conn,$sql);
	
  
   mysqli_close($conn);

?>

 <html>
   <body>
   
      <form action="<?php $_PHP_SELF ?>" method="POST">
		 card: <input type = "text" name = "cardCom" />
         cost: <input type = "text" name = "cost" />
		 day: <input type = "text" name = "Day" />
		 store: <input type = "text" name = "storeName" />
		 status: <input type = "text" name = "status" />
         <input type = "submit" />
      </form>
   
   </body>
</html>
