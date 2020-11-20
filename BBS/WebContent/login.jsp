<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1"><!-- 기기에 맞는 해상도나 크기를 위해서 -->
<link rel="stylesheet" href="css/bootstrap.css"><!-- 디자인 담당하는_css 참조하기 -->
<link rel="stylesheet" href="css/custom.css">
<title>JSP 웹 사이트 게시판_서가영</title>
</head>
<body>
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
			 	<li><a href="bbs.jsp">매일의 기록</a></li>
			 	<li><a href="todo.jsp"></a>오늘 해야할 일</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
						<!-- #은 현재 가리키고 있는 링크 없음 -->
					<ul class="dropdown-menu">
						<li class="active"><a href="login.jsp">로그인</a></li><!-- active는 현재 선택이 되었다는 뜻 -->
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jombotron" style="padding-top: 20px">
				<form method="post" action="loginAction.jsp">
					<h3 style="text-align: center;">로그인 화면</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
					</div>
					<input type="submit" class="btn btn-primary form-control" value="로그인">
				</form><!-- post는 정보를 숨기면서 보낼 때 메소드, action 페이지로 로그인 정보 보내주겠다. -->
			</div>
		</div>
		<div class="col-lg-4"></div>
	</div>
	<!-- 애니메이션 효과_js사용위해 juery참조--> 
	<!-- 애니메이션 효과_js 사용위해 bootstrap의 js 참조--> 
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>