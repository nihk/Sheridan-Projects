<?php 
session_start();
include "scripts/connect.php";
$_SESSION['accountFound'] = false;

if ($_SERVER["REQUEST_METHOD"] == "POST") {
	$_SESSION['firstName'] = $_POST['firstName'];
	$_SESSION['lastName'] = $_POST['lastName'];
	$_SESSION['studentNumber'] = $_POST['studentNumber'];

	$sql = "SELECT studentnumber, firstname, lastname FROM `rosenich`.`accounts`";
	$result = $conn->query($sql);
	$postString = $_POST['firstName']." ".$_POST['lastName']." ".$_POST['studentNumber'];
	$dbString;
	/* checks for whether the account is in the accounts table, aka if it is a "valid" account (I arbitrarily decided which accounts
	   were valid based on whatever entries are inside the accounts table). */
	if ($result->num_rows > 0) {
		while($row = $result->fetch_assoc()) {
			$dbString = $row['firstname']." ".$row['lastname']." ".$row['studentnumber'];
			if ($postString == $dbString) {
				$_SESSION['accountFound'] = true;
				break;
			}	
		}
	}
}
//if the account exists in the `accounts` table, set the post values to cookies
if ($_SERVER["REQUEST_METHOD"] == "POST" && $_SESSION['accountFound']) {
	setcookie("studentNumber", $_POST['studentNumber'], time() + 1800);
	setcookie("firstName", $_POST['firstName'], time() + 1800);
	setcookie("lastName", $_POST['lastName'], time() + 1800);
}
//if the user has already enrolled and has program/course information in the `students` database,
//I want to fetch this info and have it reflected in both session and cookie superglobals
if ((isset($_SESSION['firstName']) || isset($_COOKIE['firstName']))) {
	include "scripts/connect.php";

	//grabs all student numbers from the database
	$sql = "SELECT studentnumber FROM `rosenich`.`students`";
	$result = $conn->query($sql);
	$studentNumbersFromDB;
	if ($result->num_rows > 0) {
		while($row = $result->fetch_assoc()) {
			$studentNumbersFromDB .= $row['studentnumber']." "; //space functions as a delimiter
		}
	}
	
	$stdnumFromSessOrCook = (isset($_SESSION['studentNumber']) ? $_SESSION['studentNumber'] : $_COOKIE['studentNumber']);
	
	//php's strange way to compare if one string is contained within another
	if (strpos($studentNumbersFromDB, $_SESSION['studentNumber']) !== false) {
		//get the program/courses associated with that student number from the DB
		$studentprogram;
		$studentcourses;
		$sql = "SELECT program, courses FROM `rosenich`.`students` WHERE studentnumber='$stdnumFromSessOrCook'";
		$result = $conn->query($sql);
		if ($result->num_rows > 0) {
			while($row = $result->fetch_assoc()) {
				$studentprogram = $row['program'];
				$studentcourses = $row['courses'];
			}
		}
		//assign them to these session/cookie variables, this way if the user signs in and
		//their student number already exists in the DB, their course choices will be
		//reflected in the program combo box and course checkboxes
		$_SESSION['programs'] = $studentprogram;
		$_SESSION['courses'] = $studentcourses;
		setcookie("programs", $studentprogram, time() + 1800);
		setcookie("courses", $studentcourses, time() + 1800);
	}
}
?>
<!-- Nick Rose -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Nick Rose: Project (Web Programming)</title>
		<link rel="stylesheet" href="css/styles.css" type="text/css">
		<link rel="shortcut icon" href="images/icon.ico" type="image/x-icon">
	</head>
	<body>
		<?php 
			include "scripts/index-options.inc.php"; 
			$conn->close();
		?>
	</body>
</html>