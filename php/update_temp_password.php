<?php 
include "dbconfig.php";
// LOG IN
  
    $email = mysqli_real_escape_string($conn, $_POST['email']);
    $password = mysqli_real_escape_string($conn, $_POST['password']);
 
    $query = "UPDATE t_register_users SET Password = '$password' WHERE Email = '$email'";
	$query_check_existance = "SELECT EXISTS(SELECT * from t_register_users WHERE Email='$email')";
	
	$results_existance = mysqli_query($conn, $query_check_existance);
	$user_exist = mysqli_fetch_row($results_existance);
	if($user_exist[0] == 0)
    {
        echo "User does not exist";
    }
	else{
		$results = mysqli_query($conn, $query);
		if($results>0){
			echo "Password Changed";
		}
	}
    
?>