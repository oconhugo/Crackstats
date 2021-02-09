<?php 
include "dbconfig.php";
// accept the acceptance of a team 

    $id = mysqli_real_escape_string($conn, $_POST['id']);
	$player_email = mysqli_real_escape_string($conn, $_POST['player_email']);
	$team =  mysqli_real_escape_string($conn, $_POST['team']);
	$user_email = mysqli_real_escape_string($conn, $_POST['user_email']);
	$league = mysqli_real_escape_string($conn, $_POST['league']);
	
    $query_delete_notification = "DELETE FROM t_notifications WHERE ID = '$id'";
	$query_send_notification = "INSERT INTO t_notifications (Message,Sender,Receiver,Type_Of_Request,Team,League) VALUES ('Your request to create $team to league $league has been accepted','$user_email','$player_email',0,'$team','$league')";
    $query_insert_team = "INSERT INTO t_teams (Name,Owner,League) 
                            VALUES ('$team','$player_email','$league')";

    $results = mysqli_query($conn, $query_delete_notification);
    $results2 = mysqli_query($conn, $query_send_notification);
    $results3 = mysqli_query($conn, $query_insert_team);
	
    if($results && $results2>0 && $results3>0){
      echo "Success";
    }
?>