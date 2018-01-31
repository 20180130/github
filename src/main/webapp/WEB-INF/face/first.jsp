<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/face/common/tag.jsp"%>
  <%
String basePath = request.getContextPath();
String JSESSIONID = request.getSession().getId();
%>
<html>
<head>
<title>智能网联汽车云控平台</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">

<link rel="stylesheet" type="text/css" href="${baseurl}js/easyui/styles/default.css">
    <%@ include file="/WEB-INF/face/common/common_css.jsp"%>
    <%@ include file="/WEB-INF/face/common/common_js.jsp"%>
<style>

.leftmenu{
font-size:18px;
text-align: left;
border:0px solid white;
height:40px;

}
.leftdistance1{
margin-left:5px;
}

.leftdistance2{
margin-left:4px;
}

</style>
<script type="text/javascript">
    var tabOnSelect = function(title) {
		//根据标题获取tab对象
		var currTab = $('#tabs').tabs('getTab', title);
		var iframe = $(currTab.panel('options').content);//获取标签的内容
		
		var src = iframe.attr('src');//获取iframe的src
		//当重新选中tab时将ifram的内容重新加载一遍，目的是获取当前页面的最新内容
		if (src)
			$('#tabs').tabs('update', {
				tab : currTab,
				options : {
					content : createFrame(src)//ifram内容
				}
			});

	};
	var _menus;
	$(function() {//预加载方法
		getTime();
		window.setInterval(getTime, 1000);
		var frameUrl="${baseurl}vender/trafficaccidentmange.html";
		if("${href}"=="m4"){
    		frameUrl = "${baseurl}publictrafficcar/show";
		}else if("${href}"=="m5"){
    		frameUrl = "${baseurl}rescue/show";
		}else if("${href}"=="m6"){
			frameUrl = "${baseurl}login/showManoeuvreconsole";
		}
	    $('#tabs').panel({
	    	content:createFrame(frameUrl)
	    	//content:createFrame('${baseurl}vender/car.html')
	      /* href:url,
	            
	        onLoad:function(){    
	            alert('loaded successfully');    
	        }   */
	    });
		
		/* $('#tabs').tabs('add', {
			title : '欢迎使用',
			content : createFrame('car.html')
		}).tabs({
			//当重新选中tab时将ifram的内容重新加载一遍
			onSelect : tabOnSelect
		}); */
		
		//修改密码
		$('#modifypwd').click(menuclick);

	});

	//退出系统方法
	function logout() {
		//_confirm('您确定要退出本系统吗?',null,
				//function(){
					location.href = '${baseurl}login/logout';
			//	}
		//)
	}
	

	//帮助
	function showhelp(){
	    window.open('${baseurl}help/help.html','帮助文档'); 
	}
	
	function getTime(){
		var date = new Date();
		var y = date.getFullYear();
		var m = date.getMonth()+1;
		var d = date.getDate();
		var h = date.getHours();
		var i = date.getMinutes();
		var s = date.getSeconds();
		$("#sysTime").html(y+"年"+(m>9?m:("0"+m))+"月"+(d>9?d:("0"+d))+"日 "+(h>9?h:("0"+h))+":"+(i>9?i:("0"+i))+":"+(s>9?s:("0"+s)));
	}
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

a{text-decoration : none} 
.system_log{
height:38px;
margin-top:0px;
margin-bottom: 0px;
}

.system_log dt{
height:31px;
border:0px solid white;
}

</style>
<META name="GENERATOR" content="MSHTML 9.00.8112.16540">
</HEAD>

