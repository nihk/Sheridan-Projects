<?php 
session_start();
include "scripts/connect.php";

if ($_SERVER["REQUEST_METHOD"] == "POST") { //in case a user visits submit.php via direct URL
	setcookie("programs", $_POST['programs'], time() + 1800);
	setcookie("courses", implode(", ", $_POST['courses']), time() + 1800);
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
		<div class="wrapper">
			<br>
			<a href="logout.php">
				<img class="signout" src="images/signout.png">
				<p class="signoutText">Sign<br>out</p>
			</a>
			<h1>Congratulations,  <span style="color: #F54F29;"><?php echo isset($_SESSION['firstName']) ? $_SESSION['firstName'] : $_COOKIE['firstName']; ?></span>!</h1>
			<h3 class="subtitle2">You have successfully enrolled <br>in the <span style="color: #F54F29;"><?php echo $_POST['programs']; ?></span> module</h3>
			<h3>Course(s) chosen:<br></h3>
			<h4><?php printCourses(); ?></h4>
			<a href="index.php"><img id="back" src="images/arrow.png"></a>
			<img id="sLogo" src="images/sheridan.png">
			<p id="footnote">Nick Rose &ndash; Project: Web Programming &ndash; 4-16-2015</p>
		</div>
		<?php
		$_SESSION['programs'] = $_POST['programs'];
		$_SESSION['courses'] = implode(", ", $_POST['courses']);
		
		//grabs all student numbers from the database
		$sql = "SELECT studentnumber FROM `rosenich`.`students`";
		$result = $conn->query($sql);
		$studentNumbersFromDB; //don't actually need to create the variable here, but I find it more readable this way

		if ($result->num_rows > 0) {
			while($row = $result->fetch_assoc()) {
				$studentNumbersFromDB .= $row['studentnumber']." "; //the extra space string here creates a delimiter
			}
		}
		
		//if the user signed in with a student number existing in the DB, update rather than insert.
		//also, sometimes the user might have a cookie for their information; this accounts for that
		$snForDB = isset($_SESSION['studentNumber']) ? $_SESSION['studentNumber'] : $_COOKIE['studentNumber'];
		$nameForDB = (isset($_SESSION['firstName']) ? $_SESSION['firstName'] : $_COOKIE['firstName'])." ".
			(isset($_SESSION['lastName']) ? $_SESSION['lastName'] : $_COOKIE['lastName']);
		$progForDB = isset($_SESSION['programs']) ? $_SESSION['programs'] : $_COOKIE['programs'];
		$coursesforDB = isset($_SESSION['courses']) ? $_SESSION['courses'] : $_COOKIE['courses'];
		
		if (strpos($studentNumbersFromDB, $snForDB) !== false) {
			updateDB($snForDB, $nameForDB, $progForDB, $coursesforDB);
		} else {
			insertIntoDB($snForDB, $nameForDB, $progForDB, $coursesforDB);
		}
		?>
	</body>
</html>
<?php
} else {
	header("Location: index.php");
}
function updateDB($studentnumber, $fullname, $program, $courses) {
	global $conn;
	$sql = "UPDATE `rosenich`.`students` SET fullname='$fullname', 
		program='$program', courses='$courses' 
		WHERE studentnumber='$studentnumber'";
	if (!$conn->query($sql)) {
		echo "Error: " . $sql . "<br>" . $conn->error;
	}		
}		
//these default values for each parameter will create an entry in the database
//to articulate that something has gone wrong.
function insertIntoDB($studentnumber = "123456", $name = "Anne Error",
	$program = "Has", $courses = "Occurred") {
	global $conn;
	$sql = "INSERT INTO `rosenich`.`students` (`studentnumber`, `fullname`, `program`, `courses`) 
		VALUES ('$studentnumber', '$name', '$program', '$courses')";	
	if (!$conn->query($sql)) {
		echo "Error: " . $sql . "<br>" . $conn->error;
	}
}	
function printCourses() {
	foreach ($_POST['courses'] as $aCourse) {
		echo "$aCourse<br>";
	}
}

$conn->close();
?>