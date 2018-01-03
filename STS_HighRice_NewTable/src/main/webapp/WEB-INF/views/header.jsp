<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="resources/css/jquery-ui.min.css">
<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
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
<script type="text/javascript" src="https://code.jquery.com/jquery-1.7.0.min.js"></script>
<script type="text/javascript" src = "./js/jquery-ui.min.js"></script>

<title>Insert title here</title>
</head>
<body>
	<div style="margin: 0 15% 0 15%; padding: 40px 0 40px 0;">
		<div style="width: 40%; float: left;">
			<a href="main.jsp"><img src="resources/img/logo.png"
				style="width: auto; height: 100px;"></a>
		</div>
		<div style="width: 60%; float: right; text-align: left; color: white;">
			<div style="width: 20%; float: right;">
				<c:if test="${sessionScope.id==null}">
					<a id="login">LOGIN</a>
					<br>
					
				</c:if>
				<c:if test="${sessionScope.id!=null}">
					<a onclick="logout()">LOGOUT</a>
					<br>
				</c:if>
				<c:if test="${sessionScope.id!=null}">
					<br>
				</c:if>
				<c:if test="${sessionScope.id==null}">
					<a href="join.do">JOIN</a>
					<br>
				</c:if>
				<a class="chk_login" value="myPage.do">MYPAGE</a><br> <a
					class="chk_login" value="cartList.do">CART</a><br>
				<c:if test="${sessionScope.mid==null}">
					<a id="mlogin">ADMIN</a>
					<br>
					
				</c:if>
				<c:if test="${sessionScope.mid!=null}">
					<a href="productList.do">ADMIN</a>
					<a onclick="mlogout()">OUT</a>
				</c:if>
			</div>
			<div style="width: 20%; float: right;">
				<a class="chk_login" value="sellList.do">SELL</a><br>
				<br> <a href="aboutUs.do">ABOUT US</a><br> <a
					href="faq.do">FAQ</a><br> <a class="chk_login"
					value="listQna.do">QNA</a><br>
			</div>
			<div style="width: 20%; float: right;">
				<a href="customize.do">CUSTMIZE</a><br> <a
					href="product.do?item=BED">BED</a><br> <a
					href="product.do?item=SOFA">SOFA</a><br> <a
					href="product.do?item=CLOSET">CLOSET</a><br> <a
					href="product.do?item=DESK">DESK</a><br>
			</div>
		</div>
	</div>
</body>
</html>