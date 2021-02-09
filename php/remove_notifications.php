<?php 
include "dbconfig.php";
// REGISTER USER
  
    $id = mysqli_real_escape_string($conn, $_POST['id']);
    $query = "DELETE FROM t_notifications WHERE ID = '$id'";
    $results = mysqli_query($conn, $query);
    if($results>0){
      echo "Notification removed";
    }
?>