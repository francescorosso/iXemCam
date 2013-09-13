<script type="text/javascript">
function scanSensors(apID) {
	showPage("loading");
	setTimeout(function() {
		getSensors(apID);
	}, 5000);
}

function getSensors(apID) {
	$.ajax({
		type: "GET",
		url: baseURI + "/ap/" + apID,
		dataType: "json",
		success: function(json) {
			$("#access_point_button_scan").off("click").on("click", function() {
				scanSensors(apID);
			});
			$("#access_point_button_advanced").off("click").on("click", function() {
				showAdvanced(apID);
			});
			$("#access_point_sensors_list").empty();
			for (var i = 0; i < json.sensors.length; i++) {
				var sensor = json.sensors[i];
				$("#access_point_sensors_list").append("<li><a id='access_point_sensor_" + sensor.id + "'>" + sensor.name + "</a></li>");
				$("#access_point_sensor_" + sensor.id).val(sensor.id).off("click").on("click", function() {
					getSensor(apID, $(this).val());
				});
				$("#access_point_sensor_" + sensor.id).append("&nbsp;<img class='led' src='<%=request.getContextPath() %>/resources/led_" + sensor.status + ".png'/>");
				$("#access_point_sensor_" + sensor.id).append("&nbsp;<span>AP:</span><img class='signal' src='<%=request.getContextPath() %>/resources/signal_" + sensor.apSignal + ".png' />");
				$("#access_point_sensor_" + sensor.id).append("<span>Station:</span><img class='signal' src='<%=request.getContextPath() %>/resources/signal_" + sensor.sensorSignal + ".png' />");
			}
			showPage("access_point");	
		}
	});
}
</script>

<h1></h1>
<h1>WiXemCam</h1>
<a id="access_point_button_scan" class="cancelButton">Scan</a>
<a id="access_point_button_advanced" class="doneButton">Advanced</a>

<ul id="access_point_sensors_list"></ul>