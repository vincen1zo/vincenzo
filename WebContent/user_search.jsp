<%@page import="dao.CommunityMainDao"%>
<%@page import="vo.UserSearchVo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ArrayList<UserSearchVo> listUserSearchVo = (ArrayList<UserSearchVo>) request.getAttribute("listUserSearchVo");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel ="stylesheet" href = "css/all.css">
	<link rel ="stylesheet" href = "css/header_kh.css">
	<link rel ="stylesheet" href = "css/footer.css">
	<link rel ="stylesheet" href = "css/user_search.css">
	<script src="js/jquery-3.7.1.min.js"></script>
	<script>
		$(function() {
			//헤더 검색창 색 변경
			$(".search1 > input").focus(function() {
				$(".search1").addClass('click');
			});
			$(".search1 > input").blur(function() {
				$(".search1").removeClass('click');
			});
			//메뉴 밑줄
			$(".m_line").click(function(){
				$(this).addClass('on');
			});
			//팔로우 버튼 클릭시
			$(".kh_searched_user_follow_btn").click(function() {
				$(".kh_user_follow_btn").attr('class','kh_user_follow_btn_on');
			});
		});
	</script>
<title>유저 검색</title>
</head>
<body>
	<div id="container">
		<jsp:include page="header_kh.jsp" flush="true"/>
		<div id="main">
			<% for(UserSearchVo vo : listUserSearchVo) { %>
			<div class="kh_search_title">
				<span>'action에서 받아온 검색단어일거야 그렇지?'에 대한 유저 검색 결과</span>
			</div>
				<div class="kh_search_result">
					<div class="kh_searched_user">
						<div class="kh_searched_user_img_name">
							<div class="kh_user_img">
								<img src="<%=vo.getProfileImg()%>"/>
							</div>
							<div class="kh_user_name">
								<span><%=vo.getMemberId() %></span>
							</div>
						</div>
						<div class="kh_searched_user_follow_btn">
							<% if(vo.isFollowing()) { %>
							<button class="kh_user_follow_btn_on">
								<svg width="16" height="16" viewBox="0 0 16 16" preserveAspectRatio="xMidYMid meet" class="css-13sh6fx e1q03nfq0"><path fill="#BDBDBD" d="M6.185 10.247L13.264 2.95 14.699 4.343 6.256 13.046 1.3 8.432 2.663 6.968z"></path></svg>팔로잉
							</button>
							<% } else { %>
							<button class="kh_user_follow_btn">
								<svg fill="none" viewBox="0 0 8 8" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" class="css-615bg6 e1q03nfq1"><path fill-rule="evenodd" clip-rule="evenodd" d="M4.77.14H3.23v3.09H.14v1.54h3.09v3.09h1.54V4.77h3.09V3.23H4.77V.14z" fill="currentColor"></path></svg>팔로우
							</button>
							<% } %>
						</div>
					</div>
				</div>
			<% } %>
			<%--
			<div class="kh_search_result">
				<div class="kh_searched_user">
					<div class="kh_searched_user_img_name">
						<div class="kh_user_img">
							<img src="https://image.ohou.se/i/bucketplace-v2-development/uploads/default_images/avatar.png?gif=1&w=240"/>
						</div>
						<div class="kh_user_name">
							<span>kevin</span>
						</div>
					</div>
					<div class="kh_searched_user_follow_btn">
						<button class="kh_user_follow_btn">
							<svg fill="none" viewBox="0 0 8 8" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" class="css-615bg6 e1q03nfq1"><path fill-rule="evenodd" clip-rule="evenodd" d="M4.77.14H3.23v3.09H.14v1.54h3.09v3.09h1.54V4.77h3.09V3.23H4.77V.14z" fill="currentColor"></path></svg>팔로우
						</button>
					</div>
				</div>
			</div>
			<div class="kh_search_result">
				<div class="kh_searched_user">
					<div class="kh_searched_user_img_name">
						<div class="kh_user_img">
							<img src="https://image.ohou.se/i/bucketplace-v2-development/uploads/default_images/avatar.png?gif=1&w=240"/>
						</div>
						<div class="kh_user_name">
							<span>bob</span>
						</div>
					</div>
					<div class="kh_searched_user_follow_btn">
						<button class="kh_user_follow_btn_on">
							<svg width="16" height="16" viewBox="0 0 16 16" preserveAspectRatio="xMidYMid meet" class="css-13sh6fx e1q03nfq0"><path fill="#BDBDBD" d="M6.185 10.247L13.264 2.95 14.699 4.343 6.256 13.046 1.3 8.432 2.663 6.968z"></path></svg>팔로잉
						</button>
					</div>
				</div>
			</div>
			--%>
		</div>
		<jsp:include page="footer.jsp" flush="true"/>
	</div>
</body>
</html>