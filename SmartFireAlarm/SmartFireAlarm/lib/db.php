<?php 
	class DBConnection{
		public $conn = NULL;

		public function connect(){
			try {
				$this -> conn = new PDO("mysql:host=localhost;dbname=firealarm;charset=utf8", "root", "");
			} catch (Exception $e) {
				$this -> conn = NULL;
				echo json_encode("{error: 'DatabaseError'}");
				header("../www/index.html");
			}
		}
	}

	$db = new DBConnection();
	$db -> connect();
?>