<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %><!-- 만든 클래스 사용하기 -->
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;" charset="UTF-8">
<title>JSP 웹 사이트 게시판_서가영</title>
</head>
<body>
	<%
		session.invalidate();//이 페이지에 접속한 회원의 세션이 빼앗기도록 해서 로그아웃 시켜줌.
	%>
	<script>
		location.href = 'main.jsp';
	</script>
</body>
</html>