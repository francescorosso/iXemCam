<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<title>WiXemCam</title>

	<meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;" />
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
	<link rel="apple-touch-icon" href="<%=request.getContextPath() %>/resources/icon.png"/>

	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/ixemcam.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/iphone/iphone.css" />

	<script src="http://code.jquery.com/jquery-1.8.2.min.js"></script>
	<script src="http://malsup.github.io/jquery.form.js"></script>
	<script type="text/javascript">
	function showPage(pageID) {
		$("div.page").css("display", "none");
		$("#" + pageID).css("display", "inline");
	}
	</script>
</head>
<body>
	<jsp:include page="/ixemcam.jsp" />
</body>
</html>