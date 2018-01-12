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
		$("#chk_idBtn").click(function(){
			var member_id = $("#member_id").val()
			var data = {"member_id":member_id}
			$.ajax({
				url:"getOne_member.do",
				data:data,
				success:function(data){
					data = eval("("+data+")")
					if(data==null){
						$("#chkResult_id").html("*사용 가능한 아이디입니다.")
					}else{
						$("#chkResult_id").html("*이미 존재하는 아이디입니다.")
					}
				}
			})
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
	<form name="form" id="form" method="post">
		<table width="60%" border="1" cellpadding="10px" cellspacing="5" class="JoinInfo">
			<tr>
				<td width="20%" class="title">아이디</td>
				<td><input type="text" id="member_id" required="required"> <input type="button" value="중복확인" id="chk_idBtn"><span id="chkResult_id" style="color: red;"/></td>
			</tr>
			<tr>
				<td class="title">비밀번호</td>
				<td><input type="password" id="inputPwd"></td>
			</tr>
			<tr>
				<td class="title">비밀번호 확인</td>
				<td><input type="password" id="inputPwd2"> <input type="button" value="중복확인" id="chk_pwdBtn"></td>
			</tr>
			<tr>
				<td class="title">이름</td>
				<td><b><input type="text" value="" readonly="readonly" id="member_id"></b></td>
			</tr>
			<tr>
				<td class="title">주민번호</td>
				<td><b><input type="text" maxlength="6" value="" readonly="readonly"><input type="hidden" id="jumin" value=""></b></td>
			</tr>
			<tr>
				<td class="title">은행</td>
				<td>
					 계좌번호 : <input type="text" id="account_no"> / 
					<select>
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
					<input type="text" id="roadAddrPart1" value=" 도로명 주소 검색" size="55%" name="address"> <input type="button"  value="주소검색" onclick="goPopup();"><br>
					<input type="text" id="addrDetail" name="address_detail" value=" 상세주소" size="55%">
				</td>
			</tr>
			<tr>
				<td class="title">핸드폰번호</td>
				<td><input type="text" id="tel"> <input type="button" value="인증번호 요청" id="requiredMsg"><span id="chkSendMsg"/></td>
			</tr>
			<tr>
				<td class="title">비밀번호 힌트</td>
				<td>
					<select>
						<option>A</option>
						<option>B</option>
						<option>C</option>
						<option>D</option>
						<option>E</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="title">답</td>
				<td><input type="text" id="pwd_a"></td>
			</tr>
		</table>
		<input type="hidden" id="roadAddrPart2"  value="">
		<input type="hidden" id="confmKey" name="confmKey" value=""  >
		<input type="hidden" id="zipNo" name="zipNo" readonly >
	</form>
	<br>
		<input type="button" value="가입">
		<input type="button" value="취소">
	</center>
</body>
</html>