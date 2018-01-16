<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%  request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.JoinInfo:td{
	border: 1px solid;
	height: 40px;
}
.title{
	text-align: left;
	font-weight: bold;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		var intervalObject	// Timer역할을 할 Interval객체
		var ranNum	// 인증번호를 위한 임의의 난수

		$("#chk_idBtn").click(function(){
			if($("#member_id").val()!=""){
				clearInterval(intervalObject)
				var member_id = $("#member_id").val()
				var data = {"member_id":member_id}
				//var chkEmail = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
				var chkEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/; 
				//var chkEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
				 if(!chkEmail.test($("#member_id").val())) {
					 $("#chkResult_id").html(" *이메일 형식이 맞지 않습니다.")		                
					 member_id.focus();
		                return false;}
				$.ajax({
					url:"getOne_member.do",
					data:data,
					success:function(data){
						
						data = eval("("+data+")")
						
						if(data==null){
							$("#chkResult_id").html(" *사용 가능. 입력한 이메일로 인증번호를 발송했습니다. <br><br><input type='text' id='input_confirmText'> <input type='button' id='chk_confirmTextBtn' value='인증번호 확인'> <span id='timerView'/><br><span id='msg_join'></span>")
							ranNum = Math.floor(Math.random()*10000)
							
							if(ranNum<1000)
							{	ranNum = ranNum + 1000   }
							
							var confirmData = {"member_id":member_id,"confirmText":ranNum}
							
							$.ajax({
								url:"sendMail.do",
								data:confirmData,
								success:function(data){
									
									var timer = 180
									var min = Math.floor(timer/60)
									var sec = timer%60
									
									intervalObject = setInterval(function(){
										
										$("#timerView").html(min+"분"+" "+sec+"초 남았습니다.")
										timer--
										min = Math.floor(timer/60)
										sec = Math.round(timer%60)
										
										if(timer==-2){
											clearInterval(intervalObject)
											$("#timerView").html("인증시간 초과. 다시 시도해주시길 바랍니다.")
										}
									}, 1000);
									
								}
							})
							
						}else{
							$("#chkResult_id").html(" *이미 존재하는 아이디입니다.")
						}
					}
				})
			}else{
				alert("아이디를 이메일 형식으로 입력하고, 이메일 인증을 바랍니다.")
			}
		})
		
		$(document).on("click","#chk_confirmTextBtn",function(){
			var input_confirmText = $("#input_confirmText").val()
			if(input_confirmText==ranNum){
				$("#chkResult_id").html("인증완료")
				$("#memberIdForDb").val($("#member_id").val())
				clearInterval(intervalObject)
			}else{
				$("#msg_join").html("인증번호 오류")
			}
		})
		
		$("#chk_pwdBtn").click(function(){
			var inputPwd = $("#inputPwd").val()
			var inputPwd2 = $("#inputPwd2").val()
			if(inputPwd==inputPwd2){
				$("#chk_confirmPwd").html("비밀번호 확인 완료.")
				$("#pwd").val(inputPwd)
			}else{
				$("#chk_confirmPwd").html("두 비밀번호가 일치하지 않습니다.")
			}
		})
		
		$("#insert_memberBtn").click(function(){
			if($("#chkResult_id").html()!="인증완료")
			{
				alert("아이디 이메일 인증을 해주시길 바랍니다.")
				return false;
			}
			
			if($("#chk_confirmPwd").html()!="비밀번호 확인 완료."){
				alert("비밀번호 확인을 해주세요.")
				return false;
			}
			
			if($("#roadAddrPart1").val()==""){
				alert("주소를 등록해 주세요.")
				return false;
			}
			
		})
		
		
		
		
		
	})
	
	
	
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
	<center><h2>JOIN</h2></center>
	<center>
	<form action="insert_member.do" name="form" id="form" method="post">
		<table width="60%" border="1" cellpadding="10px" cellspacing="5" class="JoinInfo">
			<tr>
				<td width="20%" class="title">아이디</td>
				<td><input type="text" id="member_id" required="required"> <input type="button" value="중복확인" id="chk_idBtn"><span id="chkResult_id" style="color: red;"/> *이메일 주소형식<span id="confirmText_join"></span></td>
			</tr>
			<tr>
				<td class="title">비밀번호</td>
				<td><input type="password" id="inputPwd" required="required"></td>
			</tr>
			<tr>
				<td class="title">비밀번호 확인</td>
				<td><input type="password" id="inputPwd2"  required="required"> <input type="button" value="비밀번호 확인" id="chk_pwdBtn"> <span id="chk_confirmPwd" style="color: red;"></span></td>
			</tr>
			<tr>
				<td class="title">이름</td>
				<td><b><input type="text" name="name" required="required"></b></td>
			</tr>
			<tr>
				<td class="title">주민번호</td>
				<td><b><input type="text" maxlength="6" value="${jumin }-*******" readonly="readonly"><input type="hidden" name="jumin" value="${v.jumin }"></b></td>
			</tr>
			<tr>
				<td class="title">은행</td>
				<td>
					 계좌번호 : <input type="text" id="account_no" name="account_no" required="required"> / 
					<select name="bank">
						<option>신한은행</option>
						<option>기업은행</option>
						<option>농협은행</option>
						<option>국민은행</option>
						<option>카카오뱅크</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="title">주소</td>
				<td>
					<input type="text" id="roadAddrPart1" size="55%" name="address" readonly="readonly"> <input type="button"  value="주소검색" onclick="goPopup();"><br>
					<input type="text" id="addrDetail" readonly="readonly" name="address_detail" size="55%">
				</td>
			</tr>
			<tr>
				<td class="title">핸드폰번호</td>
				<td><input type="text" name="tel" id="tel" required="required"></td>
			</tr>
			<tr>
				<td class="title">비밀번호 힌트</td>
				<td>
					<select name="pwd_q">
						<option>가장 기억에 남는 선물은?</option>
						<option>자신의 보물 제 1호는?</option>
						<option>인상 깊게 읽은 책 이름은?</option>
						<option>자신의 출신 초등학교는?</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="title">답</td>
				<td><input type="text" id="pwd_a" name="pwd_a" required="required"></td>
			</tr>
		</table>
		<input type="hidden" id="roadAddrPart2"  value="">
		<input type="hidden" id="confmKey" name="confmKey" value=""  >
		<input type="hidden" id="zipNo" name="zipNo" >
		<input type="hidden" name="pwd" id="pwd">
		<input type="hidden" name="member_id" id="memberIdForDb">
		
		<br>
		<input type="submit" value="가입" id="insert_memberBtn">
		<input type="button" value="취소" id="resetInsertBtn">
	</form>
	
	</center>
</body>
</html>