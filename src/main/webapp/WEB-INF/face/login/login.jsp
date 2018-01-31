<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/face/common/tag.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
	<base href="${baseurl}">
    <meta charset="UTF-8">  
    <meta name="viewport" content="width = device-width,initial-scale=1">  
    <title></title>  
    <%@ include file="/WEB-INF/face/common/common_css.jsp"%>
    <%@ include file="/WEB-INF/face/common/common_js.jsp"%>
<%
String basePath = request.getContextPath();
String JSESSION = request.getSession().getId();
%>
<link href="${baseurl}vender/css/login.css" type="text/css"
	rel="stylesheet">

<script type="text/javascript" src="${baseurl}vender/js/md5.js"></script>
<link href="${baseurl}vender/css/login.css" type="text/css"
	rel="stylesheet">
<script type="text/javascript">
  	function loginEvent(){
  		var email = $("#email").val();
  		var pwd = $("#pwd").val();
  		var pwdHash = hex_md5(pwd);
  		$.ajax({
            url:"${baseurl}login/selectLoginUser",
            type:"post",
            dataType : "json",
            data:{
            	email:email,
            	password:pwdHash
            },
            success:function(data){
            	if(data.success){
            		window.location.href="${baseurl}login/success.do";
            	}else{
            		$("#error").text("账号或密码错误！");
            	}
            },
            error:function(e){
                alert("错误！！");
            }
        }); 
  		
  	}
	</script>
</head>
<body style="width: 100%">
	<div id="div">
		<div
			style="position: absolute; top: 120px; left: 50px; width: 200px; height: 30px;">
			<p id="error" style="color: red"></p>
		</div>
		<form id="fm"
			action="${baseurl}login/selectLoginUser"
			method="post">
			<table>
				<tr>
					<td id="td_email"><input id="email" name="email" /></td>
				</tr>
				<tr>
					<td id="td_pwd"><input id="pwd" name="password"
						type="password" /></td>
				</tr>
			</table>
			<!-- <div>
	 	<input id = "submit" type="submit" value="ssadasd">
	 </div> -->
		</form>
		<div>
			<img alt="登陆" src="${baseurl}vender/img/btn_login.png"
				onclick="loginEvent()">
		</div>
	</div>

</body>
</html>
