<?php 
include "dbconfig.php";
// Insert a new match into the db. Distributes the required info to the corresponding tables
  
    $localteam = mysqli_real_escape_string($conn, $_POST['localTeam']);
    $visitorteam = mysqli_real_escape_string($conn, $_POST['visitorTeam']);
    $week = mysqli_real_escape_string($conn, $_POST['Week_Num']);
    $date = mysqli_real_escape_string($conn, $_POST['date']);
    $venue = mysqli_real_escape_string($conn, $_POST['venue']);
    $localscore = mysqli_real_escape_string($conn, $_POST['localScore']);
    $visitorscore = mysqli_real_escape_string($conn, $_POST['visitorScore']);
	$localyellows = mysqli_real_escape_string($conn, $_POST['localYellows']);
	$visitoryellows = mysqli_real_escape_string($conn, $_POST['visitorYellows']);
	$localreds = mysqli_real_escape_string($conn, $_POST['localReds']);
	$visitorreds = mysqli_real_escape_string($conn, $_POST['visitorReds']);
	$time = mysqli_real_escape_string($conn, $_POST['time']);
	$league = mysqli_real_escape_string($conn, $_POST['league']);
	$localapps = mysqli_real_escape_string($conn, $_POST['localApps']);
	$visitorapps = mysqli_real_escape_string($conn, $_POST['visitorApps']);
    $gamePlayed = mysqli_real_escape_string($conn, $_POST['gamePlayed']);
	
        $query = "INSERT INTO t_schedules (Local, Visitor, Week_Num, Date, Field_name, Local_Score, Visitor_Score, Local_Yellow_Card, Local_Red_Card, Visitor_Yellow_Cards, Visitor_Red_Cards, Time, League, Local_Participants, Visitor_Participants, Game_Played)
  			  VALUES('$localteam', '$visitorteam', '$week', '$date', '$venue', '$localscore', '$visitorscore', '$localyellows' ,'$localreds', '$visitoryellows', '$visitorreds' ,'$time', '$league', '$localapps', '$visitorapps', '$newmatch')";
			  
		$decoded_local_scorers = json_decode(stripslashes($localscore),true);
        $decoded_visitor_scorers = json_decode(stripslashes($visitorscore),true);
        $decoded_local_yellows = json_decode(stripslashes($localyellows),true);
        $decoded_visitor_yellows = json_decode(stripslashes($visitoryellows),true);
        $decoded_local_reds = json_decode(stripslashes($localreds),true);
        $decoded_visitor_reds = json_decode(stripslashes($visitorreds),true);
        $decoded_local_apps = json_decode(stripslashes($localapps),true);
        $decoded_visitor_apps = json_decode(stripslashes($visitorapps),true);

    $results = mysqli_query($conn, $query);
    
	if($results>0)
    {
		//checks if the game had been played
		if($gamePlayed==1)
		{	
        //update local goals
        foreach ($decoded_local_scorers as $value){
            $query1 = "UPDATE t_players SET Goals = Goals + 1 WHERE ID = '$value'";
            $res = mysqli_query($conn, $query1);
            $query2 = "UPDATE t_team_stats SET GF = GF + 1 WHERE Team = '$localteam' and League = '$league'";
            $res = mysqli_query($conn, $query2);
            $query3 = "UPDATE t_team_stats SET GA = GA + 1 WHERE Team = '$visitorteam' and League = '$league'";
            $res = mysqli_query($conn, $query3);
        }

        //update visitor goals
        foreach ($decoded_visitor_scorers as $value){
            $query1 = "UPDATE t_players SET Goals = Goals + 1 WHERE ID = '$value'";
            $res = mysqli_query($conn, $query1);
            $query2 = "UPDATE t_team_stats SET GA = GA + 1 WHERE Team = '$localteam' and League = '$league'";
            $res = mysqli_query($conn, $query2);
            $query3 = "UPDATE t_team_stats SET GF = GF + 1 WHERE Team = '$visitorteam' and League = '$league'";
            $res = mysqli_query($conn, $query3);
        }
        
        //update t_team_stats depending of the match result
        if(count($decoded_local_scorers) > count($decoded_visitor_scorers)){
            $query = "UPDATE t_team_stats SET Games_Won = Games_Won + 1, Points = Points + 3 WHERE Team = '$localteam' and League = '$league'";
            $res = mysqli_query($conn, $query);
            $query1 = "UPDATE t_team_stats SET Games_Lost = Games_Lost + 1 WHERE Team = '$visitorteam' and League = '$league'";
            $res = mysqli_query($conn, $query1);
        }else if (count($decoded_visitor_scorers) > count($decoded_local_scorers)){
            $query = "UPDATE t_team_stats SET Games_Won = Games_Won + 1, Points = Points + 3 WHERE Team = '$visitorteam' and League = '$league'";
            $res = mysqli_query($conn, $query);
            $query1 = "UPDATE t_team_stats SET Games_Lost = Games_Lost + 1 WHERE Team = '$localteam' and League = '$league'";
            $res = mysqli_query($conn, $query1);
        }else{
            $query = "UPDATE t_team_stats SET Games_Drawn = Games_Drawn + 1, Points = Points + 1 WHERE Team = '$localteam' and League = '$league'";
            $res = mysqli_query($conn, $query);
            $query1 = "UPDATE t_team_stats SET Games_Drawn = Games_Drawn + 1, Points = Points + 1 WHERE Team = '$visitorteam' and League = '$league'";
            $res = mysqli_query($conn, $query1);
        }

        //update local yellows
        foreach ($decoded_local_yellows as $value){
            $query1 = "UPDATE t_players SET Yellow_Cards = Yellow_Cards + 1 WHERE ID = '$value'";
            $res = mysqli_query($conn, $query1);
        }

        //update visitor yellows
        foreach ($decoded_visitor_yellows as $value){
            $query1 = "UPDATE t_players SET Yellow_Cards = Yellow_Cards + 1 WHERE ID = '$value'";
            $res = mysqli_query($conn, $query1);
        }

        //update local reds
        foreach ($decoded_local_reds as $value){
            $query1 = "UPDATE t_players SET Red_Cards = Red_Cards + 1 WHERE ID = '$value'";
            $res = mysqli_query($conn, $query1);
        }

        //update visitor reds
        foreach ($decoded_visitor_reds as $value){
            $query1 = "UPDATE t_players SET Red_Cards = Red_Cards + 1 WHERE ID = '$value'";
            $res = mysqli_query($conn, $query1);
        }

        //update local apps
        foreach ($decoded_local_apps as $value){
            $query1 = "UPDATE t_players SET Apps = Apps + 1 WHERE ID = '$value'";
            $res = mysqli_query($conn, $query1);
        }

        //update visitor apps
        foreach ($decoded_visitor_apps as $value){
            $query1 = "UPDATE t_players SET Apps = Apps + 1 WHERE ID = '$value'";
            $res = mysqli_query($conn, $query1);
        }

        //increment matchs played
        $qry = "UPDATE t_team_stats SET Num_Games = Num_Games + 1 WHERE Team = '$localteam' and League = '$league'";
        $res = mysqli_query($conn, $qry);
        $qry1 = "UPDATE t_team_stats SET Num_Games = Num_Games + 1 WHERE Team = '$visitorteam' and League = '$league'";
        $res = mysqli_query($conn, $qry1);
		
		}
        
        echo "Success";
    }   
?>