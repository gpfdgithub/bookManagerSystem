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
					  
		              {field:'name',title:'书名',width:100},
		              
		              {field:'price',title:'价格',width:100},
		              
		              {field:'author',title:'作者',width:100},
		              
		              {field:'type',title:'类型',width:100},
		              
		              {field:'description',title:'简介',width:100},
		              
		              {
		            	  field:'publicationDate',
		            	  title:'出版日期',
		            	  width:100,
		            	  formatter: function(value,row,index){
								
		            		  if(value!=null)
		            		  {
		            			  var year=value['year']+1900+"-";
			            		  var month=value['month']+1+"-";
			            		  var day=value['date']+"";
			            		  return year+month+day+"";
		            		  }
		            		  else
		            		  {
		            			  return '';
		            		  }
		            		
		            	  }
		              },
		              
		              {
		            	  field:'isBorrow',
		            	  title:'是否借出',
		            	  width:100,
		            	  formatter: function(value,row,index){
		            	         if (value==true){
		            	            return "已经借出";
		            	         } else {
		            	            return "未借出";
		            	         }  			
		            	     }  
		              
		              
		              },
		              
		              
		        ]];
		
		var toolbar=[
		             
		             {text:"查找",iconCls: 'icon-search',handler:function(){
		            	 
		            	 $('#serachwin').window('open'); 
		            	 
		             }},
		         	 
		         	 
		         	 
		             {text:"删除",iconCls: 'icon-remove',handler:remove},
		             
		             {text:"编辑",iconCls: 'icon-edit',handler:function(){
		            	 
		            	 
		            	 alert("选定要编辑的行然后双击");
		            	 
		             }},
		             
		             
		             
		             {text:"添加",iconCls: 'icon-add',handler:function(){
		            	 
		            	
		            	 $('#win').window('open'); 
		            	
		            	 
		             }}
		             ];
	

		$('#bookTable').datagrid({ 
		
			url:'BookAction_pageQuery',
		
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

			url:"BookAction_add", 

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
					
					location.href="BookAction_deleteBatch?ids="+ids;
					
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

			url:"BookAction_edit", 

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
			
			"name":$('#serachName').val(),
			"author":$('#serachAuthor').val(),
			"type":$('#serachType').val()
			
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
				<div>图书信息</div>
			</div> 
			
			<div data-options="region:'center'"> 
				<form id="ff" method="post"> 
				
						<label>书名:</label> 
						<input class="easyui-validatebox" type="text" name="name" data-options="required:true" /> <br/>
					
						<label>作者:</label> 
						<input class="easyui-validatebox" type="text" name="author" data-options="required:true" /> <br/>
					
						<label>价格:</label> 
						<input class="easyui-numberbox" type="text" name="price" data-options="required:true" /> <br/>
					 
						<label>类型:</label> 
						<select name="type">
							<option value="言情">言情</option>
							<option value="科幻">科幻</option>
							<option value="科普">科普</option>
							<option value="青年">青年</option>
							<option value="计算机">计算机</option>
							<option value="自然">自然</option>
							<option value="传记">传记</option>
							<option value="其它">其它</option>
						</select> <br/>
						<label>出版日期:</label> 
						<input class="easyui-datetimebox" name="publicationDate"  style="width:150px"><br/>
					
						<label>简介:</label>
						<input type="text"  name="description"  height="80px" style="width:350px"><br/>
						<a class="easyui-linkbutton" onclick="submitFormAdd()" href="#">提交</a><br/>
					
				</form>
			</div> 
		</div> 
	</div>
	
	<div id="editwin"  class="easyui-window" title="图书编辑" style="width:400px;height:300px" data-options="iconCls:'icon-edit',modal:true,closed:true" > 

		<div class="easyui-layout" data-options="fit:true"> 
		
			<div data-options="region:'north',split:true" style="height:30px">
				<div align="center">图书信息</div>
			</div> 
			
			<div data-options="region:'center'"> 
				<form id="editForm" method="post"> 
						<input type="hidden" name="id">
						<label>书名:</label> 
						<input class="easyui-validatebox" type="text" name="name" data-options="required:true" /> <br/>
					
						<label>作者:</label> 
						<input class="easyui-validatebox" type="text" name="author" data-options="required:true" /> <br/>
					
						<label>价格:</label> 
						<input class="easyui-numberbox" type="text" name="price" data-options="required:true" /> <br/>
					 
						<label>类型:</label> 
						<select name="type">
							<option value="言情">言情</option>
							<option value="科幻">科幻</option>
							<option value="科普">科普</option>
							<option value="青年">青年</option>
							<option value="计算机">计算机</option>
							<option value="自然">自然</option>
							<option value="传记">传记</option>
							<option value="其它">其它</option>
						</select> <br/>
						<label>出版日期:</label> 
						<input class="easyui-datetimebox" name="publicationDate"  style="width:150px"><br/>
					
						<label>简介:</label>
						<input type="text"  name="description"  height="80px" style="width:350px"><br/>
						<a class="easyui-linkbutton" onclick="submitFormEdit()" href="#" >更新</a><br/>
					
				</form>
			</div> 
		</div> 
	</div>
	
	
	<div id="serachwin"  class="easyui-window" title="图书查找" style="width:400px;height:300px" data-options="iconCls:'icon-serach',modal:true,closed:true" >
			
		<form id="serachForm" method="post">
			书名：<input type="text" id="serachName" name="name"/><br/>
			作者：<input type="text" id="serachAuthor" name="author"/><br/>
			<label>类型:</label> 
			<select id="serachType" name="type">
				<option value=""></option>
				<option value="言情">言情</option>
				<option value="科幻">科幻</option>
				<option value="科普">科普</option>
				<option value="青年">青年</option>
				<option value="计算机">计算机</option>
				<option value="自然">自然</option>
				<option value="传记">传记</option>
				<option value="其它">其它</option>
			</select><br/>
			
			<a class="easyui-linkbutton" href="#" onclick="doSerach()">模糊检索</a>
		</form>	
	
	</div>
</body>
</html>