
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
html, body {
	width: 100%;
	height: 100%;
	margin: 0px;
	padding: 0px;
}
</style>
<title>BIT FR COMPANY</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
</script>
</head>
<body>
	<div style="text-align: center;">
		<!-- 헤더영역 -->
		<div style="background: #ccc; height: 200px; position:static;">
			<jsp:include page="header.jsp" />
		</div>
		<!-- 바디영역 -->
		<div style="min_height: 100%; position:relative;">
			<jsp:include page="${viewPage }" />
		</div>
		<!-- 푸터영역 -->
		<div style="background: #ddd; height: 120px; position:static;">
			<jsp:include page="footer.jsp" />
		<%-- <%@ include file="footer.jsp" %> --%>
		</div>
	</div>
</body>
</html>