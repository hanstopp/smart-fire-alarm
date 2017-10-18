<?php
	require_once("user.php");
	require_once("db.php");

	class NotificationService{
		private static $query = 'SELECT * FROM incident WHERE user = :user AND code >= :last';

		public static function getNotifications($db, $last = 0){
			$user = $_SESSION["user"];
			$sel = $db -> conn -> prepare(NotificationService::$query);
			$sel -> execute(array(':user' => $user -> code, ':last' => $last));
			$result = $sel -> fetchAll();
			echo json_encode($result);
			$ret = array();
			foreach ($result as $row) {
				$ret -> push(new Notification($row["code"], $row["date"], $row["time"], $row["sensorData"]));
			}
			echo json_encode($ret);
		}
	}
?>