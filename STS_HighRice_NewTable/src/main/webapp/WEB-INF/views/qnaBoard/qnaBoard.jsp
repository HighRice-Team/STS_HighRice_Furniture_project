<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>  
<script type="text/javascript">
$(function(){
	$.ajax({url:"getAll_qnaBoard.do",success:function(data){
		var arr = eval("("+data+")");
		$.each(arr, function(index, qb){
			var qnaOne = $("<tr></tr>")
			var board_id = $("<td></td>").html(qb.board_id);
			var post_type = $("<td></td>").html(qb.post_type);
			var title = $("<td></td>").append(($("<a></a>").attr("href", "detail.do?board_id="+qb.board_id)).html(qb.title))		
			if(qb.b_level == 1){
				title = $("<td></td>").append(($("<a></a>").attr("href", "detail.do?board_id="+qb.board_id)).html("[답변완료]_"+qb.title))		
			}
			var member_id = $("<td></td>").html(qb.member_id)
			var product_id = $("<td></td>").html(qb.product_id);
			var regdate = $("<td></td>").html(qb.regdate)

			if (qb.board_id > 0 && qb.b_level != 3) {
				$(qnaOne).append(board_id, post_type, title, member_id, product_id, regdate);
				$("#qnaBoardList").append(qnaOne);
			}
		});
	}});
});
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div style="margin: 0 15% 0 15%; padding: 40px 0 40px 0">
	<h2>QNA</h2>
	<hr>
	<table id="qnaBoardList" width="100%" style="text-align: left;">
	</table>
	<hr>
	<a href="insert.do" style="float: right;">게시물 등록</a><br>
	</div>
</body>
</html>
