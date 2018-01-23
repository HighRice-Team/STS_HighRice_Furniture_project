<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<style type="text/css">
.text { margin: 5px 0 5px 0; padding:5px 0 5px 0; font-size: 18px; height: 50px; }
#type { width: 50%; height: 50px; margin: 5px 0 5px 0;font-size: 18px; border: 1px solid gray; border-radius: 3px; float: left;}
#title { width: 100%; height: 50px; margin: 5px 0 5px 0; font-size: 18px;border: 1px solid gray; border-radius: 3px;}
#content { width: 100%; height: 200px; padding: 0;  font-size: 18px;border: 1px solid gray; border-radius: 3px;}
</style>
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
	<div class="contentForm">
		<h2>QNA 등록</h2><hr>
		<form id="insertForm">
			<input type="hidden" name="member_id" value="a1"> <!-- 세션에 저장된 id 값이 가야함 -->	
				<div style=" width: 15%; float: left">	
					<p class="text">질문분류</p>
					<p class="text">제목</p>
				</div>
				<div  style=" width: 85%;float: left">	
					<select name="post_type" id="type">
						<option value='물품문의'>물품문의</option>
						<option value='배송문의'>배송문의</option>
						<option value='주문/결제문의'>주문/결제문의</option>
						<option value='취소/환불문의'>취소/환불문의</option>
						<option value='기타문의'>기타문의</option>
					</select>
					<input type="text" name="title" id="title"><br>
				</div>	
				<textarea name="content" id="content"></textarea><br>
				<input type="button" class="button" value="등록" id="insert" >
				<input type="button" class="button" value="취소" onclick="location.href = 'qnaBoard.do'" >
		</form>
		<hr>
	</div>
</body>
</html>