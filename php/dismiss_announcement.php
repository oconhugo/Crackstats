<?php 
include "dbconfig.php";
// dismiss the announcement
  
    $id = mysqli_real_escape_string($conn, $_POST['id']);
    $query = "DELETE FROM t_announcements WHERE ID = '$id'";
    $results = mysqli_query($conn, $query);
    if($results>0){
      echo "Announcement removed";
    }
?>