<?php
	class DBConnection(){
		public function conexion(){
			public $con= NULL;
			try {
				$this -> conn = new PDO("mysql:host=localhost;dbname=firealarm;charset=utf8", "root", "");
			} catch (Exception $e) {
				$this -> conn = NULL;
				echo json_encode("{error: 'DatabaseError'}");
			}
		}
	}
	$db =new BDConnection();
	$db->conexion();
?>