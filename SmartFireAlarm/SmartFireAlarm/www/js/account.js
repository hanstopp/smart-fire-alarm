function Account(controller) {
	var _this = this;
	this.controller = controller;
	this.container = $("#accountCont");
	
	this.controller.components["account"] = this.container;

	return this;
}