<body style="overflow-y: hidden;background: #333;" class="easyui-layout" scroll="no" >




	<div
		style='background: #000000; height: 50px; padding-top: 2px; color: rgb(255, 255, 255); line-height: 20px; float: left; overflow: hidden; font-family: Verdana, 微软雅黑, 黑体; border: 0px solid white;'
		border="false" style="border:0px solid black;" split="true" region="north">
		<div
			style="border: 0px solid white; float: left; width: 150px; height: 100%; margin-left: 5px;margin-top:6px; border-right: 0px solid #404040;">
			<IMG alt="" src="${baseurl}vender/img/login/topleftmenu.png"
				style="width: 140px; height: 30px;">
		</div>


		<div
			style="border: 0px solid yellow; color: #B8B8B8; float: left; width: 270px; height: 60%; margin-top: 6px; margin-left: 25px; text-align: left; font-size: 20px;">
			启迪智能网联汽车云控平台</div>
		
		
						<div  
			style="border: 0px solid yellow; float: right; width: 85px; height: 30px; margin-left: 20px;margin-top:6px; text-align: right;cursor:pointer;position: absolute;right:120px;" id="createcontroller" >
			<A  style='background:#00b0f0;color: white;border:0px solid white;right:0px;text-align:center;padding-top:5px;width:85px;height:30px;position: absolute;font-size:16px;'  >创建管控</A>

		</div>
		
			<div  
			style="border: 0px solid yellow; float: right; width: 85px; height: 30px; margin-left: 20px;margin-top:6px; text-align: right;cursor:pointer;position: absolute;right:20px;" >
			<A  style='background:#00b0f0;color: white;border:0px solid white;right:0px;text-align:center;padding-top:5px;width:85px;height:30px;position: absolute;font-size:16px;' id="loginOut"  href=javascript:logout()>退出系统</A>

		</div>


		

		

	</div>







	<div style="background: #000; height: 30px;" split="false" border="false" 
		region="south"  >

		<div class="footer" style="background: #333;">
