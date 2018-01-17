<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	qnaBoardList();
	function qnaBoardList() {
		var url = "getDetail_qnaBoard.do?board_id="+$("#board_id").val();
		$.ajax({url:url, success:function(data){
			var arr = eval("("+data+")");
			$.each(arr, function(index, qb){
				var board_id = $("<p></p>").html(qb.board_id);
				var post_type = $("<p></p>").html(qb.post_type);
				var title = $("<p></p>").html(qb.title);
				var member_id = $("<p></p>").html(qb.member_id);
				var regdate = $("<p></p>").html(qb.regdate);
				var content = $("<p></p>").html(qb.content);
				var updateBtn =$("<input>").attr({"type": "button", "value":"수정"})
				var deleteBtn =$("<input>").attr({"type": "button", "value":"삭제"})
				var hiddenBtn =$("<input>").attr({"type": "button", "value":"게시물숨기기"})

				if(qb.b_level == 0 || qb.b_level == 1){
					$(updateBtn).toggle(
						function(){
							$(title).remove(); 
							$(content).remove();
							title = $("<input>").attr({"type": "text", "id": "updateTitle", "value": qb.title})
							content = $("<input>").attr({"type": "text", "id": "updateContent", "value": qb.content})
							$("#question").append(board_id,post_type,title,member_id,regdate,content);
							
						},function(){
							var data = {"board_id": qb.board_id,"title": $("#updateTitle").val(),"content":$("#updateContent").val()}
							$.ajax({url:"update_qnaBoard.do",data:data,success:function(data){
								$(title).remove(); 
								$(content).remove();
								title = $("<p></p>").html(qb.title);
								content = $("<p></p>").html(qb.content);
								$("#question").append(board_id,post_type,title,member_id,regdate,content);
								location.reload();
							}})
						}
					)
					$(deleteBtn).click(function(){
						$.ajax({url:"delete_qnaBoard.do?board_id="+qb.board_id,success:function(data){
							location.href="qnaBoard.do";
						}})		
					})
					$("#question").append(board_id,post_type,title,member_id,regdate,content);
					$("#questionEdit").append(updateBtn,deleteBtn);	
					
					
				}else if (qb.b_level == 2){
					$("#adminReplyForm").css("visibility", "hidden")
					$("#questionEdit").empty();
					$("#questionEdit").append(hiddenBtn);
					$(updateBtn).toggle(
						function(){
							$(title).remove(); 
							$(content).remove();
							title = $("<input>").attr({"type": "text", "id": "updateTitle", "value": qb.title})
							content = $("<input>").attr({"type": "text", "id": "updateContent", "value": qb.content})
							$("#answer").append(title,member_id,regdate,content);
						},function(){
							var data = {"board_id": qb.board_id,"title": $("#updateTitle").val(),"content":$("#updateContent").val()}
							$.ajax({url:"update_qnaBoard.do",data:data,success:function(data){
								$(title).remove();
								$(content).remove();
								title = $("<td></td>").html(qb.title);
								content = $("<td></td>").html(qb.content);
								$("#answer").append(title,member_id,regdate,content);
								location.reload();
							}})
						}
					)
					$(deleteBtn).click(function(){
						$.ajax({url:"delete_qnaBoard.do?board_id="+qb.board_id,success:function(data){
							location.reload();
						}})		
					})
					$(hiddenBtn).click(function(){
						$.ajax({url:"hidden_qnaBoard.do?board_id="+qb.board_id*-1,success:function(data){
							location.href="qnaBoard.do";
						}})		
					})
					$("#answer").append(title,member_id,regdate,content);
					$("#answerEdit").append(updateBtn,deleteBtn);
				} 		
			});
		}});
	}
	
	$("#insert").click(function(){
		var data = $("#adminReplyForm").serializeArray();
		$.ajax({url:"insertAdminReply.do",data:data,success:function(data){
			$("#question").empty();
			qnaBoardList();
			location.reload();
		}});
	});
});
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div style="margin: 0 15% 0 15%; padding: 40px 0 40px 0;">
		<h2>게시물 상세</h2>
		<hr>
		<div id="question" style="background: #eee">
			<div id="questionEdit"></div>
		</div>
		<div id="answer" style="background: #aaa">
			<div id="answerEdit"></div>
		</div>
		<input type="hidden" name="member_id"  id="member_id" value="${qnaboard.member_id }">
		<c:if test="${qnaboard.member_id == \"a1\" }"> <!-- 세션에 저장된 member_id 값과 master이면 -->
			<form id="adminReplyForm">
				<input type="hidden" name="board_id"  id="board_id" value="${qnaboard.board_id }">
				<input type="hidden" name="member_id" value="master">
				<input type="hidden" name="post_type" id="post_type" value="답변">
				<input type="hidden" name="title" id="title" value="답변입니다.">
				c : <textarea rows="1" cols="60" name="content" id="content"></textarea>
				<input type="button" id="insert" value="등록">
			</form>
		</c:if>
	</div>	 
</body>
</html>



















