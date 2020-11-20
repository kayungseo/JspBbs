<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %><!-- 만든 클래스 사용하기 -->
<%@ page import="java.io.PrintWriter" %><!-- JS 작성위해 사용  -->
<% request.setCharacterEncoding("UTF-8"); %><!-- 건너오는 데이터 UTF-8으로 받을 수 있도록 -->
<jsp:useBean id="user" class="user.User" scope="page"/> <!-- useBean: user.User라는 자바빈 사용 명시. scope: 현재페이지 내에서만 beans 사용  -->
<jsp:setProperty name="user" property="userID"/> <!-- setProperty: useBean의 자바빈의 필드값 설정/ login.jsp에서 userID 그대로 받아옴 -->
<jsp:setProperty name="user" property="userPassword"/> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 웹 사이트 게시판_서가영</title>
</head>
<body>
	<%
		//특정 세션을 할당함으로써 어떤 페이지를 보여주고 안보여줄지를 관리할 수 있다. 
		//로그인 된 유저는 회원가입, 로그인 페이지에 들어갈 수 없도록 한다. 
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");//해당 변수가 자신에게 할당된 변수를 담을 수 있도록 한다.
		}
		if (userID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp");
			script.println("</script>");
		}
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
	
  		if(result == 1){
  			session.setAttribute("userID", user.getUserID());//세션 할당 : 해당 회원의 아이디를 세션값으로 넣어줌 , login 여부 확인 가능 
  			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
 		}
  		else if(result == 0){
  			PrintWriter script = response.getWriter();
   			script.println("<script>");
   			script.println("alert('비밀번호가 틀립니다.')");
   			script.println("history.back()");
			script.println("</script>");
  		}else if(result == -1){
  			PrintWriter script = response.getWriter();
  			script.println("<script>");
   			script.println("alert('존재하지 않는 아이디입니다.')");
   			script.println("history.back()");
			script.println("</script>");
  		}else if(result == -2){
  			PrintWriter script = response.getWriter();
  			script.println("<script>");
   			script.println("alert('DB오류가 발생했습니다.')");
   			script.println("history.back()");
			script.println("</script>");
  		}
	%>
</body>
</html>