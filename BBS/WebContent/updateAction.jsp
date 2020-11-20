<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %><!-- * 게시글을 작성할 수 있는 데이터베이스는 BbsDAO 객체를 이용해서 다룰 수 있기 때문에 * -->
<%@ page import="bbs.Bbs" %>
<%@ page import="java.io.PrintWriter" %><!-- JS 작성위해 사용  -->
<% request.setCharacterEncoding("UTF-8"); %><!-- 건너오는 데이터 UTF-8으로 받을 수 있도록 -->

<%@ page import="bbs.BbsDAO" %>

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
		}
		
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if(!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		
		else{ //login 한 경우 
			//update form에서 name이 넘어옴 , 자바빈즈를 사용하지 않으므로 request로 변경함 
			if(request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null
			|| request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals(""))
					{
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('입력이 안된 사항이 있습니다.')");
						script.println("history.back()");
						script.println("</script>");
						
					} else { // 입력 적절히 한 경우, 실제로 데이터베이스에 등록을 해주자. 
						BbsDAO bbsDAO = new BbsDAO();
						int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
						
						if(result == -1)
						{
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('글수정에 실패했습니다.')");//DB오류
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