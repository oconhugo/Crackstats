<?php 
include "dbconfig.php";
// Retrieve the selected player stats
  
	$first_name = mysqli_real_escape_string($conn, $_POST['first_name']);
	$last_name = mysqli_real_escape_string($conn, $_POST['last_name']);
	$team = mysqli_real_escape_string($conn, $_POST['team']);
	$league = mysqli_real_escape_string($conn, $_POST['league']);
 
    $query = "SELECT Goals, Apps, Yellow_Cards, Red_Cards FROM t_players WHERE First_Name='$first_name' and Last_Name= '$last_name' and Team='$team' and League='$league'";
	
	$results = mysqli_query($conn, $query);
	
	if($results>0){
		$row = mysqli_fetch_array($results, MYSQLI_NUM);
		echo json_encode($row);
	}
    
?>