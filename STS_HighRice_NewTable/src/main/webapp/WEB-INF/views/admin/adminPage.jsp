<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
table{
	width: 100%;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript" src="https://code.jquery.com/jquery-1.7.0.min.js"></script>


<script type="text/javascript">
$(function(){
		$("#tabs").tabs();
		var customDialog = {
// 				onclickSubmit:function(params){
// 					var selectedRow = $('#product_grid').getGridParam('selrow');
// 					rowData = $('#product_grid').getRowData(selectedRow);
// 					location.href="";
// 					return {product_id : rowData.product_id};
// 				}
		}
		
		
		$("#product_grid").jsGrid({
	        width: "100%",
	        height: "auto",
	        editing:true,
	        filtering: true,
	        sorting: true,
	        paging: true,
	        autoload: true,
	        
	        pageSize : 10,
	        pageButtonCount:5,
	        
	        controller : {
	        	loadData: function(item) {
	        	var def = $.Deferred();
	        	$.ajax({
	        			url:'admin_product.do',
	        	        dataType : "json"
	        		 }).done(function(response) {
	        			def.resolve(response);
	        		});
	        	return def.promise();
	            },
	            
	            updateItem : function(item){
	            	
	            	$.ajax({
	            		url:'adminUpdate_product.do',
	            		data:item,
	            		success:function(data){
	            			alert("변경 완료")
	            		}
	            	})
	            }
	        },
	        
	        fields: [
	            { name: "product_id", type: "text", width: 50, readOnly:true },
	            { name: "category", type: "text", width: 50 },
	            { name: "product_name", type: "text", width: 200 },
	            { name: "member_id", type: "text",width:50, readOnly:true },
	            { name: "quality", type: "text", width:50 },
	            { name: "price", type: "number", width:100},
	            { name: "condition", type: "text", width:100},
	            { type: "control", deleteButton:false }
	        ]
		});
			
		$("#order_grid").jsGrid({
	        width: "100%",
	        height: "400px",
	        editing:true,
	        filtering: true,
	        sorting: true,
	        paging: true,
	        autoload: true,
	        
	        pageSize : 10,
	        pageButtonCount:5,
	        
	        controller : {
	        	loadData: function() {
	        	var def = $.Deferred();
	        	$.ajax({
	        			url:'admin_orderlist.do',
	        	        dataType : "json"
	        		 }).done(function(response) {
	        			def.resolve(response);
	        		});
	        	return def.promise();
	            },
	            
	            updateItem : function(item){
	            	$.ajax({
	            		url:"adminUpdate_orderlist.do",
	            		data:item,
	            		success:function(data){
	            			alert("오더리스트 업데이트 완료");
	            		}
	            	})
	            }
	        },
	        
	        fields: [
	            { name: "order_id", type: "text", width: 30, readOnly:true },
	            { name: "member_id", type: "text", width: 30, readOnly:true },
	            { name: "product_id", type: "text", width: 50, readOnly:true },
	            { name: "pay_date", type: "text",width:100, readOnly:true },
	            { name: "rent_start", type: "text", width:100 },
	            { name: "rent_end", type: "text", width:100, readOnly:true},
	            { name: "rent_month", type: "number", width:30},
	            { type: "control", deleteButton:false }
	        ]
		})
		
		$("#member_grid").jsGrid({
			width: "100%",
	        height: "400px",
	        filtering: true,
	        editing:false,
	        sorting: true,
	        paging: true,
	        autoload: true,
	        
	        rowDoubleClick: function(args) {
	        	var reset =  confirm("비밀번호를 초기화 하시겠습니까?")
	        	var item = args.item
	        	
	        	if(reset == true){
	        		$.ajax({
	        			url:"updateResetPwd_member.do",
	        			dataType:"json",
	        			data:item,
	        			success:function(data){
	        				alert("비밀번호를 초기화 하였습니다.")
	        			}
	        			
	        		})
	        		
	        	}
	        },
	        
	        pageSize : 10,
	        pageButtonCount:5,
	        
	        controller : {
	        	loadData: function(filter) {
	        	var def = $.Deferred();
	        	$.ajax({
	        			url:'admin_member.do',
	        	        dataType : "json",
	        	        data:filter
	        		 }).done(function(response) {
	        			def.resolve(response);
	        		});
	        	return def.promise();
	            },
	            
	            updateItem : function(data){
	            	$.ajax({
	            		url:'adminUpdate_member.do',
	            		data:data,
	            		success:function(data){
	            			elart("회원정보 변경 완료")
	            		}
	            	})
	            }
	        },
	        
	        fields: [
	            { name: "member_id", type: "text", width: 50, readOnly:true },
	            { name: "name", type: "text", width: 50 },
	            { name: "tel", type: "text", width: 100 },
	            { name: "pwd_q", type: "text", width: 170 },
	            { name: "pwd_a", type: "text", width: 70 },
	            { name: "address", type: "text",width:100 },
	            { name: "address_detail", type: "text", width:100 },
	            { name: "payback", type: "text", width:50, readOnly:true},
	            { name: "bank", type: "number", width:50},
	            { name: "account_no", type: "text", width:100},
	            { name: "grade", type: "number", width:30},
	            { type: "control", deleteButton:false, editButton:false }
	        ]
		})
		
// 		$("#pager").on("change", function() {
// 	        var page = parseInt($(this).val(), 10);
// 	        $("#product_grid").jsGrid("openPage", page);
// 	    });
	
})

</script>
<title>Insert title here</title>
</head>
<body>
	<div id="tabs">
		<ul>
			<li><a href="#a">물품관리</a></li>
			<li><a href="#b">주문관리</a></li>
			<li><a href="#c">회원관리</a></li>
		</ul>
		
		<div id="a">
			<h2>물품관리</h2>
			<hr>
			<div>
				<table id="product_grid" border="1" cellpadding="10px" cellspacing="10px" class="table">

				</table>
				<div id="pager"></div>
			</div>
		</div>

		<div id="b">
			<h2>주문관리</h2>
			<hr>
			<div>
				<table id="order_grid" border="1" cellpadding="10px" cellspacing="10px" class="table">
					
				</table>
				
			</div>
		</div>

		<div id="c">
			<h2>회원관리</h2>
			<hr>
			<div>
				<table id="member_grid" border="1" cellpadding="10px" cellspacing="10px" class="table">
			
				</table>
			</div>
		</div>
	</div>
</body>
</html>