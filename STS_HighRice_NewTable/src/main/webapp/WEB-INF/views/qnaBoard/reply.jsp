<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
$(function(){
	qnaBoardList();
	function qnaBoardList() {
		$.ajax({url:"getAll_qnaBoard.do",success:function(data){
			var arr = eval("("+data+")")
			$.each(arr, function(index, qb){
				var post_type = $("<p></p>").html(qb.post_type);
				var title = $("<p></p>").append(($("<a></a>").attr("href", "detail.do?board_id="+qb.board_id)).html(qb.title))		
				if(qb.b_level == 1){
					title = $("<p></p>").append(($("<a></a>").attr("href", "detail.do?board_id="+qb.board_id)).html("[답변완료]_"+qb.title))		
				}
				var member_id = $("<p></p>").html(qb.member_id)
				var regdate = $("<p></p>").html(qb.regdate)
				var content = $("<p></p>").html(qb.content)
				var updateBtn =$("<input>").attr({"type":"button", "value":"수정"})
				var deleteBtn =$("<input>").attr({"type":"button", "value":"삭제"})
	
				$(updateBtn).toggle(
					function(){
						$(title).remove();
						$(content).remove();
						title = $("<p></p>").append($("<input>").attr({"type":"text", "id":"updateTitle", "value":qb.title}))
						content = $("<p></p>").append($("<input>").attr({"type":"text", "id":"updateContent", "value":qb.content}))
						$("#productReplyList").append(post_type,title,member_id,regdate,content,updateBtn,deleteBtn);
					},function(){
						var data = {"board_id": qb.board_id,"title": $("#updateTitle").val(),"content":$("#updateContent").val()}
						$.ajax({url:"update_qnaBoard.do", data:data, success:function(data){
							$(title).remove();
							$(content).remove();
							title = $("<p></p>").html(qb.title);
							content = $("<p></p>").html(qb.content);
							$("#productReplyList").append(post_type,title,member_id,regdate,content,updateBtn,deleteBtn);
							location.reload();
						}})
					}
				)
				$(deleteBtn).click(function(){
					$.ajax({url:"delete_qnaBoard.do?board_id="+qb.board_id,success:function(data){
						location.reload();
					}})		
				})
				if (qb.product_id==1 &&  qb.b_level!=3) { //상세페이지의 product_id 값이랑 비교
					$("#productReplyList").append(post_type,title,member_id,regdate,content);
					if (qb.member_id == "a1" &&  qb.b_level==0) { //세션에 저장된 member_id 값이랑 비교
						$("#productReplyList").append(post_type,title,member_id,regdate,content,updateBtn,deleteBtn);
					}
				}
			})
		}})
	}
	$("#insert").click(function(){
		var data = $("#insertForm").serializeArray();
		$.ajax({url:"insert_qnaBoard.do",data:data,success:function(data){
			$("#title").val("");
			$("#content").val("");
			location.reload();
		}});
	});
})
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="contentForm">
	<div id="productReplyList" width="100%"></div>
	<a href="qnaBoard.do">qnaBoard</a>
		<form id="insertForm" style="width: 100%">
			<input type="hidden" name="board_id"  id="board_id" value="0">
			<input type="hidden" name="member_id" value="a1"> <!-- 세션에 저장된 id 값이 가야함 -->
			<input type="hidden" name="product_id" value="1"> <!-- 해당페이지의 product_id가 가야함 -->
			<select name="post_type" style="height:55px; width: 10%;  margin-top: 2px; float:  left;">
				<option value='물품문의'>물품문의</option>
				<option value='배송문의'>배송문의</option>
				<option value='주문/결제문의'>주문/결제문의</option>
				<option value='취소/환불문의'>취소/환불문의</option>
				<option value='기타문의'>기타문의</option>
			</select>
			<div style="width: 25%; float: left;">
				<p style="height:5px; margin-top: 0px">title</p>
			 	<input type="text" name="title" id="title" style="height:30px; width: 100%">
			</div>
			<div style="width: 55%; float: left;">
				<p style="height:5px; margin-top: 0px">content</p>
			 	<input type="text" name="content" id="content" size="50%" style="height:30px; width: 100%">
			</div>
			<input type="button" id="insert" value="등록" style="float: right; height:55px; width: 10%;  margin-top: 2px;">
		</form>
	</div>
</body>
</html>