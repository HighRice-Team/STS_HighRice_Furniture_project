<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#insert").click(function(){
		var data = $("#insertForm").serializeArray();
		$.ajax({url:"insert_qnaBoard.do",data:data,success:function(data){
			location.href="qnaBoard.do"
		}});
	});
})
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div style="margin: 0 15% 0 15%; padding: 40px 0 40px 0;">
		<h2>QNA 등록</h2>
		<hr>
		
		<form id="insertForm">
			<input type="hidden" name="member_id" value="a1"> <!-- 세션에 저장된 id 값이 가야함 -->	
			<select name="post_type">
				<option value='물품문의'>물품문의</option>
				<option value='배송문의'>배송문의</option>
				<option value='주문/결제문의'>주문/결제문의</option>
				<option value='취소/환불문의'>취소/환불문의</option>
				<option value='기타문의'>기타문의</option>
			</select>
			title : <input type="text" name="title"><br>
			content : <br><textarea rows="10" cols="60" name="content"></textarea><br>
			<input type="button" id="insert" value="등록">
		</form>
		<hr>
	</div>
</body>
</html>