<?php
/*  File:        send.php
    Author:      Justin Dawson (JDawson@ku.edu)
    Description: This script will send the input data to the input IP address
                 via a curl operation on port 55555. This is used to send the
                 request to the appraiser
*/
  include('session.php');
  $ip = $_POST['ip'];
  $data = $_POST['data'];
  $ch = curl_init();
  curl_setopt($ch,CURLOPT_URL,$ip . ":55555/");
  curl_setopt($ch,CURLOPT_RETURNTRANSFER, true); 
  curl_setopt($ch,CURLOPT_POST,1);
  curl_setopt($ch,CURLOPT_TIMEOUT,1);
  curl_setopt($ch,CURLOPT_POSTFIELDS,$data);
  $output = curl_exec($ch);
  curl_close($ch);
  echo $output;
  return $output;
?>

