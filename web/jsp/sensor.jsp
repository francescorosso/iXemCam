<script type="text/javascript">
function getSensor(apID, sensorID) {
	$.ajax({
		type: "GET",
		url: baseURI + "/ap/" + apID + "/" + sensorID,
		dataType: "json",
		success: function(json) {
			$("#sensor_button_backward").off("click").on("click", function() {
				getSensors(apID);
			});
			$("#sensor_title").html(json.name);
			$("#sensor_select_date").empty().off("change").on("change", function() {
				getSensorData(apID, sensorID, $(this).val());
			});
			for (var i = 0; i < json.timestamps.length; i++) {
				var date = new Date(json.timestamps[i]);
				$("#sensor_select_date").append("<option value=" + json.timestamps[i] + ">" + date.getDate() + "/" + (date.getMonth() + 1) + "/" + date.getFullYear() + " " + date.getHours() + ":00</option>");
			}
			$("#sensor_select_date").trigger("change");
			showPage("sensor");
		}
	});
}
function getSensorData(apID, sensorID, timestamp) {
	$.ajax({
		type: "GET",
		url: baseURI + "/ap/" + apID + "/" + sensorID + "/" + timestamp,
		dataType: "json",
		success: function(json) {
			$("#sensor_temperature").html(json.temperature + " °C");
			$("#sensor_humidity").html(json.humidity + " %");
			$("#sensor_photo").attr("src", baseURI + "/ap/" + apID + "/" + sensorID + "/" + timestamp + "/photo");	
		}
	});
}
</script>

<h1></h1>
<h1 id="sensor_title"></h1>
<a id="sensor_button_backward" class="backwardButton">Back</a>

<img id="sensor_photo" style="width: 100%;" />

<table>
	<tr><td><fieldset><select id="sensor_select_date"></select></fieldset></td><td id="sensor_temperature"></td><td id="sensor_humidity"></td></tr>
</table>