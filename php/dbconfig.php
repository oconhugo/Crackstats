<?php
  $server = '192.185.4.46';
  $username = 'ocon14_Alex04'; // for the database on my PC
  $password = 'Rashgoal$10'; // for the database on my PC
  $database = 'ocon14_Crackstats'; // the name of the database on my PC

  try {
    $conn = mysqli_connect($server,$username,$password,$database);
  } catch(PDOException $e) {
    die("Connection failed: " . $e->getMessage());
  }
?>