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
	background: url(${baseurl}vender/img/map.png);
	background-size: 100% 100%;
}
</style>
</head>
<body>
	<div class="page" id = "page">
		<div id="jiuhu"
			style="width: 25%; height: 40%; background-image: url(${baseurl}vender/img/rescue/tablebackimage.png);background-size:100% 100%; position: absolute; top: 20%; left: 30%; display: none;">
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
						<button id = "affirm_btn";
							style="margin-left: 40%; background-color: #E0E0E0; border: none;">确认选择</button>
					</td>
				</tr>
			</table>
			<div id="jiuhu_closebtn"
				style="position: absolute; top: 3%; left: 92%">
				<img style="width: 20px;" alt="关闭"
					src="${baseurl}vender/img/rescue/closebtn.png"
					onclick="jiuhuDivClose()" />
			</div>
		</div>
		<%-- <div id="rescuePoint"
			style="position: absolute; left: 75%; top: 49%">
			<img style="width: 25px;" alt="救护点"
				src="${baseurl}vender/img/rescue/rescue_point.png"
				onclick="rescues()" />
		</div> --%>
		<div id="hospital_point"
			style="position: absolute; left: 85%; top: 12%">
			<img style="width: 35px;" alt="医院"
				src="${baseurl}vender/img/rescue/hospital.png" />
		</div>
	</div>
	<script type="text/javascript">
	//判断手机横竖屏状态：
	/* window.addEventListener("onorientationchange" in window ? "orientationchange" : "resize", function() {
	        if (window.orientation === 180 || window.orientation === 0) {
	            location.reload() 
	        }
	        if (window.orientation === 90 || window.orientation === -90 ){
	            location.reload() 
	        } 
	}, false); */
		/* window.onload = window.onresize = function() {
			pageResponse({
				selectors : 'div.page', //模块选择器，使用querySelectorAll的方法
				mode : 'cover', // auto || contain || cover ，默认模式为auto 
				width : '1920', //输入页面的宽度，只支持输入数值，默认宽度为1920px
				height : '1080' //输入页面的高度，只支持输入数值，默认高度为1080px
			})
		} */
		
		/* 轮询 */
		setInterval(function(){
		    Push();
		},3000); 
		
		function Push(){
			$(function(){
				$.ajax({
			        type:"POST",
			        url:"${baseurl}rescue/selectRescuePoint",
			        data:{},
			        beforeSend:function(){},
			        success: function(data){
			        	if(data.success){
			        		if(data.obj!=null&&data.obj.length>0){
			        			var jsonobj = JSON.parse(data.obj)
				        		for (var i = 0; i < jsonobj.length; i++) {
				        			insertRescuePoint(jsonobj[i].id ,jsonobj[i].eventlng, jsonobj[i].eventlat , jsonobj[i].state)
								}
			        		}
			        	}
			        }
			    });
			})
		}
		
		/* function rescues(){
				$.ajax({
			        type:"POST",
			        url:"${baseurl}rescue/selectRescuePoint",
			        data:{},
			        beforeSend:function(){},
			        success: function(data){
			        	if(data.success){
			        		if(data.obj!=null&&data.obj.length>0){
			        			var jsonobj = JSON.parse(data.obj)
				        		for (var i = 0; i < jsonobj.length; i++) {
				        			insertRescuePoint(jsonobj[i].id ,jsonobj[i].eventlng, jsonobj[i].eventlat , jsonobj[i].state)
								}
			        		}
			        	}
			        }
			    });
		} */
		function insertRescuePoint(id , top , left , state){
			var rescuePoints = $(".rescuePoint");
			rescuePoints.remove();
			$("#page").append(
					"<div id='rescuePoint_"+id+"' class ='rescuePoint' style = 'position: absolute; top: "+top+"px ; left : "+left+"px'>"
					+ "<img style = 'width :25px ;' alt='救护点' src ='${baseurl}vender/img/rescue/rescue_point.png'"
					+" onclick='rescue_"+state+"(this)'/></div>");
		}
		
		function rescue_0(e){
			var ids = e.parentElement.id;
			var pointId = ids.substring(ids.indexOf("_")+1,ids.length);
			var affirm_btn = document.getElementById('affirm_btn');
			affirm_btn.style.display="block";
			affirm_btn.onclick=function(){
				selectAffirm(pointId)
			}
			var url = "${baseurl}rescue/selectTableInfo";
			var org = "<button style='background-image:url(${baseurl}vender/img/trans/btn_color_1.png);background-size:100% 100%;  border:none;' onclick='btnColor(this)'>选    择</button>";
			var data = null;
			rescue(url,data,org);
			
			
		}
		
		function rescue_1(e){
			var ids = e.parentElement.id;
			var id = ids.substring(ids.indexOf("_")+1,ids.length);
			var affirm_btn = document.getElementById('affirm_btn');
			affirm_btn.style.display="none";
			var url = "${baseurl}rescue/selectUnderwayInfo";
			var org = "进行中..";
			var data = {"id":id};
			rescue(url,data,org);
		}
		
		function rescue(url,data,org){
			var car = $("#used_car_info tr");
			var station = $("#station tr");
			for (var i = car.length - 1; i > 1; i--) {
				car[i].remove();
			}
			for (var i = station.length - 1; i > 1; i--) {
				station[i].remove();
			}
			$("#jiuhu").css("display", "block");
			$.ajax({
				data : JSON.stringify(data),
				type : "post",
				contentType:'application/json;charset=UTF-8',//关键是要加上这行
				traditional:true,//这使json格式的字符不会被转码
				dataType : 'json',
				async : false,
				url : url,
				success : function(data) {
					debugger;
					var busDataList = JSON.parse(data.obj[0]);
					var stationDataList = JSON.parse(data.obj[1]);
					for (var i = 0; i < busDataList.length; i++) {
						var busData = busDataList[i];
						$("#used_car_info")
								.append(
										"<tr><td style ='display:none;'>"
												+ busData.jiuhuid
												+ "</td><td>京AD181"
												+ busData.jiuhuid
												+ "</td><td>00:05</td><td>"+org+"</td></tr>");
					}
					for (var i = 0; i < stationDataList.length; i++) {
						var stationData = stationDataList[i];
						$("#station")
								.append(
										"<tr><td style ='display:none;'>"
												+ stationData.stopid
												+ "</td><td>站点"
												+ stationData.stopid
												+ "</td><td>00:03</td><td>"+org+"</td></tr>");
					}
				}

			});
		}

		function btnColor(e) {
			var flag = false;
			if (e.style.backgroundImage.indexOf("btn_color_1.png") > 0) {
				flag = true;
			}
			var tr = e.parentElement.parentElement.parentElement.children;
			for (var i = 2; i < tr.length; i++) {
				tr[i].children[3].firstChild.style.cssText = "background-image: url(${baseurl}vender/img/trans/btn_color_1.png) ; background-size : 100% 100%; border : none;"
			}
			if (flag) {
				e.style.cssText = "background-image: url(${baseurl}vender/img/trans/btn_color_2.png) ; background-size : 100% 100%; border : none;"
			}

		}

		function jiuhuDivClose() {
			$("#jiuhu").css("display", "none");
		}
		
		function selectAffirm(pointId) {
			var jiuhuid = "";
			var stopid = "";
			var button = $(".jiuhuTable tr").find("button");
			for (var i = 0; i < button.length; i++) {
				var image = button[i].style.backgroundImage;
				if (image.indexOf("btn_color_2.png")>0) {
					var id = button[i].parentElement.parentElement.firstChild.textContent;
					var tabId = button[i].parentElement.parentElement.parentElement.parentElement.id;
					if (tabId == "used_car_info") {
						jiuhuid = id;
					} else if (tabId == "station") {
						stopid = id;
					}
				}
			}
			var data = {
					"jiuhuid" : jiuhuid,
					"stopid" : stopid,
					"pointId":pointId
			};
			var url = "${baseurl}rescue/busDispatch";
			$.ajax({
				dataType : "json",
				contentType:'application/json;charset=UTF-8',//关键是要加上这行
				traditional:true,//这使json格式的字符不会被转码
				data : JSON.stringify(data),
				type : "post",
				timeout : 20000,
				url : url,
				success : function(data) {
					if (data.success) {
						$.messager.show({
							title : 'success',
							msg : data.info,
							showType : 'fade',
							timeout : 5000,
						})
					}
					$("#jiuhu").css("display", "none");
				}
			});

		}
	</script>
</body>
</html>
