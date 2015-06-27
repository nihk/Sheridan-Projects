<?php 
session_start();
include "../scripts/connect.php";

$sql = "SELECT studentnumber, fullname, program, courses FROM `rosenich`.`students`";
$result = $conn->query($sql);
?>
<!-- Nick Rose -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Nick Rose: Project (Web Programming)</title>
		<link rel="stylesheet" href="../css/styles.css" type="text/css">
		<link rel="shortcut icon" href="../images/icon.ico" type="image/x-icon">
	</head>
	<body>
		<div class="wrapperDb">
			<a href="../index.php"><img id="back" src="../images/arrow.png"></a>
			<h1>Enrolment Database</h1>
			<table id="databaseTable">
				<tr>
					<th class="dbStudentNumber"><i>Student &#8470;</i></th>
					<th class="dbName"><i>Name</i></th>
					<th class="dbProgram"><i>Program</i></th>
					<th class="dbCourse"><i>Courses</i></th>
					<th class="dbDelete"><i>Delete</i></th>
				</tr>
				<?php
				if ($result->num_rows > 0) {
					while($row = $result->fetch_assoc()) {
					?>
					<tr>
						<td class="dbStudentNumber"><?php echo $row['studentnumber']; ?></td>
						<td class="dbName"><?php echo $row['fullname']; ?></td>
						<td class="dbProgram"><?php echo $row['program']; ?></td>
						<td class="dbCourse"><?php echo $row['courses']; ?><br></td>
						<td class="dbDelete">
							<a href="delete.php?studentnumber=<?php echo $row['studentnumber']; ?>">
								<input type="button" class="rButtons" value="Remove">
							</a>
						</td>
					</tr>			
					<?php	
					}
				}
				?>
			</table>
			<p id="footnote">Nick Rose &ndash; Project: Web Programming &ndash; 4-16-2015</p>
		</div>
		<?php
			$conn->close();
		?>
	</body>
</html>