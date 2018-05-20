<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags"  prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户登陆界面</title>
</head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/easyui/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript">
	
	

</script>

<body>

		<form id="ff" method="post" action="UserAction_Login"> 
			<div> 
				<label for="name">姓名:</label> 
				<input class="easyui-validatebox" type="text" name="username" data-options="required:true" /> 
			</div> 
			<div> 
				<label for="password">密码:</label> 
				<input class="easyui-validatebox" type="password" name="password" data-options="required:true" /> 
			</div>
			<div>
					请输入验证码：<input  type="text" name="checkcode"/>
					<img id="loginform:vCode" src="${pageContext.request.contextPath }/validatecode.jsp"
							onclick="javascript:document.getElementById('loginform:vCode').src='${pageContext.request.contextPath }/validatecode.jsp?'+Math.random();" />
			</div>
			 <div> 
				<input  type="submit" value="登陆"/>
				<s:actionerror/>
			</div>
		</form>
		

</body>
</html>