<%-- 			系统版本号：${version_number}&nbsp;&nbsp;&nbsp;发布日期：${version_date} --%>
		</div>
	</div>

	<div style="width: 180px;color: rgb(255, 255, 255);background: #333;" id="west" title="" split="true"
		region="west" hide="true" border="false" >

		<div id="nav" class="easyui-accordion" border="false" fit="true" style="background: #333; height: 30px;">
	
	
	
	<!-- href="javascript:addTab('交通管制信息','/FogManagementSystem//trafficControl.html')"
	 -->
	
 	<dl class="system_log"  style="border:0px solid yellow;" id="m1" value=''>
						<dt style="color: rgb(255, 255, 255);padding-top: 7px;">
							<img class="icon2" src="${baseurl}vender/img/leftmenu/1.png" /> 
							<input type='hidden' value='${baseurl}vender/img/leftmenu/accident.png'>
							
				<%-- 			<a href=javascript:addTab('${sub.menuName }','${baseurl }/${sub.menuUrl }')
												style="color: rgb(255, 255, 255);">
												- ${sub.menuName }</a> --%>
												<a  class="leftmenu"   value='/Console/vender/trafficaccidentmange.html' href=javascript:addTab('事故处理系统','/Console/vender/trafficaccidentmange.html') style="color: rgb(255, 255, 255);" >
												-事故处理系统
												</a>
												<input type='hidden' value='${baseurl}vender/img/leftmenu/1.png'>
						</dt>
	
	</dl>
	<dl class="system_log system_menu"  id="m2" value=''>
						<dt style="color: rgb(255, 255, 255);padding-top: 7px;">
							<img class="icon2" src="${baseurl}vender/img/leftmenu/2.png" /> 
							<input type='hidden' value='${baseurl}vender/img/leftmenu/roadadministrative.png'>
						
							<a  class="leftmenu"  value='/Console/vender/roadmanagecar.html' href=javascript:addTab('路政管理系统','/Console/vender/roadmanagecar.html')
												style="color: rgb(255, 255, 255);">
												-路政管理系统
												</a>
													<input type='hidden' value='${baseurl}vender/img/leftmenu/2.png'>
						</dt>
	
	</dl>
	<dl class="system_log system_menu"  id="m3" value=''>
						<dt style="color: rgb(255, 255, 255);padding-top: 7px;">
							<img class="icon2" src="${baseurl}vender/img/leftmenu/3.png" />
							<input type='hidden' value='${baseurl}vender/img/leftmenu/trafficcontroller.png'>
							<a  class="leftmenu  leftdistance1" value='/Console/vender/publictrafficcar.html' href=javascript:addTab('交通管控系统','/Console/vender/publictrafficcar.html')
												style="color: rgb(255, 255, 255);">
												-交通管控系统
												</a>
												<input type='hidden' value='${baseurl}vender/img/leftmenu/3.png'>
						</dt>
	
	</dl>	
	
	 <%-- <dl class="system_log system_menu" id="m4">
				<dt style="color: rgb(255, 255, 255);">
					<img class="icon2"
						src="${baseurl}vender/img/leftmenu/publictrafficmange.png" /> - <a value = ""
						href="javascript:void(0);" onclick ="addTab('公交管理系统','${baseurl}/publictrafficcar/show')"
												style="color: rgb(255, 255, 255);">
						公交管理系统 </a>
				</dt>

			</dl>
			<dl class="system_log system_menu" id="m5">
				<dt style="color: rgb(255, 255, 255);">
					<img class="icon2"
						src="${baseurl}vender/img/leftmenu/rescuemanage.png" /> - <a
						href="javascript:void(0);" onclick ="addTab('救护管理系统','${baseurl}rescue/show')"
												style="color: rgb(255, 255, 255);">
						救护管理系统 </a>
				</dt>

			</dl>

			<dl class="system_log system_menu" id="m6">
				<dt style="color: rgb(255, 255, 255);">
					<img class="icon2" src="${baseurl}vender/img/leftmenu/accident.png" />- <a 
					href="javascript:void(0);" onclick ="addTab('演习控制台','${baseurl}/login/showManoeuvreconsole')"
												style="color: rgb(255, 255, 255);">
						演习控制台 </a>
				</dt>
 --%>
			</dl>
	
	
	<dl class="system_log system_menu"  id="m4" value=''>
						<dt style="color: rgb(255, 255, 255);padding-top: 7px;">
							<img class="icon2" src="${baseurl}vender/img/leftmenu/4.png" /> 
							<input type='hidden' value='${baseurl}vender/img/leftmenu/publictrafficmange.png'>		
									<a   class="leftmenu leftdistance2" href="javascript:void(0);" value='${baseurl}/publictrafficcar/show' onclick ="addTab('公交管理系统','${baseurl}/publictrafficcar/show')"
												style="color: rgb(255, 255, 255);">
												-公交管理系统
												</a>
												<input type='hidden' value='${baseurl}vender/img/leftmenu/4.png'>
						</dt>
	
	</dl>
	<dl class="system_log system_menu"  id="m5" value=''>
						<dt style="color: rgb(255, 255, 255);padding-top: 7px;">
							<img class="icon2" src="${baseurl}vender/img/leftmenu/5.png" /> 
							<input type='hidden' value='${baseurl}vender/img/leftmenu/rescuemanage.png'>		
									<a  class="leftmenu" value='${baseurl}rescue/show' href="javascript:void(0);" onclick ="addTab('救护管理系统','${baseurl}rescue/show')"
												style="color: rgb(255, 255, 255);">
												-救护管理系统
												</a>
												<input type='hidden' value='${baseurl}vender/img/leftmenu/5.png'>
						</dt>
	
	</dl>	
	
	
		<dl class="system_log system_menu"  id="m6">
						<dt style="color: rgb(255, 255, 255);padding-top: 7px;">
							<img class="icon2" src="${baseurl}vender/img/leftmenu/1.png" /> 
							<input type='hidden' value='${baseurl}vender/img/leftmenu/accident.png'>
								<a  class="leftmenu"  value='${baseurl}/login/showManoeuvreconsole' href="javascript:void(0);" onclick ="addTab('演习控制台','${baseurl}/login/showManoeuvreconsole')"
												style="color: rgb(255, 255, 255);">
												-演习控制台
												</a>
												<input type='hidden' value='${baseurl}vender/img/leftmenu/1.png'>
						</dt>
	
	</dl> 		
		<%-- <c:forEach items="${menuList}" var="menu">
				<c:if test="${menu.hasMenu}">
					<dl class="system_log">
						<dt style="color: rgb(255, 255, 255);">
							<img class="icon1" src="" /><img class="icon2" src="" /> -
							${menu.menuName }<img class="icon3" src="" /><img class="icon4"
								src="" />
						</dt>
						<c:forEach items="${menu.subMenu}" var="sub">
							<c:if test="${sub.hasMenu}">
								<c:choose>
									<c:when test="${not empty sub.menuUrl}">
										<dd style="color: rgb(255, 255, 255);">
											<img class="coin11" src="" /><img class="coin22" src="" /><a
												href=javascript:addTab('${sub.menuName }','${baseurl }/${sub.menuUrl }')
												style="color: rgb(255, 255, 255);">
												- ${sub.menuName }</a><img class="icon5" src="" />
										</dd>
									</c:when>
									<c:otherwise>
										<dd>
											<img class="coin11" src="" /><img class="coin22" src="" /><a
												href=javascript:addTab('${sub.menuName }','${baseurl }/${sub.menuUrl }')
												style="color: rgb(255, 255, 255);">
												- ${sub.menuName }</a><img class="icon5" src="" />
										</dd>
									</c:otherwise>
								</c:choose>
							</c:if>
						</c:forEach>
					</dl>
				</c:if>
			</c:forEach> --%>
		</div>
	</div>

	<div style="background: rgb(238, 238, 238); overflow-y: hidden;"
		id="mainPanle" region="center">
		<div id="tabs" class="easyui-tabs" border="false" fit="true"></div>
	</div>
