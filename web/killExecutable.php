<?php
/*  File:        nodeStatus.php
  Author:      Justin Dawson (JDawson@ku.edu)
  Description: This PHP script calls an expect script called vmIp.exp which
               ultimately calls a script of the same name that must be on all 
               the compute nodes involved in the demo. It gives the VM's name
               domain id, and IP address
*/
  include('session.php');
  $ip = $_POST['ip'];
  $exec = $_POST['exec'];
  $output = shell_exec("./killExec.exp $ip $exec"); 
  echo $output;
?>
