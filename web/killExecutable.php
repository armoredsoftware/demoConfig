<?php
/*  File:      killExecutable.php
  Author:      Justin Dawson (JDawson@ku.edu)
  Description: This PHP script calls a shell script called killExec.sh which
               will call the ~/demo/killExec.sh script on the corresponding 
               vm that will kill the corresponding executable
*/
  include('session.php');
  $ip = $_POST['ip'];
  $exec = $_POST['exec'];
  $output = shell_exec("./killExec.sh $ip $exec"); 
  echo $output;
?>
