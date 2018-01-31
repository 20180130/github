<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String basePath = request.getContextPath();
String JSESSIONID = request.getSession().getId();
%>

<!DOCTYPE HTML>
<html>
<head>
	<base href="<%=basePath%>">
    <meta charset="UTF-8">  
    <meta name="viewport" content="width = device-width,initial-scale=1">  
    <title></title>  
  	<script src="<%=basePath%>/vender/js/jquery.min-v=2.1.4.js"></script>
    <link href="<%=basePath%>/vender/css/login.css" type="text/css" rel="stylesheet">  
  	<script type="text/javascript">
  	
  	function loginEvent(){
  		var jsessionid = "<%=JSESSIONID%>";
  		var email = $("#email").val();
  		var pwd = $("#pwd").val();
  		var token = "";
  		//window.location.href="${pageContext.request.contextPath}/login/skip?bool=true";
  		//$("#fm").submit();
  		$.ajax({
            url:"${pageContext.request.contextPath}/login/selectLoginUser",
            type:"post",
            dataType : "json",
            data:{
            	email:email,
            	password:pwd,
            	jsessionid:jsessionid,
            	token:token
            },
            success:function(data){
            	window.location.href="${pageContext.request.contextPath}/login/skip?bool="+data.success;
            },
            error:function(e){
                alert("错误！！");
            }
        }); 
  		
  		
  	}
	</script>
</head> 
<body style="width: 100%">
<div id = "div">
<form id = "fm" action="http://localhost:8080/Console/login/selectLoginUser" method="post">
	<table>
	 	<tr>
	 		<td id="td_email">
	 			<input id = "email" name = "email"/>
	 		</td>
	 	</tr>
	 	<tr>
	 		<td id="td_pwd">
	 			<input id = "pwd" name = "password" />
	 		</td>
	 	</tr>
	 </table>
	 <!-- <div>
	 	<input id = "submit" type="submit" value="ssadasd">
	 </div> -->
</form>
	 <div>
	 	<img alt="登陆" src="<%=basePath%>/vender/img/btn_login.png" onclick="loginEvent()" >
	 </div>
</div>
	 
</body>
</html>