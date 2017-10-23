// Si quiere una introducción sobre la plantilla En blanco, vea la siguiente documentación:
// http://go.microsoft.com/fwlink/?LinkID=397704
// Para depurar código al cargar la página en cordova-simulate o en dispositivos o emuladores Android: inicie la aplicación, establezca puntos de interrupción 
// y ejecute "window.location.reload()" en la Consola de JavaScript.
/*
(function () {
    "use strict";

    document.addEventListener('deviceready', onDeviceReady.bind(this), false);
    
    function onDeviceReady() {
        
        // Controlar la pausa de Cordova y reanudar eventos
        document.addEventListener('pause', onPause.bind(this), false);
        document.addEventListener('resume', onResume.bind(this), false);

        document.getElementById("dialogAlert").addEventListener("loadstart", dialogAlert);
        console.log(navigator.notification);
        function alertDismissed() {
            // do something
        }

        navigator.notification.alert(
            'You are the winner!',  // message
            alertDismissed,         // callback
            'Game Over',            // title
            'Done'                  // buttonName
        );
        
        document.getElementById("dialogConfirm").addEventListener("loadeddata", dialogConfirm);
        document.getElementById("dialogPrompt").addEventListener("click", dialogPrompt);
        document.getElementById("dialogBeep").addEventListener("click", dialogBeep);

        // TODO: Cordova se ha cargado. Haga aquí las inicializaciones que necesiten Cordova.
        var parentElement = document.getElementById('deviceready');
        var listeningElement = parentElement.querySelector('.listening');
        var receivedElement = parentElement.querySelector('.received');
        listeningElement.setAttribute('style', 'display:none;');
        receivedElement.setAttribute('style', 'display:block;');
    };

    document.addEventListener("deviceready", onDeviceReady, false);

    // device APIs are available
    //
    function onDeviceReady() {
        // Empty
    }

    // alert dialog dismissed
    function alertDismissed() {
        // do something
    }

    // Show a custom alertDismissed
    //
    function showAlert() {
        navigator.notification.alert(
            'You are the winner!',  // message
            alertDismissed,         // callback
            'Game Over',            // title
            'Done'                  // buttonName
        );
    }
    function onPause() {
        // TODO: esta aplicación se ha suspendido. Guarde el estado de la aplicación aquí.
    };

    function onResume() {
        // TODO: esta aplicación se ha reactivado. Restaure el estado de la aplicación aquí.
    };
    // json
    var myJSON = '{ "name":"John", "age":31, "city":"New York" }';
    var myObj = JSON.parse(myJSON);

    function mostrarhora() {
        var f = new Date();
        var cad = f.getHours() + ":" + f.getMinutes() + ":" + f.getSeconds();
        window.status = cad;
        setTimeout("mostrarhora()", 1000);
    }

    function myFunction() {
        setInterval(
            function dialogAlert() {
                var message = myObj.name;
                var title = "ALERT";
                var buttonName = "Alert Button";
                navigator.notification.alert(message, alertCallback, title, buttonName);
                //setTimeOut("dialogAlert()", 1000);
                function alertCallback() {
                    console.log("Alert is Dismissed!");
                }
            }
            ,
            3000);
    }

    
    function dialogAlert() {
        var message = myObj.name;
        var title = "ALERT";
        var buttonName = "Alert Button";
        navigator.notification.alert(message, alertCallback, title, buttonName);
        //setTimeOut("dialogAlert()", 1000);
        function alertCallback() {
            console.log("Alert is Dismissed!");
        }
    };
    function dialogConfirm() {
        var message = "Am I Confirm Dialog?";
        var title = "CONFIRM";
        var buttonLabels = "YES,NO";
        navigator.notification.confirm(message, confirmCallback, title, buttonLabels);

        function confirmCallback(buttonIndex) {
            console.log("You clicked " + buttonIndex + " button!");
        }

    };
    function dialogPrompt() {
        var message = "Am I Prompt Dialog?";
        var title = "PROMPT";
        var buttonLabels = ["YES", "NO"];
        var defaultText = "Default"
        navigator.notification.prompt(message, promptCallback,
            title, buttonLabels, defaultText);

        function promptCallback(result) {
            console.log("You clicked " + result.buttonIndex + " button! \n" +
                "You entered " + result.input1);
        }

    };
    function dialogBeep() {
        var times = 2;
        navigator.notification.beep(times);
    };
})();*/


document.addEventListener("deviceready", onDeviceReady, false);

// device APIs are available
//
function onDeviceReady() {
    // Empty
}

// alert dialog dismissed
function alertDismissed() {
    // do something
}

// Show a custom alertDismissed
//

var myJSON = '{ "name":"John", "age":31, "ubicacion":"New York" }';
var myObj = JSON.parse(myJSON);

var myVar;
function myFunction() {
    myVar = setInterval(showAlert, 3000);
}

function showAlert() {
    navigator.notification.alert(
        'Sr(a) ' + myObj.name +' su casa se esta quemando',           // message
        alertDismissed,                                               // callback
        'Notificacion',                                               // title
        'OK'//myStopFunction()                                              // buttonName
    );
}
function myStopFunction() {
    clearInterval(myVar);
}


/////////////////////////////////////////////////////////
// 2DO PLANO
/*
document.addEventListener('deviceready', function () {
    // cordova.plugins.backgroundMode is now available
}, false);
cordova.plugins.backgroundMode.enable();
// or
//cordova.plugins.backgroundMode.setEnabled(true);

cordova.plugins.backgroundMode.isActive();
cordova.plugins.backgroundMode.on('EVENT', function);
*/