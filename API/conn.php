<?php

define('DB_SERVER', 'localhost');
define('DB_USERNAME', 'id18925117_admin');
define('DB_PASSWORD', 'Mydb-12341234');
define('DB_NAME', 'id18925117_attendance');
 

$link = mysqli_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_NAME);
 

if($link === false){
    die("ERROR: Could not connect. " . mysqli_connect_error());
}
else{
    
}
?>