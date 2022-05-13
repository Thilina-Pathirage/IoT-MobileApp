<?php
if($_GET['APIkey']=='ndndjdvnvss84d5vdsaf5'){
	
	include 'conn.php';

	$email = $_GET['email'];
	$password = $_GET['password'];

 
	$q = "select * from LogDetails where FingerPrintID = (select FingerPrintID from Employee where Email = '".$email."' and Password = '".$password."') ORDER BY `LogDetails`.`LogID` DESC";

	$query = $link->query($q);
	$result = array();

	while ($rowData = $query->fetch_assoc()) {
		$result[] = $rowData;
	}

	if($result==null || $result=="[]"){
		header("HTTP/1.1 403 No Access");
	}
	else{
		echo json_encode($result);
	}
}
?>