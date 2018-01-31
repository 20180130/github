<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/face/common/tag.jsp"%>
<%
String basePath = request.getContextPath();
String JSESSIONID = request.getSession().getId();
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<%@ include file="/WEB-INF/face/common/common_css.jsp"%>
<%@ include file="/WEB-INF/face/common/common_js.jsp"%>
<title>演戏控制台</title>
<style type="text/css">
* {
	padding: 0;
	margin: 0;
}

img {
	border: none;
	
}

html, body {
	height: 100%;
}

.page {
	position: relative;
	width: 1920px;
	height: 1080px;
	overflow: hidden;
	background-color: black;
	background: url(${baseurl}vender/img/leftmenu/mainback.png);
	background-size: 100% 100%;
}


</style>
</head>
<body>
	<div class="page" style="position: relative;">
		<div id = "div_start" 
			style=" position: absolute; left :40% ; top : 40%; display: block;" 
			onclick="onStartClick()"
			width=200
			>
			<img alt="开始演示" src="${baseurl}/vender/img/console/startbtn.png"/>
		</div>
		<div id = "div_stop" style="position: absolute; left :40% ; top : 40%; display: none"  onclick="onStopClick()">
			<img alt="结束演示" src="${baseurl}/vender/img/console/stopbtn.png" />
		</div>
		
		<div id="div_mist_start" style="position: absolute; left :60% ;top:30% ; display: none;" onclick="onMistStartClick()">
			<img alt="模拟雾开始" src="${baseurl}/vender/img/console/mist_start.png" />
			<span style="float: left; margin-top: 50%;">模拟雾开始</span>
		</div>
		
		<div id="div_mist_stop" style="position: absolute; left :60% ;top:30% ; display: none;" onclick="onMistStopClick()">
			<img alt="模拟雾结束" src="${baseurl}/vender/img/console/mist_stop.png" />
			<span style="float: left; margin-top: 50%;">模拟雾结束</span>
		</div>
	</div>
	<script type="text/javascript">
	
	$(function(){
		$.ajax({
	          url: "${baseurl}/show/getShowStatus",
	          type: "post",
	          dataType: "json",
	          data: {
	            
	          },
	          async: false,
	          success: function(data) {
	        	  var datajson = JSON.parse(data.obj);
	        	  var isStart = datajson.isStart;
	        	  var mistIsStart = datajson.mistIsStart;
	        	  var div_start = document.getElementById('div_start');
	        	  var div_stop = document.getElementById('div_stop');
	        	  var div_mist_start = document.getElementById('div_mist_start');
	        	  var div_mist_stop = document.getElementById('div_mist_stop');
	        	  if(isStart=="true"){
	        		  if(mistIsStart=="true"){
				  		    div_start.style.display = "none";
				  		    div_stop.style.display = "block";
				  		    div_mist_start.style.display = "none";
				  		    div_mist_stop.style.display = "block";
	        		  }else{
	        			    div_start.style.display = "none";
	        			    div_stop.style.display = "block";
	        			    div_mist_start.style.display = "block";
	        			    div_mist_stop.style.display = "none";
	        		  }
	        	  }else if(isStart=="false"){
			  			div_start.style.display = "block";
			  			div_stop.style.display = "none";
			  			div_mist_start.style.display = "none";
			  			div_mist_stop.style.display = "none";
	        	  }
	          },
	          error: function() {
					
	          }
	        });
		
		
	})
		function onStartClick(){
			 $.ajax({
		          url: "${baseurl}/show/startShow",
		          type: "post",
		          dataType: "json",
		          data: {
		            
		          },
		          async: false,
		          success: function(data) {
		        	  if(data.success){
		        		  var div_start = document.getElementById('div_start');
				  			div_start.style.display = "none";
				  			var div_start = document.getElementById('div_stop');
				  			div_start.style.display = "block";
				  			var div_start = document.getElementById('div_mist_start');
				  			div_start.style.display = "block";
				  			var div_start = document.getElementById('div_mist_stop');
				  			div_start.style.display = "none";
		        	  }
		          },
		          error: function() {
						
		          }
		        });
		}
		
		function onStopClick(){
			
			
			 $.ajax({
		          url: "${baseurl}/show/stopShow",
		          type: "post",
		          dataType: "json",
		          data: {
		            
		          },
		          async: false,
		          success: function(data) {
		        	  if(data.success){
		        		var div_start = document.getElementById('div_start');
		      			div_start.style.display = "block";
		      			var div_start = document.getElementById('div_stop');
		      			div_start.style.display = "none";
		      			
		      			var div_start = document.getElementById('div_mist_start');
		      			div_start.style.display = "none";
		      			var div_start = document.getElementById('div_mist_stop');
		      			div_start.style.display = "none";
		        	  }
		          },
		          error: function() {
						
		          }
		        });
			
		}
		
		function onMistStartClick(){
			$.ajax({
		          url: "${baseurl}/show/mistStartShow",
		          type: "post",
		          dataType: "json",
		          data: {
		            
		          },
		          async: false,
		          success: function(data) {
		        	  if(data.success){
		        		  var div_start = document.getElementById('div_mist_start');
		      			div_start.style.display = "none";
		      			var div_start = document.getElementById('div_mist_stop');
		      			div_start.style.display = "block";
		        	  }
		          },
		          error: function() {
						
		          }
		        });
			
			
			
		}
		
		function onMistStopClick(){
			$.ajax({
		          url: "${baseurl}/show/mistStopShow",
		          type: "post",
		          dataType: "json",
		          data: {
		            
		          },
		          async: false,
		          success: function(data) {
		        	  if(data.success){
		        		  var div_start = document.getElementById('div_mist_start');
		      			div_start.style.display = "block";
		      			var div_start = document.getElementById('div_mist_stop');
		      			div_start.style.display = "none";
		        	  }
		          },
		          error: function() {
						
		          }
		        });
			
			
		}
	
	
	</script>
</body>
</html>
