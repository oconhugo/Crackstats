<?php 
include "dbconfig.php";
// send new player request
  
    $sender = mysqli_real_escape_string($conn, $_POST['sender']);
    $team = mysqli_real_escape_string($conn, $_POST['team']);
    $league = mysqli_real_escape_string($conn, $_POST['league']);
    $comment = mysqli_real_escape_string($conn, $_POST['comment']);
    
    $qry = "SELECT Team FROM t_players WHERE Email = '$sender' and League = '$league'";

    $res = mysqli_query($conn, $qry);

    $values = [];

    while($row = mysqli_fetch_array($res, MYSQLI_NUM)){
        array_push($values,$row[0]);
    }
    
    if(count($values)>0){
        echo "Already registered on this league";
    }else{
        $query = "INSERT INTO t_notifications (Message, Sender, Receiver, Type_Of_Request, Team, League)
  		    	  VALUES ('$comment', '$sender', (SELECT Owner FROM t_teams where League = '$league' and Name = '$team'), 2, '$team', '$league')";
        $results = mysqli_query($conn, $query);
        if($results>0)
        {
            echo "Request sent Succesfully";
        }
    }

    
?>