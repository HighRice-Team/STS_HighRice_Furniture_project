<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
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
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		// 상태유지. 드롭박스를 선택 후 페이지가 넘어가도 현재 상태가 유지 된다.
		if ($("#category2").val() != "") {
			$("select[name=category]").val($("#category2").val())
		}
		if ($("#max2").val() != 0) {
			$("select[name=max]").val($("#max2").val())
		}
		if ($("#min2").val() != 0) {
			$("select[name=min]").val($("#min2").val())
		}
		if ($("#quality2").val() != "") {
			$("select[name=quality]").val($("#quality2").val())
		}
		
		
		// 각 상품에 대하여 하이라이트 효과를 적용.
		$(document).on("mouseover",".hover", function() {
			$(this).addClass("over");
		})
		$(document).on("mouseout",".hover", function() {
			$(this).removeClass("over");
		})
		

		//창을 띄울 때 상품들의 이미지 크기를 조정.
		$(".category_img").css("width", $("#product_box").width() * 0.22)
		$(".category_img").css("height", $("#product_box").width() * 0.13)
		
		//창의 크기가 변동 될 때 상품들의 이미지 크기를 조정.
		$(window).resize(function() {
			$(".category_img").css("width", $("#product_box").width() * 0.22)
			$(".category_img").css("height", $("#product_box").width() * 0.13)
		})
	});
</script>
</head>
<body>
	<div style="margin: 0 15% 0 15%; padding: 40px 0 40px 0;">
		<form action="customize.do" method="post" name="F">

			<!--카테고리 드롭박스 -->
			<select name="category">
				<option value=null disabled="disabled" selected="selected">분류</option>
				<option value="">선택 안함</option>
				<option value='SOFA'>소파</option>
				<option value='BED'>침대</option>
				<option value='CLOSET'>옷장</option>
				<option value='DESK'>책상</option>
			</select>
			
			<!--품질 드롭박스 -->
			<select name="quality">
				<option value=null disabled="disabled" selected="selected">품질</option>
				<option value="">선택 안함</option>
				<option value='A'>A급</option>
				<option value='B'>B급</option>
				<option value='C'>C급</option>
			</select>
			
			<!--최소금액 드롭박스 -->
			<select name="min" onchange="cus()">
				<option value=null disabled="disabled" selected="selected">최저금액</option>
				<option value=0>선택 안함</option>
				<option value=1000>1,000~</option>
				<option value=3000>3,000~</option>
				<option value=5000>5,000~</option>
				<option value=7000>7,000~</option>
			</select>
			
			<!--최대금액 드롭박스 -->
			<select name="max" id="max">
				<option value=null disabled="disabled" selected="selected">최고금액</option>
				<option value=0>선택 안함</option>
				<option value=1>~1,000</option>
				<option value=3000>~3,000</option>
				<option value=5000>~5,000</option>
				<option value=7000>~7,000</option>
				<option value=9000>~9,000</option>
			</select>
			
			<input type="submit" value="검색"><br><br>
			
			<!--상품목록 -->
			<div style="width:100%; float: left;" id="product_box">
				<c:forEach items="${list }" var="list">
					<div class="hover" style="width:23%; background-color:#DDDDDD; float:left; border: 5px solid; border-color: white;">
						<a href="productDetail.do?product_id=${list.product_id }">
						<br>${list.product_name }<br><br>
						<img src="resources/img/product/${list.main_img }" class="category_img">
						<br>${list.category }
						<br>${list.quality }
						<br>${list.price }</a>
					</div>
				</c:forEach>
			</div>
			
			
			<!--페이징처리 부분 -->
			<div>
				<center>
					<c:forEach var="pageNum" begin="1" end="${pageMax }">
						<a href="customize.do?pageNum=${pageNum }&category=${category}&quality=${quality}&max=${max }&min=${min }">${pageNum}</a>
					</c:forEach>
				</center>
			</div>
		</form>
		
		<!--검색조건 상태유지 -->
		<input type="hidden" id="category2" value="${category }">
		<input type="hidden" id="max2" value="${max }">
		<input type="hidden" id="min2" value="${min }">
		<input type="hidden" id="quality2" value="${quality }">
	</div>
</body>
</html>