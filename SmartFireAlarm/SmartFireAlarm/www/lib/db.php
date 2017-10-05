<?php
	require_once("db.php");
	class Login{
		public $query="SELECT * FROM User WHERE email= :mail";
		
		public static function OnLogin($mail,$pass){
			$sel = $db -> conn -> prepare(Login::$query);
			$sel -> execute(array(':email'   => $email));
			$result = $sel -> fetchAll();

			$user = NULL;
			if($result > 0){
				if(md5($passwd) == $result[0]["passwd"]){
					$user = new User($result[0]["code"], $result[0]["name"], $result[0]["lastName"], $result[0]["email"]);
				}
			}
			return $user;
		}
	}
?>