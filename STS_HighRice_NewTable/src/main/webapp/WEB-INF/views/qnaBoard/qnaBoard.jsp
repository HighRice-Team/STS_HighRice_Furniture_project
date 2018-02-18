<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
$(function(){
	$("#qnaBoardList").jsGrid({
		width:"100%", height:"auto", autoload:true, paging:true, pageSize:5, pageButtonCount:5,
		controller : {
			loadData: function(filter) {
				return $.ajax({type:"POST",url:'getAll_qnaBoard.do',data:filter,dataType : "JSON"})
			}
		},rowClick: function(agrs) {
			location.href="detail.do?board_id="+agrs.item.board_id
		},fields: [
			{ name: "board_id", title:"NO",type: "number", width: 2},
			{ name: "post_type", title:"TYPE",type: "text", width: 50},
			{ title: "TITLE", type: "text", itemTemplate:function(_,item) {if(item.b_level == 1) {str= "[답변완료]" + item.title} else {str=item.title} return str}, width: 150},
			{ name: "member_id",title:"MEMBER", type: "text",width:30},
			{ name: "regdate", title:"WRITE_DATE", type: "text", width:50 }
		]
	})
});
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="contentForm">
		<h2>QNAd</h2><hr>
		<table id="qnaBoardList"></table>
		<input type="button" class="button" value="게시물등록" onclick="location.href = 'insert.do'" />
	</div>
</body>
</html>
