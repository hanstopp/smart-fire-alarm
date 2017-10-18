<?php 
	require_once("lib/login.php");
	require_once("lib/notificationService.php");
	require_once("lib/session.php");

	if(isset($_POST["type"])){
		$decode= json_decode($_POST["type"]);
		$type=$decode->{'type'};
		switch ($type) {
			case 'login':
				$email=$decode->{'email'};
				$passwd=$decode->{'passwd'};
				if($email && $passwd){
					$user = Login::getLogin($db,$email, $passwd);
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
				$last=$decode->{'last'};
				$notifications = Notification::getNotifications($db, $last);
				echo $notifications;
				break;
			default:
				header("index.php");
		}
	}
	else{
		header("index.php");
	}
?>