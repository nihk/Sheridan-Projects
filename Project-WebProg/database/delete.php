<?php 
session_start();
header("Location: database.php");
include "../scripts/connect.php";

if (!isset($_GET['studentnumber'])) {
    exit;
}

$rowToDelete = $_GET['studentnumber']; //can't put superglobals into sql statements apparently

$sql = "DELETE FROM `rosenich`.`students` WHERE `students`.`studentnumber` = $rowToDelete";
if ($conn->query($sql) === TRUE) { 
	echo "Record deleted successfully"; //left these echoes in for testing; they don't affect the user experience since the page instantly redirects
} else {
	echo "Error deleting record: " . $conn->error;
}	

$conn->close();
?>