<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %><!-- * 게시글을 작성할 수 있는 데이터베이스는 BbsDAO 객체를 이용해서 다룰 수 있기 때문에 * -->
<%@ page import="java.io.PrintWriter" %><!-- JS 작성위해 사용  -->
<% request.setCharacterEncoding("UTF-8"); %><!-- 건너오는 데이터 UTF-8으로 받을 수 있도록 -->
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page"/> <!-- useBean: user.User라는 자바빈 사용 명시. scope: 현재페이지 내에서만 beans 사용  -->
<jsp:setProperty name="bbs" property="bbsTitle"/> <!-- setProperty: useBean의 자바빈의 필드값 설정/ login.jsp에서 userID 그대로 받아옴 -->
<jsp:setProperty name="bbs" property="bbsContent"/> 

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
		if (userID == null) { //login 안 한 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}else{ //login 한 경우 
			if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null)
					{
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('입력이 안된 사항이 있습니다.')");
						script.println("history.back()");
						script.println("</script>");
						
					} else { // 입력 적절히 한 경우, 실제로 데이터베이스에 등록을 해주자. 
						BbsDAO bbsDAO = new BbsDAO();
						int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
						
						if(result == -1)
						{
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('글쓰기에 실패했습니다.')");//DB오류
							script.println("history.back()");
							script.println("</script>");
						}
						else 
						{
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("location.href = 'bbs.jsp'");
							script.println("</script>");
						}	
					}
		}
	%>

</body>
</html>