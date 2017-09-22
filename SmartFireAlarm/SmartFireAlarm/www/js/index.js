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