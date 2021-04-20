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
	$prevLocalScore= mysqli_real_escape_string($conn, $_POST['prevLocalScore']);
	$prevVisitorScore= mysqli_real_escape_string($conn, $_POST['prevVisitorScore']);
	$prevLocalYellowCards= mysqli_real_escape_string($conn, $_POST['prevLocalYellowCards']);
	$prevVisitorYellowCard= mysqli_real_escape_string($conn, $_POST['prevVisitorYellowCard']);
	$prevLocalRedCards= mysqli_real_escape_string($conn, $_POST['prevLocalRedCards']);
	$prevVisitorRedCards= mysqli_real_escape_string($conn, $_POST['prevVisitorRedCards']);
	$prevLocalApps= mysqli_real_escape_string($conn, $_POST['prevLocalApps']);
	$prevVisitorApps= mysqli_real_escape_string($conn, $_POST['prevVisitorApps']);
	
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

        $decoded_prevlocal_scorers = json_decode(stripslashes($prevLocalscore),true);
        $decoded_prevvisitor_scorers = json_decode(stripslashes($prevVisitorscore),true);
        $decoded_prevlocal_yellows = json_decode(stripslashes($prevLocalyellows),true);
        $decoded_prevvisitor_yellows = json_decode(stripslashes($prevVisitoryellows),true);
        $decoded_prevlocal_reds = json_decode(stripslashes($prevLocalreds),true);
        $decoded_prevvisitor_reds = json_decode(stripslashes($prevVisitorreds),true);
        $decoded_prevlocal_apps = json_decode(stripslashes($prevLocalapps),true);
        $decoded_prevvisitor_apps = json_decode(stripslashes($prevVisitorapps),true);

    $results = mysqli_query($conn, $query);
    
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
	
	
    
?>