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
					  {
						  field:'bookname',title:'书名',width:100,
						  formatter: function(value,row,index){
					  			return row.book.name;
						}},
					  
					  {
							field:'bookid',title:'书编号',width:100,
							 formatter: function(value,row,index){
						  		return row.book.id;
							}	
					  
					  },
					  
					  {
						  field:'userphone',title:'借书人联系电话',width:100,
						  formatter: function(value,row,index){
					  			return row.user.telphoneNumber;
						}  
					  
					  },
					  
					  {
						  field:'userid',title:'借书人编号',width:100,
						  formatter: function(value,row,index){
		            		  	
					  			return row.user.id;
						}  
					  
					  },
					  
		              {
						  field:'username',title:'借书人姓名',width:100,
						  formatter: function(value,row,index){
		            		  	
							  
					  			return row.user.username;
						}
		              
		              },
		              
		              {
		            	  field:'borrowDate',title:'借书日期',width:100,
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
	            		
	            	  }},
		              
		              {
	            		  field:'returnDate',title:'还书日期',width:150,
	            		  formatter: function(value,row,index)
	            		  {
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
		              
		              
		        ]];
		
		var toolbar=[
		             
		             {text:"查找",iconCls: 'icon-search',handler:function(){
		            	 
		            	 $('#serachwin').window('open'); 
		            	 
		             }},
		         	 
		         	 
		             {text:"删除",iconCls: 'icon-remove',handler:remove}
		             
		             ];
	

		$('#bookTable').datagrid({ 
		
			url:'RecordAction_pageQuery',
		
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
					
					location.href="RecordAction_deleteBatch?ids="+ids;
				} 

				});
		}
		
	}
	
	function doDbClickEdit(rowIndex, rowData)
	{
		
		$('#editwin').window("open");
		$("#editForm").form("load",rowData);
		
	}
	function submitFormEdit()
	{
		$('#editForm').form('submit', { 

			url:"RecordAction_edit", 

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
				
					$('#editwin').window('close');
					
			} 

			});
	}
	
	function doSerach()
	{
		
		$('#bookTable').datagrid("load",{
			"username":$('#serachName').val(),
			"bookname":$('#serachBookName').val(),
		});
		
		$("#serachwin").window("close");
	}
</script>

<body onload="doLoad()">
	
	<table id="bookTable">
		
	</table>
	
	
	<div id="editwin"  class="easyui-window" title="借书记录编辑" style="width:400px;height:300px" data-options="iconCls:'icon-edit',modal:true,closed:true" > 

		<div class="easyui-layout" data-options="fit:true"> 
		
			<div data-options="region:'north',split:true" style="height:30px">
				<div align="center">借书记录信息</div>
			</div> 
			
			<div data-options="region:'center'"> 
				<form id="editForm" method="post"> 
						书名：<input type="text" name="bookname"><br/>
						用户名：<input type="text" name="username"><br/>
						书编号：<input type="text" name="bookid"><br/>
						用户手机：<input type="text" name="userphone"><br/>
						借书日期：<input class="easyui-datetimebox" type="text" name="borrowDate"><br/>
						还书日期：<input class="easyui-datetimebox" type="text" name="returnDate"><br/>
						<a class="easyui-linkbutton" onclick="submitFormEdit()" href="#" >更新</a><br/>
					
				</form>
			</div> 
		</div> 
	</div>
	
	
	<div id="serachwin"  class="easyui-window" title="查找借书记录" style="width:400px;height:300px" data-options="iconCls:'icon-serach',modal:true,closed:true" >
			
		<form id="serachForm" method="post">
			书名：<input type="text" id="serachBookName"/><br/>
			用户名：<input type="text" id="serachName"/><br/>
			
			<a class="easyui-linkbutton" href="#" onclick="doSerach()">模糊检索</a>
		</form>	
	
	</div>
</body>
</html>