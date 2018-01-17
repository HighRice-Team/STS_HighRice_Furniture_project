<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.css" />
<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid-theme.min.css" />
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.js"></script>
<style type="text/css">
	#main_footer{
		font-size: 1.2vw;
	}
</style>
<script type="text/javascript">
	$(function() {

		$("#loginDialog_footer").dialog({
			autoOpen : false,
			modal : true,
			resizable : false,
			closeOnEscape: false,
			open: function(event, ui) { 
				$(".ui-dialog-titlebar-close", $(this).parent()).hide();
			},
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
								location.href="";
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
					$.ajax({
						url : "logout.do",
						success : function () {
							location.href="";
						}
					});
				},
				"회원가입" : function() {
					$.ajax({
						url : "logout.do",
						success : function () {
							location.replace("joinAccess.do");
						}
					});
				}
			}
		});
	})
	
	function onDialog(){
		$("#loginDialog_footer").dialog("open")
	}
	
// 	마이페이지에서 비밀번호 변경
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
				
				
				var data ={"input_pwd":pwd,"input_pwd2":pwd2,"old_pwd":oldPwd};
					$.ajax({
						url:"changePwdChk.do",
						data:data,
						success:function(data){
							data = eval('('+data+')')
							if(data=="일치"){
								var member_id = $("#id_mypage").val()
								data = {"member_id":member_id ,"pwd":pwd}
								$.ajax({
									url:"updatePwd_member.do",
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
	
// 	마이페이지에서 비밀번호를 변경할때 쓰는 다일로그 오픈
	$("#change_pwd").click(function(){
		$("#changePwd").dialog("open")
	})
	
// 	마이페이지에서 회원정보 변경
	$("#dialog").dialog({
		width:800,
		maxWidth:800,
		minWidth:800,
		autoOpen:false,
		modal:true,
		buttons:{
			"수정":function(){
				var str="";
				var data = $("#form").serializeArray();
				
				$.ajax({url:"updateInfo_member.do",data:data,success:function(data){
					
					if(data==1)
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
	
// 	마이페이지에서 로그아웃 버튼
	$("input[value=로그아웃]").click(function(){
		 if(confirm("로그아웃 하시겠습니까?")){
	         $.ajax({
	            url:"logout.do",
	            success:function(){
	               alert("로그아웃 완료");
	               location.href="index.do";
	            }
	            
	         })
	      }
	})
	
// 	마이페이지에서 회원정보 변경을 위한 다일로그 오픈
	$("input[value=회원정보수정]").click(function(){
		
		var data = {'member_id':$("#id_mypage").val()}
		
		$.ajax({url:"getOne_member_ajax.do", data:data ,success:function(data){
			
			data = eval('('+data+')')
			
			$("#member_id").html(data.member_id);
			$("#name").html(data.name);
			$("#jumin").html(data.jumin);
			$("#account_no").val(data.account_no);
			$("#address3").val(data.address3);
			$("#tel").val(data.tel);
			$("#pwd_a").val(data.pwd_a);
			$("#pwd_q").val(data.pwd_q);
			$("#bank").val(data.bank);
			$("#roadAddrPart1").val(data.address);
			$("#addrDetail").val(data.address_detail);
		}})
		$("#dialog").dialog("open");
	})
	
// 	마이페이지 상품삭제 버튼
	$("input[value=삭제]").click(function(){
//			location.href="productDelete.do?product_id="+$(this).parent().find("#product_id").val();
		if(confirm("상품을 삭제하시겠습니까?")){
			var product_id=$(this).parent().find("#product_id").val();
			data = {"product_id":product_id};
			$.ajax({
				url:"delete_product.do",
				data:data,
				success:function(data){
					alert("삭제완료")
				}
			})
			location.href="";
			
		}
	})
</script>
</head>
<body>
	<div id="main_footer" style="margin: 20px 28% 0 28%; padding: 10px 0 10px 0;">
		<div style="width: 50%; float: left;">
			<img src="resources/img/logo.png" style="width: 70%; height: auto;">
		</div>
		<div style="width: 50%; float: right; text-align: left;">
			BIT FR Company<br> 주소 : 서울시 마포구 신수동<br> 고객센터 : 02-1234-5678<br>
			이메일 : bitfr@naver.com<br>
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