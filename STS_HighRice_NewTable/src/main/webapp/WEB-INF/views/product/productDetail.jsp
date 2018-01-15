<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
   $(function(){
      //$("#main_img").fancybox();
     
      /* $("#cal").dblclick(function(){
	      var rent_start = $("#cal").val()
	      var d = new Date()
	      milli = d.setMilliseconds(rent_start)
           
      }); */
         
      /* var d = new Date();
      $("#day").html(d.getFullYear()+"년 "+(eval(d.getMonth())+1)+"월 "+(eval(d.getDate())+2))
      rent_start = d.getFullYear()+""+(eval(d.getMonth())+1)+""+(eval(d.getDate())+2)
      */
   })
   
</script>
<script type="text/javascript">

	function cart(){
  		month = $("#rentMonth").val()
   		if(month=="대여기간"){
	      	alert("대여기간을 선택하시오.");
	      	return
   		}
	  		
	   	var id = '<%=session.getAttribute("id")%>'
	   	
	   	if(id != "null"){
	      month = $("#rentMonth").val();
	      product_id = $("#product_id").val()
	      var data = {"rent_month":month,"product_id":product_id};
	      
	      $.ajax({
	          url:"orderlist/insertOrderListAjax.jsp",
	          data:data,
	          success:function(data){
	             data = eval("("+data+")");
	             if(data.re==1){
	                if(confirm("이미 등록한 상품입니다. 장바구니로 이동하시겠습니까?")){
	                   location.href="cartList.do";
	                }                   
	             }else{
	                if(confirm("장바구니에 추가하였습니다. 장바구니로 이동하시겠습니까?")){
	                    location.href="cartList.do";
	                }
	             }
	          }
	             
	       })
	         
	   	}else{
	         if(confirm("로그인이 필요한 서비스 입니다.\n 로그인 하시겠습니까?","a")){
	        	 	onDialog();
	         }
	  	}
	   
	}

	
	function payment_info(){
		product_id=$("#product_id").val();
		month = $("#rentMonth").val();
		//price = $("#price").val();
	   
		var id = '<%=session.getAttribute("id")%>'
	  
		if(id=="null"){
	    		if(confirm("로그인이 필요한 서비스 입니다.\n 로그인 하시겠습니까?","a")){
	    			onDialog();
	      	}
	    		
	   	}else{
	   		if(month=="대여기간"){
	        	alert("대여기간을 선택하시오.");
	        	return
	        	
	   		}
	   		
	   		if(confirm("구매 화면으로 이동하시겠습니까?")){
	   			location.href="paymentInfo.do?product_id="+product_id+"&rentMonth="+month+"&rent_start="+rent_start;
	        }
	   }
	  
	}
</script>
</head>
<body>
	<div style="margin: 0 15% 0 15%; padding: 40px 0 40px 0;">
		<h2>
			<a href="product.do?category=${category }">${category }</a>
		</h2>
		<hr>
		<div style="width: 100%; height: 300px;">
			<div style="width: 35%; float: left; margin-left: 5%">
			<!--  <a id="main_img" rel="fancybox" href="resources/img/product/${list.main_img}">-->
				<img src="resources/img/product/${list.main_img}" style="width: 100%; height: 300px;">
			<!--    </a> -->
			</div>
			
			<div style="width: 55%; float: right; text-align: right; margin: 25px 5% 0 0">
				<input type="hidden" value="${list.product_id }" id="product_id">
				<input type="hidden" value="${member_id }" id="member_id">
				<input type="hidden" value="${list.price }" id="price">
				${list.category }
				<h2>${list.product_name }</h2>
				<br>
				<br> 가격 : ${list.price}&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp; 
				<select id="rentMonth">
					<option selected="selected" disabled="disabled">대여기간</option>
					<option value=6>6개월</option>
					<option value=7>7개월</option>
					<option value=8>8개월</option>
					<option value=9>9개월</option>
					<option value=10>10개월</option>
					<option value=11>11개월</option>
					<option value=12>1년</option>
				</select><br>
				<br>
				
				<!-- <p>대여 시작일 : <input type="date" id="cal"></p> 대여 시작일은 <span id="day"></span>일 입니다.<br><br>-->
				<c:if test="${list.member_id != sessionScope.id}">&nbsp;&nbsp;&nbsp;
					<input type="button" value="장바구니" id///// onclick="cart()">&nbsp;&nbsp;&nbsp;
	                <input type="button" value="물품 대여" onclick="payment_info()">
				</c:if>
				<c:if test="${list.member_id == sessionScope.id}">&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;
					나의 물건 입니다.&nbsp;&nbsp;&nbsp;
	                
				</c:if>
				
			</div>
		</div>
		<hr>
		<div style="background-color: grey;">
			<img src="resources/img/product/${list.sub_img}" style="width: 100%;">
		</div>
	</div>

</body>
</html>