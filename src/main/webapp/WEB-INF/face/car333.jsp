<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style type="text/css">
body, html, #allmap {
	width: 100%;
	height: 100%;
	overflow: hidden;
	margin: 0;
	font-family: "微软雅黑";
}

.anchorBL {
	display: none;
}
</style>
<script type="text/javascript" src="${baseurl}js/jquery-1.7.min.js"></script>
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=bxpu6nOOfgfqP2DgNMYGFdORugxzw07d"></script>
<!--加载检索信息窗口-->
<script type="text/javascript"
	src="http://api.map.baidu.com/library/SearchInfoWindow/1.4/src/SearchInfoWindow_min.js"></script>
<link rel="stylesheet"
	href="http://api.map.baidu.com/library/SearchInfoWindow/1.4/src/SearchInfoWindow_min.css" />
<script type="text/javascript"
	src="http://api.map.baidu.com/library/TextIconOverlay/1.2/src/TextIconOverlay_min.js"></script>
<script type="text/javascript"
	src="http://api.map.baidu.com/library/MarkerClusterer/1.2/src/MarkerClusterer_min.js"></script>
	<!--加载鼠标绘制工具-->
<script type="text/javascript" src="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.js"></script>
<link rel="stylesheet" href="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.css" />
<title>车辆运行轨迹测试</title>
<script src="http://c.cnzz.com/core.php"></script>
<script type="text/javascript">
	//在此处进行小车经过点的初始化操作 
	$(function() {
		var car1Image1 = "http://sandbox.runjs.cn/uploads/rs/101/wmbvrxnx/kache.png";
		var car3Image1 = "http://developer.baidu.com/map/jsdemo/img/car.png";
		var guankong1 = new BMap.Marker(new BMap.Point(116.344749,39.998589),{zIndex: 1});
		guankong1.setRotation(0);
		var guankong2 = new BMap.Marker(new BMap.Point(116.348199,39.998692),{zIndex: 1});
		guankong2.setRotation(0);
		var polyline = new BMap.Polyline([
		              					new BMap.Point(116.344749,39.998589),//起始点的经纬度
		              					new BMap.Point(116.348199,39.998692) //终止点的经纬度
		              			], {
		              				strokeColor : "red",//设置颜色 
		              				strokeWeight : 3, //宽度
		              				strokeOpacity : 1
		              			});//透明度
		var car1pace = "100km/h";
		var car2pace = "50km/h";
		var car1angle = 0;
		var car2angle = 0;
		//1查询一共有几辆车
		var car_num=2;
		var interval1 = '';
		var interval2 = '';
		var interval3 = '';
		for(var i=0;i<=car_num;i++){
			eval("var carMk" + i + "='';");
		}
		//2.常见车辆轨迹集合
		for(var i=0;i<=car_num;i++){
				eval("var list" + i + "=[];");				
		}
		//判断每个小车的经过点的个数
		for(var i=0;i<=car_num;i++){
				eval("var listLast" + i + "='';");		
		}
		eval("var endLong = '';");
		eval("var endLat = '';");
		//2.车辆轨迹的起止点
		for(var i=0;i<=car_num;i++){
				eval("var startLong" + i + "= '';");
				eval("var startLat" + i + " = '';");
				eval("var endLong" + i + "= '';");
				eval("var endLat" + i + "= '';");
				eval("var direction" + i + "= '';");
		}
		var rectangle = new BMap.Polygon([
		                  			    new BMap.Point(116.344651,39.999428),
		                  			    new BMap.Point(116.34731,39.999656),
		                  			    new BMap.Point(116.347256,39.99815),
		                  			    new BMap.Point(116.344938,39.997957)
		                  			], {strokeColor:"red", fillColor:"white", strokeWeight:2, strokeOpacity:1,fillOpacity: 0.9, zIndex:9999 });  //创建矩形
	    var bing = new BMap.Polygon([
			                  			new BMap.Point(116.346528,39.999107),
			                  		    new BMap.Point(116.347642,39.998962),
			                  			new BMap.Point(116.346968,39.998257),
			                  			new BMap.Point(116.346088,39.998264)
			                  	    ], {strokeColor:"blue", fillColor:"white", strokeWeight:2, strokeOpacity:0.5,fillOpacity: 0.9, zIndex:9999 });  //创建矩形	 
	    var   forbidIcon = new BMap.Icon("images/forbidIcon.jpeg",
			      						new BMap.Size(60, 60), {
			      							imageOffset : new BMap.Size(0, 0)
			      						});//卡车
	    var forbidMk = new BMap.Marker(new BMap.Point(116.344704,39.998305),//起始点的经纬度
			                  			{
			                  				icon : forbidIcon,
			                  				zIndex: 1
			                  			});
	    var   deng1 = new BMap.Icon("images/deng.png",
					new BMap.Size(60, 60), {
						imageOffset : new BMap.Size(0, 0)
					});//卡车
        var deng1Mk = new BMap.Marker(new BMap.Point(116.343159,39.998768),//起始点的经纬度
      			{
      				icon : deng1,
      				zIndex: 1
      			});				
		var linesPoints = null;
		// 百度地图API功能
		var map = new BMap.Map('allmap'); // 创建Map实例
		map.centerAndZoom(new BMap.Point(116.344974, 39.998561), 18); 
		// 初始化地图,设置中心点坐标和地图级别
// 		map.addControl(new BMap.MapTypeControl()); //添加地图类型控件
		map.disableDragging(); //禁止拖拽
        map.addOverlay(deng1Mk); 
		//获取点击位置的经纬度
		var pt = null;
		 		map.addEventListener("click",function(e){
 		 	        alert(e.point.lng+","+ e.point.lat);
		         });
		var myIcon = '';
		var i = 0;
		var j = 0;
		var z = 0;
		var label;
		var label1;
		var label2;
		function goWay() {
			var v = 0;
// 			for(var v=0;v<=car_num;v++){
				$.ajax({
					async : false,
					type : "GET", //提交方式  
					url : "${baseurl}getCarJson",//路径  
					data : {
						type : v
					},//数据，这里使用的是Json格式进行传输  
					success : function(result) {//返回数据根据结果进行相应的处理  
						var str = result;
						var obj = eval('(' + str + ')');
						if (obj.length > 0) {
							for (var j = 0; j <=obj.length-1; j++) {
								var placeStr = '{Long :' + obj[j].info1 + ',Lat :'
										+ obj[j].info2 + ',direction :' + obj[j].info3
										+ '}';
								var placeObj = eval('(' + placeStr + ')');
									eval("list" + (v) + "["+j+"]="+'(' + placeStr + ')'+";");
							}
						}
		
					}
				});
 				    eval("listLast" + (v) + "=list" + (v)+".length-1;");
					eval("var carNum = list" + (v)+".length;");// 					alert(carNum);

					try {
						myIcon = new BMap.Icon(eval("car"+(v+1)+"Image1"),
								new BMap.Size(60, 25), {
									imageOffset : new BMap.Size(0, 0)
								});//卡车
 				    } catch (e) {
 				    	
 				    }finally{
 	 						if (carNum > 0) {
 	 							eval("startLong" + (v)+ " = endLong;");
 	 	 						eval("startLat" + (v)+ " = endLat;");
 	 	 						eval("endLong" + (v)+ " = list" + (v)+ "["+(i+1)+"]"+".Long;");
 	 	 						eval("endLat" + (v)+ " = list" + (v)+ "["+(i+1)+"]"+".Lat;");
 	 	 						eval("direction" + (v)+ " = list" + (v)+ "["+(i+1)+"]"+".direction;");
 	 						i++;
 	 						}
 	 						eval("drawIcon"+v+"(startLong"+(v)+",startLat"+(v)+",endLong"+(v)+",endLat"+(v)+",direction"+(v)+","+(v)+");");
 	 				   
 				    }	    
// 	 		}
		}
		function goWay1() {
			var v = 1;
// 			for(var v=0;v<=car_num;v++){
				$.ajax({
					async : false,
					type : "GET", //提交方式  
					url : "${baseurl}getCarJson",//路径  
					data : {
						type : v
					},//数据，这里使用的是Json格式进行传输  
					success : function(result) {//返回数据根据结果进行相应的处理  
						var str = result;
						var obj = eval('(' + str + ')');
						if (obj.length > 0) {
							for (var j = 0; j <=obj.length-1; j++) {
								var placeStr = '{Long :' + obj[j].info1 + ',Lat :'
										+ obj[j].info2 + ',direction :' + obj[j].info3
										+ '}';
								var placeObj = eval('(' + placeStr + ')');
									eval("list" + (v) + "["+j+"]="+'(' + placeStr + ')'+";");
							}
						}
		
					}
				});
 				    eval("listLast" + (v) + "=list" + (v)+".length-1;");
					eval("var carNum = list" + (v)+".length;");// 					alert(carNum);

					try {
						myIcon = new BMap.Icon(eval("car"+(v+1)+"Image1"),
								new BMap.Size(60, 25), {
									imageOffset : new BMap.Size(0, 0)
								});//卡车
 				    } catch (e) {
 				    	
 				    }finally{
 	 						if (carNum > 0) {
 	 							eval("startLong" + (v)+ " = endLong;");
 	 	 						eval("startLat" + (v)+ " = endLat;");
 	 	 						eval("endLong" + (v)+ " = list" + (v)+ "["+(j+1)+"]"+".Long;");
 	 	 						eval("endLat" + (v)+ " = list" + (v)+ "["+(j+1)+"]"+".Lat;");
 	 	 						eval("direction" + (v)+ " = list" + (v)+ "["+(j+1)+"]"+".direction;");
 	 						j++;
 	 						}
 	 						eval("drawIcon"+v+"(startLong"+(v)+",startLat"+(v)+",endLong"+(v)+",endLat"+(v)+",direction"+(v)+","+(v)+");");
 	 				   
 				    }	    
// 	 		}
		}function goWay2() {
			var v = 2;
// 			for(var v=0;v<=car_num;v++){
				$.ajax({
					async : false,
					type : "GET", //提交方式  
					url : "${baseurl}getCarJson",//路径  
					data : {
						type : v
					},//数据，这里使用的是Json格式进行传输  
					success : function(result) {//返回数据根据结果进行相应的处理  
						var str = result;
						var obj = eval('(' + str + ')');
						if (obj.length > 0) {
							for (var j = 0; j <=obj.length-1; j++) {
								var placeStr = '{Long :' + obj[j].info1 + ',Lat :'
										+ obj[j].info2 + ',direction :' + obj[j].info3
										+ '}';
								var placeObj = eval('(' + placeStr + ')');
									eval("list" + (v) + "["+j+"]="+'(' + placeStr + ')'+";");
							}
						}
		
					}
				});
 				    eval("listLast" + (v) + "=list" + (v)+".length-1;");
					eval("var carNum = list" + (v)+".length;");// 					alert(carNum);

					try {
						myIcon = new BMap.Icon(eval("car"+(v+1)+"Image1"),
								new BMap.Size(60, 25), {
									imageOffset : new BMap.Size(0, 0)
								});//卡车
 				    } catch (e) {
 				    	
 				    }finally{
 	 						if (carNum > 0) {
 	 							eval("startLong" + (v)+ " = endLong;");
 	 	 						eval("startLat" + (v)+ " = endLat;");
 	 	 						eval("endLong" + (v)+ " = list" + (v)+ "["+(z+1)+"]"+".Long;");
 	 	 						eval("endLat" + (v)+ " = list" + (v)+ "["+(z+1)+"]"+".Lat;");
 	 	 						eval("direction" + (v)+ " = list" + (v)+ "["+(z+1)+"]"+".direction;");
 	 						z++;
 	 						}
 	 						eval("drawIcon"+v+"(startLong"+(v)+",startLat"+(v)+",endLong"+(v)+",endLat"+(v)+",direction"+(v)+","+(v)+");");
 	 				   
 				    }	    
// 	 		}
		}
		function drawIcon0(startLong, startLat, endLong, endLat, direction,n) {
			    var no = "carMk"+n; 
				var point = new BMap.Point(endLong, endLat);
				var opts = {
						 position : point,    // 指定文本标注所在的地理位置
						 offset   : new BMap.Size(-50, -30)    //设置文本偏移量
						}
				if (eval(no)) {
					map.removeOverlay(carMk0);
				}
				carMk0 = new BMap.Marker(new BMap.Point(endLong, endLat),//起始点的经纬度
				{
					icon : myIcon,
					zIndex: 1
				});
				carMk0.setRotation(direction);
				var label = new BMap.Label("车辆牌照:粤A30000<br/>经度:"+endLong+",纬度:"+endLat+"<br/>当前速度:"+car1pace+"<br/>路程预计:2km<br/>车辆类型:中型载客汽车",{offset:new BMap.Size(0,-100)});
			    label.setStyle({border:"1px solid rgb(204, 204, 204)",color: "rgb(0, 0, 0)",borderRadius:"10px",padding:"5px",background:"rgb(255, 255, 255)",});
			    carMk0.setLabel(label);
				map.addOverlay(carMk0);
				drawGreenLine(startLong, startLat, endLong, endLat);
		}
		function drawGreenLine(startLong, startLat, endLong, endLat) {
			var polyline = new BMap.Polyline([
			              					new BMap.Point(startLong, startLat),//起始点的经纬度
			              					new BMap.Point(endLong, endLat) //终止点的经纬度
			              			], {
			              				strokeColor : "write",//设置颜色 
			              				strokeWeight : 3, //宽度
			              				strokeOpacity : 1
			              			});//透明度
			              			map.addOverlay(polyline);
		}
		function drawIcon1(startLong, startLat, endLong, endLat, direction,n) {
			    var no = "carMk"+n; 
				var point = new BMap.Point(endLong, endLat);
				var opts = {
						 position : point,    // 指定文本标注所在的地理位置
						 offset   : new BMap.Size(-50, -30)    //设置文本偏移量
						}
				if (eval(no)) {
					map.removeOverlay(carMk1);
				}
				carMk1 = new BMap.Marker(new BMap.Point(endLong, endLat),//起始点的经纬度
				{
					icon : myIcon,
					zIndex: 1
				});
				carMk1.setRotation(direction); 
				var label = new BMap.Label("车辆牌照:粤A32222<br/>经度:"+endLong+",纬度:"+endLat+"<br/>当前速度:"+car1pace+"<br/>路程预计:2km<br/>车辆类型:中型载客汽车",{offset:new BMap.Size(0,-100)});
			    label.setStyle({border:"1px solid rgb(204, 204, 204)",color: "rgb(0, 0, 0)",borderRadius:"10px",padding:"5px",background:"rgb(255, 255, 255)",});
			    carMk1.setLabel(label);
				map.addOverlay(carMk1);
				drawGreenLine(startLong, startLat, endLong, endLat);
	    }
		function drawIcon2(startLong, startLat, endLong, endLat, direction,n) {
			 var no = "carMk"+n; 
			var point = new BMap.Point(endLong, endLat);
			var opts = {
					 position : point,    // 指定文本标注所在的地理位置
					 offset   : new BMap.Size(-50, -30) ,   //设置文本偏移量,
			         zIndex: 1
					}
			if (eval(no)) {
				map.removeOverlay(carMk2);
			}
			carMk2 = new BMap.Marker(new BMap.Point(endLong, endLat),//起始点的经纬度
			{
				icon : myIcon,
				zIndex: 1
			});
			carMk2.setRotation(direction);
			var label = new BMap.Label("车辆牌照:粤A30111<br/>经度:"+endLong+",纬度:"+endLat+"<br/>当前速度:"+car2pace+"<br/>路程预计:2km<br/>车辆类型:小型载客汽车",{offset:new BMap.Size(0,-100)});
		    label.setStyle({border:"1px solid rgb(204, 204, 204)",color: "rgb(0, 0, 0)",borderRadius:"10px",padding:"5px",background:"rgb(255, 255, 255)",});
		    carMk2.setLabel(label);
			map.addOverlay(carMk2);
			drawGreenLine(startLong, startLat, endLong, endLat);
	}
		$("[name='start']").live("click",function(){
			interval1 = setInterval(goWay, 500);
 			interval2 = setInterval(goWay1, 500);
 			interval3 = setInterval(goWay2, 500);
		});
		$("[name='reset']").live("click",function(){
			clearInterval(interval1);
			clearInterval(interval2);
			clearInterval(interval3);
			window.location.reload();//刷新当前页面.
		});
		$("[name='end']").live("click",function(){
			clearInterval(interval1);
			clearInterval(interval2);
			clearInterval(interval3);
		});
		$("[name='wuduan']").live("click",function(){
			    map.addOverlay(rectangle); 
		});
		$("[name='jiechu']").live("click",function(){
			    map.removeOverlay(rectangle); 
		});
		$("[name='bingdong']").live("click",function(){
		    map.addOverlay(bing); 
		});
		$("[name='bingdongjiechu']").live("click",function(){
			 map.removeOverlay(bing); 
		});
		$("[name='kaideng']").live("click",function(){
			 car1Image1 = "http://sandbox.runjs.cn/uploads/rs/101/wmbvrxnx/kache.png";
			 car3Image1 = "http://developer.baidu.com/map/jsdemo/img/car.png";
			 var myIcon = new BMap.Icon(car3Image1,
						new BMap.Size(60, 25), {
							imageOffset : new BMap.Size(0, 0)
						});//卡车
			 carMk2.setRotation(0);
			 carMk2.setIcon(myIcon);
			 myIcon = new BMap.Icon(car1Image1,
						new BMap.Size(60, 25), {
							imageOffset : new BMap.Size(0, 0)
						});//卡车
			 carMk0.setRotation(0);
			 carMk0.setIcon(myIcon);

			 			
		});
		$("[name='guandeng']").live("click",function(){
			 car1Image1 = "http://sandbox.runjs.cn/uploads/rs/101/wmbvrxnx/kache.png";
			 car3Image1 = "http://developer.baidu.com/map/jsdemo/img/car.png";
		});
		$("[name='jiansu']").live("click",function(){
			 car1pace = "50km/h";
			 car2pace = "25km/h";
		});
		$("[name='quxiaojiansu']").live("click",function(){
			 car1pace = "100km/h";
			 car2pace = "50km/h";
		});
		$("[name='forbidMk']").live("click",function(){
			forbidMk.addEventListener("click",function(e){
// 		 	        alert('详情');
	         });
			map.addOverlay(forbidMk);
		    map.addOverlay(guankong1);
			map.addOverlay(guankong2);
			map.addOverlay(polyline);
		drawRedLine(116.344749,39.998589,116.348199,39.998692);
		});
		$("[name='jiechuforbidMk']").live("click",function(){
			 map.removeOverlay(forbidMk); 
			 map.removeOverlay(guankong1);
			 map.removeOverlay(guankong2);
			 map.removeOverlay(polyline);
		});
		$("[name='dahua']").live("click",function(){
			carMk0.setRotation(-30);
			carMk2.setRotation(-30);
			carMk0.setRotation(0);
			carMk2.setRotation(0);
		});
	});

