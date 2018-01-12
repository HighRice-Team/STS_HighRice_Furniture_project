<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.7.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#goMain").click(function(){
		location.href = "index.do";
	})
})	
</script>
</head>
<body>
	<div
		style="margin: 0 15% 0 15%; padding: 40px 0 40px 0; text-align: left;">
		<center><h2>Complete JOIN</h2></center>
			<table align="center" width="400" height="200" border="1">
				<tr>
					<td align="center">가입이 완료되었습니다.<br> 입력하신 정보로 로그인하여 주시기
						바랍니다.
					</td>
				</tr>
			</table>
			<p align="center">
				<button id="goMain">메인으로 가기</button>
			</p>
	</div>
</body>
</html>