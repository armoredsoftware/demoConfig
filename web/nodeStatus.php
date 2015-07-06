<?php
/*  File:        nodeStatus.php
  Author:      Justin Dawson (JDawson@ku.edu)
  Description: This PHP script calls an expect script called vmIp.exp which
               ultimately calls a script of the same name that must be on all 
               the compute nodes involved in the demo. It gives the VM's name
               domain id, and IP address
*/
  include('session.php');
  $node = $_POST['node'];
  $output = shell_exec("./vmIp.exp $node"); 
  echo $output;
?>
