<?php
/*  File:        readLog.php
    Author:      Justin Dawson (JDawson@ku.edu)
    Description: This script calls a shell script that when given an IP address
                 of a VM will ssh to the vm and read a particular log file to
                 display the running Appraiser/Attester
*/
  include('session.php');
  $ip = $_POST['ip'];
  $output = shell_exec("./readLog.sh $ip"); 
  echo $output;
?>
