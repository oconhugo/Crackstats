<?php 
include "dbconfig.php";
// Retrieve the user leagues announcements
  
    $id = mysqli_real_escape_string($conn, $_POST['id']);
 
    $query = "SELECT * from t_schedules WHERE ID='$id'";
	
	$results = mysqli_query($conn, $query);
	
	if($results>0){
		echo json_encode(mysqli_fetch_array($results, MYSQLI_NUM));
	}
    
?>