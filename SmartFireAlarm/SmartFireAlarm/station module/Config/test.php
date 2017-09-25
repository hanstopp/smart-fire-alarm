<?php
	if (isset($_POST["srv_action"])) {
		if ($_POST["srv_action"] == "set_user") {
			if (isset($_POST["user"]) and isset($_POST["pwd"])) {
				echo '{"user":"Andres","pwd":"12345678"}';
			}
			else {
				echo '{"Error":"ArgsError","Message":"Incorrect Argument"}';
			}
		}
		else {
			echo '{"Error":"NilReturn","Message":"The action is not recognized"}';
		}
	}
	else {
		echo '{"Error":"NilReturn","Message":"None is Returned"}';
	}
?>