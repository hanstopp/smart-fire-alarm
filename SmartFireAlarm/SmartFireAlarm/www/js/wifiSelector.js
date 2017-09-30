function WifiSelector(controller) {
	var _this = this;
	this.controller = controller;
	this.container  = $("#wifiCont");
	this.wifiList   = $("#wifiList");
	this.wifiForm   = $("#wifiForm");
	this.selectedNet = $("#selectedNet");
	this.selectedNetID = null;

	this.getNetworks = function(){
		for(indx in post){
			this.wifiList.append(
				'<button type="button" class="list-group-item wifiNetBtn" id="net-' + indx +'">' + post[indx] + '</button>'
			)
		}
		$(".wifiNetBtn").click(this.selectNetwork);
	}

	this.selectNetwork = function(evnt){
		_this.wifiList.css("display", "none");
		_this.wifiForm.css("display", "block");
		_this.selectedNet.append("Conectarse a " + this.innerHTML);
		_this.selectedNetID = this.innerHTML;
	}

	this.sendNetworkData = function(evnt){
		evnt.preventDefault();
		var formData = _this.wifiForm.serializeArray();
		var postData = {};

		for(indx in formData){
			postData[formData[indx].name] = formData[indx].value;
		}

		postData["ssid"] = _this.selectedNetID;
		console.log(postData);
		$.post(
			"http://localhost/fireAlarm/nodeSim.php",
			postData,
			_this.nodeResponse
		);
	}

	this.nodeResponse = function(data, status){
		console.log(data);
	}

	this.wifiForm.on("submit", this.sendNetworkData);
	this.controller.components["wifiSelector"] = this.container;
	return this;
}