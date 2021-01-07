<?php 
include "dbconfig.php";
// Retrieve the user league stats
  
	$email = mysqli_real_escape_string($conn, $_POST['email']);
	$league = mysqli_real_escape_string($conn, $_POST['league']);
 
    $query = "SELECT Goals, Apps, Yellow_Cards, Red_Cards from t_players WHERE Email='$email' and League= '$league'";
	
	$results = mysqli_query($conn, $query);
	
	if($results>0){
		$row = mysqli_fetch_array($results, MYSQLI_NUM);
		echo json_encode($row);
	}
    
?>