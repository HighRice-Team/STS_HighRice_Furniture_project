<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">

#name{
	font-size: 1.15vw;
}

p{
	font-size: 1vw;
	line-height: 10px; 
}

.slide-box {
	width: 600px;
	height: 400px;
	margin: auto;
	overflow: hidden;
	position: relative;
}

.slide-box img {
	width: 100%;
	height: 100%;
	display: block;
	position: absolute;
	top: 0px;
	left: -100%;
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
	$(".category_img").css("width", $("#product_box").width() * 0.225)
	$(".category_img").css("height", $("#product_box").width() * 0.225)

	//창의 크기가 변동 될 때 상품들의 이미지 크기를 조정.
	$(window).resize(function() {
		$(".category_img").css("width", $("#product_box").width() * 0.225)
		$(".category_img").css("height", $("#product_box").width() * 0.225)
	})

		var auto_slide;
		var auto_time = 1000; // 슬라이드 시간 1000 = 1초
		var auto_num = 0;

		$(".slide-box img").eq(auto_num).css({
			"left" : "0%"
		}); // 처음로드시 첫이미지 보이기
		auto_slide = setInterval(function() {
			slide_start()
		}, auto_time);

		function slide_start() { // 슬라이드 구현
			var no = auto_num + 1;
			if (no >= $(".slide-box img").length) {
				no = 0;
			}
			$(".slide-box img").eq(no).css({
				"left" : "-100%"
			}).stop().animate({
				"left" : "0%"
			});
			$(".slide-box img").eq(auto_num).stop().animate({
				"left" : "100%"
			});
			auto_num = no;
		}
		$(".slide-box").hover(function() { // 마우스 오버시 슬라이드 멈춤
			clearInterval(auto_slide);
		}, function() { // 마우스 아웃시 다시 시작
			auto_slide = setInterval(function() {
				slide_start()
			}, auto_time);
		});

	});
</script>
<script type="text/javascript">
function cus() {
    str=""
    if(document.F.min.value==0)
    {
       str+="<option value=null disabled='disabled' selected='selected'>최고금액</option>"
       str+="<option value=0>선택 안함</option>"
        str+="<option value=3000>~3,000</option>"
       str+="<option value=5000>~5,000</option>"
       str+="<option value=7000>~7,000</option>"
       str+="<option value=9000>~9,000</option>"
          
    }
    if(document.F.min.value=="1000")
    {
       str+="<option value=null disabled='disabled' selected='selected'>최고금액</option>"
       str+="<option value=0>선택 안함</option>"
        str+="<option value=3000>~3,000</option>"
       str+="<option value=5000>~5,000</option>"
       str+="<option value=7000>~7,000</option>"
       str+="<option value=9000>~9,000</option>"
       
    }else if(document.F.min.value=="3000")
    {
       str+="<option value=null disabled='disabled' selected='selected'>최고금액</option>"
       str+="<option value=0>선택 안함</option>"
       str+="<option value=5000>~5,000</option>"
       str+="<option value=7000>~7,000</option>"
       str+="<option value=9000>~9,000</option>"
    }else if(document.F.min.value=="5000")
    {
       str+="<option value=null disabled='disabled' selected='selected'>최고금액</option>"
       str+="<option value=0>선택 안함</option>"
       str+="<option value=7000>~7,000</option>"
       str+="<option value=9000>~9,000</option>"
    }else if(document.F.min.value=="7000")
    {
       str+="<option value=null disabled='disabled' selected='selected'>최고금액</option>"
       str+="<option value=0>선택 안함</option>"
          str+="<option value=9000>~9,000</option>"
    }
    document.getElementById("max").innerHTML=str
    
 }
</script>
</head>
<body>
	<!-- 이미지 슬라이드 -->
	<div class="slide-box" style="width: 100%; height: 300px; position: relative;">
		<a href="#"><img src="resources/img/slide1.jpg" alt="slide"></a>
		<a href="#"><img src="resources/img/slide2.jpg" alt="slide"></a>
		<a href="#"><img src="resources/img/slide3.jpg" alt="slide"></a>
		<a href="#"><img src="resources/img/slide4.jpg" alt="slide"></a>
	</div>
	
	
	<div style="margin: 0 15% 0 15%; padding: 40px 0 40px 0;">
		<form action="index.do" method="post" name="F">

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
			<div style="width:100%; float: left; padding-bottom: 10px;" id="product_box">
				<c:forEach items="${list }" var="list">
					<div class="hover" style="width: 23%; background-color: #DDDDDD; float: left; border: 5px solid; border-color: white; padding-top: 3px;">
						<a href="productDetail.do?product_id=${list.product_id }">
							<img src="resources/img/product/${list.main_img }"class="category_img"> <br>
							<p id="name">${list.product_name }</p>
							
							<p>Category: ${list.category }</p>
							<p>Condition: ${list.quality }</p>
							<p>Price: ${list.price }WON/Month</p>
						</a>
					</div>
				</c:forEach>
			</div>
			
			
			<!--페이징처리 부분 -->
			<div>
				<center>
					<c:forEach var="pageNum" begin="1" end="${pageMax }">
						<a href="index.do?pageNum=${pageNum }&category=${category}&quality=${quality}&max=${max }&min=${min }" style="font-size: 1.15vw;">${pageNum}</a>
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