</script>

</head>
<body>
		<div style="height:90px;">监控启动:<button  name="start" type="button" >监控启动</button>重置:<button  name="reset" type="button" >重置</button>监控停止:<button  name="end" type="button" >监控停止</button>模拟降雾:<button  name="wuduan" type="button" >模拟降雾</button>模拟大雾解除:<button  name="jiechu" type="button" >模拟大雾解除</button>模拟结冰:<button  name="bingdong" type="button" >模拟冰冻</button>模拟结冰解除:<button  name="bingdongjiechu" type="button" >模拟冰冻解除</button>
		<br/>模拟车辆开灯:<button  name="kaideng" type="button" >模拟车辆开灯</button>模拟车辆关灯:<button  name="guandeng" type="button" >模拟车辆关灯</button>模拟车辆减速:<button  name="jiansu" type="button" >模拟车辆减速</button>模拟车辆减速取消:<button  name="quxiaojiansu" type="button" >模拟车辆减速取消</button>
		<br/>模拟车辆限行:<button  name="forbidMk" type="button" >模拟车辆限行</button>模拟车辆放行:<button  name="jiechuforbidMk" type="button" >模拟车辆放行</button>模拟车辆打滑:<button  name="dahua" type="button" >模拟车辆打滑</button></div>
		
		<div id="allmap"></div>
	
	
</body>
</html>
