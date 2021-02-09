<?php 
include "dbconfig.php";
// Retrieve the existing leagues
  
    $email = mysqli_real_escape_string($conn, $_POST['user']);
 
    $query = "SELECT * from t_notifications WHERE Receiver='$email'";
	
	$results = mysqli_query($conn, $query);
	$values = [];
	
	if($results>0){
		while($row = mysqli_fetch_array($results, MYSQLI_NUM)){
			array_push($values,$row);
		}
		echo json_encode($values);
	}
    
?>