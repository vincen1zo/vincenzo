<%@page import="vo.newVo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("loginEmail")==null) {
%>
	<script>alert("로그인해주십시오"); location.href="Controller?command=login_form&ret_cmd=new";</script>
<%
	} 
%>    
<%
	String memberId = (String)request.getAttribute("memberId");
	ArrayList<newVo> listNew = (ArrayList<newVo>)request.getAttribute("listNew"); 
 %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel ="stylesheet" href = "css/all.css">
	<link rel ="stylesheet" href = "css/header.css">
	<link rel ="stylesheet" href = "css/footer.css">
	<link rel ="stylesheet" href = "css/new.css">
	<script src="js/jquery-3.7.1.min.js"></script>
	<script src="js/header_search.js"></script>
	<script src="js/new.js"></script>
	<script>
		alert("현재는 select만 작업된 상태입니다.\n각 해당 페이지에서 insert 작업중입니다.\n클릭하시면 아직 연동불가합니다.");
	</script>
	<title>새소식</title>
</head>
<body>
	<div id = "container">
<header>
	<div class="fixed-container" style="height: 81px;">
		<div id = "header">
			<div id = "header_inner">
				<div class="logo"><a href="Controller?command=command=interior_main"><img src="images/logo.png"/></a></div>
				<div class="homemenu">
					<span class="h_menu"><a href="Controller?command=community_main">커뮤니티</a></span>
					<span class="h_menu"><a href="Controller?command=shopping_main">쇼핑</a></span>
					<span class="h_menu"><a href="Controller?command=interior_main" class="a">인테리어</a></span>
					<span class="h_menu"><a href="Controller?command=Ozip_main">오집in</a></span>
				</div>
				<div class="topSelect">
					<div class="search1">
						<span class="dbg"></span>
						<input type = "text" placeholder = "통합검색(준비중)"/>
					</div>
					<div class="top_icon">
					<div class="top_icon1">
						<!-----------------------------------좋아요------------------------------------------>
						<a href="Controller?command=likey_book" style = "margin-right: 15px;"> 
							<span class = "ja_icon_likey"></span>
							<span class = "ja_icon_red_num">
								<span type = "fill" class = "ja_icon_num">1</span>
							</span>
						</a> 
						<!----------------------------------------------------------------------------------->
						<!-----------------------------------새소식------------------------------------------>
						<a href="Controller?command=new" style = "margin-right: 15px;">
							<span class = "ja_icon_new"></span>
							<span class = "ja_icon_red_num">
								<span type = "fill" class = "ja_icon_num">1</span>
							</span>
						</a>
						<!------------------------------------------------------------------------------------>
						<!-----------------------------------장바구니----------------------------------------->
						<a href="Controller?command=basket" style = "margin-right: 15px;">
							<span class = "ja_icon_basket"></span>
							<span class = "ja_icon_red_num">
								<span type = "fill" class = "ja_icon_num">1</span>
							</span>
						</a> 
						<!------------------------------------------------------------------------------------>
					</div>
					<!-----------------------------------프로필사진----------------------------------------->
					<div class="top_icon2">
						<div style="margin-left: -16px;">
							<button class = 'ja_icon2_btn'>
								<img src="https://image.ohou.se/i/bucketplace-v2-development/uploads/default_images/avatar.png?w=72&amp;h=72&amp;c=c">
							</button>
						</div> 
					</div>
					<!------------------------------------------------------------------------------------>
					<!-----------------------------------글쓰기----------------------------------------->
					<div class="top_icon3">
						<a href="https://ebony-drink-dc2.notion.site/2d90666c160c4c01aba3fe268e46ec25"><div><span>사이트설명</span></div></a>
					</div>
					<!------------------------------------------------------------------------------------>
					</div>
				</div>
				<!---------------------------마이페이지/로그아웃 시작--------------------------->
				<div class = "ja_pop_menu_big_box">
					<div class = "ja_pop_menu_box">
						<div class = "ja_pop_menu">
							<a class = "ja_pop_menu_title" href = "Controller?command=Mypage_profile_with_ozip">마이페이지</a>	
							<a class = "ja_pop_menu_title" href = "Controller?command=QA">고객센터</a>						
							<a class = "ja_pop_menu_title" href = "Controller?command=logout">로그아웃</a>							
						</div>						
					</div>
				</div>
				<!---------------------------마이페이지/로그아웃 끝--------------------------->
				<div style="clear:both;"></div>
			</div>
		</div>
	</div>	
<div style="clear:both"></div>
</header>
	
	<!--메인-->
	<main>
		<div class="content">
			<h1>내 소식</h1>
			<% if(listNew.size() == 0) { %>
			<div class="content_inner">
				<p>최근 내 소식이 없습니다.</p>
			</div>
			<% } %>
			
		<% if(listNew.size() != 0) { %>
			<% for(newVo vo : listNew) { %>
			<div class="data">
				<div>
					<div class="data_inner">
						<a class="user_profile" href="#">
							<img src="<%=vo.getProfileImg()%>">
						</a>
						<a class="user_write" href="#">
							<div class="user_w1">
								<span class="user_con">
									<strong><%=vo.getWhoMemberId() %></strong>
									<%=vo.getSentence() %>
								</span>
								<span class="user_date"><%=vo.getWheen() %></span><!-- ex.19시간 -->
							</div>
						</a>
					</div>
				</div>
			</div>
			<% } %>
		<% } %>
		</div>
	</main>
<jsp:include page="footer.jsp" flush="true"/>
</div>
</body>
</html>