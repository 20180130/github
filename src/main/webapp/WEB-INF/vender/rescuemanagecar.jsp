<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/face/common/tag.jsp"%>
<%
String basePath = request.getContextPath();
String JSESSIONID = request.getSession().getId();
%>
<html>
<head>
<meta charset="utf-8">
<meta
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no"
	name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta content="telephone=no" name="format-detection">
<meta content="email=no" name="format-detection">
<title>救护管理系统</title>
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
	background: url(img/map.png);
	background-size: 100% 100%;
}

.carImage {
	background: url(img/xiaoche.png);
	background-size: 100% 100%;
}
</style>
</head>
<body>
	<div class="page">
		<div id="jiuhu"
			style="width: 26.8%; height: 40%; background-image: url(${baseurl}vender/img/ambulance/tablebackimage.png); position: absolute; top: 20%; left: 30%; display: none;">
			<table class="jiuhuTable" id="used_car_info"
				style="border-collapse: separate; border-spacing: 50px 15px; margin-top: 20px; width: 100%">
				<tr>
					<th colspan="4" align="left"
						style="border-bottom: 1px solid black; width: 100%; padding-bottom: 7px">可用车辆列表</th>
				</tr>
				<tr>
					<td style="display: none;">ID</td>
					<td>车辆</td>
					<td>预计用时</td>
					<td>操作</td>
				</tr>
			</table>
			<table class="jiuhuTable" id="station"
				style="border-collapse: separate; border-spacing: 50px 15px; width: 100%">
				<tr>
					<th colspan="4" align="left"
						style="border-bottom: 1px solid black; width: 100%; padding-bottom: 7px">可用车辆列表</th>
				</tr>
				<tr>
					<td style="display: none;">ID</td>
					<td>站点</td>
					<td>预计用时</td>
					<td>操作</td>
				</tr>
			</table>
			<table style="width: 100%;">
				<tr>
					<td>
						<button
							style="margin-left: 40%; background-color: #E0E0E0; border: none;"
							onclick="selectAffirm()">确认选择</button>
					</td>
				</tr>
			</table>
		</div>
		<div id="jiuhu_closebtn"
			style="position: absolute; left: 55%; top: 21%; display: none;">
			<img style="width: 20px;" alt="关闭"
				src="${baseurl}vender/img/ambulance/closebtn.png"
				onclick="jiuhuDivClose()" />
		</div>

		<div id="ambulance_point"
			style="position: absolute; left: 75%; top: 48%">
			<img style="width: 25px;" alt="救护点"
				src="${baseurl}vender/img/ambulance/Ambulance_point.png"
				onclick="ambulance()" />
		</div>
		<div id="hospital_point"
			style="position: absolute; left: 85%; top: 12%">
			<img style="width: 35px;" alt="医院"
				src="${baseurl}vender/img/ambulance/hospital.png" />
		</div>
	</div>
	<script type="text/javascript" src="js/pageResponse.min.js"></script>
	<script type="text/javascript" src="js/jquery-1.7.min.js"></script>
	<script type="text/javascript">
	//判断手机横竖屏状态：
	window.addEventListener("onorientationchange" in window ? "orientationchange" : "resize", function() {
	        if (window.orientation === 180 || window.orientation === 0) {
	            location.reload() 
	        }
	        if (window.orientation === 90 || window.orientation === -90 ){
	            location.reload() 
	        } 
	    }, false);
		window.onload = window.onresize = function() {
			pageResponse({
				selectors : 'div.page', //模块选择器，使用querySelectorAll的方法
				mode : 'cover', // auto || contain || cover ，默认模式为auto 
				width : '1920', //输入页面的宽度，只支持输入数值，默认宽度为1920px
				height : '1080' //输入页面的高度，只支持输入数值，默认高度为1080px
			})
		}
		$(document).ready(function(){
			//createDiv();
		});
		var seatX = 0*GetPercent(document.body.clientWidth,1920);
		var seatY = 523*GetPercent(document.body.clientHeight,1080);
		var seatX1 = 200*GetPercent(document.body.clientWidth,1920);
		var seatY1 = 523*GetPercent(document.body.clientHeight,1080);
		var carWidth = 100*GetPercent(document.body.clientWidth,1920);
		//计算div的确切位置
		function createDiv() {
			//首先创建div
			var descDiv = document.createElement('div');
			document.body.appendChild(descDiv);
			//给div设置样式，比如大小、位置
			var cssStr = "z-index:5;width:"+carWidth+"px;height:auto;position:absolute;left:"
			+ seatX + 'px;top:'+ seatY+ 'px;';
			//将样式添加到div上，显示div
			descDiv.style.cssText = cssStr;
			descDiv.innerHTML = '1';
			descDiv.id = 'car1';
			descDiv.style.display = 'block';
			descDiv.setAttribute("class", "carImage");

			//首先创建div
			var descDiv = document.createElement('div');
			document.body.appendChild(descDiv);
			//给div设置样式，比如大小、位置
			var cssStr = "z-index:5;width:"+carWidth+"px;height:auto;position:absolute;left:"
			+ seatX1+ 'px;top:'+ seatY1+ 'px;';
			//将样式添加到div上，显示div
			descDiv.style.cssText = cssStr;
			descDiv.innerHTML = '2';
			descDiv.id = 'car2';
			descDiv.style.display = 'block';
			descDiv.setAttribute("class", "carImage");
		}
		   setInterval(moveCars, 500);//使用字符串执行方法 

		function moveCars() {
			var car1 = document.getElementById('car1');
			car1.style.position = "relative";
			var cssStr = "z-index:5;width:"+carWidth+"px;height:auto;position:absolute;margin:0 auto;left:"
					+ seatX + 'px;top:' + seatY + 'px;';
			//将样式添加到div上，显示div
			car1.style.cssText = cssStr;
			seatX += 5;

			var car2 = document.getElementById('car2');
			car2.style.position = "relative";
			var cssStr = "z-index:5;width:"+carWidth+"px;height:auto;position:absolute;margin:0 auto;left:"
					+ seatX1 + 'px;top:' + seatY1 + 'px;';
			//将样式添加到div上，显示div
			car2.style.cssText = cssStr;
			seatX1 += 5;
		}
		///计算两个整数的百分比值 
		function GetPercent(num, total) {
			num = parseFloat(num);
			total = parseFloat(total);
			if (isNaN(num) || isNaN(total)) {
				return "-";
			}
			return total <= 0 ? "0%"
					: (Math.round(num / total * 100) / 100.00);
		}
		
		
		
		function ambulance(){
			var car = $("#used_car_info tr");
			var station = $("#station tr");
			for (var i = car.length - 1; i > 1; i--) {
				car[i].remove();
			}
			for (var i = station.length - 1; i > 1; i--) {
				station[i].remove();
			}
			$("#jiuhu").css("display","block");
			$("#jiuhu_closebtn").css("display","block");
			 $.ajax({  
			        data:{
			        	
			        },  
			        type:"post",  
			        dataType: 'json', 
			        async:false,
			        url:"${baseurl}ambulance/selectTableInfo",  
			        error:function(data){  
			            alert("出错了！！:"+data.msg);  
			        },  
			        success:function(data){
			        	var busDataList  = JSON.parse(data.obj[0]);
			        	var stationDataList  = JSON.parse(data.obj[1]);
			        	for (var i = 0; i < busDataList.length; i++) {
			        		var busData= busDataList[i];
			        		$("#used_car_info").append("<tr><td style ='display:none;'>"+busData.jiuhuid+"</td><td>京AD181"+busData.jiuhuid+"</td><td>00:05</td><td><button style='background-color:#E0E0E0;  border:none;' onclick='btnColor(this)'>选择</button></td></tr>");
						}
			        	for (var i = 0; i < stationDataList.length; i++) {
			        		var stationData = stationDataList[i];
			        		$("#station").append("<tr><td style ='display:none;'>"+stationData.stopid+"</td><td>站点"+stationData.stopid+"</td><td>00:03</td><td><button style='background-color:#E0E0E0 ;  border:none;' onclick='btnColor(this)'>选择</button></td></tr>");
				        }  
					}
			        	
			        });  
			
			
		}

		function btnColor(e){
			var tr = e.parentElement.parentElement.parentElement.children;
			for (var i = 2; i < tr.length; i++) {
				tr[i].children[3].firstChild.style.cssText="background-color: #E0E0E0; border:none;"
			}
			e.style.cssText="background-color: rgb(31,189,236); border:none;"
			
		}

		function jiuhuDivClose(){
			$("#jiuhu").css("display","none");
			$("#jiuhu_closebtn").css("display","none");
		}

		function selectAffirm(){
			
			var jiuhuid ="";
			var stopid="";
			var button = $(".jiuhuTable tr").find("button");
			for (var i = 0; i < button.length; i++) {
				var color = button[i].style.backgroundColor
				if(color=="red"){
					var id = button[i].parentElement.parentElement.firstChild.textContent;
					var tabId = button[i].parentElement.parentElement.parentElement.parentElement.id;
					if(tabId=="used_car_info"){
						jiuhuid = id;
					}else if(tabId=="station"){
						stopid = id;
					}
				}
			}
			var params = {
					param:{"jiuhuid" :jiuhuid,
				        "stopid":stopid}
			    };
			var url = "${baseurl}ambulance/busDispatch";
			 $.ajax({
			        dataType: "json",
			       // contentType:'application/json;charset=UTF-8',//关键是要加上这行
			       // traditional:true,//这使json格式的字符不会被转码
			        data: {"jiuhuid" :jiuhuid,
				        "stopid":stopid},
			        type: "post", 
			        timeout: 20000,
			        url: url,
			        success : function (data) {
			            if(data.success){
			            	 $.messager.show({
			            		 title:'success',
			            		 msg:data.info,
			            		 showType:'fade',
			            		 timeout:5000,
			            		 })
			            }
			            $("#jiuhu").css("display","none");
			        	$("#jiuhu_closebtn").css("display","none");
			        },
			        error : function (data){
			            alert(data.responseText);
			        }
			    });
			
		}
	</script>
</body>
</html>
