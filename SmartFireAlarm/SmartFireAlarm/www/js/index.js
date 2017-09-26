var app = {
	initialize: function() {
        document.addEventListener('onDeviceReady', this.onDeviceReady.bind(this), false);
	},
    onDeviceReady: function () {
        console.log("asdsad");
    },


};
app.initialize();


$(document).ready(function () {
    $('#conf_form').hide();
    $('#Cuenta_form').hide();
    $('#Login').hide();
    $('#Alertas_form').hide();
});


function Inicio() {
    $('#Inicio').click(function () {
        $('#conf_form').hide();
        $('#Cuenta_form').hide();
        $('#Login').hide();
        $('#Alertas_form').show();
    });
}

function Configuracion() {
    $('#Configuracion').click(function () {
        $('#Alertas_form').hide();
        $('#Cuenta_form').hide();
        $('#Login').hide();
        $('#conf_form').show();
    });
}

function Cuenta() {
    $('#Cuenta').click(function () {
        $('#Alertas_form').hide();
        $('#conf_form').hide();
        $('#Login').hide();
        $('#Cuenta_form').show();
        
    });
}

function Desconectar() {
    $('#Desconectar').click(function () {
        $('#navigation-nanvas').hide();
        $('#Alertas_form').hide();        
        $('#conf_form').hide();
        $('#Cuenta_form').hide();
        $('#Login').show();
    });
}


function Login() {


}

function Alertas(){
    var text = '{ "incident" : [' +
                '{ "code":"01" , "date":"24-09-2017", "time":"12:54:02" , "user":"perico", "sensorData":"value1" },' +
                '{ "code":"02" , "date":"20-09-2017", "time":"22:31:14" , "user":"juan"  , "sensorData":"value2" },' +
                '{ "code":"03" , "date":"13-09-2017", "time":"15:41:39" , "user":"carlos", "sensorData":"value3" } ]}';
    var obj = JSON.parse(text);
    document.write("<table border='1'><tr>");
    document.write("<td> CODE </td><td> DATE </td><td> TIME </td><td> USER </td><td> SENSOR_DATA </td></tr>");
    for (var i=0; i<100; i++){
        document.write("<tr>")
        document.write("<td>"+obj.incident[i].code+"</td>");
        document.write("<td>"+obj.incident[i].date+"</td>");
        document.write("<td>"+obj.incident[i].time+"</td>");
        document.write("<td>"+obj.incident[i].user+"</td>");
        document.write("<td>"+obj.incident[i].sensorData+"</td>");
        document.write("</tr>")
        }
    document.write("</table>");    
}

/*
no tomar en cuenta
function selectRedes() {
    $(document).ready(function () {
        $.ajax({
            type: 'POST',
            url: 'php/cargar_redes.php'
        })
            .done(function (listas_rep) {
                $('#lista_redes').html(listas_rep)
            })
            .fail(function () {
                alert('Hubo un errror al cargar las listas_rep')
            })

    })
}*/
