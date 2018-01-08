<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
a {
	font-family: 고딕;
	font-size: 15pt;
	font-weight: bold;
	text-decoration: none;
	color: #444444;
	cursor: pointer;
}
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		
	})
</script>

<title>Insert title here</title>
</head>
<body>
	<div style="margin: 0 15% 0 15%; padding: 40px 0 40px 0;">

		<!-- 메인 로고 -->
		<div style="width: 40%; float: left;">
			<a href="index.do"> <img src="resources/img/logo.png"
				style="width: 100%;">
			</a>
		</div>

		<!-- 메뉴 -->
		<div style="width: 60%; float: right; text-align: left; color: white;">
			<div style="width: 20%; float: right;">

				<!-- 로그인 -->
				<c:if test="${sessionScope.id==null}">
					<a href="">LOGIN</a>
				</c:if>
				<c:if test="${sessionScope.id!=null}">
					<a href="">LOGOUT</a>
					<br>
				</c:if>

				<!-- 회원가입 -->
				<c:if test="${sessionScope.id!=null}">
					<br>
				</c:if>
				<c:if test="${sessionScope.id==null}">
					<a href="">JOIN</a>
					<br>
				</c:if>


				<a href="">MYPAGE</a><br>
				
				
				<a href="">CART</a><br>
				
				<!-- 관리자 -->
				<c:if test="${sessionScope.grade==1}">
					<a href="">ADMIN</a><br>
				</c:if>
				
			</div>
			<div style="width: 20%; float: right;">
				<a href="">SELL</a><br><br>
				<a href="">ABOUT US</a><br>
				<a href="">FAQ</a><br>
				<a href="">QNA</a><br>
			</div>
			<div style="width: 20%; float: right;">
				<a href="">CUSTMIZE</a><br>
				<a href="">BED</a><br>
				<a href="">SOFA</a><br>
				<a href="">CLOSET</a><br>
				<a href="">DESK</a><br>
			</div>
		</div>
	</div>
</body>
</html>