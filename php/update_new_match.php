<?php 
include "dbconfig.php";
// update a match into the db. Distributes the required info to the corresponding tables
  
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
    $id = mysqli_real_escape_string($conn, $_POST['id']);
    $gamePlayed = mysqli_real_escape_string($conn, $_POST['newMatch']);


	$tempPrevLocalScore= mysqli_fetch_array(mysqli_query($conn, "SELECT Local_Score FROM t_schedules WHERE id = '$id'"), MYSQLI_NUM);
	$tempPrevVisitorScore= mysqli_fetch_array(mysqli_query($conn, "SELECT Visitor_Score FROM t_schedules WHERE id = '$id'"), MYSQLI_NUM);
	$tempPrevLocalYellowCards= mysqli_fetch_array(mysqli_query($conn, "SELECT Local_Yellow_Card FROM t_schedules WHERE id = '$id'"), MYSQLI_NUM);
	$tempPrevVisitorYellowCard= mysqli_fetch_array(mysqli_query($conn, "SELECT Visitor_Yellow_Cards FROM t_schedules WHERE id = '$id'"), MYSQLI_NUM);
	$tempPrevLocalRedCards= mysqli_fetch_array(mysqli_query($conn, "SELECT Local_Red_Card FROM t_schedules WHERE id = '$id'"), MYSQLI_NUM);
	$tempPrevVisitorRedCards= mysqli_fetch_array(mysqli_query($conn, "SELECT Visitor_Red_Cards FROM t_schedules WHERE id = '$id'"), MYSQLI_NUM);
	$tempPrevLocalApps= mysqli_fetch_array(mysqli_query($conn, "SELECT Local_Participants FROM t_schedules WHERE id = '$id'"), MYSQLI_NUM);
	$tempPrevVisitorApps= mysqli_fetch_array(mysqli_query($conn, "SELECT Visitor_Participants FROM t_schedules WHERE id = '$id'"), MYSQLI_NUM);
    $tempPrevMatchPlayed = mysqli_fetch_array(mysqli_query($conn, "SELECT Game_Played FROM t_schedules WHERE id = '$id'"), MYSQLI_NUM);

    $prevLocalScore = json_decode(stripslashes($tempPrevLocalScore[0]),true);
    $prevVisitorScore= json_decode(stripslashes($tempPrevVisitorScore[0]),true);
    $prevLocalYellowCards = json_decode(stripslashes($tempPrevLocalYellowCards[0]),true);
    $prevVisitorYellowCards= json_decode(stripslashes($tempPrevVisitorYellowCard[0]),true);
    $prevLocalRedCards = json_decode(stripslashes($tempPrevLocalRedCards[0]),true);
    $prevVisitorRedCards= json_decode(stripslashes($tempPrevVisitorRedCards[0]),true);
    $prevLocalApps = json_decode(stripslashes($tempPrevLocalApps[0]),true);
    $prevVisitorApps= json_decode(stripslashes($tempPrevVisitorApps[0]),true);
    $prevMatchPlayed= $tempPrevMatchPlayed[0];
	
        $query = "UPDATE t_schedules SET Local = '$localteam', Visitor = '$visitorteam', Week_Num = '$week', Date = '$date', Field_name = '$venue', Local_Score = '$localscore', Visitor_Score = '$visitorscore', Local_Yellow_Card = '$localyellows', Local_Red_Card = '$localreds', Visitor_Yellow_Cards = '$visitoryellows', Visitor_Red_Cards = '$visitorreds', Time = '$time', League = '$league', Local_Participants = '$localapps', Visitor_Participants = '$visitorapps', Game_Played = '$gamePlayed'
  			  WHERE id = '$id'";
			  

	$decoded_local_scorers = json_decode(stripslashes($localscore),true);
    $decoded_visitor_scorers = json_decode(stripslashes($visitorscore),true);
    $decoded_local_yellows = json_decode(stripslashes($localyellows),true);
    $decoded_visitor_yellows = json_decode(stripslashes($visitoryellows),true);
    $decoded_local_reds = json_decode(stripslashes($localreds),true);
    $decoded_visitor_reds = json_decode(stripslashes($visitorreds),true);
    $decoded_local_apps = json_decode(stripslashes($localapps),true);
    $decoded_visitor_apps = json_decode(stripslashes($visitorapps),true);

    $results = mysqli_query($conn, $query);
    
