<?php
/*  File:        startExecutable.php
  Author:      Justin Dawson (JDawson@ku.edu)
  Description: This PHP script calls an shell script called runExec.sh which
               will run an executable on a given vm with arguments for the
               Appraiser Attester and CA Xen Domain Ids.
*/
  include('session.php');
  $ip = $_POST['ip'];
  $exec = $_POST['exec'];
  $app = $_POST['app'];
  $att = $_POST['att'];
  $ca = $_POST['ca'];

  $output = shell_exec("./runExec.sh $ip $exec $app $att $ca"); 
  echo $output;
?>
