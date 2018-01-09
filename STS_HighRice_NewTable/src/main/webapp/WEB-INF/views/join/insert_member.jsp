<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%  request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<script type="text/javascript">

</script>
</head>
<body>
	<center><h2>JOIN</h2></center>
	<center>
	<table width="60%" border="1" cellpadding="10px" cellspacing="5" class="JoinInfo">
		<tr>
			<td width="20%" class="title">아이디</td>
			<td><input type="text" id="id"> <input type="button" value="중복확인" id="chk_idBtn"></td>
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
			<td><b>${v.name }</b></td>
		</tr>
		<tr>
			<td class="title">주민번호</td>
			<td><b>${v.jumin }</b></td>
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
				<input type="text" id="address" value="시/군/도 도로명 검색"> <input type="button" value="검색"><br>
				<textarea rows="1" cols="70"></textarea>
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
	<br>
		<input type="button" value="가입">
		<input type="button" value="취소">
	</center>
</body>
</html>