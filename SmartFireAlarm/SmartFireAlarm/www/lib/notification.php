<?php 
	class Notification{
		public $code = NULL;
		public $date = NULL;
		public $time = NULL;
		public $sens = NULL;

		function __construct($code, $date, $time, $sens){
			$this -> code = $code;
			$this -> date = $date;
			$this -> time = $time;
			$this -> sens = $sens;
		}

		function __toString(){
			return json_encode($this);
		}
	}
?>