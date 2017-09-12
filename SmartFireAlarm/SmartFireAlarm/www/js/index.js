var app = {
	initialize: function() {
		document.addEventListener('deviceready', this.onDeviceReady.bind(this), false);
	},
    onDeviceReady: function () {
        console.log("asdsad");
    },

};
app.initialize();


function Login() {
    $("#navigation-nanvas").hide();
    $("#mainContainer").hide();

    var inputname = $("<input class='form- control input- lg' type='text' placeholder='usuario' name='user' autofocus><br>");
    var inputpassword = $("<input class='form- control input- lg' type='password' placeholder='usuario' name='user' required>");
    var inputsubmit = $("<input type='submit' name='submit'>");
    //newP.text("pericos cocodrilos ");
    
    $("body").append(inputname,inputpassword,inputsubmit);
}


function Login1(){
    
    $('#desconectar,#ingresar').click(function(){

        $('#mainContainer').hide();
        $('#copyr').hide();
        $('#contenedor').fadeIn(1000);
        
    });

    $('#inicio').click(function(){
        $('#contenedor').hide();
        $('#mainContainer').fadeIn(1000);
        $('#copyr').fadeIn(1000);
    });
}
/*
document.getElementById("inicio").addEventListener("click", function () {
    document.getElementById("logo").innerHTML = "Hello World";
});

*/


