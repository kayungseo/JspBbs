<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %><!-- 만든 클래스 사용하기 -->
<%@ page import="java.io.PrintWriter" %><!-- JS 작성위해 사용  -->
<% request.setCharacterEncoding("UTF-8"); %><!-- 건너오는 데이터 UTF-8으로 받을 수 있도록 -->
<jsp:useBean id="user" class="user.User" scope="page"/> <!-- useBean: user.User라는 자바빈 사용 명시. scope: 현재페이지 내에서만 beans 사용  -->
<jsp:setProperty name="user" property="userID"/> <!-- setProperty: useBean의 자바빈의 필드값 설정/ login.jsp에서 userID 그대로 받아옴 -->
<jsp:setProperty name="user" property="userPassword"/> 
<jsp:setProperty name="user" property="userName"/> 
<jsp:setProperty name="user" property="userGender"/> 
<jsp:setProperty name="user" property="userEmail"/> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 웹 사이트 게시판_서가영</title>
</head>
<body>
	<%
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
		
		if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null ||
		user.getUserGender() == null || user.getUserEmail() == null)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
			
		} else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			
			if(result == -1)
			{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다..')");//DB에서 userID가 기본키이므로 동일한 아이디입력시 DB 안만들어짐
				script.println("history.back()");
				script.println("</script>");
			}
			else 
			{
				//세션은 클라이언트 별로 서버에 저장되는 정보이다.
				//session 객체는 웹 브라우저와 매핑되므로 해당 웹 브라우저를 닫지 않는 한 같은 창에서 열려진 페이지는 모두 같은 session 객체를 공유하게 된다. 
				//따라서 session 객체의 setAttribute() 메소드를 사용해서 세션의 속성을 지정하게 되면 계속 상태를 유지하는 기능을 사용할 수 있게 된다.
				session.setAttribute("userID", user.getUserID());//세션 할당 : 해당 회원의 아이디를 세션값으로 넣어줌 
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
		}
	%>

</body>
</html>