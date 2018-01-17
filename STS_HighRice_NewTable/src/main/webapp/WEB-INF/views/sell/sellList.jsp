<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/jquery-ui.min.css">
<style>
.detail{
	display: none;
}

</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src ="resources/js/jquery-ui.min.js"></script>
<script type="text/javascript">
	$(function() {
		$(".updateBtn").click(function(){
/* 			var product_id = $(this).parent().parent().find(".product_id").val()
			var updateForm = $(this).parent().parent().parent().find(".detail").val()
			var updateForm = $(this).next().find("#updateForm").val() */
			$("#updateForm").removeClass()
		})
		
		$(".deleteBtn").click(function(){
			var product_id = $(tr).find()
		})
	})
	
</script>
</head>
<body>
	<div id="sellList" style="margin: 0 15% 0 15%; padding: 40px 0 40px 0; position: relative;">	
		<h2>SELL LIST</h2><hr id="hr"><br>
		<div style="margin: 0 10% 0 10%; padding: 10px 0 10px 0;">
		<table>
			<tr>
				<td width="10%">이미지</td>
				<td width="50%">물품명</td>
				<td width="10%">카테고리</td>
				<td width="10%">현황</td>
				<td width="10%">물품상태</td>
				<td width="7%">수정</td>
				<td width="7%">삭제</td>
			</tr>
			<c:forEach var="list" items="${list}">
			<tr>
				<td width="10%"><img src="resources/img/product/${list.main_img}" width="70"></td>
				<td width="50%"><a href="productDetail.do?product_id=${list.product_id}">${list.product_name}</a></td>
				<td width="10%">${list.category}</td>
				<td width="10%">${list.condition}</td>
				<td width="10%">
					<c:if test="${list.quality==null}">검수중</c:if>
					<c:if test="${list.quality!=null}">${list.quality}</c:if>
				</td>
				<td width="7%">
					<c:if test="${list.condition=='등록'}"><input type="button" value="수정" name="updateBtn" class="updateBtn"></c:if>
				</td>
				<td width="7%">
					<c:if test="${list.condition=='등록'}"><input type="button" value="삭제" name="deleteBtn" class="deleteBtn"></c:if>
				</td>
				<input type="hidden" id = "member_id" value="${member_id}">
				<input type="hidden" class = "product_id" value="${list.product_id}">
				<input type="hidden" id = "getQuality" value="${list.quality}">
			</tr>
			<tr>
				<td colspan="7">
					<div id="updateForm" class="detail">
					<form action="sellWriteOk.do" method="post" enctype="multipart/form-data">
						<div style="padding: 10px" align="left">
							제목 : <textarea rows="1" style="width: 90%" name="product_name">${list.product_name}</textarea>
							<input type="hidden" name="product_id" value="${list.product_id}">
						</div>
						<div style="padding: 10px" align="left">
							분류 :  <select name="category">
							<option value="bed">BED</option>
							<option value="sofa">SOFA</option>
							<option value="desk">DESK</option>
							<option value="closet">CLOSET</option></select>
						</div>
						<div style="padding: 10px" align="left">
							품질 :  <input type="radio" name="quality" value="A">A
							<input type="radio" name="quality" value="B">B
							<input type="radio" name="quality" value="C">C
						</div>
						<div style="padding: 10px" align="left">
							대표이미지 : <input type="file" name="main_img"><br>
							서브이미지 : <input type="file" name="sub_img">
						</div>
						<div style="padding: 10px" align="center">
							<input type="submit" value="수정">&nbsp;
							<input type="reset" value="취소">
						</div>
					</form>
					</div>
				</td>
			</tr>
			</div>
			</c:forEach>
		</table>
		</div><br>
		<div>		
			<c:forEach var="pageNum" begin="1" end="${pageMax}">
				<a href="sellList.do?member_id=${member_id}&pageNum=${pageNum}" style="font-size: 1.15vw;">${pageNum}</a>
			</c:forEach>
		</div>
	</div>
</body>
</html>