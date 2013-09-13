<style>
#loading_div {
	margin: auto;
	margin-top: 30%;
	width: 180px;
	height: 180px;
	background-color: black;
	border-radius: 6px;
	-webkit-border-radius: 6px;
	-moz-border-radius: 6px;
	
	background: rgb(0, 0, 0); /* The Fallback */
	background: rgba(0, 0, 0, 0.7); 
}
#loading_div>img {
	width: 100px;
	height: 100px;
	margin: 38px;
}
</style>

<h1></h1>
<h1>WiXemCam</h1>

<div id="loading_div">
	<img src="<%=request.getContextPath() %>/resources/loading.gif" />
</div>