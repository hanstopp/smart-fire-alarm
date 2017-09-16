<?php
	if($_POST){
		if(isset($_POST["type"])){
			$decode= json_decode($_POST["type"]);
			$type=$decode->{'type'};
			switch ($type) {
				case "login":
					$nom= $decode->{'user'};
					$pas= $decode->{'pass'};
					try {
		  				$con = new PDO('mysql:host=localhost;dbname=FireAlarm', 'root','');
		  				$con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
		  				$stmt = $con->prepare('SELECT * FROM user WHERE name= :nombre AND passswd= :clave');
		  				$rows = $stmt->execute(array(':nombre'   => $nom, ':clave' => $pas));
		  				if($rows>0){
		  					$var= array('estado'=>'exito');
		  					echo json_encode($var);
		  				}
		  				else{
		  					$var= array('estado'=>'fail');
		  					echo json_encode($var);
		  				}
					} 
					catch(PDOException $e) {
		  			echo 'Error conectando con la base de datos: ' . $e->getMessage();
		  			}
					break;
				case "notification":
					$user=$_SESSION["usuario"];
					$lastRecv=$decode->{'lastRecv'};
					try {
		  				$con = new PDO('mysql:host=localhost;dbname=FireAlarm', 'root','');
		  				$con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
		  				$stmt = $con->prepare('SELECT code FROM incident WHERE user= :nombre AND time < :last');
		  				$rows = $stmt->execute(array(':nombre'   => $user, ':last' => $lastRecv));
		  				if($rows>0){
		  					$fila= $stmt->fetch(); 
		  					$var= array('notifica'=> $fila[0]);
		  					echo json_encode($var);
		  				}
		  				else{
		  					$var= array('notifica'=>'null');
		  					echo json_encode($var);
		  				}
					} 
					catch(PDOException $e) {
		  			echo 'Error conectando con la base de datos: ' . $e->getMessage();
		  			}
					break;
			}
		}
	}	
?>