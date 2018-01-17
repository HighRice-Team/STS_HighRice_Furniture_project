<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
   .light{
      background-color: gray;
   }
   input[type=checkbox]{
      vertical-align: middle;
       -ms-transform: scale(1.4);
        -moz-transform: scale(1.4);
        -webkit-transform: scale(1.4);
        -o-transform: scale(1.4);
   }
   #product_id{
      width : 7%;
   }
   
   input[type=number]{
      width : 30px;
   }
   
   img{
      width :200px;
   }
   
   #price, #total{
      width : 15%;
   }
</style>
<title>Insert title here</title>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
 $(function(){

    $(".goods").hover(function(){
       $(this).addClass("light");
    },function(){
       $(this).removeClass("light");
    })
    
    $("#paymentReset").click(function(){ $("#paymentInfo").dialog("close")})
    $("#paymentChk").click(function(){
       $("#pwdDialog2").dialog("open");
    })
    
    $("#paymentBtn").click(function(){
       if($('input[type=checkbox]:checked').length>0){
          $("#countProduct").text($('input[type=checkbox]:checked').length);
          $("#tot_price").text($("#pay").val());
          $("#mem_name").text($("#memName").val());
          //나의 풀 주소 
          $("#mem_addr").text($("#roadAddrPart1").val()+"\t"+$("#addrDetail").val());
          $("#mem_tel").text($("#memTel").val());
          $("#paymentInfo").dialog("open");
       }else{
          alert("상품을 선택하시오.");
       }
    })
    
    $("#deleteBtn").click(function(){
      
      var a = $('input[type=checkbox]:checked');
      var a_len = $(a).length;
       if(confirm(a_len+"건의 상품을 삭제하시겠습니까?")){
         $.each(a,function(index,item){
         	var value = $(this).val()
 			var par = $(this).parent()
        		var tr = $(par).parent()
         	var product_id = $(tr).find("#product").val()
          	var data = {"product_id":product_id};
            $.ajax({
                url:"deleteOrderListAjax.do",
                data:data
             });
         })
         location.href="";
      }
   });
    
    $("#paymentInfo").dialog({
       autoOpen:false,
       modal:true,
       autowidth:true
    });
    $("#pwdDialog2").dialog({
         width:400,
         maxWidth:400,
         minWidth:400,
         autoOpen:false,
         modal:true,
         buttons:{
            "확인":function(){
               var pwd = $("#pPwd").val()
               var pwd2 = $("#pPwd2").val()
               var data={"pwd":pwd,"pwd2":pwd2};
               
               $.ajax({
                  url:"pwdChk.do",
                  data:data,
                  success:function(data){
                	  
                	  	if(data == ('일치') ){
                	  		
                     	$('input[type=checkbox]:checked').each(function(index,item){
	                     	var product_id = $(this).val()
	                     	var paymentOne = $("#tot_price").text()
	                        	var data = {"product_id":product_id , "paymentOne":paymentOne}
	                     	
	                    		$.ajax({	                        	 
	                        		url : "updateConditionOderlistAjax.do",
	                       		data : data,
	                            	success : function(data) {
		                            		if( data == '1'){
	                            				paymentOk_msg = "결제가 성공적으로 완료되었습니다.";
	                            				alert(paymentOk_msg);
		                            		}else if( data == '-10'){
		                            			paymentOk_msg = "잔액이 부족합니다.";
		                            			alert(paymentOk_msg);
		                            		}else{
	                            				paymentOk_msg = "결제에 실패하였습니다.";
	                            				alert(paymentOk_msg);
	                            			}
									}
	                            			
	                         });
                        })
                        $("#pwdDialog2").dialog("close");
                        $("#paymentInfo").dialog("close");
                        location.href="";
                     }else{
                        alert(data);
                     }
                  }
               })
               
            },
            "취소":function(){
               $("#pwdDialog2").dialog("close");
               $("#paymentInfo").dialog("close");
            }
         }
    })
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
                   	
                     if(str == "회원정보 변경 완료")
                     {
                        location.href="";
                        $("#dialog").dialog("close");
                        $("#pwdDialog").dialog("close");                     
                     }            
                  }})   
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
    
    $("#update").click(function(){
		
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
    
   
    
    $('input[type = checkbox]').change(function(){
       var sum = 0;
       var a = $('input[type=checkbox]:checked'); 
       
       if(a.length > 0)
       {
          a.each(function(index,item){
             
          var value = $(this).val()
          var par = $(this).parent()
          var tr = $(par).parent()
          sum += Number(tr.find("#total").html())
         $("#count").val(index+1) 
         $("#pay").val(sum)
         $("#product_id").val(value)
           })
       }
       else
       {
          $("#count").val(0) 
          $("#pay").val(0)   
       }
         
      
    })
    
     $('#submit').click(function(){
      $("#count").html() 
      var pay = $("#pay").html()             
    })
    
       $('.btnmon').click(function(){
         var par = ($(this).parent())
         var month = par.find("input[type=number]").val()
         var tr = $(par).parent()
         var price  = $(tr).find("#price").text()
         var product_id = $(tr).find("#product").val()
         
         if(confirm("대여기간을 변경하시겠습니까?")){
            var data = {"rent_month":month,"product_id":product_id};
            $.ajax({
               url:"updateRentPeriodOrderListAjax.do",
               data:data,
               success:function(data){
                  location.href="";
               }
            })
            $(tr).find("#total").html(month * price)  
         }           
       })
   
 })

   
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
   <div style="margin: 0 15% 0 15%; padding: 40px 0 40px 0;">
   <c:if test="${list==null }"><jsp:forward page="cartList.do"></jsp:forward> </c:if>
   <h2>${mv.name}'s CART</h2><hr>
   <hr>
   
   <p>
   <table border="1" width="100%">
      <tr bgcolor="#E6E5ED">
         <td>no</td>
         <td>물품 이름</td>
         <td>물품 이미지</td>
         <td>월별 대여금액</td>
         <td>대여기간</td>
         <td>총금액</td>
      </tr>
      <c:forEach items="${list}" var="list">
         <tr class ="goods">
            <td id = 'product_id'><input type="checkbox" name = "product" id ="product" value = "${list.pr}"> ${list.rnum}</td>
            <td id = 'product_name'>${list.product_name}</td>
            <td><img src = "resources/img/product/${list.main_img}"></td>
            <td id = "price" class="price">${list.price}</td>
            <td><input type = "number" value="${list.rent_month}" id = "month">/개월<button class = "btnmon">변경</button></td>
            <td id = "total" class = "total">${list.price*list.rent_month}</td>
         </tr>
         
      </c:forEach>   
   </table>
   
   <div style="height:30px;  padding-top: 10px;">
   <button id="deleteBtn" style="position: relative; float:right;">삭제</button>
   </div>
   
   <div style="position: relative;">
   <hr>
   </div>
   <br>
   

   <table id ="mem">
      <tr>
      <td width="10%">이름  </td> 
      <td width="70%"><label>${mv.name}</label><input type = "hidden" value = "${mv.name}" id="memName"></td>
      <td rowspan="3"><input type = "button" value = "정보변경" id ="update"><td>
      </tr>
      <tr>
      <td>주소  </td> 
      <td><label>${adr}</label></td>
      </tr>
      <tr>
      <td>연락처 </td>
      <td><label>${mv.tel}</label><input type = "hidden" value="${mv.tel}" id="memTel"></td>
      
   </table>
   <br>
   <hr>
   <br>
   <p>
   
   <table border = "1" id = "order">
      <tr>
         <td>선택 건 수</td>
         <td>총 금액</td>
         <td>주문</td>
      </tr>
      <tr>
         <td><input type="text" id = "count" readonly="readonly"></td>
         <td><input type="text" id = "pay" readonly="readonly" name = "price"></td>
         <td><input type="button" value = "주문하기" id="paymentBtn"></td>
         
      </tr>
   </table>
   <br>
   </div>
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
   
   <div id="paymentInfo" title="결제">
      <table>
         <tr>
            <td><b>물품 정보</b></td>
            <td></td>
         </tr>
         <tr>
            <td>결제 건 수</td>
            <td><label id="countProduct"></label></td>
         </tr>
         <tr>
            <td>결제 총 금액</td>
            <td><label id="tot_price"></label></td>
         </tr>
         <tr><td><br></td><td></td></tr>
         <tr>
            <td><b>회원 정보</b></td>
            <td></td>
         </tr>
         <tr>
            <td>이름</td>
            <td><label id="mem_name"></label></td>
         </tr>
         <tr>
            <td>주소</td>
            <td><label id="mem_addr"></label></td>
         </tr>
         <tr>
            <td>연락처</td>
            <td><label id="mem_tel"></label></td>
         </tr>
      </table>
      <br><hr><br>
      <center>
      <button id="paymentChk">결제</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <button id="paymentReset">취소</button>
      </center>
      <br>
   </div>
   <div id="pwdDialog2">
         비밀번호:<input type="password" id="pPwd"><br>
         비밀번호 확인:<input type="password" id="pPwd2"><br>
   </div>
      
      
</body>
</html>
