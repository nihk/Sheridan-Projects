<?php 
session_start();
if (isset($_SESSION['firstName']) || isset($_COOKIE['firstName'])) { //should only sign-out if signed-in
	$_SESSION = array();	
	session_unset(); 
	session_destroy(); 
	
	setcookie("studentNumber", "sn", time() - 3600);
	setcookie("firstName", "fn", time() - 3600);
	setcookie("lastName", "ln", time() - 3600);
	setcookie("programs", "pr", time() - 3600);
	setcookie("courses", "co", time() - 3600); //expires the cookie instantly; dummy values used just to meet the req'd args of setcookie()
	unset($_COOKIE['studentNumber']);
	unset($_COOKIE['firstName']);
	unset($_COOKIE['lastName']);
	unset($_COOKIE['programs']);
	unset($_COOKIE['courses']);
	header("refresh:5;url=index.php"); //found howto at http://stackoverflow.com/questions/6119451/page-redirect-after-certain-time-php
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
		<h1>You are now logged out</h1>
		<h3 id="countdown" class="subtitle3"></h3>
		<a href="index.php"><img id="back" src="images/arrow.png"></a>
		<img id="sLogo" src="images/sheridan.png">
		<br>
		<p id="footnote">Nick Rose &ndash; Project: Web Programming &ndash; 4-16-2015</p>
	</div>
	<script>
		var count = 6; 
		countDown();
		function countDown(){
			if (count > 1) {
				count--;
				countdown.innerHTML = "Redirecting in " + count + " seconds...";
				setTimeout("countDown()", 1000);
			}
		}
	</script>
	</body>
</html>
<?php
} else {
	header("Location: index.php");
}
?>