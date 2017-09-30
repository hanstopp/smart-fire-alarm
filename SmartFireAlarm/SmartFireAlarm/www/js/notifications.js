function Notifications(controller) {
	var _this = this;
	this.controller = controller;
	this.container = $("#notificationCont");
	
	this.controller.components["notifications"] = this.container;

	return this;
}