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
	
		function updateCondition(button, product_id, condition){
			str = $("<button class='chkCondition'>").text(button).on("click",function(){
    			data = {"product_id":product_id, "condition":condition}
        		$.ajax({
        			url:"UpdateCondition_product.do",
        			data:data,
        			success:function(data){
        				alert("변경 완료")
        				location.href=""
        			}
        		})
        	})
        	return str;
		}
		
		$("#tabs").tabs();
		

		$("#product_grid").jsGrid({
	        width: "100%",
	        height: "auto",
	        editing:true,
	        filtering: true,
	        sorting: true,
	        paging: true,
	        autoload: true,
	        autosearch:true,
	        searchModeButtonTooltip :"Switch to searching",
	        pageSize : 10,
	        pageButtonCount:5,
	        
	        rowClick: function(args) {
	        	
	        },
	        
	        controller : {
	        	
	        	loadData:function(filter){
	        		return $.ajax({
	        			type:"POST",
	        			url:"admin_product.do",
	        			data:filter,
	        			dataType:"JSON"
	        		})
	        	},
	        	updateItem : function(item){
	            	$.ajax({
	            		url:"adminUpdate_product.do",
	            		data:item,
	            		success:function(data){
	            			alert("업데이트 완료");
	            		}
	            	})
	            }
	        },
	        
	        fields: [
	            { name: "product_id", type: "number", width: 50},
	            { name: "category", type: "select", 
	            	items:[{id:"", Name:""},{id:"DESK", Name:"DESK"}, {id:"CLOSET", Name:"CLOSET"}, {id:"SOFA", Name:"SOFA"}, {id:"BED", Name:"BED"}],
	            	valueField: "id", textField: "Name", valueType:"String", width: 50 },
	            { name: "product_name", type: "text", width: 200 },
	            { name: "member_id", type: "text",width:50},
	            { name: "quality", type: "select",
	            	items:[{id:"", Name:""},{id:"A", Name:"A"}, {id:"B", Name:"B"}, {id:"C", Name:"C"}],
	            	valueField: "id", textField: "Name", valueType:"String", width: 50 },
	            { name: "price", type: "number", width:100},
	            { name: "condition", type: "select",
	            	items:[{id:"", Name:""},{id:"물품게시", Name:"물품게시"}, {id:"배송중", Name:"배송중"}, 
	            		{id:"대여중", Name:"대여중"},{id:"반납", Name:"반납"},{id:"배송완료", Name:"배송완료"},
	            		{id:"등록", Name:"등록"},{id:"검수완료", Name:"검수완료"},{id:"입금완료", Name:"입금완료"},
	            		{id:"반납신청", Name:"반납신청"}, {id:"검수",Name:"검수"}],
	            	valueField: "id", textField: "Name", valueType:"String", width: 100 },
	            { type: "control", deleteButton:false },
	            { name:"UpdateCondition", width:100, itemTemplate:function(_,item){
	            	var str;
	            	if(item.condition=="등록"){
	            		str = updateCondition("접수",item.product_id,"검수")
	            	}
	            	if(item.condition=="반납신청"){
	            		str = updateCondition("반납", item.product_id, "반납")
	            	}
	            	if(item.condition=="반납"){
	            		str = updateCondition("물품게시", item.product_id, "물품게시")
	            	}
	            	if(item.condition=="입금완료"){
	            		str = $("<button class='chkCondition'>").text("배송").on("click",function(){
	            			var data = {"product_id":item.product_id ,"member_id":item.member_id, "price":item.price}
	            			$.ajax({
	            				url:"sellCompliate_product.do",
	            				data:data,
	            				success:function(d){
	            					if(d == -1){
	            						alert("페이백 적용 실패")
	            					}
	            					else{
// 	            						str = updateCondition("배송", item.product_id, "배송중")
										var data ={"product_id":item.product_id, condition:"배송중"}
										$.ajax({
											url:"UpdateCondition_product.do",
											data:data,
											success:function(data){
												alert("변경 완료")
												location.href=""
											}
										})
	            					}
	            					
	            				}
	            			})
	            		})
	            	}
	            	return str;
	            }},
	           {name:"deleteCondtion", width:50, itemTemplate:function(_,item){
	        	   var str;
	        	   if(item.condition=="등록" || item.condition=="검수"){
	        		   str = $("<button class='chkCondition'>").text("삭제").on("click",function(){
	        			   data = {"product_id":item.product_id}
	        			   var con = confirm("정말로 삭제하시겠습니까?")
	        				if(con == true){
	        					$.ajax({
			            			url:"delete_product.do",
			            			data:data,
			            			success:function(data){
			            				alert("삭제 완료")
			            				location.href=""
			            			}
			            		})
			            		// 이 값에 해당되는 상품을 삭제
	        				}
		            		
		            	})
	        	   }
	        	   return str;
	           }}
	        ]
		});
			
		$("#order_grid").jsGrid({
	        width: "100%",
	        height: "400px",
	        filtering: true,
	        sorting: true,
	        paging: true,
	        autoload: true,
	        
	        pageSize : 10,
	        pageButtonCount:5,
	        
	        controller : {
	        	loadData: function(filter) {
	        		return $.ajax({
	        			type:"POST",
	        			url:'admin_orderlist.do',
	        			data:filter,
	        	        dataType : "JSON"
	        		 })
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
	            { name: "order_id", type: "number", width: 30},
	            { name: "member_id", type: "text", width: 30},
	            { name: "product_id", type: "number", width: 50},
	            { name: "pay_date", type: "text",width:100},
	            { name: "rent_start", type: "text", width:100 },
	            { name: "rent_end", type: "text", width:100 },
	            { name: "rent_month", type: "number", width:30},
	            { type: "control", deleteButton:false, editButton:false }
	        ]
		})
		
		$("#member_grid").jsGrid({
			width: "100%",
	        height: "400px",
	        filtering: true,
	        editing:true,
	        sorting: true,
	        paging: true,
	        autoload: true,
	        
	        rowClick:function(){
	        },
	        rowDoubleClick: function(args) {
	        	
	        },
	        pageSize : 10,
	        pageButtonCount:5,
	        
	        controller : {
	        	loadData: function(filter) {
	        		return  $.ajax({
	        			url:'admin_member.do',
	        	        dataType : "json",
	        	        type:"POST",
	        	        data:filter
	        		 })
	        		
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
	            { name: "member_id", type: "text", width: 100, readOnly:true },
	            { name: "name", type: "text", width: 50 },
	            { name: "pwd", type: "text", width: 50 },
	            { name: "tel", type: "text", width: 100 },
	            { name: "pwd_q", type: "select", 
	            	items:[{id:"", Name:""},{id:"자신의 보물 제1호는?", Name:"자신의 보물 제1호는?"}, {id:"자신의 출신 초등학교는?", Name:"자신의 출신 초등학교는?"}, {id:"인상 깊게 읽은 책 이름은?", Name:"인상 깊게 읽은 책 이름은?"}, {id:"가장 기억에 남는 선물은?", Name:"가장 기억에 남는 선물은?"}],
	            	valueField: "id", textField: "Name", valueType:"String",
	            	width: 170 },
	            { name: "pwd_a", type: "text", width: 70 },
	            { name: "address", type: "text",width:100 },
	            { name: "address_detail", type: "text", width:100 },
	            { name: "payback", type: "number", width:50, readOnly:true},
	            { name: "bank", type: "select", 
	            	items:[{id:"",Name:""}, {id:"농협",Name:"농협"},{id:"국민",Name:"국민"},{id:"기업",Name:"기업"},{id:"신한",Name:"신한"},{id:"우리",Name:"우리"}],
	            	valueField: "id", textField: "Name", valueType:"String", width:50},
	            { name: "account_no", type: "text", width:100},
	            { name: "grade", type: "number", width:40},
	            { type: "control", deleteButton:false },
	            { name:"비밀번호 초기화", width:100, itemTemplate:function(_,item){
	            	var str = $("<button></button>").addClass("reset").text("초기화").on("click",function(){
	            		var reset =  confirm("비밀번호를 초기화 하시겠습니까?")
	    	        	var data = {"member_id":item.member_id}
	    	        	
	    	        	if(reset == true){
	    	        		$.ajax({
	    	        			url:"updateResetPwd_member.do",
	    	        			dataType:"json",
	    	        			data:data,
	    	        			success:function(data){
	    	        				alert("비밀번호를 초기화 하였습니다.")
	    	        			}
	    	        			
	    	        		})
	    	        		
	    	        	}
	            	})
	            	return str;
	            	
	            }}
	            
	        ]
		})

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