<?php 
include "dbconfig.php";
// Retrieve all players from a team
  
	$team = mysqli_real_escape_string($conn, $_POST['team']);
        $league = mysqli_real_escape_string($conn, $_POST['league']);
 
    $query = "SELECT DISTINCT First_name, Last_Name, ID from t_players WHERE Team= '$team' and League= '$league'";
	
	$results = mysqli_query($conn, $query);
	$values = [];
	
	if($results>0){
		while($row = mysqli_fetch_array($results, MYSQLI_NUM)){
			array_push($values,$row);
		}
		echo json_encode($values);
	}
    
?>