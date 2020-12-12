<?php 
include "dbconfig.php";
// LOG IN
  
    $name = mysqli_real_escape_string($conn, $_POST['name']);
    $email = mysqli_real_escape_string($conn, $_POST['email']);
    $last_name = mysqli_real_escape_string($conn, $_POST['last_name']);
    $dob = mysqli_real_escape_string($conn, $_POST['dob']);
    $password = mysqli_real_escape_string($conn, $_POST['password']);
 
    $query = "UPDATE t_register_users SET Password = '$password', Email = '$email', First_Name = '$name', Last_Name = '$last_name', DOB = '$dob' WHERE Email = '$email'";
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
			$query_get_info = "SELECT * FROM t_register_users WHERE Email = '$email'";
                        $results_get_info = mysqli_query($conn, $query_get_info);
                        $returned_user = $results_get_info->fetch_assoc();
                        echo json_encode($returned_user);
		}
	}
    
?>