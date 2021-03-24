<?php 
include "dbconfig.php";
// Retrieve leagues where user is Admin
  
    $userEmail = mysqli_real_escape_string($conn, $_POST['user']);
 
    $query = "SELECT * from t_leagues WHERE Administrator='$userEmail'";
	
	$results = mysqli_query($conn, $query);
	$values = [];
	
	if($results>0){
		while($row = mysqli_fetch_array($results, MYSQLI_NUM)){
			array_push($values,$row[1]);
		}
		echo json_encode($values);
	}
    
?>