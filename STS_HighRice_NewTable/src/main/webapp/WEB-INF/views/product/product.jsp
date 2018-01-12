<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">

.sort {
	text-align: right;
	padding-right: 20px;
}

.sort a {
	font-size: 15px;
}

p{
	font-size: 15px;
	font-weight: 50px;
	line-height: 10px;
}

.over {
	background-color: #606060;
	text-align: center;
	transition: all 0.8s, color 0.3s 0.3s;
	color: #504f4f;
	cursor: pointer;
}

.over:hover {
	box-shadow: 400px 0 0 0 rgba(0, 0, 0, 0.25) inset, -400px 0 0 0
		rgba(0, 0, 0, 0.25) inset;
}

.over a {
	color: white;
}
</style>
<!--  <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">-->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

<script type="text/javascript">
	// 각 상품에 대하여 하이라이트 효과를 적용.
	$(document).on("mouseover", ".hover", function() {
		$(this).addClass("over");
	})
	$(document).on("mouseout", ".hover", function() {
		$(this).removeClass("over");
	})

	//창을 띄울 때 상품들의 이미지 크기를 조정.
	$(".category_img").css("width", $("#product_box").width() * 0.225)
	$(".category_img").css("height", $("#product_box").width() * 0.225)

	//창의 크기가 변동 될 때 상품들의 이미지 크기를 조정.
	$(window).resize(function() {
		$(".category_img").css("width", $("#product_box").width() * 0.225)
		$(".category_img").css("height", $("#product_box").width() * 0.225)
	})

	$(function() {
		$(document).on("mouseover", ".hover1", function() {
			$(this).addClass("over");
		})
		$(document).on("mouseout", ".hover1", function() {
			$(this).removeClass("over");
		})

		$(".category_img").css("width", $("#hr").width() * 0.225)
		$(".category_img").css("height", $("#hr").width() * 0.225)
		$(window).resize(function() {
			$(".category_img").css("width", $("#hr").width() * 0.225)
			$(".category_img").css("height", $("#hr").width() * 0.225)
		})
	})
</script>
</head>
<body>

	<div style="margin: 0 15% 0 15%; padding: 40px 0 40px 0; position: relative;">
		<div>
			<a href="product.do?category=${category }">${category}</a>
		</div>
		<hr id="hr">
		<br>
		<div class="sort">
			<a href="product.do?sort=quality&category=${category}">품질등급순</a>&nbsp;&nbsp;
			<a href="product.do?sort=price_min&category=${category }">낮은가격순</a>&nbsp;&nbsp;
			<a href="product.do?sort=price_max&category=${category }">높은가격순</a>
		</div>
		<br>
		<div style="width: 100%; float: left;" id="product_box">
			<c:forEach items="${list }" var="list">
				<div class="hover" style="width: 23%; background-color: #DDDDDD; float: left; border: 5px solid; border-color: white; padding-top: 3px;">
					<a href="productDetail.do?product_id=${list.product_id }">
						<img src="resources/img/product/${list.main_img }"class="category_img"> <br>
						<p style="font-size: large;">${list.product_name }</p>
						
						<p>Category: ${list.category }</p>
						<p>Condition: ${list.quality }</p>
						<p>Price: ${list.price }WON/Month</p>
					</a>
				</div>
			</c:forEach>
		</div>

		<div>
			<c:forEach var="pageNum" begin="1" end="${pageMax }">
				<a
					href="product.do?pageNum=${pageNum }&category=${category}&order=${order}">${pageNum}</a>
			</c:forEach>
		</div>
	</div>
</body>
</html>