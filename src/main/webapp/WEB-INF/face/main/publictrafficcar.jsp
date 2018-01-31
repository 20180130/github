
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
<title>公交管理系统</title>
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

<script type="text/javascript">
	var div_back = null;
	var div_back1 = null;
	var div_back2 = null;
	var replace_bus_img = null;
	var selectTuoChe_img = null;
	var affirmBtn_1 = null;
	$(function() {
		div_back = document.getElementById('div_back');
		div_back1 = document.getElementById('div_back1');
		div_back2 = document.getElementById('div_back2');
		replace_bus_img = document.getElementById('replace_bus_img');
		selectTuoChe_img = document.getElementById('selectTuoChe_img');
		affirmBtn_1 = document.getElementById('affirmBtn_1');
	})
	/* 轮询 */
		setInterval(function(){
		    Push();
		},3000);
		
		function Push(){
			/*查询事故点及坐标  进行状态  */
			$(function(){
				$.ajax({
			        type:"POST",
			        url:"${baseurl}publictrafficcar/selectAllPoint",
			        data:{},
			        beforeSend:function(){},
			        success: function(data){
			        	if(data.success){
			        		if(data.obj!=null&&data.obj.length>0){
			        			var jsonobj = JSON.parse(data.obj)
				        		for (var i = 0; i < jsonobj.length; i++) {
				        			insertTransPoint(jsonobj[i].id ,jsonobj[i].top, jsonobj[i].left , jsonobj[i].state)
								}
			        		}
			        	}
			        }
			    });
			})
		}
		/* function onAccidentPointClick(){
			$.ajax({
		        type:"POST",
		        url:"${baseurl}publictrafficcar/selectAllPoint",
		        data:{},
		        beforeSend:function(){},
		        success: function(data){
		        	if(data.success){
		        		if(data.obj!=null&&data.obj.length>0){
		        			var jsonobj = JSON.parse(data.obj)
			        		for (var i = 0; i < jsonobj.length; i++) {
			        			insertTransPoint(jsonobj[i].id ,jsonobj[i].top, jsonobj[i].left , jsonobj[i].state)
							}
		        		}
		        	}
		        }
		    });
		} */
		/*  在页面添加事故点*/
		function insertTransPoint(pointId , top , left , state){
			var rescuePoints = $(".accidentPoint");
			rescuePoints.remove();
			$(".page").append(
					"<div id='accidentPoint_"+pointId+"' class ='accidentPoint' style = 'position: absolute; top: "+top+"px ; left : "+left+"px'>"
					+ "<img alt='救护点' src ='${baseurl}vender/img/trans/accident_point.png'"
					+" onclick='onAccidentPointClick_"+state+"("+pointId+")'/></div>");
		}
	/*  根据事件状态  动态添加事故点图标的点击事件*/	
	function onAccidentPointClick_0(pointId) {
		div_back.style.display = "block";
		$("#replace_bus_img").on("click",function(){
			/* state:0 ,事件未指派应急公交车辆 */
			replace_bus_onclick_0(pointId);
		})
		$("#selectTuoChe_div").on("click",function(){
			/*  暂不考虑分状态查询*/
			selectTuoChe_onclick();
		})
	}
	
	/*  根据事件状态  动态添加事故点图标的点击事件*/	
	function onAccidentPointClick_1(pointId) {
		div_back.style.display = "block";
		$("#replace_bus_img").on("click",function(){
			/* state:0 ,事件正在进行中 */
			replace_bus_onclick_1(pointId);
		})
		$("#selectTuoChe_div").on("click",function(){
			selectTuoChe_onclick();
		})
	}
	
	/*  选择车辆鼠标经过触发事件*/
	function replace_bus_onMouseOver() {
		replace_bus_img.src = "${baseurl}vender/img/trans/replace_bus_1.png";
	}
	/*  选择车辆鼠标移出触发事件*/
	function replace_bus_onMouseOut() {
		replace_bus_img.src = "${baseurl}vender/img/trans/replace_bus_0.png";
	}
	/*  选择拖车鼠标经过触发事件*/
	function selectTuoChe_onMouseOver() {
		selectTuoChe_img.src = "${baseurl}vender/img/trans/tuoche_1.png";
	}
	/*  选择拖车鼠标移出触发事件*/
	function selectTuoChe_onMouseOut() {
		selectTuoChe_img.src = "${baseurl}vender/img/trans/tuoche_0.png";
	}
	
	/*  应急公交点击事件  查询可使用车辆*/
	function replace_bus_onclick_0(pointId) {
		div_back.style.display = "none";
		div_back1.style.display = "block";
		affirmBtn_1.style.display = "block";
		affirmBtn_1.onclick = function(){div_back1_table_affirm(pointId)};
		var url ="${baseurl}/publictrafficcar/selectUsingBus";
		var trsEle = $("#div_back1_table tr");
		var tabEle = $("#div_back1_table");
		var name ="京AD181";
		var times ="00:03";
		var types = "<button style='background-image:url(${baseurl}vender/img/trans/btn_color_1.png);background-size:100% 100%;  border:none;' onclick='changeBtnColor(this)'>选择</button>";
		var data = null;
		appendEleToTable(url,data,trsEle,tabEle,name,times,types);
	}
	
	/*  应急公交点击事件  查询事件进行中时  正在使用的车辆*/
	function replace_bus_onclick_1(pointId) {
		div_back.style.display = "none";
		div_back1.style.display = "block";
		affirmBtn_1.style.display = "none";
		var url ="${baseurl}/publictrafficcar/selectUsedBus";
		var trsEle = $("#div_back1_table tr");
		var tabEle = $("#div_back1_table");
		var name ="京AD181";
		var times ="00:03";
		var types = "进行中..";
		var data = {"pointId":pointId};
		appendEleToTable(url,data,trsEle,tabEle,name,times,types);
	}
	/*  在表格中添加元素*/
	function appendEleToTable(url,data,trsEle,tabEle,name,times,types){
		$
		.ajax({
			url : url,
			type : "post",
			dataType : "json",
			async : false,
			data : JSON.stringify(data),
			contentType : 'application/json;charset=UTF-8',//关键是要加上这行
			traditional : true,//这使json格式的字符不会被转码
			success : function(datasjson) {
				if (datasjson.success) {
					for (var i = trsEle.length - 1; i > 1; i--) {
						trsEle[i].remove();
					}
					var datas = JSON.parse(datasjson.obj);
					for (var i = 0; i < datas.length; i++) {
						var data = datas[i];
						tabEle.append(
										"<tr><td style ='display:none;'>"+ data.id +"</td><td>"+ name + data.id+" </td><td>"+ times +"</td><td align='right'>"+ types +"</td></tr>");
					}
				}
			}
		});
		
		
		
	}
	
	/*  查询可使用的拖车  用与指派拖车*/
	function selectTuoChe_onclick() {
		div_back.style.display = "none";
		div_back2.style.display = "block";
		var url ="${baseurl}/publictrafficcar/selectTuoChe";
		var trsEle = $("#div_back2_table tr");
		var tabEle = $("#div_back2_table");
		var name ="津WE181";
		var times ="00:04";
		var types = "<button style='background-image:url(${baseurl}vender/img/trans/btn_color_1.png);background-size:100% 100%;  border:none;' onclick='changeBtnColor(this)'>选择</button>";
		var data = null;
		appendEleToTable(url,data,trsEle,tabEle,name,times,types);
	}
	
	
	function close_div_back() {
		div_back.style.display = "none";
	}

	function close_div_back1() {
		div_back1.style.display = "none";
	}

	function close_div_back2() {
		div_back2.style.display = "none";
	}
	
	/*  点击选择图标  改变图标颜色*/
	function changeBtnColor(e) {
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
	
	/*  车辆替换  选择确认事件*/
	function div_back1_table_affirm(pointId) {
		var busId = null;
		var button = $("#div_back1_table tr").find("button");
		for (var i = 0; i < button.length; i++) {
			var image = button[i].style.backgroundImage;
			if (image.indexOf("btn_color_2.png") > 0) {
				busId = button[i].parentElement.parentElement.firstChild.textContent;
			}
		}
		var url = "${baseurl}/publictrafficcar/submitReplaceBus";
		var data = {
			"busId" : busId,
			"pointId":pointId
		};
		var org = "bus";
		submit_id(url, data, org)
	}
	
	/*  选择拖车 选择确认事件*/
	function div_back2_table_affirm() {
		var tuocheId = null;
		var button = $("#div_back2_table tr").find("button");
		for (var i = 0; i < button.length; i++) {
			var image = button[i].style.backgroundImage;
			if (image.indexOf("btn_color_2.png") > 0) {
				tuocheId = button[i].parentElement.parentElement.firstChild.textContent;
			}
		}
		var url = "${baseurl}/publictrafficcar/submitTuoChe";
		var data = {
			"tuocheId" : tuocheId
		};
		var org = "tuoche";
		submit_id(url, data, org)

	}
	
	
	/* 提交 */
	function submit_id(url, data, org) {
		$.ajax({
			dataType : "json",
			contentType : 'application/json;charset=UTF-8',//关键是要加上这行
			traditional : true,//这使json格式的字符不会被转码
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
				if (org == "bus") {
					div_back1.style.display = "none";
				} else if (org == "tuoche") {
					div_back2.style.display = "none";
				}
			}
		});
	}
