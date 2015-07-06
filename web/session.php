<?php
/*
  File:        session.php
  Author:      Justin Dawson (JDawson@ku.edu)
  Description: This PHP script will redirect the user to the login page if they
               are not currently logged in

*/
  session_start();
  if( !isset($_SESSION['login_user'])){
     header("Location: index.php");
  }

?>
