<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>tabs</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/easyui/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/easyui/jquery.easyui.min.js"></script>

<script type="text/javascript">

	function doshow()
	{
		$.messager.show({
			
			title:"提示框",
			msg:'欢迎登陆图书管理系统',
			
		});
	}
	
	function editPassword()
	{
		$("#editPwdWindow").window("open");
	}
	function closeWindow()
	{
		$("#editPwdWindow").window("close");
	}
	
	function editPasswordFormSubmit()
	{
		/* var newpass=document.getElementById("txtNewPass");
		var repass=document.getElementById("txtRePass");
		if(newpass.value!=repass.value)
		{
			
		} */
		var v1=$("#txtNewPass").val();
		var v2=$("#txtRePass").val();
		
		if(v1==v2)
		{
			$.post("editPasswordAction",{"password":v1},function(data){
				
				if(data=='1')
				{
					$("#editPwdWindow").window("close");
				}
				else
				{
					$.messager.alert("错误提示框","修改密码出现错误！", "warning");
				}
			
				
			});
		}
		else
		{
			$.messager.alert("错误提示框","二次密码输入不一致！","warning");
		}
	}

</script>
</head>
<body class="easyui-layout" onload="doshow()">



	<!-- 使用div元素描述每个区域 -->
	<div title="图书管理系统" style="height: 100px" data-options="region:'north'">
		
		<div align="right">
			<a  data-options="iconCls:'icon-help',menu:'#mm'" class="easyui-menubutton">控制面板</a>
		</div>
		<div  id="mm" style="display:none;">
			<div onclick="editPassword();" data-options="iconCls:'icon-edit'">修改密码</div>
			<div>联系管理员</div>
			<div class="menu-sep"></div>
			<div>退出系统</div>
		</div>
	
	
	</div>
	<div title="系统菜单" style="width: 200px" data-options="region:'west'">
		<!-- 制作accordion折叠面板 
			fit:true----自适应(填充父容器)
		-->
		<div class="easyui-accordion" data-options="fit:true">
			<!-- 使用子div表示每个面板 -->
			<div data-options="iconCls:'icon-cut'" title="面板一">
			
				<a id="button1" class="easyui-linkbutton" >添加选项卡</a>
				
				<script type="text/javascript">
					$(function()
					{
						$("#button1").click(function()
						{
							var exists=$("#mytabs").tabs("exists","系统管理");
							
							if(exists)
							{
								$("#mytabs").tabs("select","系统管理");
							}
							else
							{
								$("#mytabs").tabs("add",{
									
									title:"系统管理",
									closable:true,
									iconCls:'icon-edit',
									content:'<iframe frameborder="0" src="http:www.baidu.com"  width="100%" height="100%" />'
								});
							}
						})
					});
				
				</script>
			</div>
			<div title="面板二">2222</div>
			<div title="面板三">3333</div>
		</div>
	</div>
	<div data-options="region:'center'">
		<!-- 制作一个tabs选项卡面板 -->
		<div id="mytabs" class="easyui-tabs" data-options="fit:true">
			<!-- 使用子div表示每个面板 -->
			<div data-options="iconCls:'icon-cut'" title="面板一">1111</div>
			<div data-options="closable:true" title="面板二">2222</div>
			<div title="面板三">3333</div>
		</div>
	</div>
	<div style="width: 100px" data-options="region:'east'" title="帮助"></div>
	<div style="height: 50px" data-options="region:'south'">南部区域
	
	
	</div>
	
		<!--修改密码窗口-->
    <div id="editPwdWindow" class="easyui-window" title="修改密码" collapsible="false" minimizable="false" modal="true" closed="true" resizable="false"
        maximizable="false" icon="icon-save"  style="width: 300px; height: 160px; padding: 5px;
        background: #fafafa">
        <div class="easyui-layout" fit="true">
            <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
               <form id="editPasswordForm">
	                <table cellpadding=3>
	                    <tr>
	                        <td>新密码：</td>
	                        <td><input  required="true" data-options="validType:'length[4,6]'" id="txtNewPass" type="Password" class="txt01 easyui-validatebox" /></td>
	                    </tr>
	                    <tr>
	                        <td>确认密码：</td>
	                        <td><input required="true" data-options="validType:'length[4,6]'" id="txtRePass" type="Password" class="txt01 easyui-validatebox" /></td>
	                    </tr>
	                </table>
               </form>
            </div>
            <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
                <a id="btnEp" class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="editPasswordFormSubmit()">确定</a> 
                <a id="btnCancel" class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)" onclick="closeWindow()">取消</a>
            </div>
        </div>
    </div>
	
</body>
</html>