</script>
</head>
<body>
	<div class="page" style="position: relative;">
		<%-- <div id="accident_point"
			style="position: absolute; top: 45%; left: 50%;"
			onclick="onAccidentPointClick()">
			<img alt="事故点" src="${baseurl}vender/img/trans/accident_point.png">
		</div> --%>
		<div id="div_back"
			style=" width :20% ;height:20%;display:none;
				position: absolute;top:25%;left: 32%;
				background-image: url('${baseurl}vender/img/trans/div_back.png');
				background-size:100% 100%;">
			<div id="replace_bus_div" style="margin-top: 15%; margin-left: 12%">
				<img id="replace_bus_img" alt="替换车辆"
					src="${baseurl}vender/img/trans/replace_bus_0.png"
					onMouseOver="replace_bus_onMouseOver()"
					onMouseOut="replace_bus_onMouseOut()" />
					<!-- onclick="replace_bus_onclick()" -->
			</div>
			<div id="selectTuoChe_div" style="margin-top: 5%; margin-left: 12%">
				<img id="selectTuoChe_img" alt="选择拖车"
					src="${baseurl}vender/img/trans/tuoche_0.png"
					onclick="selectTuoChe_onclick()"
					onMouseOver="selectTuoChe_onMouseOver()"
					onMouseOut="selectTuoChe_onMouseOut()" />
			</div>
			<div id="close_div" style="position: absolute; top: 5%; left: 91%">
				<img alt="关闭" src="${baseurl}vender/img/trans/btn.png"
					onclick="close_div_back()" />
			</div>
		</div>

		<div id="div_back1"
			style=" width :30% ;height:28%;display:none;
				position: absolute;top:20%;left: 30%;
				background-image: url('${baseurl}vender/img/trans/div_back_1_2.png');
				background-size:100% 100%;">
			<div>
				<table id="div_back1_table"
					style="border-collapse: separate; border-spacing: 45px 15px; width: 100%; margin-top: 4%">
					<tr>
						<th colspan="4" align="left"
							style="border-bottom: 1px solid black; width: 100%; padding-bottom: 7px;">
							可用车辆列表</th>
					</tr>
					<tr>
						<td style="display: none">ID</td>
						<td align="left">车辆</td>
						<td align="left">预计用时</td>
						<td align="right">操作</td>
					</tr>
				</table>
				<table style="margin-top: 5%; width: 100%">
					<tr style="width: 100%">
						<td><button id = "affirmBtn_1"
								style=" width:20%;height:auto; margin-left: 40%; background-image: url(${baseurl}vender/img/trans/btn_color_1.png); background-size:100% 100%; border:none;"
								>确认选择</button></td>
					</tr>
				</table>
			</div>
			<div id="close_div1" style="position: absolute; top: 5%; left: 92%"
				onclick="close_div_back1()">
				<img alt="关闭" src="${baseurl}vender/img/trans/btn.png" />
			</div>
		</div>

		<div id="div_back2"
			style=" width :30% ;height:28%;display:none;
				position: absolute;top:20%;left: 30%;
				background-image: url('${baseurl}vender/img/trans/div_back_1_2.png');
				background-size:100% 100%;">
			<div>
				<table id="div_back2_table"
					style="border-collapse: separate; border-spacing: 45px 15px; width: 100%; margin-top: 4%">
					<tr>
						<th colspan="4" align="left"
							style="border-bottom: 1px solid black; width: 100%; padding-bottom: 7px;">
							可用车辆列表</th>
					</tr>
					<tr>
						<td style="display: none">ID</td>
						<td align="left">车辆</td>
						<td align="left">预计用时</td>
						<td align="right">操作</td>
					</tr>
				</table>
				<table style="margin-top: 5%; width: 100%">
					<tr style="width: 100%">
						<td><button id ="affirmBtn_2"
								style=" width:20%;height:auto; margin-left: 40%; background-image: url(${baseurl}vender/img/trans/btn_color_1.png); background-size:100% 100%; border:none;"
								onclick="div_back2_table_affirm()">确认选择</button></td>
					</tr>
				</table>
			</div>
			<div id="close_div2" style="position: absolute; top: 5%; left: 92%"
				onclick="close_div_back2()">
				<img alt="关闭" src="${baseurl}vender/img/trans/btn.png" />
			</div>
		</div>
	</div>
</body>
</html>
