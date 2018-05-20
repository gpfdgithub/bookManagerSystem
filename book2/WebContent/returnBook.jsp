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
		        ]];

		$('#serachTable').datagrid({ 
		
			url:'BookAction_pageQueryLoginUser',
		
			columns:columns,
		
			rownumbers:true,
			
			pagination:true,
			
			pageSize:10,
			
			pageList:[10,15,20],
			
			striped:true,
			
			onDblClickRow:doDbClickEdit
		
			}); 
	}
function doDbClickEdit(rowIndex, rowData)
{
	$.post("${pageContext.request.contextPath}/RecordAction_editRecord",
			{"book_id":rowData.id},
			function(data){
				
			if(data=='1')
			{
				alert("成功还书！");
			}
		
		},
		"text"
		);
}
</script>

<body onload="showTable()">

		<div>
			<h3>
				借书列表如下：
			</h3>
			
		</div>
		<table id="serachTable">
			
		</table>
		
			
		<div>
			<h3>
				提示：双击选中的的图书即可完成还书！
			</h3>
			
		</div>
		
</body>
</html>