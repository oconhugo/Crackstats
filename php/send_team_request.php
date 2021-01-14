<?php 
include "dbconfig.php";
// send team request
  
    $sender = mysqli_real_escape_string($conn, $_POST['sender']);
    $team = mysqli_real_escape_string($conn, $_POST['team']);
    $league = mysqli_real_escape_string($conn, $_POST['league']);
    $comment = mysqli_real_escape_string($conn, $_POST['comment']);
    
    $query = "INSERT INTO t_notifications (Message, Sender, Receiver, Type_Of_Request, Team)
  			  VALUES ('$comment', '$sender', (SELECT Administrator FROM t_leagues where Name = '$league'), 1, '$team')";
    
    $results = mysqli_query($conn, $query);
	if($results>0)
    {
        echo "Request sended Succesfully";
    }
?>