<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript">
$(function(){
	$("#sub").click(function(){
		var product_id = $("#product_id").val();
		var order_id = $("#order_id").val();
		var condition = "배송중";
		var data = {"product_id":product_id,"condition":condition}
		$.ajax({
			url:"../updateOrderlistCondition.do",
			data:{"order_id":order_id,"condition":condition},
			success:function(){
				$.ajax({
					url:"../UpdateCondition_product",
					data:data,
					success:function(){
						$("#deliveryForm").submit()
						window.opener.top.location.href="../admin.do";
						self.close()
					}
				})
			}
		})
	})
})
</script>
</head>
<body>
	<h2>비트맨 지정</h2>
	<form action="http://192.168.0.111:52273/delivery_Request" method="post" id="deliveryForm">
				비트맨 이름
			${ bitSelect }<br>
			<input type="hidden" name="product_name" value="${product_info.product_name }"><br>
			<input type="hidden" name="product_id" id="product_id" value="${product_info.product_id }"><br>
			<input type="hidden" name="product_category" value="${product_info.category }"><br>
			<input type="hidden" name="product_quality" value="${product_info.quality }"><br>
			<input type="hidden" name="product_price" value="${product_info.price }"><br>
			<input type="hidden" name="product_mainImg" value="${product_info.main_img}"><br>
			<input type="hidden" name="product_subImg" value="${product_info.sub_img }"><br>
			<input type="hidden" name="order_id" id="order_id" value="${orderlist_info.order_id }"><br>
			<input type="hidden" name="orderlist_condition" value="${orderlist_info.orderlist_condition }"><br>
			<input type="hidden" name="orderlist_rent_month" value="${orderlist_info.rent_month }"><br>
			<input type="hidden" name="member_id" value="${member_info.member_id }"><br>
			<input type="hidden" name="member_name" value="${member_info.name }"><br>
			<input type="hidden" name="member_tel" value="${member_info.tel}"><br>
			<input type="hidden" name="member_address" value="${member_info.address}"><br>
			<input type="hidden" name="member_address_detail" value="${member_info.address_detail}"><br>
		<input type="button" value="전송" id="sub">
	</form>
</body>
</html>