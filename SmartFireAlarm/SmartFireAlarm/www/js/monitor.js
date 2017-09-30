function Monitor(controller) {
	var _this = this;
	this.controller = controller;
	this.container = $("#monitorCont");
	
	this.controller.components["monitor"] = this.container;

	return this;
}