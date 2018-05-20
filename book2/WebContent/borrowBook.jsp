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
		alert(value+":"+name)
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
	function doDbClickEdit()
	{
		alert("sasasa");
	}
</script>

<body onload="showTable()">

		<input class="easyui-searchbox" style="width:300px" data-options="searcher:qq,prompt:'请输入书名',menu:'#mm'" type="text" name="" id="" >
		<div id="mm" style="width:120px"> 
			<div data-options="name:'all',iconCls:'icon-ok'">所有书籍</div> 
			<div data-options="name:'sports'">。。。</div> 
		</div>
		
		
		<table id="serachTable">
			
		</table>
</body>
</html>