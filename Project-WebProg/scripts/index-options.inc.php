<?php

if ((!isset($_SESSION['firstName']) || !$_SESSION['accountFound']) && !isset($_COOKIE['firstName'])) {
	?>
	<div class="wrapper">
		<h1>Student Course Registration Form</h1>
		<form id="courseForm" method="post" enctype="multipart/form-data"> <!-- action attribute initially missing, it gets assigned through JavaScript -->
			<h4 class="subtitle1">Enter your name and student number</h4>
			<br><br>
			<img class="arrow" src="images/arrow.png">
			<input type="text" id="firstName" name="firstName" placeholder="First Name" value="<?php echo $_POST['firstName']; ?>">
			<p id="fnMissing" class="missing"></p>
			<input type="text" id="lastName" name="lastName" placeholder="Last Name" value="<?php echo $_POST['lastName']; ?>">
			<p id="lnMissing" class="missing"></p>
			<br><br>
			<img class="arrow" src="images/arrow.png">
			<input type="text" id="studentNumber" name="studentNumber" placeholder="Student Number" value="<?php echo $_POST['studentNumber']; ?>">
			<p id="snMissing" class="missing"></p>
			<br><br>
			<img id="check" src="images/check.png">
			<?php if (isset($_POST['firstName']) && !$_SESSION['accountFound']) { ?>
			<p id="accountNotFound" class="missing">This account was not found, please enter a valid one</p>
			<?php } ?>
			<input type="button" id="submitButton" value="Submit">
			<a href="database/database.php"><input type="button" id="databaseButton" value="View Enrolment Database"></a>
		</form>
		<img id="sLogo" src="images/sheridan.png">
		<br>
		<p id="footnote">Nick Rose &ndash; Project: Web Programming &ndash; 4-16-2015</p>
	</div>
	<?php include "notsignedin.inc.php";
	
} else if ((isset($_SESSION['firstName']) || isset($_COOKIE['firstName']))) {
?>
	<div class="wrapper">
		<h1>Student Course Registration Form</h1>
		<h4 class="subtitle1">
			<?php 
			$fn = (isset($_SESSION['firstName']) ? $_SESSION['firstName'] : $_COOKIE['firstName']);
			if (!isset($_SESSION['courses']) && !isset($_COOKIE['courses'])) {
				echo "Welcome, <span style='color: #F54F29;'>".$fn."</span>! Choose from the options below";
			} else {
				echo "Feel free to edit your current enrolment, <span style='color: #F54F29;'>".$fn."</span>";
			}
			?>
		</h4>
		<form id="courseForm" method="post" enctype="multipart/form-data">
			<br><br>
			<a href="logout.php">
				<img class="signout" src="images/signout.png">
				<p class="signoutText">Sign<br>out</p>
			</a>
			<img class="arrow" src="images/arrow.png">
			<p id="prMissing" class="missing"></p>
			<select id="programs" name="programs">
			<?php $sessOrCookie = isset($_SESSION['programs']) ? $_SESSION['programs'] : $_COOKIE['programs']; ?>
				<option value="None" <?php if (!isset($_SESSION['courses']) || !isset($_COOKIE['courses'])) {echo "selected='selected'";} ?>  
					disabled="disabled">Select a Program</option>
				<option value="Programming" <?php if (strpos($sessOrCookie, "Programming") !== false) {echo "selected='selected'";} ?>
					>Programming</option>
				<option value="Music" <?php if (strpos($sessOrCookie, "Music") !== false) {echo "selected='selected'";} ?>
					>Music</option>
				<option value="History" <?php if (strpos($sessOrCookie, "History") !== false) {echo "selected='selected'";} ?>
					>History</option>
				<option value="Philosophy" <?php if (strpos($sessOrCookie, "Philosophy") !== false) {echo "selected='selected'";} ?>
					>Philosophy</option>
			</select>
			<table id="courseTable">
			</table>
			<img id="check" src="images/check.png">
			<input type="button" id="submitButton" value="Submit">
		</form>
		<img id="sLogo" src="images/sheridan.png">
		<br>
		<p id="footnote">Nick Rose &ndash; Project: Web Programming &ndash; 4-16-2015</p>
	</div>
	<?php include "signedin.inc.php";
}
?>	
