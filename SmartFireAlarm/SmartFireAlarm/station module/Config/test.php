<?php
    if (isset($_POST["srv_action"])) {
        if ($_POST["srv_action"] == "set_user") {
            if (isset($_POST["user"]) and isset($_POST["pwd"])) {
                if ($_POST["user"]=="aflores" and $_POST["pwd"] == "12345678") {
                    echo '{"user":"aflores","name":"Andres Flores","rut":"19.717.817-5","location":"Freire 765, Collipulli, Chile"}';
                }
                else {
                    echo '{"Error":"SqlError","Message":"None row is returned"}';
                }
            }
            else {
                echo '{"Error":"ArgsError","Message":"Incorrect Argument"}';
            }
        }
        else {
            echo '{"Error":"NilReturn","Message":"The action is not recognized"}';
        }
    }
    else {
        echo json_encode($_POST);
    }
?>
