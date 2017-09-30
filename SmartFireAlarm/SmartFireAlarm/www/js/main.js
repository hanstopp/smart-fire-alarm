function DOMController(){
	var _this = this;
	this.document = $(document);
	this.logedOptions = $(".onceLoged");
	this.navWidgets = $(".navigation");
	this.navBar = $("#navBar");
	this.components = {};

	this.init = function(){
		_this.login         = new Login(_this);
		_this.monitor       = new Monitor(_this);
		_this.settings      = new Settings(_this);
		_this.notifications = new Notifications(_this);
		_this.wifiSelector  = new WifiSelector(_this);
		_this.account       = new Account(_this);
		_this.navWidgets.click(_this.navigate);
	}

	this.show = function(comp){
		for(var c in this.components){
			this.components[c].css("display", "none");
		}
		this.components[comp].css("display", "block");
	}

	this.onLogin = function(){
		this.show("wifiSelector");
		this.logedOptions.css("display", "block");
		this.wifiSelector.getNetworks();
	}

	this.navigate = function(evnt){
		_this.navBar.collapse("toggle");
		_this.show(this.name);
		console.log(this.name);
	}

	this.document.ready(this.init);
	return this;
}

app = new DOMController();