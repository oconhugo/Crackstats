<?php 
include "dbconfig.php";
// delete a match.
    $id = mysqli_real_escape_string($conn, $_POST['id']);
	
        $query = "DELETE FROM t_schedules WHERE id = '$id'";

    $results = mysqli_query($conn, $query);

	if($results>0)
    {
        echo "Match Deleted";
    }
    
?>