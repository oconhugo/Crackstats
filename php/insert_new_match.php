<?php 
include "dbconfig.php";
// Insert a new match into the db. Distributes the required info to the corresponding tables
  
    $localteam = mysqli_real_escape_string($conn, $_POST['localTeam']);
    $visitorteam = mysqli_real_escape_string($conn, $_POST['visitorTeam']);
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
 
        $query = "INSERT INTO t_schedules (Local, Visitor, Date, Field_name, Local_Score, Visitor_Score, Local_Yellow_Card, Local_Red_Card, Visitor_Yellow_Cards, Visitor_Red_Cards, Time, League, Local_Participants, Visitor_Participants)
  			  VALUES('$localteam', '$visitorteam', '$date', '$venue', '$temp', '$visitorscore', '$localyellows' ,'$localreds', '$visitoryellows', '$visitorreds' ,'$time', '$league', '$localapps', '$visitorapps')";

    $results = mysqli_query($conn, $query);
    
	if($results>0)
    {
        echo "Success";
    }

    //update goals
    //foreach ($localscore as $value){
        //$query1 = "UPDATE t_players SET Goals = 5 
        //WHERE First_Name = '$value[0]' and Last_name = '$value[1]' and League = '$league' and Team = '$localteam';
        //$res = mysqli_query($conn, $query1);
    //}
    
?>