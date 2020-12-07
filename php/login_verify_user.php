<?php 
include "dbconfig.php";
// LOG IN
  
    $email = mysqli_real_escape_string($conn, $_POST['email']);
    $password = mysqli_real_escape_string($conn, $_POST['password']);
 
    $query = "SELECT Email, Password FROM t_register_users WHERE Email = '$email' AND Password = '$password'";
    $results = mysqli_query($conn, $query);
    if($results> 0)
    {
        while($row = $results->fetch_assoc()){
             if( ($email==$row['Email']) && ($password==$row['Password']) ){
               echo "User exist in database";
             }
             //echo "password: " . $row['Password'];
        }
    }
    
?>
