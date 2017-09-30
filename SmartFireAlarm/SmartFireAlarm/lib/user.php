<?php 
	class User{
		public $code = NULL;
		public $name = NULL;
		public $eMail = NULL;

		function __construct($code, $fName, $lName, $eMail){
			$this -> code = $code;
			$this -> name = $fName . " ". $lName;
			$this -> eMail = $eMail;
		}

		function __toString(){
			return json_encode($this);
		}
	}
?>