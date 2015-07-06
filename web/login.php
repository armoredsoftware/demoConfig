<?php
/*
  File: login.php
  Author: Justin Dawson
  Description: Login script that validates user/password, currently Hardcoded
               should fix this
*/
 session_start();
 if ( isset($_POST['submit'])){
   $username=$_POST['username'];
   $password=$_POST['password'];
   
   if($username=="armored" && $password == "armored"){
     $_SESSION['login_user']= $username;
     header("location: index.php");
   }else{
     $error="Invalid username or password";
   }

 }else{

 }

?>
