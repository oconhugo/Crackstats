<?php 
include "dbconfig.php";
// REGISTER USER
  
    $email = mysqli_real_escape_string($conn, $_POST['email']);
    $password = mysqli_real_escape_string($conn, $_POST['password']);
 
        $query = "SELECT Email, Password FROM t_register_users WHERE Email = '$email' AND Password = '$password'";
    $results = mysqli_query($conn, $query);
    if($results> 0)
    {
        while($row = $results->fetch_assoc()){
             echo "email: " . $row["email"];
             echo "password: " . $row["password"];
        }
    }
    
?>