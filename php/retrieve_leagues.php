<?php 
include "dbconfig.php";
// Retrieve the existing leagues
 
    $query = "SELECT DISTINCT League from t_players";
	
	$results = mysqli_query($conn, $query);
	$values = [];
	
	if($results>0){
		while($row = mysqli_fetch_array($results, MYSQLI_NUM)){
			array_push($values,$row[0]);
		}
		echo json_encode($values);
	}
    
?>