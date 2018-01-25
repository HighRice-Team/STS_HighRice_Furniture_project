<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<style type="text/css">
</style>
<script type="text/javascript">
$(function(){
// 	   $("#insert").click(function(){
// 		   alert("ok")
// 	      var data = $("#sellInsertForm").serializeArray();
// 			alert(data)
// 	      $.ajax({url:"sellInsert.do",data:data,success:function(data){
// 	         location.href="sellList.do?member_id="+$("#member_id").val()
// 	      }});
// 	   });
	})
	
</script>
</head>
<body>
	<div style="margin: 0 15% 0 15%; padding: 40px 0 40px 0; ">
		<h2>SELL WRITE</h2><hr>
		<form action="sellInsert.do" method="post" enctype="multipart/form-data">
		<div style="margin: 0 20% 0 20%; padding: 20px 0 20px 0; ">
			<div style="padding: 10px" align="left">
				제목 : <textarea rows="1" style="width: 90%" name="product_name"></textarea>
				<input type="hidden" name="member_id" value="${member_id}" id="member_id">
			</div>
			<div style="padding: 10px" align="left">
				분류 :  <select name="category">
						<option value="BED">BED</option>
						<option value="SOFA">SOFA</option>
						<option value="DESK">DESK</option>
						<option value="CLOSET">CLOSET</option>	
					</select>
			</div>
			<div style="padding: 10px" align="left">
				품질 :  <input type="radio" name="quality" value="A">A
					<input type="radio" name="quality" value="B">B
					<input type="radio" name="quality" value="C">C
			</div>
			<div style="padding: 10px" align="left">
				대표이미지 : <input type="file" name="mainIMG"><br>
				서브이미지 : <input type="file" name="subIMG">
			</div>
			<div style="padding: 10px" align="center">
				<input id="insert" type="submit" value="등록">&nbsp;
				<input type="reset" value="취소">
			</div>
		</div>
		</form>
	</div>
	
</body>
</html>