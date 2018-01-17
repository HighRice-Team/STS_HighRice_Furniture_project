<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		var d = new Date();
        $("#rent").html(d.getFullYear()+"년 "+(eval(d.getMonth())+1)+"월 "+(eval(d.getDate())));
		
    		$("#pwdDialog").dialog({
    		width:400,
        maxWidth:400,
        minWidth:400,
        autoOpen:false,
        modal:true,
        buttons:{
	           "확인":function(){
	               
		        	   	if(confirm("정보를 변경 하시겠습니까?")){
			        		$("#pwd_chk").val($("#pwd_chk2").val());
			            	$("#j_pwd").val($("#j_pwd2").val());
			 
			            	var data = $("#myForm").serializeArray();
			            	$.ajax({url:"updateMemberOkAjax.do",data:data,success:function(str){
			                   	
			            		if(str == "회원정보 변경 완료"){
			                        location.href="";
			                        $("#dialog").dialog("close");
			                        $("#pwdDialog").dialog("close");                     
			                     }            
			            		}
			            	})   
			               
		        	   	}
	            },
	            "취소":function(){
	               $("#pwdDialog").dialog("close");
	           	}
         	}
   		 })
	   	
   		 $("#dialog").dialog({
		 	width:800,
		 	maxWidth:800,
		 	minWidth:800,
		  	autoOpen:false,
		  	modal:true,
		 	buttons:{
		 		"수정":function(){         
		        		$("#pwdDialog").dialog("open");
		   
		               
		            },
		            "취소":function(){
		               $("#dialog").dialog("close");
		            }
		        	}
	   	
   		 });
	    	
	    	$("#updateBtn").click(function(){
			
	    		$.getJSON("getMemberInfoAjax.do",function(data){
	    			$("#name").html(data.name);
	    			// 멤버의 주소.
	            $("#roadAddrPart1").val(data.address);
	            $("#addrDetail").val(data.address_detail);
	            $("#tel").val(data.tel);
	            $("#member_id").html(data.member_id);
	            $("#jumin").html(data.jumin);
	            $("#account_no").val(data.account_no);   
	            $("#pwd_a").val(data.pwd_a);
	            $("#pwd_q").val(data.pwd_q);
	            $("#bank").val(data.bank);
	         });
	         $("#dialog").dialog("open");
	    	})
	    
	    	// 결제 페이지이동.
		$("#payment").click(function(){
			var product_id = $("#product_id").val();
			var rentMonth = $("#rentMonth").val();
				
			location.href="goPayment.do?rentMonth="+rentMonth+"&product_id="+product_id;
			});
		
	    	$("#reset").click(function(){
			if(confirm("이전 페이지로 돌아가시겠습니까?")){
			location.href="productDetail.do?product_id="+$("#product_id").val()
			}
				
		});
	    	
	});
</script>
<script type="text/javascript">

	function goPopup() {
		// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
		var pop = window.open("search.do", "pop",
				"width=570,height=420, scrollbars=yes, resizable=yes");

		// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
		//var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
	}
	/** API 서비스 제공항목 확대 (2017.02) **/
	function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail,
			roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,
			detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn,
			buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		document.myForm.roadAddrPart1.value = roadAddrPart1;
		document.myForm.roadAddrPart2.value = roadAddrPart2;
		document.myForm.addrDetail.value = addrDetail;
		document.myForm.zipNo.value = zipNo;
	}
</script>
</head>
<body>
	<table border="1" width="100%" cellspacing="30px">
		<tr>
			<td style="width: 40%; height: 500px; background-color: grey;"><h1><center>이미지영역</center></h1></td>
			<td style="font-variant: normal;">
					<input type="hidden" id="product_id" value="${productVo.product_id}">
					<input type="hidden" id="rentMonth" value="${rentMonth}">
					<h2>물품 정보</h2>
					<h4>제품명:  ${productVo.product_name}</h4>
					<h4>분류:  ${productVo.category}</h4>
					<h4>기간:  ${rentMonth} 개월</h4>
					<h4>가격:  ${productVo.price}</h4>
					<h4>총 가격:  ${productVo.price*rentMonth} 원</h4>
					<h2>구매 정보</h2>
					<h4>이름:  ${memberVo.name}</h4>
					<h4>연락처:  ${memberVo.tel}</h4>
					<h4>주소:  ${memberVo.address} ${memberVo.address_detail}</h4>
					<h4>대여 시작일: <span id = "rent"></span>일로부터 3일후.</h4><br>					
					<input type="button" id="updateBtn" value="회원정보 수정">			
			</td>
		</tr>
	</table>
	<div id="dialog">
		<center><h1>회원정보 수정</h1></center><br><br>
      	<form id="myForm" name="myForm">
        	<table border="1" cellpadding="5" cellspacing="0" width="100%">
        		<tr>
	            <td>이름</td>
	            <td><label id="name" name="name"></label></td>
         	</tr>
         	<tr>
	            <td>주소</td>
	            <td>
	            		<input type="text" id="roadAddrPart1" size="55%" name="address" readonly="readonly"> <input type="button"  value="주소검색" onclick="goPopup();"><br>
					<input type="text" id="addrDetail" readonly="readonly" name="address_detail" size="55%">
	            </td>
        		</tr>
         	<tr>
	           	<td id="title">핸드폰번호</td>
	           	<td><input type="text" id="tel" name="tel" size="50" value="" required="required"></td>
        		</tr>                     
      	</table>
	      	<!-- api 주소. -->
	      	<input type="hidden" id="roadAddrPart2"  value="">
			<input type="hidden" id="confmKey" name="confmKey" value=""  >
			<input type="hidden" id="zipNo" name="zipNo" readonly >
	      
	        <input type="hidden" id="bank" name="bank">         
	        <input type="hidden" id="account_no" name="account_no">         
	        <input type="hidden" id="pwd_q" name="pwd_q">         
	        <input type="hidden" id="pwd_a" name="pwd_a">         
	        <input type="hidden" id="member_id" name="id">               
	        <input type="hidden" id="j_pwd" name="j_pwd">               
	        <input type="hidden" id="pwd_chk" name="pwd_chk">   
      	</form>
      	
      	<form id="myForm2">
        		<div id="pwdDialog">
        		비밀번호:<input type="password" id="j_pwd2"><br>
        		비밀번호 확인:<input type="password" id="pwd_chk2"><br>
        		</div>
    		</form>
  	</div>
	<center><button id="payment">결제</button>
	<button id="reset">취소</button></center>
</body>
</html>