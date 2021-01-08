<?php 
include "dbconfig.php";
// Retrieve all the league teams
  
	$league = mysqli_real_escape_string($conn, $_POST['league']);
 
    $query = "SELECT DISTINCT Team from t_players WHERE League= '$league'";
	
	$results = mysqli_query($conn, $query);
	$values = [];
	
	if($results>0){
		while($row = mysqli_fetch_array($results, MYSQLI_NUM)){
			array_push($values,$row[0]);
		}
		echo json_encode($values);
	}
    
?>