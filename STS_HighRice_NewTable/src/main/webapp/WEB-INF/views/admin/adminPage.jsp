<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
table{
	width: 100%;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript" src="https://code.jquery.com/jquery-1.7.0.min.js"></script>


<script type="text/javascript">
$(function(){
		$("#tabs").tabs();
		var customDialog = {
// 				onclickSubmit:function(params){
// 					var selectedRow = $('#product_grid').getGridParam('selrow');
// 					rowData = $('#product_grid').getRowData(selectedRow);
// 					location.href="";
// 					return {product_id : rowData.product_id};
// 				}
		}
		
		 $("#product_grid").jqxGrid({})
})

</script>
<title>Insert title here</title>
</head>
<body>
	<div id="tabs">
		<ul>
			<li><a href="#a">물품관리</a></li>
			<li><a href="#b">주문관리</a></li>
			<li><a href="#c">회원관리</a></li>
		</ul>
		
		<div id="a">
			<h2>물품관리</h2>
			<hr>
			<div>
				<table id="product_grid" border="1" cellpadding="10px" cellspacing="10px" class="table">
					<tr>
						<td>물품번호</td>
						<td>종류</td>
						<td>이름</td>
						<td>판매자</td>
						<td>상태</td>
						<td>가격</td>
					</tr>
				<c:forEach var="p" items="${listProduct }">
					<tr>
						<td>${p.product_id }</td>
						<td>${p.condition }</td>
						<td>${p.product_name }</td>
						<td>${p.member_id }</td>
						<td>${p.quality }</td>
						<td>${p.price }</td>
					</tr>
				</c:forEach>
					
				</table>
				<p>
					
				</p>
			</div>
		</div>

		<div id="b">
			<h2>주문관리</h2>
			<hr>
			<div>
				<table id="order_grid" border="1" cellpadding="10px" cellspacing="10px" class="table">
					<tr>
						<td>주문번호</td>
						<td>구매자</td>
						<td>상품번호</td>
						<td>결제일</td>
						<td>대여시작일</td>
						<td>대여마감일</td>
						<td>대여일수</td>
					</tr>
					<c:forEach var="o" items="${listOrder }">
						<tr>
							<td>${o.order_id }</td>
							<td>${o.member_id }</td>
							<td>${o.product_id }</td>
							<td>${o.pay_date }</td>
							<td>${o.rent_start }</td>
							<td>${o.rent_end }</td>
							<td>${o.rent_month }</td>
						</tr>
					</c:forEach>
				</table>
				<p>
					
				</p>
			</div>
		</div>

		<div id="c">
			<h2>회원관리</h2>
			<hr>
			<div>
				<table id="member_grid" border="1" cellpadding="10px" cellspacing="10px" class="table">
				<tr>
					<td>아이디</td>
					<td>이름</td>
					<td>전화번호</td>
					<td>비밀번호 질문</td>
					<td>비밀번호 답</td>
					<td>주소</td>
					<td>페이백</td>
					<td>계좌번호</td>
					<td>고객등급</td>
				</tr>
				<c:forEach var="m" items="${listMember }">
						<tr>
							<td>${m.member_id }</td>
							<td>${m.name }</td>
							<td>${m.tel }</td>
							<td>${m.pwd_q }</td>
							<td>${m.pwd_a }</td>
							<td>${m.address }&nbsp;${o.address_detail }</td>
							<td>${m.payback}</td>
							<td>${m.bank}&nbsp;${o.account_no}</td>
							<td>${m.grade }</td>
						</tr>
				</c:forEach>
				</table>
			</div>
		</div>
	</div>
</body>
</html>