<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
$(function(){
	qnaBoardList();
	function qnaBoardList() {
		var url = "getDetail_qnaBoard.do?board_id="+$("#board_id").val();
		$.ajax({url:url, success:function(data){
			var arr = eval("("+data+")");
			$.each(arr, function(index, qb){
				var post_type = $("<span></span>").html(qb.post_type);
				var member_id = $("<span></span>").html("작성자 : "+qb.member_id);
				var regdate = $("<span></span>").html("작성일 : "+qb.regdate);
				var row1 = $("<div></div>").append(post_type, member_id, regdate);
				
				var board_id = $("<span></span>").html("NO."+qb.board_id+":");
				var title = $("<span></span>").html(qb.title);
				var content = $("<p></p>").html(qb.content);
				
				var updateBtn =$("<input>").attr({"type": "button", "value":"수정"})
				var deleteBtn =$("<input>").attr({"type": "button", "value":"삭제"})
				var hiddenBtn =$("<input>").attr({"type": "button", "value":"게시물숨기기"})

				if(qb.b_level == 0 || qb.b_level == 1){
					$(updateBtn).toggle(
						function(){
							$(title).remove(); $(content).remove();
							title = $("<input>").attr({"type": "text", "id": "updateTitle", "value": qb.title})
							content = $("<input>").attr({"type": "text", "id": "updateContent", "value": qb.content})
							$("#question").append(row1,board_id,title,content);
						},function(){
							var data = {"board_id": qb.board_id,"title": $("#updateTitle").val(),"content":$("#updateContent").val()}
							$.ajax({url:"update_qnaBoard.do",data:data,success:function(data){
								$(title).remove(); $(content).remove();
								title = $("<p></p>").html(qb.title);
								content = $("<p></p>").html(qb.content);
								$("#question").append(row1,board_id,title,content);
							}})
							qnaBoardList();
						}
					)
					$(deleteBtn).click(function(){
						$.ajax({url:"delete_qnaBoard.do?board_id="+qb.board_id,success:function(data){
							location.href="qnaBoard.do";
						}})		
					})
					$("#question").append(row1,board_id,title,content);
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
							$("#answer").append(row1,title,content);
						},function(){
							var data = {"board_id": qb.board_id,"title": $("#updateTitle").val(),"content":$("#updateContent").val()}
							$.ajax({url:"update_qnaBoard.do",data:data,success:function(data){
								$(title).remove();
								$(content).remove();
								title = $("<td></td>").html(qb.title);
								content = $("<td></td>").html(qb.content);
								$("#answer").append(row1,title,content);
							}})
							location.reload();
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
				$("#answer").append(row1,title,content);
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
		}});
		location.reload();
	});
});
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="contentForm">
		<input type="hidden" name="member_id"  id="member_id" value="${qnaboard.member_id }">
		<h2>DETAILsdfd</h2><hr>
		<div id="Q" style="background: #ddd">
			<div id="question"></div>
			<div id="questionEdit"></div>
		</div>
		<div id="A" style="background: #bbb">
			<div id="answer"></div>
			<div id="answerEdit"></div>
		</div>
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
		<input type="button" class="button"  value="목록보기" onclick="location.href = 'qnaBoard.do'" >
	</div>
</body>
</html>