<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>​
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
.menu_myPage{
	background-color: #EEEEEE;
}
.over_myPage{
	background-color: white;
}
.selectedMenu{
	background-color:white;
}
	
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">
	$(function () {
		var selectedMenu = $("#selectedMyPage").val()
		if(selectedMenu=="mP"){		$("#mP").addClass("selectedMenu")		}
		if(selectedMenu=="oL"){		$("#oL").addClass("selectedMenu")		}
		if(selectedMenu=="sL"){		$("#sL").addClass("selectedMenu")		}
		if(selectedMenu=="s"){		$("#s").addClass("selectedMenu")		}
		
		$(document).on("mouseover",".menu_myPage", function() {
			$(this).addClass("over_myPage");
		})
		$(document).on("mouseout",".menu_myPage", function() {
			$(this).removeClass("over_myPage");
		})
		
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
		
		$("#myOrderlist_grid").jsGrid({
	        width: "100%",
	        height: "auto",
	        filtering: true,
	        sorting: true,
	        paging: true,
	        autoload: true,
	        autosearch:true,
	        pageSize : 10,
	        pageButtonCount:5,
	        
	        controller : {
	        	loadData:function(filter){
	        		return $.ajax({
	        			type:"POST",
	        			url:"getMyOrderlist.do",
	        			data:filter,
	        			dataType:"JSON"
	        		})
	        	}
	        },
	        
	        fields: [
	            { name: "pay_date", title:"주문일자[주문번호]",  type: "number", width: 50},
	            { name: "main_img", title:"이미지",  itemTemplate:function(_,item){  return $("<img>").attr("src","resources/img/product/"+item.main_img).attr("width","100%") }, width: 50},
	            { name: "product_name", title:"상품정보", type: "text", width: 200 },
	            { name: "price", title:"상품 구매금액",  itemTemplate:function(_,item){  return item.price*item.rent_month}, type: "text", width: 50 },
	            { name: "con", title:"주문처리상태", type: "text",width:50},
	            { name: "버튼", width:50 }
	        ]
		});
		
	})
</script>

<script type="text/javascript">

