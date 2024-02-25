<%@page import="vo.MypageProfileMemberInfoVo"%>
<%@page import="vo.MypageProfileHousePartyVo"%>
<%@page import="vo.MPOzipVo"%>
<%@ page import="vo.OzipVo"%>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("loginEmail")==null) {
%>
		<script>alert("로그인해주십시오"); location.href="Controller?command=login_form&ret_cmd=Mypage_shopping_list_form";</script>
<%
	} 
%>        

<%
	//내가 작성한 오집인
	ArrayList<MPOzipVo> listMPOzipVo = (ArrayList<MPOzipVo>) request.getAttribute("listMPOzipVo");
	//내가 작성한 집들이
	ArrayList<MypageProfileHousePartyVo> listMPPHouseParty = (ArrayList<MypageProfileHousePartyVo>) request.getAttribute("listMPPHouseParty");
	//내 계정정보
	ArrayList<MypageProfileMemberInfoVo> listMPPMemberInfo = (ArrayList<MypageProfileMemberInfoVo>) request.getAttribute("listMPPMemberInfo");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>alsldjswm28님의 집들이 페이지 | 라이프스타일 슈퍼앱, 오늘의집</title>
	<link rel="stylesheet" href="css/all.css">
	<link rel="stylesheet" href="css/header.css">
	<link rel="stylesheet" href="css/footer.css">
	<link rel="stylesheet" href="css/Mypage_shopping.css">
	<link rel="stylesheet" href="css/Ozip_main.css">
	<link rel="stylesheet" href="css/mypage_V_jy.css"/>
	<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
	<script src="js/jquery-3.7.1.min.js"></script>
	<script>
		//헤더 검색창 색 변경
		$(function() {
			$(".search1 > input").focus(function() {
				$(".search1").addClass('click');
			});
			$(".search1 > input").blur(function() {
				$(".search1").removeClass('click');
			});
			
			// 글자만
			 $(".upb").click(function(){
					$('.upb').removeClass("y_active_on_just_color");
					$(this).addClass('y_active_on_just_color');
				}); 
		//소메뉴 밑줄
			$(".downb").click(function(){
				$('.downb').removeClass("y_active_on");
				$(this).addClass('y_active_on');
			});
		//집들이 alert
			$('.b3b_hp').click(function() {
				alert("준비중인 기능입니다.");
			});
		});
	</script>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"/>
	<div class="mypage_menu_tl">
		<nav class="up MYmenu">
			<ul class="up_menu_inner">
				<li class="nav_button">
					<a class="active upb y_active_on_just_color" href="Controller?command=Mypage_profile_with_ozip">프로필</a>
				</li>
				<li class="nav_button">
					<a class="active upb" href="Controller?command=Mypage_shopping_list_form">나의 쇼핑</a>
				</li>
				<li class="nav_button">
					<a class="active upb" href="Controller?command=mypage_review_form">나의 리뷰</a>
				</li>
				<li class="nav_button">
					<a class="active upb" href="Controller?command=Mypage_setting_edit_user_info_form">설정</a>
				</li>
			</ul>
		</nav>
	</div><!-- 위에 상단 메뉴바 끝 -->
	<div><!------------ 컨텐트 -------------->
	<div id="container">
		<div id="content">
			<div class="block_1">
				<div class="b1_sticky">
					<%for(MypageProfileMemberInfoVo mIvo : listMPPMemberInfo) {%>
					<div class="b1_box">
						<div class="b1b_1">
							<button class="b1b_share" type="button">
								<svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor" preserveAspectRatio="xMidYMid meet"><path d="M9.64 14.646a4.5 4.5 0 1 1 0-5.292l4.54-2.476a4.5 4.5 0 1 1 .63.795l-4.675 2.55c.235.545.365 1.146.365 1.777s-.13 1.232-.365 1.777l4.675 2.55a4.5 4.5 0 1 1-.63.795l-4.54-2.476zM18 8a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7zM6 15.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7zM18 23a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7z"></path></svg>
							</button>
						</div>
						<div class="b1b_2">
							<div class="b1b2_1">
								<img class="css-1cqverl e18gdfbl2" src="https://image.ohou.se/i/bucketplace-v2-development/uploads/default_images/avatar.png?gif=1&w=36&webp=1"/>
							</div>
							<div class="b1b2_2">
								<div class="b22_1"><%=mIvo.getMemberId() %></div>
								<div class="b22_2">
									<div class="b1_follow">
										<span class="b1f_w">팔로워</span>
										<span class="b1f_n1">
											<a href="#"><%=mIvo.getFollowerCount() %></a>
										</span>
										<span class="b1f_w">팔로잉</span>
										<span class="b1f_n2">
											<a href="#"><%=mIvo.getFollowCount() %></a>
										</span>
									</div>
									<div class="b1_factory">
										<a href="Controller?command=Mypage_setting_edit_user_info_form" class="b1fac_1">설정</a>
									</div>
								</div>
							</div>
						</div>
						<div class="b1b_3">
							<p class="user_com"><%=mIvo.getOneLiner() %></p>
						</div>
					</div>
					<%} %>
				</div>
			</div>
			<div class="block_2"></div>
			<div class="block_3">
				<div class="jy_ozip_title_in_MyPage jy_up"><span>집들이</span></div>
				<div class="b3_box">
				<%for(MypageProfileHousePartyVo hPvo : listMPPHouseParty) {%>
					<div class="b3b_hp"><!-- 아마 이게 반복 -->
						<a href="#">
						<div class="b3bhp_img">
							<img class="image" alt="" src="<%=hPvo.getCoverImg() %>"/>
						</div>
						<span class="b3bhp_tit"><%=hPvo.getTitle() %></span>
						<div class="b3bhp_con" style="color:#bdbdbd;">
							<span class="b3bhpc1">스크랩 <%=hPvo.getShareCount() %></span>
							<span class="b3bhpc2">조회 <%=hPvo.getHitCount() %></span>
						</div>
						</a>
					</div>
				<%} %>
				</div>
			</div>
			<div class="block_3_1">
			
			</div>
		</div>
		<div class="jy_myPage_ozip_aera"><!-- 질문과 답변 부분  -->
			<div class="jy_myPage_inner">
			<div class="jy_ozip_title_in_MyPage"><span>질문과 답변</span></div>
			<%
			if(listMPOzipVo==null) {}
			else{
			for(MPOzipVo MPvo : listMPOzipVo) {
			%>
				<!-- 반복 -->
				<hr><!-- 1 -->
				<div class=content_inner_ozip>
					<a href="Controller?command=Ozip_detail&ozip_idx=<%=MPvo.getOzipIdx() %>" class="ozip_content_all" ></a>
					<div id="main_tl">
						<div class="fr">
							<% if(MPvo.getImgUrl()!=null && MPvo.getImgUrl().startsWith("http")) { %>
							<img src="<%=MPvo.getImgUrl() %>" class="content_image"/>
							<% } else if(MPvo.getImgUrl()!=null && !MPvo.getImgUrl().startsWith("http")) { %>
							<img src="upload/<%=MPvo.getImgUrl() %>" class="content_image">	
							<% } else { } %>
							</div>
							<div class="content_title_outer"><span class="content_title"><%=MPvo.getTitle() %></span></div>
							<div class="content_content_outer"><span class="content_content"><%=MPvo.getDescription() %></span></div>
							<div class="wdrhh">
								<div class="wdrh">
									<div class="w">
										<div class="w_i_w">
											<div class="w_i_w_image"><img src="https://image.ohou.se/i/bucketplace-v2-development/uploads/default_images/avatar.png?gif=1&w=36&webp=1" width=18px height=18px/></div>
											<div class="www"><%=MPvo.getMemberId() %></div>
										</div>
									</div>
									<div class="d">
										<%=MPvo.getWritedate() %>
									</div>
									<div class='r'>
										댓글
										<span class="jy_c_num">
											<%=MPvo.getcNum() %>
										</span>
									</div>
									<div class="hitcount">
										조회
										<%=MPvo.getHitcount() %>
									</div>
								</div>
								<ul class="ozip_tag_list">
									<%
										String[] arrHashtag = MPvo.getHashtag().split(" ");
										for(String tag : arrHashtag) {
									%>
										<li class="jy_old_tag_tl"><a href="Exsucess.jsp" class="hot_tag"><%=tag%></a></li>
									<%
										}
									%>
								</ul>
							</div>
						</div>
					</div>
					<!-- //반복 -->
				<%
				}
				%>
			<%
			}
			%>
				<hr>
			</div>	
		</div>
	</div>
	</div>	
	<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>