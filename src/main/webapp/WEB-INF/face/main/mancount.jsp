<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/face/common/tag.jsp"%>
<html>
<head>
<title>智能网联汽车云控平台</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<%--  <script type="text/javascript" src="${baseurl}js/jquery-1.4.4.min.js"></script> --%>
<link rel="stylesheet" type="text/css" href="${baseurl}/vender/ui/easyui/styles/default.css"> 
    <%@ include file="/WEB-INF/face/common/common_css.jsp"%>
     <%@ include file="/WEB-INF/face/common/common_js.jsp"%> 
<script type="text/javascript">

$(function() {
	$("#outfirstrect > div").click(
			function() {
				var systemnum = $(this).attr("id");
				//alert(pp);
				$(window).attr('location',
						'${baseurl}main/first?href=' + systemnum);

			});

	$("#outsecondrect > div").click(
			function() {
				var towsystemnum = $(this).attr("id");
				if(towsystemnum=="m5"||towsystemnum=="m6"){
					$(window).attr('location',
							'${baseurl}main/first?href=' + towsystemnum);
				}else{
					$(window).attr('location',
							'${baseurl}main/first?href=' + towsystemnum);
				}
				
			});

})
</script>


<style type="text/css">

.combo-text{
background:#202020;
color:white;
width:90px;
border:0px solid #202020;
}
.combo{

border:0px solid #505050;
}

.combobox-item{
color:white;
}
</style>
<META name="GENERATOR" content="MSHTML 9.00.8112.16540">
</HEAD>

<body style="overflow-y: hidden;background: #333;margin:0px;" class="easyui-layout" scroll="no" >


<div style=" background: #f6fdff url(${baseurl}vender/img/leftmenu/mainback.png) repeat-x;border:1px solid #000000;width:100%;height:100%;">
	<div
		style='background: #000000; height: 35px; padding-top: 2px; color: rgb(255, 255, 255);width:100%; line-height: 20px; float: left; overflow: hidden; font-family: Verdana, 微软雅黑, 黑体; border: 1px solid #000000;;'>
		<div
			style="border: 0px solid white; float: left; width: 100px; height: 100%; margin-left: 5px; border-right: 1px solid 	#000000;">
			<IMG alt="" src="${baseurl}vender/img/login/topleftmenu.png"
				style="width: 100px; height: 28px;">
		</div>



	</div>

		<div
			style="margin-top:0px;border: 0px solid yellow; width: 100%; height: 100%; ">
			<div
				style="border: 0px solid white; width: 70%; height: 150px; margin-top: 10%; margin-left: 20%;" id="outfirstrect">
				<div
					style="color:white;border: 0px solid white; width: 360px; height: 240px; margin-left: 10px; float: left; cursor: pointer;"
					id="m1">
						<img class="icon2" src="${baseurl}vender/img/mainlogo/first.png"  style="width:360px;height:240px;"/> 
					</div>
				<div
					style="color:white;border: 0px solid white; width: 360px; height: 240px;  margin-left: 3%; float: left; cursor: pointer;"
					id="m2">
						<img class="icon2" src="${baseurl}vender/img/mainlogo/tow.png"  style="width:360px;height:240px;"/> 
					</div>
				<div
					style="color:white;border: 0px solid white; width: 360px; height: 240px;  margin-left:  3%; float: left; cursor: pointer;"
					id="m3">
						<img class="icon2" src="${baseurl}vender/img/mainlogo/three.png"  style="width:360px;height:240px;"/> 
					</div>
			</div>

			<div
				style="border: 0px solid white; width: 70%; height: 150px; margin-top: 8%; margin-left: 20%;" id="outsecondrect">
				<div
					style="color:white;border: 0px solid white; width: 360px; height: 240px;  margin-left: 10px; float: left; cursor: pointer;"
					id="m4">
						<img class="icon2" src="${baseurl}vender/img/mainlogo/four.png"  style="width:360px;height:240px;"/> 
					</div>
				<div
					style="color:white;border: 0px solid white; width: 360px; height: 240px;  margin-left:  3%; float: left; cursor: pointer;"
					id="m5">
						<img class="icon2" src="${baseurl}vender/img/mainlogo/five.png"  style="width:360px;height:240px;"/> 
					</div>
				<div
					style="color:white;border: 0px solid white; width: 360px; height: 240px;  margin-left: 3%;  float: left; cursor: pointer;"
					id="m6">
					<img class="icon2" src="${baseurl}/vender/img/mainlogo/six.png"  style="width:360px;height:240px;"/> 
					</div>
			</div>
		</div>

	</div>


	

</body>

</html>