//	마이페이지에서 회원정보 변경을 위한 다일로그 오픈

	function showMemberInfo(){
		$("#dialog").dialog("open")
		var data = {'member_id':$("#id_mypage").val()}
		
		$.ajax({url:"getOne_member_ajax.do", data:data ,success:function(data){
			
			data = eval('('+data+')')
			
			$("#member_id").html(data.member_id);
			$("#name").html(data.name);
			$("#jumin").html(data.jumin);
			$("#account_no").val(data.account_no);
			$("#address3").val(data.address3);
			$("#tel").val(data.tel);
			$("#pwd_a").val(data.pwd_a);
			$("#pwd_q").val(data.pwd_q);
			$("#bank").val(data.bank);
			$("#roadAddrPart1").val(data.address);
			$("#addrDetail").val(data.address_detail);
		}})
		$("#dialog").dialog("open");
	}

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
	<c:if test="${selectedMyPage=='mP' }">
		<center>
		<div style="width: 93%; height: 130px; position: relative; padding-top: 20px;">
			<div style="float: left; width:7%; height: 90%;"><img src="resources/img/myPageGradeImg.PNG" width="100%" height="100%"></div>
			<div style="float:left; width:92%; height: 90%; background-color: #EEEEEE;">
				<div style="padding-bottom: 2px;">
					<p style="font-size: 0.9vw;">저희 BIT FR 가구점을 이용해 주셔서 감사합니다. ${member.name } 님은 <c:if test="${grade==1 }">[일반]</c:if><c:if test="${grade==0 }">[관리자]</c:if> 회원이십니다.<br><br>무통장입금으로 50,000원 이상 구매시 1%을 추가적립 받으실 수 있습니다.</p>
				</div><center>
				<div style="padding-left:13%; float: left; width: 15%;border-right: 1px solid grey; height:40%;"><a style="font-size: 1vw;">입금완료<br>${rent1 }건</a></div>
				<div style="float: left; width: 15%;border-right: 1px solid grey; height:40%;"><a style="font-size: 1vw;">배송중<br>${rent2 }건</a></div>
				<div style="float: left; width: 15%;border-right: 1px solid grey; height:40%;"><a style="font-size: 1vw;">대여중<br>${rent3 }건</a></div>
				<div style="float: left; width: 15%;border-right: 1px solid grey; height:40%; "><a style="font-size: 1vw;">반납<br>${rent4 }건</a></div>
				<div style="float: left; width: 15%; height:40%; "><a style="font-size: 1vw;">나의 물건<br>${rent4 }건</a></div></center>
			</div>
		</div>
		<div style=" width:93%; height:1000px; position: relative;">
			<div style="float: left; width: 10%;">
				<div style="height: 30px;"></div>
				<a href="myPage.do?selectedMyPage=mP"><div style="width: 100%; margin-bottom: 3px;" class="menu_myPage" id="mP">마이페이지</div></a>
				<a href="myPage.do?selectedMyPage=oL"><div style="width: 100%; margin-bottom: 3px;" class="menu_myPage" id="oL">주문내역</div></a>
				<a href="myPage.do?selectedMyPage=sL"><div style="width: 100%; margin-bottom: 3px; " class="menu_myPage" id="sL">판매내역</div></a>
				<a onclick="showMemberInfo()"><div style="width: 100%; margin-bottom: 3px; " class="menu_myPage" id="mI">회원정보</div></a>
				<a href=""><div style="width: 100%; margin-bottom: 3px; " class="menu_myPage" id="s">판매하기</div></a>
			</div>
			<div style="float: left; width: 88%; padding-left: 1%;">
	<!-- 			<div><img src="resources/img/slide1.jpg" width="100%" height="150px"></div> -->
				<div>
					<div style="float:left; width:15%; text-align: left; padding-left: 40px; padding-top: 10px; padding-bottom:10px; font-size: 1.3vw; font-weight: bold;">최근 주문내역</div>
					<div style="float:left; width:70%; text-align: right; padding-left: 40px; padding-top: 28px; padding-bottom:2px; font-weight: bold;"><a style="font-size: 0.8vw;">더보기</a></div>
					<div style="text-align: left;">
						<table width="100%" style="text-align: center;">
							<thead style="background-color: #EEEEEE;  font-size: 1vw;">
								<th style="border-bottom: 1px solid grey;">주문일자<br>[주문번호]</th>
								<th style="border-bottom: 1px solid grey;">이미지${chkRecentList }</th>
								<th style="border-bottom: 1px solid grey;">상품정보</th>
								<th style="border-bottom: 1px solid grey;">상품 구매금액</th>
								<th style="border-bottom: 1px solid grey;">주문처리상태</th>
								<th style="border-bottom: 1px solid grey;">취소/교환/반품</th>
							</thead>
	<!-- 						최근 2주 이내에 구매한 물품 보이기 -->
							<c:if test="${chkRecentList==null }">
								<tr>
									<td colspan="6">주문 내역이 없습니다.</td>
								</tr>
							</c:if>
							<c:if test="${chkRecentList!=null }">
								<c:forEach items="${recentList }" var="recentList">
									<tr>
										<td>${recentList.pay_date } <b>[${recentList.order_id }]</b></td>
										<td>${recentList.main_img }</td>
										<td>${recentList.product_name }</td>
										<td>${recentList.rent_month * recentList.price}</td>
										<td>${recentList.con}</td>
										<td>
											<c:if test="${recentList.con=='입금완료'}">
												<input type="button" value="취소"> 
											</c:if>
											<input type="button" value="교환">
											<input type="button" value="반품">
										</td>
									</tr>
								</c:forEach>
							</c:if>
							<tr>
								<td colspan="6" style="background-color: #EEEEEE"></td>	
							</tr>
						</table>
					</div>
					
					<div style="float:left; width:15%; text-align: left; padding-left: 40px; padding-top: 50px; padding-bottom:10px; font-size: 1.3vw; font-weight: bold;">최근 게시물</div>
					<div style="float:left; width:70%; text-align: right; padding-left: 40px; padding-top: 68px; padding-bottom:2px; font-weight: bold;"><a style="font-size: 0.8vw;">더보기</a></div>
					<div style="text-align: left;">
						<table width="100%" style="text-align: center;">
							<thead style="background-color: #EEEEEE;  font-size: 1vw;">
								<th style="border-bottom: 1px solid grey;">번호</th>
								<th style="border-bottom: 1px solid grey;">분류</th>
								<th style="border-bottom: 1px solid grey;">제목</th>
								<th style="border-bottom: 1px solid grey;">작성자</th>
								<th style="border-bottom: 1px solid grey;">작성일</th>
							</thead>
	<!-- 						최근 1달 이내에 작성한 게시글 보이기 -->
							<c:if test="${resentBoard==null }">
								<tr>
									<td colspan="5">게시물이 없습니다.</td>
								</tr>
							</c:if>
							<tr>
								<td colspan="6" style="background-color: #EEEEEE"></td>	
							</tr>
						</table>
					</div>
				<div>
					<div style="text-align: left; padding-left: 40px; padding-top: 50px; padding-bottom:30px; font-size: 1.3vw; font-weight: bold;">내가 등록한 판매물품</div>
						<c:if test="${not empty list }"> 
			 			<div class="slider" style="width:23%; background-color:#DDDDDD; height:200px; float:left; border: 5px solid; border-color: white;">
			 				<c:forEach items="${list }" var="list">
			 					<div class="hover" style="width: 23%; background-color: #DDDDDD; float: left; border: 5px solid; border-color: white; padding-top: 3px;">
			 						<a href="productDetail.do?product_id=${list.product_id }">
			 							<img src="resources/img/product/${list.main_img}"> <br>
			 							<p id="name_product">${list.product_name }</p>
										
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
			</div>
		</div>
		<center>
	</c:if>
	<c:if test="${selectedMyPage=='oL' }">
		<center>
		<div style="width: 93%; height: 130px; position: relative; padding-top: 20px;">
			<div style="float: left; width:7%; height: 90%;"><img src="resources/img/myPageGradeImg.PNG" width="100%" height="100%"></div>
			<div style="float:left; width:92%; height: 90%; background-color: #EEEEEE;">
				<div style="padding-bottom: 2px;">
					<p style="font-size: 0.9vw;">저희 BIT FR 가구점을 이용해 주셔서 감사합니다. ${member.name } 님은 [일반] 회원이십니다.<br><br>무통장입금으로 50,000원 이상 구매시 1%을 추가적립 받으실 수 있습니다.</p>
				</div><center>
				<div style="padding-left:13%; float: left; width: 15%;border-right: 1px solid grey; height:40%;"><a style="font-size: 1vw;">입금완료<br>${rent1 }건</a></div>
				<div style="float: left; width: 15%;border-right: 1px solid grey; height:40%;"><a style="font-size: 1vw;">배송중<br>${rent2 }건</a></div>
				<div style="float: left; width: 15%;border-right: 1px solid grey; height:40%;"><a style="font-size: 1vw;">대여중<br>${rent3 }건</a></div>
				<div style="float: left; width: 15%;border-right: 1px solid grey; height:40%; "><a style="font-size: 1vw;">반납<br>${rent4 }건</a></div>
				<div style="float: left; width: 15%; height:40%; "><a style="font-size: 1vw;">나의 물건<br>${rent4 }건</a></div></center>
			</div>
		</div>
		<div style=" width:93%; height:1000px; position: relative;">
			<div style="float: left; width: 10%;">
				<div style="height: 30px;"></div>
				<a href="myPage.do?selectedMyPage=mP"><div style="width: 100%; margin-bottom: 3px;" class="menu_myPage" id="mP">마이페이지</div></a>
				<a href="myPage.do?selectedMyPage=oL"><div style="width: 100%; margin-bottom: 3px;" class="menu_myPage" id="oL">주문내역</div></a>
				<a href="myPage.do?selectedMyPage=sL"><div style="width: 100%; margin-bottom: 3px; " class="menu_myPage" id="sL">판매내역</div></a>
				<a onclick="showMemberInfo()"><div style="width: 100%; margin-bottom: 3px; " class="menu_myPage" id="mI">회원정보</div></a>
				<a href=""><div style="width: 100%; margin-bottom: 3px; " class="menu_myPage" id="s">판매하기</div></a>
			</div>
			<div style="float: left; width: 88%; padding-left: 1%;">
				<div>
					<table id="myOrderlist_grid" border="1" cellpadding="10px" cellspacing="10px" class="table" style="text-align: center;">
						
					</table>
				
				</div>
					
			</div>
		</div>
		<center>
	</c:if>
	<c:if test="${selectedMyPage=='sL' }">
		<center>
		<div style="width: 93%; height: 130px; position: relative; padding-top: 20px;">
			<div style="float: left; width:7%; height: 90%;"><img src="resources/img/myPageGradeImg.PNG" width="100%" height="100%"></div>
			<div style="float:left; width:92%; height: 90%; background-color: #EEEEEE;">
				<div style="padding-bottom: 2px;">
					<p style="font-size: 0.9vw;">저희 BIT FR 가구점을 이용해 주셔서 감사합니다. ${member.name } 님은 [일반] 회원이십니다.<br><br>무통장입금으로 50,000원 이상 구매시 1%을 추가적립 받으실 수 있습니다.</p>
				</div><center>
				<div style="padding-left:13%; float: left; width: 15%;border-right: 1px solid grey; height:40%;"><a style="font-size: 1vw;">입금완료<br>${rent1 }건</a></div>
				<div style="float: left; width: 15%;border-right: 1px solid grey; height:40%;"><a style="font-size: 1vw;">배송중<br>${rent2 }건</a></div>
				<div style="float: left; width: 15%;border-right: 1px solid grey; height:40%;"><a style="font-size: 1vw;">대여중<br>${rent3 }건</a></div>
				<div style="float: left; width: 15%;border-right: 1px solid grey; height:40%; "><a style="font-size: 1vw;">반납<br>${rent4 }건</a></div>
				<div style="float: left; width: 15%; height:40%; "><a style="font-size: 1vw;">나의 물건<br>${rent4 }건</a></div></center>
			</div>
		</div>
		<div style=" width:93%; height:1000px; position: relative;">
			<div style="float: left; width: 10%;">
				<div style="height: 30px;"></div>
				<a href="myPage.do?selectedMyPage=mP"><div style="width: 100%; margin-bottom: 3px;" class="menu_myPage" id="mP">마이페이지</div></a>
				<a href="myPage.do?selectedMyPage=oL"><div style="width: 100%; margin-bottom: 3px;" class="menu_myPage" id="oL">주문내역</div></a>
				<a href="myPage.do?selectedMyPage=sL"><div style="width: 100%; margin-bottom: 3px; " class="menu_myPage" id="sL">판매내역</div></a>
				<a onclick="showMemberInfo()"><div style="width: 100%; margin-bottom: 3px; " class="menu_myPage" id="mI">회원정보</div></a>
				<a href=""><div style="width: 100%; margin-bottom: 3px; " class="menu_myPage" id="s">판매하기</div></a>
			</div>
			<div style="float: left; width: 88%; padding-left: 1%;">
				
					
			</div>
		</div>
		<center>
	</c:if>
	<c:if test="${selectedMyPage=='mI' }">
		<center>
		<div style="width: 93%; height: 130px; position: relative; padding-top: 20px;">
			<div style="float: left; width:7%; height: 90%;"><img src="resources/img/myPageGradeImg.PNG" width="100%" height="100%"></div>
			<div style="float:left; width:92%; height: 90%; background-color: #EEEEEE;">
				<div style="padding-bottom: 2px;">
					<p style="font-size: 0.9vw;">저희 BIT FR 가구점을 이용해 주셔서 감사합니다. ${member.name } 님은 [일반] 회원이십니다.<br><br>무통장입금으로 50,000원 이상 구매시 1%을 추가적립 받으실 수 있습니다.</p>
				</div><center>
				<div style="padding-left:13%; float: left; width: 15%;border-right: 1px solid grey; height:40%;"><a style="font-size: 1vw;">입금완료<br>${rent1 }건</a></div>
				<div style="float: left; width: 15%;border-right: 1px solid grey; height:40%;"><a style="font-size: 1vw;">배송중<br>${rent2 }건</a></div>
				<div style="float: left; width: 15%;border-right: 1px solid grey; height:40%;"><a style="font-size: 1vw;">대여중<br>${rent3 }건</a></div>
				<div style="float: left; width: 15%;border-right: 1px solid grey; height:40%; "><a style="font-size: 1vw;">반납<br>${rent4 }건</a></div>
				<div style="float: left; width: 15%; height:40%; "><a style="font-size: 1vw;">나의 물건<br>${rent4 }건</a></div></center>
			</div>
		</div>
		<div style=" width:93%; height:1000px; position: relative;">
			<div style="float: left; width: 10%;">
				<div style="height: 30px;"></div>
				<a href="myPage.do?selectedMyPage=mP"><div style="width: 100%; margin-bottom: 3px;" class="menu_myPage" id="mP">마이페이지</div></a>
				<a href="myPage.do?selectedMyPage=oL"><div style="width: 100%; margin-bottom: 3px;" class="menu_myPage" id="oL">주문내역</div></a>
				<a href="myPage.do?selectedMyPage=sL"><div style="width: 100%; margin-bottom: 3px; " class="menu_myPage" id="sL">판매내역</div></a>
				<a onclick="showMemberInfo()"><div style="width: 100%; margin-bottom: 3px; " class="menu_myPage" id="mI">회원정보</div></a>
				<a href=""><div style="width: 100%; margin-bottom: 3px; " class="menu_myPage" id="s">판매하기</div></a>
			</div>
			<div style="float: left; width: 88%; padding-left: 1%;">
				
					
			</div>
		</div>
		<center>
	</c:if>
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
						<option value="자신의 보물 제1호는?">자신의 보물 제1호는?</option>
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
			<input type="hidden" id="selectedMyPage" value="${selectedMyPage }">
		</table>
		</form>
		</div>
</body>
</html>