if($prevMatchPlayed==0)
{
	if($results>0)
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
        
        echo "Success";
    }
}
else{
    //remove previous local score stat and add new one
    //remove previous
    foreach ($prevLocalScore as $value){
        $query1 = "UPDATE t_players SET Goals = Goals - 1 WHERE ID = '$value'";
        $res = mysqli_query($conn, $query1);
        $query2 = "UPDATE t_team_stats SET GF = GF - 1 WHERE Team = '$localteam' and League = '$league'";
        $res = mysqli_query($conn, $query2);
        $query3 = "UPDATE t_team_stats SET GA = GA - 1 WHERE Team = '$visitorteam' and League = '$league'";
        $res = mysqli_query($conn, $query3);
    }
    //Add new values
    foreach ($decoded_local_scorers as $value){
        $query1 = "UPDATE t_players SET Goals = Goals + 1 WHERE ID = '$value'";
        $res = mysqli_query($conn, $query1);
        $query2 = "UPDATE t_team_stats SET GF = GF + 1 WHERE Team = '$localteam' and League = '$league'";
        $res = mysqli_query($conn, $query2);
        $query3 = "UPDATE t_team_stats SET GA = GA + 1 WHERE Team = '$visitorteam' and League = '$league'";
        $res = mysqli_query($conn, $query3);
    }

    //remove  prev visitor score stat and add new one
    //remove previous
    foreach ($prevVisitorScore as $value){
        $query1 = "UPDATE t_players SET Goals = Goals - 1 WHERE ID = '$value'";
        $res = mysqli_query($conn, $query1);
        $query2 = "UPDATE t_team_stats SET GA = GA - 1 WHERE Team = '$localteam' and League = '$league'";
        $res = mysqli_query($conn, $query2);
        $query3 = "UPDATE t_team_stats SET GF = GF - 1 WHERE Team = '$visitorteam' and League = '$league'";
        $res = mysqli_query($conn, $query3);
    }
    //add new scorers
    foreach ($decoded_visitor_scorers as $value){
        $query1 = "UPDATE t_players SET Goals = Goals + 1 WHERE ID = '$value'";
        $res = mysqli_query($conn, $query1);
        $query2 = "UPDATE t_team_stats SET GA = GA + 1 WHERE Team = '$localteam' and League = '$league'";
        $res = mysqli_query($conn, $query2);
        $query3 = "UPDATE t_team_stats SET GF = GF + 1 WHERE Team = '$visitorteam' and League = '$league'";
        $res = mysqli_query($conn, $query3);
    }

    //remove previos local yellow cards and add new
    //remove previos
    foreach ($prevLocalYellowCards as $value){
        $query1 = "UPDATE t_players SET Yellow_Cards = Yellow_Cards - 1 WHERE ID = '$value'";
        $res = mysqli_query($conn, $query1);
    }
    //add new
    foreach ($decoded_local_yellows as $value){
        $query1 = "UPDATE t_players SET Yellow_Cards = Yellow_Cards + 1 WHERE ID = '$value'";
        $res = mysqli_query($conn, $query1);
    }

    //remove previos visitor yellow cards and add new
    //remove previos
    foreach ($prevVisitorYellowCards as $value){
        $query1 = "UPDATE t_players SET Yellow_Cards = Yellow_Cards - 1 WHERE ID = '$value'";
        $res = mysqli_query($conn, $query1);
    }
    //add new
    foreach ($decoded_visitor_yellows as $value){
        $query1 = "UPDATE t_players SET Yellow_Cards = Yellow_Cards + 1 WHERE ID = '$value'";
        $res = mysqli_query($conn, $query1);
    }

    //remove local reds and add new
    //remove previous
    foreach ($prevLocalRedCards as $value){
        $query1 = "UPDATE t_players SET Red_Cards = Red_Cards - 1 WHERE ID = '$value'";
        $res = mysqli_query($conn, $query1);
    }
    //add new
    foreach ($decoded_local_reds as $value){
        $query1 = "UPDATE t_players SET Red_Cards = Red_Cards + 1 WHERE ID = '$value'";
        $res = mysqli_query($conn, $query1);
    }

    //remove visitor reds and add new
    //remove previous
    foreach ($prevVisitorRedCards as $value){
        $query1 = "UPDATE t_players SET Red_Cards = Red_Cards - 1 WHERE ID = '$value'";
        $res = mysqli_query($conn, $query1);
    }
    //add new
    foreach ($decoded_visitor_reds as $value){
        $query1 = "UPDATE t_players SET Red_Cards = Red_Cards + 1 WHERE ID = '$value'";
        $res = mysqli_query($conn, $query1);
    }

    //remove local apps and add new
    //remove previous
    foreach ($prevLocalApps as $value){
        $query1 = "UPDATE t_players SET Apps = Apps - 1 WHERE ID = '$value'";
        $res = mysqli_query($conn, $query1);
    }
    //add new
    foreach ($decoded_local_apps as $value){
        $query1 = "UPDATE t_players SET Apps = Apps + 1 WHERE ID = '$value'";
        $res = mysqli_query($conn, $query1);
    }

    //remove visitor apps and add new
    //remove
    foreach ($prevVisitorApps as $value){
        $query1 = "UPDATE t_players SET Apps = Apps - 1 WHERE ID = '$value'";
        $res = mysqli_query($conn, $query1);
    }
    //add new
    foreach ($decoded_visitor_apps as $value){
        $query1 = "UPDATE t_players SET Apps = Apps + 1 WHERE ID = '$value'";
        $res = mysqli_query($conn, $query1);
    }

    //remove matches win/lose/tied previos and add new
    //remove
    if(count($prevLocalScore) > count($prevVisitorScore)){
        $query = "UPDATE t_team_stats SET Games_Won = Games_Won - 1, Points = Points - 3 WHERE Team = '$localteam' and League = '$league'";
        $res = mysqli_query($conn, $query);
        $query1 = "UPDATE t_team_stats SET Games_Lost = Games_Lost - 1 WHERE Team = '$visitorteam' and League = '$league'";
        $res = mysqli_query($conn, $query1);
    }else if (count($prevVisitorScore) > count($prevLocalScore)){
        $query = "UPDATE t_team_stats SET Games_Won = Games_Won - 1, Points = Points - 3 WHERE Team = '$visitorteam' and League = '$league'";
        $res = mysqli_query($conn, $query);
        $query1 = "UPDATE t_team_stats SET Games_Lost = Games_Lost - 1 WHERE Team = '$localteam' and League = '$league'";
        $res = mysqli_query($conn, $query1);
    }else{
        $query = "UPDATE t_team_stats SET Games_Drawn = Games_Drawn - 1, Points = Points - 1 WHERE Team = '$localteam' and League = '$league'";
        $res = mysqli_query($conn, $query);
        $query1 = "UPDATE t_team_stats SET Games_Drawn = Games_Drawn - 1, Points = Points - 1 WHERE Team = '$visitorteam' and League = '$league'";
        $res = mysqli_query($conn, $query1);
    }
    //add
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
}
	
    
?>