<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>비트맨 지정</h2>
	<form action="" method="post">
		<table>
			<tr>
				<td>분류</td>
				<td>
					<select name="">
						<option value="1">배송</option>
						<option value="0">수거</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>비트맨 이름</td>
				<td>${ bitman }</td>
			</tr>
			<tr>
				<td>가구정보</td>
				<td></td>
			</tr>
			<tr>
				<td>오더리스트 정보</td>
				<td></td>
			</tr>
			<tr>
				<td>회원 정보</td>
				<td></td>
			</tr>
			<tr>
				<td>관리자의 배송또는 수거의 요청날짜</td>
				<td></td>
			</tr>
			<tr>
				<td>비트맨의 수행완료날짜</td>
				<td></td>
			</tr>
			<tr>
				<td>수거및 배송에대한 사용자의 사인기록(파일이름)</td>
				<td></td>
			</tr>
			<tr>
				<td>상태: 완료 및 진행중 </td>
				<td></td>
			</tr>
		</table>
		<input type="button" id="testBtn" value="전송">
	</form>
</body>
</html>