<input type="text" id="systemmenu" value="${href}">
<input type="text" id="curentid" value="">
</body>
<script type="text/javascript">
$(function(){
    var curentblueimg="";
	var href=$("#systemmenu").val();
	hellle(href);
	$("#"+ href).css("background","#505050");
	//获取白色图标
	var inputimg=$("#"+ href).children().children("input");
	//设置字体颜色
	$("#"+ href).children().children("a").css("color","#99FFFF");
	//获取当前蓝色图图片
	curentblueimg=$("#"+ href).children().children("img").attr("src");
	//替换当前蓝色图标
	$("#"+ href).children().children("img").attr("src",inputimg[0].value);
	
	$("#"+ href).attr("value","1");
	
	
	
/* 	$(".system_log").click(function(){
		$(".system_log").css("background","");
		$(this).css("background","#505050");
		$(this).attr("value","1");
	
	}); */
	
	//鼠标移动到菜单上菜单背景色变白图标切换到白，鼠标移出则背景色图标还原
	var value1="";
	$(".system_log").click(function(){
	
		var validatecurentvalue=$(this).attr("value");
		if(validatecurentvalue!='1'){
		//还原value=1的菜单的图片
		var pppy=$("dl[value ='1']").children().children("input");
		$("dl[value ='1']").children().children("img").attr("src",pppy[1].value);
		$("dl[value ='1']").children().children("a").css("color","rgb(255, 255, 255)");
		$("dl[value ='1']").attr("value","");
		////获取当前蓝色图图片
		curentblueimg=$(this).children().children("img").attr("src");
		//获取当前菜单的白色图标
		var inputimg=$(this).children().children("input");
		//替换当前蓝色图标
		$(this).children().children("img").attr("src",inputimg[0].value);
		//给当前连接文字替换颜色
		$(this).children().children("a").css("color","#99FFFF");
		$(".system_log").attr("value","");
		$(".system_log").css("background","");
		$(this).css("background","#505050");
		$(this).attr("value","1");
		$("#curentid").attr("value",$(this).attr("id"));
		}
	
	});
	
 	var outstyl="";
	$(".system_log").mouseenter(function(){ 
		var value=	$(this).attr("value");
		if(value!='1'){
		outstyl=$(this).css("background-color");
		$(this).css("background-color","#505050");//鼠标移入改变背景颜色  
		}
		  });  


	$(".system_log").mouseleave(function(){  
		var value=	$(this).attr("value");
		if(value!='1'){
		var style=$(this).css("background-color");
		$(this).css("background-color",outstyl);
		}
	  	});  

})



