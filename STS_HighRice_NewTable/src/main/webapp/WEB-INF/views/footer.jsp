<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
	$(function() {

		$("#loginDialog_footer").dialog({
			autoOpen : false,
			modal : true,
			resizable : false,
			buttons : {
				"로그인" : function() {
					var member_id_footer = $("#member_id_footer").val();
					var pwd_footer = $("#pwd_footer").val();
					data = {"member_id":member_id_footer,"pwd":pwd_footer}
					$.ajax({
						url:"login.do",
						data:data,
						success:function(data){
							if(data==1)
							{
								$("#loginDialog_footer").dialog("close")
								resetPage();
							}else if(data==0){
								$("#msg_footer").html("비밀번호 오류")
							}else{
								$("#msg_footer").html("존재하지 않는 아이디 입니다.")
							}
						}
					})
				},
				"취소" : function() {
					$("#loginDialog_footer").dialog("close")
				},
				"회원가입" : function() {
					location.replace("joinAccess.do");
				}
			}
		});
	})
	
	function onDialog(){
		$("#loginDialog_footer").dialog("open")
	}
	
	$("#changePwd").dialog({
		width:400,
		maxWidth:400,
		minWidth:400,
		autoOpen:false,
		modal:true,
		buttons:{
			"수정":function(){
				var oldPwd = $("#oldPwd").val();
				var pwd = $("#newPwd").val();
				var pwd2 = $("#chk_newPwd").val();
				var data ={"pwd":pwd,"pwd2":pwd2,"oldPwd":oldPwd};
					$.ajax({
						url:"pwdChk2.do",
						data:data,
						success:function(data){
							data = eval("("+data+")");
							data = data.str;
							if(data=="일치"){
								data = {"pwd":pwd}
								$.ajax({
									url:"updatePwdAjax.do",
									data:data,
								})
								alert("비밀번호 변경 완료");
								location.href="";
								$("#changePwd").dialog("close")
							}else{
								alert(data)
							}
						}
					})
				
			},
			"취소":function(){
				$("#changePwd").dialog("close")
			}
		}
	});
	
	$("#change_pwd").click(function(){
		$("#changePwd").dialog("open")
	})
	
	$("#dialog").dialog({
		width:800,
		maxWidth:800,
		minWidth:800,
		autoOpen:false,
		modal:true,
		buttons:{
			"수정":function(){
				var str="";
				var data = $("#myForm").serializeArray();
				$.ajax({url:"updateMemberOkAjax.do",data:data,success:function(str){
					str = eval("("+str+")");
					alert(str.str)
					if(str.str=="회원정보 변경 완료")
					{
						location.href="";
						$("#dialog").dialog("close");
					}						
				}})
				
			},
			"취소":function(){
				$("#dialog").dialog("close");
			}
		}
	});
	$("input[value=로그아웃]").click(function(){
		 if(confirm("로그아웃 하시겠습니까?")){
	         $.ajax({
	            url:"login/logoutAjax.jsp",
	            success:function(){
	               alert("로그아웃 완료");
	               location.href="index.do";
	            }
	            
	         })
	      }
	})
	$("input[value=회원정보수정]").click(function(){
		$.getJSON("./login/updateMemberAjax.jsp",function(data){
			$("#member_id").html(data.member_id);
			$("#name").html(data.name);
			$("#jumin").html(data.jumin);
			$("#account_no").val(data.account_no);
			$("#address3").val(data.address3);
			$("#tel").val(data.tel);
			$("#pwd_a").val(data.pwd_a);
			$("#pwd_q").val(data.pwd_q);
			$("#bank").val(data.bank);
			$("#address1").val(data.address1);
			$("#address2").val(data.address2);
		})
		$("#dialog").dialog("open");
	})
	$("input[value=삭제]").click(function(){
//			location.href="productDelete.do?product_id="+$(this).parent().find("#product_id").val();
		if(confirm("상품을 삭제하시겠습니까?")){
			var product_id=$(this).parent().find("#product_id").val();
			data = {"product_id":product_id};
			$.ajax({
				url:"product/deleteProductAjax.jsp",
				data:data,
				success:function(){
					alert("삭제완료")
				}
			})
			location.href="";
			
		}
	})
</script>
</head>
<body>
	<div style="margin: 60px 28% 0 28%; padding: 10px 0 10px 0;">
		<div style="width: 65%; float: left;">
			<img src="resources/img/logo.png" style="width: 70%; height: auto;">
		</div>
		<div style="width: 35%; float: right; text-align: left;">
			BIR FR Company<br> 주소 : 서울시 마포구 신수동<br> 고객센터 : 02-1234-5678<br>
			이메일 : admin@bitfr.com<br>
		</div>
	</div>

	<div id="loginDialog_footer" title="로그인">
		<form id="loginForm_footer">
			<table>
				<tr>
					<td>ID:</td>
					<td><input type="text" id="member_id_footer"
						name="member_id_footer"></td>
				</tr>
				<tr>
					<td>PW:</td>
					<td><input type="password" id="pwd_footer" name="pwd_footer"></td>
				</tr>
				<tr>
					<td colspan="2" style="color: red" id="msg_footer"></td>
				</tr>
			</table>
		</form>
		<br>
	</div>
</body>
</html>