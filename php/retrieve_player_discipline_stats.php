<?php 
include "dbconfig.php";
// Retrieve the player sactions
  
	$league = mysqli_real_escape_string($conn, $_POST['league']);
 
    $query = "SELECT First_Name, Last_Name, Yellow_Cards, Red_Cards from t_players WHERE League='$league'";
	
	$results = mysqli_query($conn, $query);
	$values = [];
	
	if($results>0){
		while($row = mysqli_fetch_array($results, MYSQLI_NUM)){
			array_push($values,$row);
		}
		echo json_encode($values);
	}
    
?>