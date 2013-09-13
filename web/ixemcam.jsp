
<script type="text/javascript">
	var baseURI = "<%=request.getContextPath() %>/rest";
	$(document).ready(function() {
		var apID = 1;
		scanSensors(apID);
	});
</script>

<style>
div.page {
	display: none;
}
</style>

<div id="loading" class="page">
	<jsp:include page="/jsp/loading.jsp" />
</div>
<div id="access_point" class="page">
	<jsp:include page="/jsp/access_point.jsp" />
</div>
<div id="sensor" class="page">
	<jsp:include page="/jsp/sensor.jsp" />
</div>
<div id="advanced" class="page">
	<jsp:include page="/jsp/advanced.jsp" />
</div>