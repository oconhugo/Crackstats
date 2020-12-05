<?php 
include "dbconfig.php";
// REGISTER USER
  
    $name = mysqli_real_escape_string($connect, $_POST['name']);
    $email = mysqli_real_escape_string($connect, $_POST['email']);
 
        $query = "INSERT INTO t_register_users (ID, email)
  			  VALUES('$name', '$email')";
    $results = mysqli_query($conn, $query);
    if($results>0)
    {
        echo "user added successfully";
    }
    
?>