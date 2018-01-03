<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.7.0.min.js"></script>
<script type="text/javascript" src = "./js/jquery-ui.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		$("#loginDialog_footer").dialog({
	         autoOpen:false,
	         modal:true,
	         resizable:false,
	         buttons:{
	            "로그인":function(){
	               var id = $("#login_member_id").val()
	               var pwd = $("#login_pwd").val()
	               var data = {"member_id":id,"pwd":pwd};
	               $.ajax({
	                  url:"login/loginAjax.jsp",
	                  data:data,
	                  success:function(data){
	                     data = eval("("+data+")");
	                     if(data.str==""){
	                        location.href="";
	                        $("#loginDialog_footer").dialog("close")
	                     }else{
	                        $("#msg").html("*"+data.str);
	                     }
	                  }
	               })
	            },
	            "취소":function(){
	               $("#loginDialog_footer").dialog("close")
	            },
	            "회원가입":function(){
	               location.href = "join.do"
	            }
	         }
	      });
	      $("#login").click(function(){
	         $("#loginDialog_footer").dialog("open");
	      })
	      
			$(document).on("click",".chk_login",function(){
	           var id = '<%=session.getAttribute("id")%>'
				if (id == "null") {
					if (confirm("로그인이 필요한 서비스 입니다.\n 로그인 하시겠습니까?", "a")) {
						$("#loginDialog_footer").dialog("open");
					}
				} else {
					location.href = $(this).attr("value")
				}
			})
			
		function logout() {
			''
			if (confirm("로그아웃 하시겠습니까?")) {
				$.ajax({
					url : "login/logoutAjax.jsp",
					success : function() {
						alert("로그아웃 완료");
						location.href = "index.do";
					}

				})
			}
		}
		
	})
</script>
</head>
<body>
	<div style="margin: 60px 28% 0 28%; padding: 10px 0 10px 0; ">
		<div style="width: 65%; float: left; ">
			<img src="resources/img/logo.png" style="width:70%; height: auto;">
		</div>
		<div style="width: 35%; float: right; text-align: left;">
			BIR FR Company<br>
			주소 : 서울시 마포구 신수동<br>
			고객센터 : 02-1234-5678<br>
			이메일 : admin@bitfr.com<br>
		</div>
	</div>
	
	<div id="loginDialog_footer" title="로그인">
		<form id="loginForm_footer">
			<table>
				<tr>
					 <td>ID:</td>
				 	<td><input type="text" id="login_member_id"	name="login_member_id"></td>
				</tr>
				<tr>
					<td>PW:</td>
					<td><input type="password" id="login_pwd" name="login_pwd"></td>
				</tr>
				<tr>
					<td colspan="2" style="color: red" id="msg"></td>
				</tr>
			</table>
		</form>
		<br>
	</div>
</body>
</html>