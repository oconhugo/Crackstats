<?php 
include "dbconfig.php";
// decline the acceptance of a team
  
    $id = mysqli_real_escape_string($conn, $_POST['id']);
	$player_email = mysqli_real_escape_string($conn, $_POST['player_email']);
	$team =  mysqli_real_escape_string($conn, $_POST['team']);
	$user_email = mysqli_real_escape_string($conn, $_POST['user_email']);
	$league = mysqli_real_escape_string($conn, $_POST['league']);
	
    $query_delete_notification = "DELETE FROM t_notifications WHERE ID = '$id'";
	$query_send_notification = "INSERT INTO t_notifications (Message,Sender,Receiver,Type_Of_Request,Team,League) VALUES ('Your request to create $team to league $league has been denied','$user_email','$player_email',0,'$team','$league')";
	
    $results = mysqli_query($conn, $query_delete_notification);
	$results2 = mysqli_query($conn, $query_send_notification);
	
    if($results && $results2>0){
      echo "Success";
    }
?>