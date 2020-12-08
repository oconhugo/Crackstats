<?php 
include "dbconfig.php";
// REGISTER USER
  
    $name = mysqli_real_escape_string($conn, $_POST['name']);
    $email = mysqli_real_escape_string($conn, $_POST['email']);
    $last_name = mysqli_real_escape_string($conn, $_POST['last_name']);
    $dob = mysqli_real_escape_string($conn, $_POST['dob']);
    $gender = mysqli_real_escape_string($conn, $_POST['gender']);
    $password = mysqli_real_escape_string($conn, $_POST['password']);
    
    $query_check_existance = "SELECT EXISTS(SELECT * from t_register_users WHERE Email='$email')";

    $query = "INSERT INTO t_register_users (First_Name, Last_Name, dob, Gender, Salt, Email, Password)
  			  VALUES('$name', '$last_name', '$dob', '$gender', '', '$email', '$password')";
    
    $results_existance = mysqli_query($conn, $query_check_existance);
	$user_exist = mysqli_fetch_row($results_existance);
	if($user_exist[0] == 0)
    {
        $results = mysqli_query($conn, $query);
        if($results>0)
        {
            echo "user added successfully";
        }
    } else{
        echo "user already registered";
    }
?>
