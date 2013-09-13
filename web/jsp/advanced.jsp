<script type="text/javascript">
	function showAdvanced(apID) {
		$("#advanced_button_backward").off("click").on("click", function() {
			getSensors(apID);
		});
		showPage("advanced");
	}
</script>

<h1></h1>
<h1>Advanced</h1>
<a id="advanced_button_backward" class="backwardButton">Back</a>

<ul>
	<li><a>Settings</a></li>
	<li><a>Logs</a></li>
	<li><a>Test</a></li>
	<li><a>Console</a></li>
</ul>