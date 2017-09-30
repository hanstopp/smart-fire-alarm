<?php
	require_once("user.php");
	require_once("db.php");
	//session_start();
	//$_SESSION["user"] = new User("1", "Matias", "Poblete", "matias.salgado4@gmail.com");

	class NotificationService{
		private static $query = 'SELECT * FROM incident WHERE user = :user AND code >= :last';

		public static function getNotifications($db, $last = 0){
			$user = $_SESSION["user"];
			$sel = $db -> conn -> prepare(NotificationService::$query);

			$sel -> execute(array(':user' => $user -> code, ':last' => $last));

			$result = $sel -> fetchAll();
			$ret = array();

			foreach ($result as $row) {
				// function __construct($code, $date, $time, $sens){
				$ret -> push(new Notification($row["code"], $row["date"], $row["time"], $row["sensorData"]));
			}

			return json_encode($ret);
		}
	}

	//NotificationService::getNotifications($db);

	//session_destroy();

?>