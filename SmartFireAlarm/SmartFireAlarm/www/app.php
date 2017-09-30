<?php 
	//- require("/lib/session.php");

	require_once("../lib/login.php");
	require_once("../lib/notificationService.php");
	require_once("../lib/session.php");

	if(isset($_POST["type"])){
		switch ($_POST["type"]) {
			case 'login':
				if(isset($_POST["email"]) && isset($_POST["passwd"])){
					$user = Login::getLogin($db, $_POST["email"], $_POST["passwd"]);
					if($user == NULL){
						echo '{"error": "Wrong Credentials"}';
						break;
					}
				}
				Session::start($user);
				echo $user;
				break;
			case 'getNotifications':
				Session::check();
				$notifications = Notification::getNotifications($db, $_POST["last"]);
				echo $notifications;
				break;
			default:
				header("index.html");
		}
	}
	else{
		header("index.html");
	}
?>