<?php 
include "dbconfig.php";
// LOG IN
  
    $email = mysqli_real_escape_string($conn, $_POST['email']);
    $password = mysqli_real_escape_string($conn, $_POST['password']);
 
    $query = "SELECT Email, Password FROM t_register_users WHERE Email = '$email' AND Password = '$password'";
    $results_user_exists = mysqli_query($conn, $query);
	
	$query_get_info = "SELECT * FROM t_register_users WHERE Email = '$email' AND Password = '$password'";
	$results_get_info = mysqli_query($conn, $query_get_info);
	$number_rows_returned_info = mysqli_num_rows($results_get_info);
	
    if($results_user_exists> 0)
    {
		if($number_rows_returned_info==1){
			$returned_user = $results_get_info->fetch_assoc();
			echo json_encode($returned_user);
		}
    }
    
?>