<script>
	(function() {
		submitButton.addEventListener("click", submitClicked);

		function submitClicked() {
			if (validateForm()) {
				courseForm.action = "index.php";
				submitButton.type = "submit";
			} else {
				printMissingMessages();
			}
		}
		function validateForm() {	
			return (firstName.value != "") && (lastName.value != "") &&
				(studentNumber.value.length == 6) && !isNaN(studentNumber.value);
		}
		function printMissingMessages() {
			clearMissingMessages();
			if (firstName.value == "") {
				fnMissing.innerHTML = "*Please enter your first name.";
			}
			if (lastName.value == "") {
				lnMissing.innerHTML = "*Please enter your last name.";
			}
			if (isNaN(studentNumber.value) || studentNumber.value.length != 6) {
				snMissing.innerHTML = "*Please enter a six-digit student number.";
			}
			if (studentNumber.value == "") {
				snMissing.innerHTML = "*Please enter your student number.";
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