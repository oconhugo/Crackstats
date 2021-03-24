<?php 
include "dbconfig.php";
// Insert a new announcement
  
    $message = mysqli_real_escape_string($conn, $_POST['message']);
    $league = mysqli_real_escape_string($conn, $_POST['league']);

    $query = "INSERT INTO t_announcements (Message, League)
  			  VALUES('$message', '$league')";
    

        $results = mysqli_query($conn, $query);
        if($results>0)
        {
            echo "announcement added successfully";
        }
?>