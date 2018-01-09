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
		// 취소 버튼 클릭시 첫화면으로 이동
		$("#back").click(function(){
			location.href="index.do"
		})
		
		$("#joinChkBtn").click(function(){
			if($("#name").val()!=""&&$("#jumin").val()!=""){
				var name = $("#name").val()
				var jumin = $("#jumin").val()
				data = {"name":name,"jumin":jumin}
				$.ajax({
					url:"getId_member.do",
					type:"POST",
					data:data,
					success:function(data){
						if(data!="")
						{
							alert("이미 가입된 회원입니다.")
						}else{
							location.href="insert_member.do?jumin="+jumin+"&name="+name;
						}
					}
				})
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
	<table align="center" width="400" height="200" border="1" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center">주민번호 인증이 필요합니다.<br><br> 
			이름 : <input type="text" id="name" required="required"><br><br> 
			주민번호 : <input type="text" id="jumin" required="required"></td>
		</tr>
	</table>
	<p align="center">
		<input type="button" value="이전" id="back">
		<input type="button" value="다음" id="joinChkBtn">
	</p>
	</form>
 	</div>
</body>
</html>