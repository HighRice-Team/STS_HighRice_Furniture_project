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
			history.go(-1)
		})
		
		$(".findInfo").click(function(){
			if($("#name").val()!=""&&$("#jumin").val()!=""){
				var name = $("#name").val()
				var jumin = $("#jumin1").val()+"-"+$("#jumin2").val()
				//올바른 주민등록번호 인지 검사.
				var chkJumin = Number(jumin.substr(13,1)) == 11-((2*Number(jumin.substr(0,1))+3*Number(jumin.substr(1,1))+4*Number(jumin.substr(2,1))+5*Number(jumin.substr(3,1))+6*Number(jumin.substr(4,1))+7*Number(jumin.substr(5,1))+8*Number(jumin.substr(7,1))+9*Number(jumin.substr(8,1))+2*Number(jumin.substr(9,1))+3*Number(jumin.substr(10,1))+4*Number(jumin.substr(11,1))+5*Number(jumin.substr(12,1)))%11)
				if(chkJumin){
					data = {"name":name,"jumin":jumin}
					$.ajax({
						url:"getId_member.do",
						type:"POST",
						data:data,
						success:function(data){
							if(data!="")
							{
								if(confirm("가입한 ID : "+data +"\n비밀번호를 찾으시겠습니까?")){
									$.ajax({
										url:"sendMail.do",
										data:{"member_id":data},
										success:function(re){
											alert("비밀번호를 메일로 발송하였습니다.")
										}
									})
								}
							}else{
								alert("가입 된 정보가 없습니다.")
							}
						}
					})
				}else{
					$("#msg_joinCheck").html("* 올바르지 않는 주민등록번호 입니다.")
				}
			}else{
				alert("입력정보를 모두 작성해주시길 바랍니다.")
			}
		})
	})
</script>
</head>
<body>
	<div style="margin: 0 15% 0 15%; padding: 40px 0 40px 0;">
	<h2>JOIN</h2>
	<center>
		<div style="border: 1px solid; width: 40%;">
			<table align="center" width="400" height="200">
				<tr>
					<td align="center" colspan="2" style="font-size: 15px;"><b>회원정보 입력.</b></td><br><br>
				</tr>
				<tr>
					<td width="20%" align="center">이름 : </td>
					<td width="*" align="center"><input type="text" id="name" required="required" style="text-align: center;"></td>	
				</tr>
				<tr>
					<td width="20%">주민번호 : </td>
					<td width="*" align="center"><input type="text" id="jumin1" required="required" maxlength="6" size="7" style="text-align: center;">-<input type="password" id="jumin2" required="required" maxlength="7" size="7" style="text-align: center;"></td>
				</tr>
				<tr>
					<td align="center" colspan="2"><span id="msg_joinCheck" style="color: red;"></span></td>
					
				</tr>
			</table>
		</div>
	</center>
	<p align="center">
		<input type="button" value="이전" id="back">
		<input type="button" value="로그인" id="loginBtn_findMember">
		<input type="button" value="아이디 /비밀번호 찾기" id="findId" class="findInfo">
	</p>
	</form>
 	</div>
 	
</body>
</html>