function Settings(controller) {
	var _this = this;
	this.controller = controller;
	this.container = $("#settingCont");
	
	this.controller.components["settings"] = this.container;

	return this;
}