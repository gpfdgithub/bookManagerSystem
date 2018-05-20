<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>books</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/easyui/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/easyui/locale/easyui-lang-zh_CN.js"></script>
</head>
<script type="text/javascript">

	function doLoad()
	{
		var columns=[[	
					  {field:'id',title:'编号',width:100,checkbox:true},
					  
		              {field:'username',title:'用户名',width:100},
		              
		              {field:'password',title:'密码',width:100},
		              
		              {field:'telphoneNumber',title:'联系电话',width:100},
		              
		              
		        ]];
		
		var toolbar=[
		             
		             {text:"查找",iconCls: 'icon-search',handler:function(){
		            	 
		            	 $('#serachwin').window('open'); 
		            	 
		             }},
		         	 
		         	 
		             {text:"删除",iconCls: 'icon-remove',handler:remove},
		             
		             
		             {text:"添加",iconCls: 'icon-add',handler:function(){
		            	 
		            	
		            	 $('#win').window('open'); 
		            	
		            	 
		             }}
		             ];
	

		$('#bookTable').datagrid({ 
		
			url:'UserAction_pageQuery',
		
			columns:columns,
		
			toolbar:toolbar,
			
			rownumbers:true,
			
			pagination:true,
			
			pageSize:5,
			
			pageList:[5,10,15,20],
			
			striped:true,
			
			onDblClickRow:doDbClickEdit
		
			}); 
		

	}
	
	function submitFormAdd()
	{

		$('#ff').form('submit', { 

			url:"UserAction_add", 

			onSubmit: function(){ 
				
				var bool=$('#ff').form('validate');
				if(bool)
				{
					return true;
				}
				else
				{
					return false;
				}
				
			}, 

			success:function(data){ 
	
					alert("新增成功！")
					if(data=='1')
					{
						$('#win').window('close');
					}
			} 

			});

		
	}
	
	function remove()
	{
		var rows=$('#bookTable').datagrid("getSelections");
		if(rows.length==0)
		{
			$.messager.alert("提示信息","请勾选要删除的行!","warning");
		}
		else
		{
			$.messager.confirm('Confirm','您确定删除所选记录吗?',function(r){ 
				if(r)
				{ 
					var array=new Array();
					
					for(var i=0;i<rows.length;i++)
					{
						array.push(rows[i].id);
					}
					
					var ids=array.join(",");
					
					location.href="UserAction_deleteBatch?ids="+ids;
					
				} 

				});

		}
		
	}
	
	function doDbClickEdit(rowIndex, rowData)
	{
		
		$('#editwin').window("open");
		//使用form表单对象的load方法回显数据
		$("#editForm").form("load",rowData);
		
	}
	function submitFormEdit()
	{
		$('#editForm').form('submit', { 

			url:"UserAction_edit", 

			onSubmit: function(){ 
				
				var bool=$('#editForm').form('validate');
				if(bool)
				{
					return true;
				}
				else
				{
					return false;
				}
				
			}, 

			success:function(data){ 
	
					alert("更新成功！")
					if(data=='1')
					{
						$('#editwin').window('close');
					}
			} 

			});
	}
	
	function doSerach()
	{
		
		$('#bookTable').datagrid("load",{
			"username":$('#serachName').val(),
		});
		
		$("#serachwin").window("close");
	}
</script>

<body onload="doLoad()">
	
	<table id="bookTable">
		
	
	
	</table>
	
	<div id="win" closed="true" class="easyui-window" title="图书新增" style="width:400px;height:300px" data-options="iconCls:'icon-save',modal:true" > 

		<div class="easyui-layout" data-options="fit:true"> 
		
			<div data-options="region:'north',split:true" style="height:30px">
				<div>用户信息</div>
			</div> 
			
			<div data-options="region:'center'"> 
				<form id="ff" method="post"> 
				
						<label>用户名:</label> 
						<input class="easyui-validatebox" type="text" name="username" data-options="required:true" /> <br/>
					
						<label>密码:</label> 
						<input class="easyui-validatebox" type="text" name="password" data-options="required:true" /> <br/>
					
						<label>联系电话:</label> 
						<input class="easyui-numberbox" type="text" name="telphoneNumber" data-options="required:true" /> <br/>

			
						<a class="easyui-linkbutton" onclick="submitFormAdd()" href="#">提交</a><br/>
					
				</form>
			</div> 
		</div> 
	</div>
	
	<div id="editwin"  class="easyui-window" title="用户编辑" style="width:400px;height:300px" data-options="iconCls:'icon-edit',modal:true,closed:true" > 

		<div class="easyui-layout" data-options="fit:true"> 
		
			<div data-options="region:'north',split:true" style="height:30px">
				<div align="center">用户信息</div>
			</div> 
			
			<div data-options="region:'center'"> 
				<form id="editForm" method="post"> 
						<input type="hidden" name="id">
						<label>用户名:</label> 
						<input class="easyui-validatebox" type="text" name="username" data-options="required:true" /> <br/>
					
						<label>密码:</label> 
						<input class="easyui-validatebox" type="text" name="password" data-options="required:true" /> <br/>
					
						<label>联系电话:</label> 
						<input class="easyui-numberbox" type="text" name="telphoneNumber" data-options="required:true" /> <br/>
					 
					
						<a class="easyui-linkbutton" onclick="submitFormEdit()" href="#" >更新</a><br/>
					
				</form>
			</div> 
		</div> 
	</div>
	
	
	<div id="serachwin"  class="easyui-window" title="查找用户" style="width:400px;height:300px" data-options="iconCls:'icon-serach',modal:true,closed:true" >
			
		<form id="serachForm" method="post">
			用户名：<input type="text" id="serachName" name="username"/><br/>
			
			<a class="easyui-linkbutton" href="#" onclick="doSerach()">模糊检索</a>
		</form>	
	
	</div>
</body>
</html>