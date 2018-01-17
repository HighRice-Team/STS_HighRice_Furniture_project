<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- <link rel="stylesheet" href="./css/jquery-ui.min.css"> -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<style type="text/css">
.over {
		
		background-color:#606060;  
		text-align:center; transition:all 0.8s, color 0.3s 0.3s;  
		color:#504f4f; cursor: pointer;  
	}

.over:hover{
		box-shadow:
			400px 0 0 0  rgba(0,0,0,0.25) inset, 
			-400px 0 0 0  rgba(0,0,0,0.25) inset;
	}
.over a{
	color : white;
	}
 #name{
	font-size: 1.15vw;
}

p{
	font-size: 1vw;
	line-height: 10px; 
}


	
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">
	$(function () {
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
		
		$(".slider").bxSlider({
			mode:'horizontal',
			slideWidth : 300,
			pager:false,
			preloadImages:'all',
 			minSlides:4,
			maxSlides:4,
			moveSlides:4,
			infiniteLoop:true
		});
		
		
		
	})
</script>

<script type="text/javascript">
	// 	주소검색 API
	function goPopup(){
		// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
	    var pop = window.open("search.do","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	    
		// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
	    //var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
		}
		/** API 서비스 제공항목 확대 (2017.02) **/
	function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn
							, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo){
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		document.form.roadAddrPart1.value = roadAddrPart1;
		document.form.roadAddrPart2.value = roadAddrPart2;
		document.form.addrDetail.value = addrDetail;
		document.form.zipNo.value = zipNo;
	}
</script>
</head>
<body>
	<div style="margin: 0 15% 0 15%; padding: 40px 0 40px 0;">
		<h2>MY PAGE</h2><hr>
		<div style="border: 1px solid; height: 100px;">
			<div style="width: 100px; float: left; margin-left:  0px ">
				<img src="resources/img/myPage.JPG"  style="position:absolute; height: 100px; width:100px; background: grey;">
			</div>
			<div style="width: 80%; float: right;">
				<p>${member.name }회원님 저희 비트가구 대여 사이트를 이용해 주셔서 감사합니다.
		 	</div>
		</div>
		<div style="height: 40px; text-align: right;">
			<input type="button" value="회원정보수정" >
			<input type="button" value="비밀번호변경" id="change_pwd">
			<input type="button" value="로그아웃" >
		</div>
		<div>
			<table border="0" width="100%">
				<tr><td><h2>SELL</h2></td><td><h2>MY RENT</h2></td></tr>
				<tr><td rowspan="4" width="30%" style="border: 1px solid;"><a href="sellWrite.do"><img src="resources/img/SELL.JPG" style="width:100%; background: grey;"></a></td><td style="border: 1px solid;"><a href="orderlistByCondition.do"><b>입금완료 : ${rent1 }</b></a></td></tr>		
				<tr><td style="border: 1px solid;"><a href="orderlistByCondition.do"><b>배송중 : ${rent2 }</b></a></td></tr>		
				<tr><td style="border: 1px solid;"><a href="orderlistByCondition.do"><b>대여중 : ${rent3 }</b></a></td></tr>		
				<tr><td style="border: 1px solid;"><a href="orderlistByCondition.do"><b>반납 : ${rent4 }</b></a></td></tr>		
			</table>	
		</div>
		<div style="height: 100px;"></div>
		<div style="height: 30px; padding-bottom: 30px;"><h2>SELL LIST</h2></div>
			<c:if test="${not empty list }">
			<div class="slider" style="width:23%; background-color:#DDDDDD; float:left; border: 5px solid; border-color: white;">
				<c:forEach items="${list }" var="list">
 					<div class="hover" style="width: 23%; background-color: #DDDDDD; float: left; border: 5px solid; border-color: white; padding-top: 3px;">
						<a href="productDetail.do?product_id=${list.product_id }">
							<img src="resources/img/product/${list.main_img}"> <br>
							<p id="name">${list.product_name }</p>
							
							<p>Category: ${list.category }</p>
							<p>Condition: ${list.quality }</p>
							<p>Price: ${list.price }WON/Month</p>
						</a>
							<c:if test="${list.condition=='등록' }">
 								<input type="button" value="삭제"><br>&nbsp;
 							</c:if>
 							<c:if test="${list.condition!='등록' }">
 								<br>&nbsp;
 							</c:if>
					</div>
 				</c:forEach>
			</div>
			</c:if>
	</div>
	
	<div id="changePwd">
		<table>
			<tr>
				<td>현재 비밀번호</td>
				<td><input type="password" id="oldPwd"></td>
			</tr>
			<tr>
				<td>변경할 비밀번호</td>
				<td><input type="password" id="newPwd"></td>
			</tr>
			<tr>
				<td>변경할 비밀번호 확인</td>
				<td><input type="password" id="chk_newPwd"></td>
			</tr>
		</table>
	</div>
	
	<div id="dialog">
		<center><h1>회원정보 수정</h1></center><br><br>
		<form id="form" name="form" method="post">
			<table border="1" cellpadding="5" cellspacing="0" width="100%">
			<tr>
				<td id="title" width="15%">아이디</td>
					<td colspan="3" id="member_id">
					<input type="hidden" id="id_mypage" name = "member_id" value="${member.member_id }">
				</td>
			</tr>


			<tr>
				<td id="title">이름</td>
				<td colspan="4" id="name" name="name"></td>
			</tr>

			<tr>
				<td id="title">주민번호</td>
				<td colspan="4" id="jumin" name="jumin"></td>
			</tr>

			<tr>
				<td id="title">계좌번호</td>
				<td>	
					<select id="bank" name="bank">
						<option value="국민">국민</option>
						<option value="신한">신한</option>
						<option value="농협">농협</option>
						<option value="기업">기업</option>
						<option value="우리">우리</option>
					</select> 
						<input type="text" id="account_no" name="account_no" size="40" value="" required="required">
				</td>
			</tr>

			<tr>
				<td id="title">주소</td>
				<td>	
					<input type="text" id="roadAddrPart1" size="55%" name="address" readonly="readonly"> <input type="button"  value="주소검색" onclick="goPopup();"><br>
					<input type="text" id="addrDetail" readonly="readonly" name="address_detail" size="55%">
				</td>
			</tr>
			<tr>
				<td id="title">핸드폰번호</td>
				<td colspan="4"><input type="text" id="tel" name="tel" size="50" value="" required="required">
				</td>
			</tr>
			<tr>
				<td id="title">비밀번호 힌트</td>
				<td colspan="4"><select id="pwd_q" name="pwd_q">
						<option value="자신의 보물 제 1호는?">자신의 보물 제 1호는?</option>
						<option value="자신의 출신 초등학교는?">자신의 출신 초등학교는?</option>
						<option value="인상깊게 읽은 책 이름은?">인상깊게 읽은 책 이름은?</option>
						<option value="가장 기억에 남는 선물은?">가장 기억에 남는 선물은?</option>
						
				</select></td>
			</tr>
			<tr>
				<td id="title">힌트 답</td>
				<td colspan="4"><input type="text" name="pwd_a" id="pwd_a" maxlength="50" value="" required="required">
				</td>
			</tr>
			<input type="hidden" id="roadAddrPart2"  value="">
			<input type="hidden" id="confmKey" name="confmKey" value=""  >
			<input type="hidden" id="zipNo" name="zipNo" >
		</table>
		</form>
		</div>
</body>
</html>