//从地图中进入其他系统界切换当前主界面
function hellle(href){
	
	//$(".system_log").click(function(){
		$(".system_log").css("background","");
		$(this).css("background","#505050");
		$("#"+ href).css("background","#505050");
		var url=$("#"+ href).children().children("a").attr("value");
		var text=$("#"+ href).children().children("a").text();
	//});
	//alert(text+"==="+url);
	
	var iddd=$("#curentid").attr("value");
	if(iddd!=''){
	var aaap=$("dl[id ="+iddd+"]").children().children("input");
	//alert(aaap[0].value);
	
	$("dl[id ="+iddd+"]").children().children("img").attr("src",aaap[0].value);
	$("dl[id ="+iddd+"]").children().children("a").css("color","rgb(255, 255, 255)");
	$("dl[id ="+iddd+"]").attr("value","");
	}
   		$("#"+ href).css("background","#505050");
	//获取白色图标
	var inputimg=$("#"+ href).children().children("input");
	//设置字体颜色
	$("#"+ href).children().children("a").css("color","#99FFFF");
	//获取当前蓝色图图片
	curentblueimg=$("#"+ href).children().children("img").attr("src");
	//替换当前蓝色图标
	$("#"+ href).children().children("img").attr("src",inputimg[0].value);
	
	$("#"+ href).attr("value","1"); 
	
	
	
	addTab(text,url);
}


//隐藏顶层创建图标
function hiddentopimg(){
	//alert("======");
	$("#createcontroller").html("");
	
}
function replaytopimg(){
	//alert("======");
	var pathd='${baseurl}'+"vender/img/login/createcontro.png";
	var img="<IMG  src='"+pathd+"' style='height: 27px;'>";
	//$("#createcontroller").html("");
	$("#createcontroller").html("<A  style='background:#00b0f0;color: white;border:0px solid white;right:0px;text-align:center;padding-top:5px;width:85px;height:30px;position: absolute;font-size:16px;' >创建管控</A>");
	
}

$(function(){
         $.ajax({  
          url:'${baseurl}test/getDistribuList',   
          type:'post',  
          success:function(data){  
        	 // alert(data[0].id);
        	 var themecombo2 =new Array();  
        	  $.each(data,function(i,da){
        		 // alert(da.id+"=="+i);
        		  themecombo2.push({'text':da.text,'id':da.id}); 
        		 // themecombo2.push(da);  
        	  });
        	  $("#themecombo").combobox("loadData", themecombo2); 
        	 // alert(data[0].id);
             /* var themecombo2 =[{ 'text':'请选择','id':''}];  
                 for(var i=0;i<data.length;i++){  
                 themecombo2.push({"text":data[i].title,"id":data[i].id});  
                 }  
             $("#themecombo").combobox("loadData", themecombo2);   */
          }  
         });  
	
})


function selectCity(){
	
	alert("sdfsdfsf");
	
}


function SelectRewardByRewardName(){
	alert("sdfsdsdff");
}

</script>
<script type="text/javascript">  
         window.onload=function(){  
            var olink = document.links;  
            for(var i=0; i< olink.length; i++){  
                olink[i].onmouseover = function(){  
                    window.status = "";  
                    return true;  
                }  
                olink[i].onfocus = function(){  
                    window.status = "";  
                    return true;  
                }  
            }  
        }  
    </script>  
</html>
