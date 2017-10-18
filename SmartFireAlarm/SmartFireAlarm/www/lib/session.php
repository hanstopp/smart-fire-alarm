<?php 
	class Session{
		public static function check(){
			session_start();
			if($SESSION["user"] == NULL){
				header("ïndex.php");
			}
		}

		public static function start($user){
			session_start();
			$_SESSION["user"] = $user;
		}

		public static function close(){
			$_SESSION["user"] = NULL;
			session_destroy();
		}
	}
?>