<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/h=tml; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		// 취소 버튼 클릭시 첫화면으로 이동
		$("#back").click(function(){
			location.href="index.do"
		})
		
		$("#joinChkBtn").click(function(){
			if($("#jumin1").val()!=""&&$("#jumin2").val()!=""){
				var jumin = $("#jumin1").val()+"-"+$("#jumin2").val()
				//올바른 주민등록번호 인지 검사.
				var chkJumin = Number(jumin.substr(13,1)) == 11-((2*Number(jumin.substr(0,1))+3*Number(jumin.substr(1,1))+4*Number(jumin.substr(2,1))+5*Number(jumin.substr(3,1))+6*Number(jumin.substr(4,1))+7*Number(jumin.substr(5,1))+8*Number(jumin.substr(7,1))+9*Number(jumin.substr(8,1))+2*Number(jumin.substr(9,1))+3*Number(jumin.substr(10,1))+4*Number(jumin.substr(11,1))+5*Number(jumin.substr(12,1)))%11)
				if(chkJumin){
					data = {"jumin":jumin}
					$.ajax({
						url:"getId_member.do",
						type:"POST",
						data:data,
						success:function(data){
							if(data!="")
							{
								alert("이미 가입된 회원입니다.")
							}else{
								$("#jumin").val(jumin)
								$("#F").submit();
							}
						}
					})
				}else{
					$("#msg_joinCheck").html("* 올바르지 않는 주민등록번호 입니다.")
				}
			}else{
				alert("주민등록 번호를 작성해주시길 바랍니다.")
			}
		})
		
		$("#findMemberBtn").click(function(){
			location.href="findMember.do"
		})
	})
</script>
</head>
<body>
	<div style="margin: 0 15% 0 15%; padding: 40px 0 40px 0;">
	<h2>Check JOIN</h2>
	<form id="F" action="joinCheck.do" method="post">
		
		<center>
			<div style="border: 1px solid; width: 40%; height: 100px; text-align: center;">
				<br><br>주민번호 : <input type="text" id="jumin1" required="required" maxlength="6" size="7px" style="text-align: center;">-<input type="password" id="jumin2" required="required" maxlength="7" size="7px" style="text-align: center;">
				<br><span id="msg_joinCheck" style="color: red;"></span>
			</div>
		</center>
		
		<!--JavaScript에서 주민등록번호 유효성 검사를 하고, 결과가 참으로 나올때 jumin 값을 참조하기위해. -->
		<input type="hidden" name="jumin" id="jumin" value="">
	</form>
	<p align="center">
		<input type="button" value="이전" id="back">
		<input type="button" value="회원정보 찾기" id="findMemberBtn">
		<input type="button" value="다음" id="joinChkBtn">
	</p>
	</form>
 	</div>
 	
</body>
</html>