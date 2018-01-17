<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		$("#paymentBtn").click(function () {
			var db_pwd = $("#db_pwd").val();
			var new_pwd = $("#new_pwd").val();
			
			var product_id = $("#product_id").val();
			var paymentOne = $("#paymentOne").val();
			var rentMonth = $("#rentMonth").val();
			
			var data = {"rentMonth":rentMonth,"product_id":product_id,"paymentOne":paymentOne};
			
			if( new_pwd != '' ){
				if( db_pwd == new_pwd ){
					
					$.ajax({
						url : "paymentOkAjax.do",
						data : data,
						success : function(data) {
							if( data == '1'){
                					paymentOk_msg = "결제가 성공적으로 완료되었습니다.";
                					alert(paymentOk_msg);
                					if(confirm("마이페이지로 이동하시겠습니까?") == true){
                						location.href="myPage.do";
                					}else{
                						location.href="index.do";
                					}
                					
                					
                    			}else if( data == '-10'){
                    				paymentOk_msg = "잔액이 부족합니다.";
                    				alert(paymentOk_msg);
                    				location.href="";
                    			}else{
                					paymentOk_msg = "결제에 실패하였습니다.";
                					alert(paymentOk_msg);
                					location.href="";
                				}
						}
						
					});
					
				}else{
					alert("비밀번호가 틀렸습니다.");
				}
			}else{
				alert("비밀번호를 입력해주세요.");
			}
			
		});
		
		
	})
</script>
</head>
<body>
	<input type="hidden" id="db_pwd" value="${pwd}">
	<input type="hidden" name="product_id" id="product_id" value="${product_id}">
	<input type="hidden" name="paymentOne" id="paymentOne" value="${paymentOne}">
	<input type="hidden" name="rentMonth" id="rentMonth" value="${rentMonth}">
	

	<center><h1>결제창</h1></center>
	<hr>
	<center>
		<table width="40%">
			<tr style="height: 100px;">
				<td>결제 금액</td>
				<td><label>${paymentOne} 원</label></td>
			</tr>
			<tr style="height: 100px;">
				<td>로그인 시 비밀번호</td>
				<td><input type="password" name="new_pwd" id="new_pwd"></td>
			</tr>
		</table>
	</center>
			
	<center>
		<button type="button" id="paymentBtn">결제</button>
	</center>
</body>
</html>