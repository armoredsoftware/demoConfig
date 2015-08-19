<?php
/*  File:        nodeStatus.php
  Author:      Justin Dawson (JDawson@ku.edu)
  Description: This PHP script calls a shell script called vmIp.sh which
               ultimately calls getVmIp.exp that must be on all 
               the compute nodes involved in the demo. It gives the VM's name
               domain id, and IP address
*/
  include('session.php');
  $node = $_POST['node'];
  $output = shell_exec("./vmIp.sh $node"); 
  echo $output;
?>
