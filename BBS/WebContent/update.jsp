<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> <!-- library불러옴 -->
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width initial-scale=1"><!-- 기기에 맞는 해상도나 크기를 위해서 -->
<link rel="stylesheet" href="css/bootstrap.css"><!-- 디자인 담당하는_css 참조하기 -->
<link rel="stylesheet" href="css/custom.css">
<title>JSP 웹 사이트 게시판_서가영</title>
</head>
<body>
	<% 
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요 ')");
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
		script.println("alert('유효하지 않은 글입니다.  ')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}
	Bbs bbs = new BbsDAO().getBbs(bbsID);
	if(!userID.equals(bbs.getUserID())){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.  ')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header"><!-- head영역 먼저 만듦. header는 로고를 담는 부분 -->
			<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹사이트</a><!-- brand 는 로고 -->
		</div>
		<div class="collapse-navbar-collapse" id="bs-example-navbar-collapse-1"><!-- id는 data-target과 같은 이름 -->
			<ul class="nav navbar-nav"><!-- list 보여줄 때 -->
			 	<li><a href="main.jsp">메인</a></li>
			 	<li><a href="bucket.jsp">버킷리스트</a></li>
			 	<li class="active"><a href="bbs.jsp">매일의 기록</a></li>
			 	<li><a href="todo.jsp">오늘 해야할 일</a></li>
			 	
			</ul>
			
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
						<!-- #은 현재 가리키고 있는 링크 없음 -->
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>			

		</div>
	</nav>
	<div class="container">
	<!-- 특정한 내용을 담을 수 있는 container 안에 테이블을 만들자! -->
		<div class="row">
			<form method="post" action="updateAction.jsp?bbsID=<%=bbsID%>">
			<table class="table table-striped" style="text-align: center; border:1px solid #dddddd">
				<thead><!-- 속성을 알려주는 제일 윗 부분 -->
					<tr><!-- 한 줄 -->
						<th colspan="2" style="background-color: #eeeeee; text-align: center">게시판 글 수정 양식</th>
						
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder="글 제목"  name="bbsTitle" maxlength="50" value="<%=bbs.getBbsTitle()%>"></td><!-- input은 특정정보를 action 페이지로 보내기 위해 ,name은 자바빈즈의 변수명과 동일-->
					</tr>
					<tr>
						<td><textarea class="form-control" placeholder="글 내용"  name="bbsContent" maxlength="2048" style="height: 350px;" ><%=bbs.getBbsContent()%></textarea></td>
					</tr>
				</tbody>
			</table>
			<input type="submit" class="btn btn-primary pull-right" value="글수정"><!-- 글쓰기 버튼->데이터를  action페이지로 보낼 수 있음 -->
			</form>
		</div>
	</div>
	
	<!-- 애니메이션 효과_js사용위해 juery참조--> 
	<!-- 애니메이션 효과_js 사용위해 bootstrap의 js 참조--> 
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>