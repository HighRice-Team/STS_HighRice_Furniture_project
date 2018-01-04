<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.7.0.min.js"></script>
<script type="text/javascript" src="./js/jquery-ui.min.js"></script>
<script type="text/javascript">
	$(function() {

		$("#loginDialog_footer").dialog({
			autoOpen : false,
			modal : true,
			resizable : false,
			buttons : {
				"로그인" : function() {

				},
				"취소" : function() {

				},
				"회원가입" : function() {

				}
			}
		});
	})
</script>
</head>
<body>
	<div style="margin: 60px 28% 0 28%; padding: 10px 0 10px 0;">
		<div style="width: 65%; float: left;">
			<img src="resources/img/logo.png" style="width: 70%; height: auto;">
		</div>
		<div style="width: 35%; float: right; text-align: left;">
			BIR FR Company<br> 주소 : 서울시 마포구 신수동<br> 고객센터 : 02-1234-5678<br>
			이메일 : admin@bitfr.com<br>
		</div>
	</div>

	<div id="loginDialog_footer" title="로그인">
		<form id="loginForm_footer">
			<table>
				<tr>
					<td>ID:</td>
					<td><input type="text" id="member_id_footer"
						name="member_id_footer"></td>
				</tr>
				<tr>
					<td>PW:</td>
					<td><input type="password" id="pwd_footer" name="pwd_footer"></td>
				</tr>
				<tr>
					<td colspan="2" style="color: red" id="msg_footer"></td>
				</tr>
			</table>
		</form>
		<br>
	</div>
</body>
</html>