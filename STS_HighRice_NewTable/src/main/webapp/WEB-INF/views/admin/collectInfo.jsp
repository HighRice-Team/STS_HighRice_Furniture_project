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
	var today = (new Date())
	$("#regDate").val(today.getFullYear()+"-"+(today.getMonth()+1)+"-"+today.getDate()+" "+today.getHours()+":"+today.getMinutes()+":"+today.getSeconds())
	$("#sub").click(function(){
		$("#deliveryForm").submit()
		var product_id = $("#product_id").val();
		var order_id = $("#order_id").val();
		var condition = "비트맨 지정단계";
		var data = {"product_id":product_id,"condition":condition}
		$.ajax({
			url:"../UpdateCondition_product",
			data:data,
			success:function(){
				window.opener.top.location.href="../admin.do";
			}
		})
			
	})
})
</script>
</head>
<body>
	<center>
		<h2>수거 담당 비트맨 지정</h2>
	</center><br>

	<center>
		<form action="http://203.236.209.226:52273/collect_Request" method="post" id="deliveryForm">
					비트맨 이름
				${ bitSelect }
				<input type="button" value="전송" id="sub">
				<input type="text" name="product_name" value="${product_info.product_name }" style="display:none ;">
				<input type="text" name="product_id" id="product_id" value="${product_info.product_id }"style="display: none;">
				<input type="text" name="product_category" value="${product_info.category }"style="display: none;">
				<input type="text" name="product_quality" value="${product_info.quality }"style="display: none;">
				<input type="text" name="product_price" value="${product_info.price }"style="display: none;">
				<input type="text" name="product_mainImg" value="${product_info.main_img}"style="display: none;">
				<input type="text" name="product_subImg" value="${product_info.sub_img }" style="display: none;">
				<input type="text" name="member_id" value="${member_info.member_id }"style="display: none;">
				<input type="text" name="member_name" value="${member_info.name }"style="display: none;">
				<input type="text" name="member_tel" value="${member_info.tel}"style="display: none;">
				<input type="text" name="member_address" value="${member_info.address}"style="display: none;">
				<input type="text" name="member_address_detail" value="${member_info.address_detail}"style="display: none;">
				<input type="text" name="regDate" id ="regDate"style="display: none;">
			
		</form>
	</center>
</body>
</html>