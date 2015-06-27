<script>
	(function() {
	var numCourses = 6;
	var checkBoxesAppended = false;
	var programIs = {}; //just being explicit about hoisting

	//As the combo box choice changes, so do the potential courses
	//in the list of checkboxes immediately below the combo box
	programs.addEventListener("change", addCourses);
	submitButton.addEventListener("click", submitClicked);
	
	var programIs = {
		progCourses: ["Java", "Perl", "C++", "PHP", "Python", "MySQL"],
		musCourses: ["Music Theory", "Composition", "Music History", "Orchestration",
			"Musicianship", "Performance"],
		hisCourses: ["Wars that Changed the World", "Twentieth Century Totalitarianism", 
			"Nazi Germany", "Medieval Lives", "History of Russia-USSR", "Survey of East Asian History"],
		philCourses: ["Architects of Reason", "Basic Logic", "Ethics and Society", 
			"Gender and Sexuality", "Science and Values", "Metaphysics and Epistemology"],
		programming: function() {
			for (var i = 0; i < numCourses; i++) {
				courseTable.rows[i].cells[0].childNodes[0].value = this.progCourses[i];
				courseTable.rows[i].cells[1].childNodes[0].innerHTML = this.progCourses[i];
			}
		},
		music: function() {
			for (var i = 0; i < numCourses; i++) {
				courseTable.rows[i].cells[0].childNodes[0].value = this.musCourses[i];
				courseTable.rows[i].cells[1].childNodes[0].innerHTML = this.musCourses[i];
			}		
		},
		history: function() {
			for (var i = 0; i < numCourses; i++) {
				courseTable.rows[i].cells[0].childNodes[0].value = this.hisCourses[i];
				courseTable.rows[i].cells[1].childNodes[0].innerHTML = this.hisCourses[i];
			}
		},
		philosophy: function() {
			for (var i = 0; i < numCourses; i++) {
				courseTable.rows[i].cells[0].childNodes[0].value = this.philCourses[i];
				courseTable.rows[i].cells[1].childNodes[0].innerHTML = this.philCourses[i];
			}		
		}
	};
	
	addCourses();

	function addCourses(event) {
		if (programs.selectedIndex == 0) {
			return;
		}
		if (!checkBoxesAppended) {
			addCheckBoxes();
			checkBoxesAppended = true; //Only need to add the checkboxes once
		}
		uncheckAllCheckBoxes();
		switch (programs.selectedIndex) {
			case 1: programIs.programming(); break;
			case 2: programIs.music(); break;
			case 3: programIs.history(); break;
			case 4: programIs.philosophy(); break;
			default: console.log("A user program wasn't selected"); break;
		}
		<?php
			if (isset($_SESSION['courses']) || isset($_COOKIE['courses'])) {
			?>
				checkEnrolled();
			<?php 
			}
		?>
	}
	function checkEnrolled() {
		var coursesEnrolled = "<?php echo isset($_SESSION['courses']) ? $_SESSION['courses'] : $_COOKIE['courses']; ?>";
		for (var i = 0; i < numCourses; i++) {
			if (coursesEnrolled.indexOf(courseTable.rows[i].cells[0].childNodes[0].value) != -1) {
				courseTable.rows[i].cells[0].childNodes[0].checked = true;
			}
		}
	}
	function addCheckBoxes() {
		for (var i = 0; i < numCourses; i++) {
			var aCheckBox = createCheckBox();
			aCheckBox.id = "course" + i; //creates unique IDs "course0", "course1", etc. for each checkbox
			aCheckBox.name = "courses[]"; //any value attributes will be inserted into this course array. PHP handles this with $_POST['courses'];
			var aLabel = createLabel();
			aLabel.htmlFor = aCheckBox.id;
			
			var new_tr = courseTable.insertRow();
			var td1 = new_tr.insertCell(0);
			var td2 = new_tr.insertCell(1);
			td1.appendChild(aCheckBox);
			td2.appendChild(aLabel);
		}
	}
	function createCheckBox() {
		var aNewCheckbox = document.createElement("input");
		aNewCheckbox.type = "checkbox";
		return aNewCheckbox;
	}
	function createLabel() {
		var aNewLabel = document.createElement("label");
		return aNewLabel;
	}
	function uncheckAllCheckBoxes() {
		for (var i = 0; i < numCourses; i++) {
			if (courseTable.rows[i].cells[0].childNodes[0].checked) {
				courseTable.rows[i].cells[0].childNodes[0].checked = false;
			}
		}
	}
	function submitClicked() {
		var formsFilled = false;
		var atLeastOneCourseChecked = false;
		
		if (programs.selectedIndex != "0") {
			formsFilled = true;
		}
		for (var i = 0; i < courseTable.rows.length; i++) {
			if (courseTable.rows[i].cells[0].childNodes[0].checked) {
				atLeastOneCourseChecked = true;
				break;
			}
		}
		if (formsFilled && atLeastOneCourseChecked) {
			courseForm.action = "submit.php";
			submitButton.type = "submit";
		} else {
			printMissingMessages(formsFilled, atLeastOneCourseChecked);
		}
	}
	function printMissingMessages(formsFilled, atLeastOneCourseChecked) {
		clearMissingMessages();
		if (!atLeastOneCourseChecked) {
			prMissing.innerHTML = "*Please select at least one course.";
		}
		if (!formsFilled) {
			if (programs.selectedIndex == "0") {
				prMissing.innerHTML = "*Please select a program.";
			}
		}
	}
	function clearMissingMessages() {
		var missing = document.getElementsByClassName("missing");
		for (var i = 0; i < missing.length; i++) {
			missing[i].innerHTML = "";
		}
	}
	})();
</script>