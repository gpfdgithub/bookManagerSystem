<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/easyui/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript">
	function qq(value,name)
	{
		if(name=="all"||name=="other")
		{
			alert(value+":"+name);
			$('#serachTable').datagrid('load',{
				name:value
			  });  
		}
		else
		{
			$('#serachTable').datagrid('load',{
				name:value,
				type:name
			  }); 
			
		}
		
	}
	function showTable()
	{
		var columns=[[	
					  {field:'id',title:'编号',width:100},
					  
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

		$('#serachTable').datagrid({ 
		
			url:'BookAction_pageQuery',
		
			columns:columns,
		
			rownumbers:true,
			
			pagination:true,
			
			pageSize:5,
			
			pageList:[5,10,15,20],
			
			striped:true,
			
			onDblClickRow:doDbClickEdit
		
			}); 
	}
	function doDbClickEdit(rowIndex, rowData)
	{
		
		
		$.messager.confirm('Confirm','你确定借这本书吗？',function(r){ 
			if(r)
			{ 
				if(rowData.isBorrow==false)
				{
					$.post("${pageContext.request.contextPath}/RecordAction_borrow",
							
							{"book_id":rowData.id},
							
							function(data)
					{
							if(data=='1')
							{
								alert('完成'); 
							}
							else
							{
								alert("出现异常！请重试(可能没有登录)");
							}
					},
					"text"
					);
				}
				else
				{
					alert("借书失败，该书已经借出！");
				}
			  
			} 
			});

	}
</script>

<body onload="showTable()">

		<input class="easyui-searchbox" style="width:300px" data-options="searcher:qq,prompt:'请输入书名',menu:'#mm'" type="text" name="" id="" >
		<div id="mm" style="width:120px"> 
			<div data-options="name:'all',iconCls:'icon-ok'">所有书籍</div> 
			<div data-options="name:'sports'">科普类</div>
			<div data-options="name:'word'">文学类</div>
			<div data-options="name:'computer'">计算机类</div>
			<div data-options="name:'other'">其它类</div>
		</div>
		
		
		<table id="serachTable">
			
		</table>
		
		<div>
			<h2>提示：双击选中的图书进行借书！</h2>
		</div>
	
		
</body>
</html>