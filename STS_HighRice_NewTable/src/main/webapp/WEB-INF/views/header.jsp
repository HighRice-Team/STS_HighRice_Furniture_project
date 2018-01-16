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
/* 	font-size: 15pt; */
	font-size: 1.3vw;
	font-weight: bold;
	text-decoration: none;
	color: #444444;
	cursor: pointer;
}
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#login_header").click(function(){
			//로그인 dialog 메세지 초기화.
			$("#msg_footer").html('')
			$("#loginDialog_footer").dialog("open")
		})
		$("#logout_header").click(function(){

			if(confirm("로그아웃 하시겠습니까?")){
				$.ajax({
					url:"logout.do",
					success:function(data){
						location.href="";
					}
				})
			}
		})
		
		
		
	})
</script>
<script type="text/javascript">
	//로그인 관련 header.
	
	//필터에서 적용된 get 방식의 쿼리스트링을 리셋하기 위함.   location.href="" 방식은 쿼리스트링이 남아있음.
	function resetPage() {
		location.href="index.do";
	}
	
	$(function () {
		
		// 필터에서 파라미터값 가져오기.
		<%
			String needToLogin = "";
			
			if( session.getAttribute("needToLogin") != null){
				needToLogin = (String)session.getAttribute("needToLogin");
			}
		%>
		
		var needToLogin = '<%=needToLogin%>';
		
		// 권한이 없는 페이지에 접속을 시도할 경우
		if( needToLogin == 'plz'){
			
			if($("#msg_footer").html() == ''){
				$("#msg_footer").html("로그인이 필요한 서비스입니다.")
				onDialog();
			}
		}
		
		
		
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
					<a id="login_header">LOGIN</a><br>
				</c:if>
				<c:if test="${sessionScope.id!=null}">
					<a id="logout_header">LOGOUT</a>
					<br>
				</c:if>

				<!-- 회원가입 -->
				<c:if test="${sessionScope.id!=null}">
					<br>
				</c:if>
				<c:if test="${sessionScope.id==null}">
					<a href="joinAccess.do">JOIN</a>
					<br>
				</c:if>


				<a href="myPage.do?selectedMyPage=mP">MYPAGE</a><br>
				
				
				<a href="cartList.do">CART</a><br>
				
				<!-- 관리자 -->
				<c:if test="${sessionScope.grade==0}">
					<a href="admin.do">ADMIN</a><br>
				</c:if>
				
			</div>
			<div style="width: 20%; float: right;">
				<a href="">SELL</a><br><br>
				<a href="">ABOUT US</a><br>
				<a href="">FAQ</a><br>
				<a href="">QNA</a><br>
			</div>
			<div style="width: 20%; float: right;">

				<a href="customize.do">CUSTMIZE</a><br>
				<a href="product.do?category=BED">BED</a><br>
				<a href="product.do?category=SOFA">SOFA</a><br>
				<a href="product.do?category=CLOSET">CLOSET</a><br>
				<a href="product.do?category=DESK">DESK</a><br>
			</div>
		</div>
	</div>
</body>
</html>