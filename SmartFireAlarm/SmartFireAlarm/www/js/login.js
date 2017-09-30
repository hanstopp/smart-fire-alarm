function Login(controller) {
	var _this = this;
	this.controller = controller;
	this.container = $("#loginCont");
	this.form = $("#loginForm");
	this.user = null;

	this.send = function(evnt){
		evnt.preventDefault();
		$.post(
			"../app.php",
			_this.form.serialize(),
			_this.response
		);
	}

	this.response = function(data, status){
		if(status != "success"){
			this.error(data);
			return;
		}
		var data = JSON.parse(data);
		if("error" in data){
			console.log(data["error"]);
			return;
		}
		_this.user = data;
		console.log(data);
		_this.controller.onLogin();
	}

	this.error = function(error){
		console.log("Error: " + error);
	}

	this.form.on("submit", this.send);
	this.controller.components["login"] = this.container;

	return this;
}