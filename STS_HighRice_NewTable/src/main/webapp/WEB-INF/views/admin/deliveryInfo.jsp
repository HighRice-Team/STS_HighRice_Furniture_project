<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>비트맨 지정</h2>
	<form action="http://localhost:8080/Controller/index.do" method="post">

				비트맨 이름
				${ bitSelect }<br>
			
			<input type="hidden" name="product_name" value="${product_info.product_name }"><br>
			<input type="hidden" name="product_id" value="${product_info.product_id }"><br>
			<input type="hidden" name="product_category" value="${product_info.category }"><br>
			<input type="hidden" name="product_quality" value="${product_info.quality }"><br>
			<input type="hidden" name="product_price" value="${product_info.price }"><br>
			<input type="hidden" name="product_mainImg" value="${product_info.main_img}"><br>
			<input type="hidden" name="product_subImg" value="${product_info.sub_img }"><br>
			<input type="hidden" name="order_id" value="${orderlist_info.order_id }"><br>
			<input type="hidden" name="orderlist_condition" value="${orderlist_info.orderlist_condition }"><br>
			<input type="hidden" name="orderlist_rent_month" value="${orderlist_info.rent_month }"><br>
			<input type="hidden" name="member_id" value="${member_info.member_id }"><br>
			<input type="hidden" name="member_name" value="${member_info.name }"><br>
			<input type="hidden" name="member_tel" value="${member_info.tel}"><br>
			<input type="hidden" name="member_address" value="${member_info.address}"><br>
			<input type="hidden" name="member_address_detail" value="${member_info.address_detail}"><br>
		<input type="submit" id="testBtn" value="전송">
	</form>
</body>
</html>