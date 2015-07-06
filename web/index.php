<?php
/*   File: index.php
 *   Author: Justin Dawson (JDawson@ku.edu)
 *   Description: This page is the login screen for the Armored Demo web page
 */               
   include('login.php'); // Includes Login Script

  if(isset($_SESSION['login_user'])){
    header("location: main.php");
  }

?>

<!DOCTYPE html>
<html>
<head>
  <link href="css/login.css" rel="stylesheet" type="text/css">
  <link href="css/armored.css" rel="stylesheet" type="text/css">
  <script src="http://code.jquery.com/jquery-latest.min.js"
        type="text/javascript"></script>
  
</head>
<script>
  function start(){
     $("#header").load("header.html", function(){
           $("#logout").hide();
     });
  }

window.onload=start;
</script>


<body>
<div id="header"></div>

<div id="loginForm">
  <form action="" method="post">
    <label>Username: </label>
    <input id="name" name="username" placeholder="username" type="text">
    <label>Password: </label>
    <input id="password" name="password" placeholder="********" type="password">
    <input name="submit" type="submit" value=" Login ">
    <p style="color:red;"><?php echo $error;?></p>
   </form>
</div>

</body>



