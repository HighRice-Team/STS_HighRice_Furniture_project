<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/jquery-ui.min.css">
<style>

</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src ="resources/js/jquery-ui.min.js"></script>
<script type="text/javascript">
	$(function(){
		var member_id = $("#member_id").val()
		$("#sellList_grid").jsGrid({
	        width: "100%",
	        height: "auto",
	        editing: true,
	        filtering: false,
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
	        			url:"sellList_product.do?member_id="+member_id,
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
	            { name: "main_img", title:"이미지",  itemTemplate:function(_,item){  return $("<img>").attr("src","resources/img/product/"+item.main_img).attr("width","100%") }, width: 30},
	            { name: "product_name",title:"물품명", type: "text", width: 200 },
	            { name: "category", title:"품목",type: "text", width: 200},
	          /*   	items:[{id:"", Name:""},{id:"DESK", Name:"DESK"}, {id:"CLOSET", Name:"CLOSET"}, {id:"SOFA", Name:"SOFA"}, {id:"BED", Name:"BED"}],
	            	valueField: "id", textField: "Name", valueType:"String", width: 50 }, */	
	            { name: "condition", title:"현황", type: "select",
	            	items:[{id:"", Name:""},{id:"물품게시", Name:"물품게시"}, {id:"배송중", Name:"배송중"}, 
	            		{id:"대여중", Name:"대여중"},{id:"반납", Name:"반납"},{id:"배송완료", Name:"배송완료"},
	            		{id:"등록", Name:"등록"},{id:"검수완료", Name:"검수완료"},{id:"입금완료", Name:"입금완료"},
	            		{id:"반납신청", Name:"반납신청"}, {id:"검수",Name:"검수"}],
	            	valueField: "id", textField: "Name", valueType:"String", width: 100 },	            	
	            { name: "quality", title:"물품 상태", type: "select",
	            	items:[{id:"", Name:""},{id:"A", Name:"A"}, {id:"B", Name:"B"}, {id:"C", Name:"C"}],
	            	valueField: "id", textField: "Name", valueType:"String", width: 50 },

	            { type: "control", deleteButton:false },
/* 	            { name:"UpdateCondition", title:"수정", width:70, itemTemplate:function(_,item){
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
	            }}, */
	           {name:"deleteCondtion",title:"삭제", width:50, itemTemplate:function(_,item){
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
		
	})
	
</script>
</head>
<body>
	<div style="margin: 0 15% 0 15%; padding: 40px 0 40px 0">
		<h2>SELL LIST3333</h2>
		<hr>
		<input type="hidden" id="member_id" value="${member_id}">
		
		<div style="position: relative;">
			<table id="sellList_grid" width="100%"></table>
			<div id="pager"></div>
			<input type="hidden" id="member_id" value="${member_id}">
		</div>
	</div>
</body>
<%-- <body>
	<div id="sellList" style="margin: 0 15% 0 15%; padding: 40px 0 40px 0; position: relative;">	
		<h2>SELL LIST</h2><hr id="hr"><br>
		<div style="margin: 0 10% 0 10%; padding: 10px 0 10px 0;">
		<table>
			<tr>
				<td width="10%">이미지</td>
				<td width="50%">물품명</td>
				<td width="10%">카테고리</td>
				<td width="10%">현황</td>
				<td width="10%">물품상태</td>
				<td width="7%">수정</td>
				<td width="7%">삭제</td>
			</tr>
			<c:forEach var="list" items="${list}">
			<tr>
				<td width="10%"><img src="resources/img/product/${list.main_img}" width="70"></td>
				<td width="50%"><a href="productDetail.do?product_id=${list.product_id}">${list.product_name}</a></td>
				<td width="10%">${list.category}</td>
				<td width="10%">${list.condition}</td>
				<td width="10%">
					<c:if test="${list.quality==null}">검수중</c:if>
					<c:if test="${list.quality!=null}">${list.quality}</c:if>
				</td>
				<td width="7%">
					<c:if test="${list.condition=='등록'}"><input type="button" value="수정" name="updateBtn" class="updateBtn"></c:if>
				</td>
				<td width="7%">
					<c:if test="${list.condition=='등록'}"><input type="button" value="삭제" name="deleteBtn" class="deleteBtn"></c:if>
				</td>
				<input type="hidden" id = "member_id" value="${member_id}">
				<input type="hidden" class = "product_id" value="${list.product_id}">
				<input type="hidden" id = "getQuality" value="${list.quality}">
			</tr>
			<tr>
				<td colspan="7">
					<div id="updateForm" class="detail">
					<form action="sellWriteOk.do" method="post" enctype="multipart/form-data">
						<div style="padding: 10px" align="left">
							제목 : <textarea rows="1" style="width: 90%" name="product_name">${list.product_name}</textarea>
							<input type="hidden" name="product_id" value="${list.product_id}">
						</div>
						<div style="padding: 10px" align="left">
							분류 :  <select name="category">
							<option value="bed">BED</option>
							<option value="sofa">SOFA</option>
							<option value="desk">DESK</option>
							<option value="closet">CLOSET</option></select>
						</div>
						<div style="padding: 10px" align="left">
							품질 :  <input type="radio" name="quality" value="A">A
							<input type="radio" name="quality" value="B">B
							<input type="radio" name="quality" value="C">C
						</div>
						<div style="padding: 10px" align="left">
							대표이미지 : <input type="file" name="main_img"><br>
							서브이미지 : <input type="file" name="sub_img">
						</div>
						<div style="padding: 10px" align="center">
							<input type="submit" value="수정">&nbsp;
							<input type="reset" value="취소">
						</div>
					</form>
					</div>
				</td>
			</tr>
			</div>
			</c:forEach>
		</table>
		</div><br>
		<div>		
			<c:forEach var="pageNum" begin="1" end="${pageMax}">
				<a href="sellList.do?member_id=${member_id}&pageNum=${pageNum}" style="font-size: 1.15vw;">${pageNum}</a>
			</c:forEach>
		</div>
	</div>
</body> --%>
</html>