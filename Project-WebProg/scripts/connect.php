<?php
$servername = ""; //removed for GitHub
$username = "";   //removed for GitHub
$password = "";   //removed for GitHub

$conn = new mysqli($servername, $username, $password);

if ($conn->connect_error) {
	die("Connection failed: " . $conn->connect_error);
} 
?>