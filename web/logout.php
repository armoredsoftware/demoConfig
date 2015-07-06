<?php
/*
  File:        logout.php
  Author:      Justin Dawson (JDawson@ku.edu)
  Description: Logout script, destroys session variables
*/

session_start();
if(session_destroy()) // Destroying All Sessions
{
header("Location: index.php"); // Redirecting To Home Page
}
?>
