<?php 
include "dbconfig.php";
// REGISTER USER
  
    $name = mysqli_real_escape_string($conn, $_POST['name']);
    $email = mysqli_real_escape_string($conn, $_POST['email']);
    $last_name = mysqli_real_escape_string($conn, $_POST['last_name']);
    $dob = mysqli_real_escape_string($conn, $_POST['dob']);
    $gender = mysqli_real_escape_string($conn, $_POST['gender']);
    $password = mysqli_real_escape_string($conn, $_POST['password']);
 
        $query = "INSERT INTO t_register_users (First_Name, Last_Name, dob, Gender, Salt, Email, Password)
  			  VALUES('$name', '$last_name', '$DOB', '$gender', '', '$email', '$password')";
    $results = mysqli_query($conn, $query);
    if($results>0)
    {
        echo "user added successfully";
    }
    
?>