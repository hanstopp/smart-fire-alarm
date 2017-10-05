<?php
	require_once("login.php");
	if(isset($_POST["type"])){
		switch ($_POST["type"]) {
			case 'login':
				$mail=$_POST["email"];
				$pass=$_POST["password"];
				if($mail && $pass){
					Login::OnLogin($db,$mail,$pass);
					if($user == NULL){
						echo '{"error": "Wrong Credentials"}';
						break;
					}
				}
				echo $user;
				break;
		}
	}
?>