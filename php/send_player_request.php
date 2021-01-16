<?php 
include "dbconfig.php";
// send new player request
  
    $sender = mysqli_real_escape_string($conn, $_POST['sender']);
    $team = mysqli_real_escape_string($conn, $_POST['team']);
    $league = mysqli_real_escape_string($conn, $_POST['league']);
    $comment = mysqli_real_escape_string($conn, $_POST['comment']);
    
    $query = "INSERT INTO t_notifications (Message, Sender, Receiver, Type_Of_Request, Team, League)
  			  VALUES ('$comment', '$sender', (SELECT Owner FROM t_teams where League = '$league' and Name = '$team'), 2, '$team', '$league')";
    
    $results = mysqli_query($conn, $query);
	if($results>0)
    {
        echo "Request sended Succesfully";
    }else{
        echo "no entre";
    }
?>