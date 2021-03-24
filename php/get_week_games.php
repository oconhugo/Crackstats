<?php 
include "dbconfig.php";
// Retrieve the user leagues announcements
  
    $week_num = mysqli_real_escape_string($conn, $_POST['week_num']);
	$league = mysqli_real_escape_string($conn, $_POST['league']);
 
    $query = "SELECT * from t_schedules WHERE League='$league' and Week_Num = $week_num";
	
	$results = mysqli_query($conn, $query);
	$values = [];
	
	if($results>0){
		while($row = mysqli_fetch_array($results, MYSQLI_NUM)){
			array_push($values,$row);
		}
		echo json_encode($values);
	}
    
?>