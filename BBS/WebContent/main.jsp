<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> <!-- library불러옴 -->
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
			<ul class="nav navbar-nav"><!-- unordered list 보여줄 때 -->
			 	<li class="active"><a href="main.jsp">메인</a></li>
			 	<li><a href="bucket.jsp">버킷리스트</a></li>
			 	<li><a href="bbs.jsp">매일의 기록</a></li>
			 	<li><a href="todo.jsp">오늘 해야할 일</a></li>
			</ul>
			<% 
				if(userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
						<!-- #은 현재 가리키고 있는 링크 없음 -->
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li><!-- active는 현재 선택이 되었다는 뜻 -->
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				} else {
			%>
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
			<% } 
			%>
		</div>
	</nav>
	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1>웹사이트 소개</h1>
				<p>이 웹사이트는 jsp를 활용해 만든 게시판 사이트 입니다. 로그인과 회원가입 기능이 있으며 글 작성, 수정, 삭제 등의 기능을 사용할 수 있습니다. </p>
				<p><a class="btn btn-primary btn-pull" href="#" role="button">자세히 알아보기</a></p>
			</div>
		</div>
	</div>
	
	<div class="container">
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2" ></li>
			</ol>
			<div class="carousel-inner">
				<div class="item active">
					<img src="images/0.jpg">
				</div>
				<div class="item">
					<img src="images/1.jpg">
				</div>
				<div class="item">
					<img src="images/2.jpg">
				</div>
			</div>
			 <!-- Left and right controls -->
			  <a class="left carousel-control" href="#myCarousel" data-slide="prev">
			    <span class="glyphicon glyphicon-chevron-left"></span>
			    <span class="sr-only">Previous</span>
			  </a>
			  <a class="right carousel-control" href="#myCarousel" data-slide="next">
			    <span class="glyphicon glyphicon-chevron-right"></span>
			    <span class="sr-only">Next</span>
			  </a>
			
		</div>
	</div>
	<!-- 애니메이션 효과_js사용위해 juery참조--> 
	<!-- 애니메이션 효과_js 사용위해 bootstrap의 js 참조--> 
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>