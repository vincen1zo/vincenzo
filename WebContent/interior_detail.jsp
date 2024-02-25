<%@page import="vo.ConReviewVo"%>
<%@page import="vo.InteriorInfoVo"%>
<%@page import="vo.InteriorPhotoVo"%>
<%@page import="vo.HousepartySigongVo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.ConReviewListVo"%>
<%@page import="vo.InteriorDetailSideVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	String loginMemberId = "또랑이";   // TODO : from session.
 	String tab = (String)request.getAttribute("tab");
 	String conName = (String) request.getAttribute("conName");
 	int count = (Integer) request.getAttribute("count");
 	InteriorDetailSideVo sideVo = (InteriorDetailSideVo)request.getAttribute("sideVo");
 	ArrayList<ConReviewListVo> listConReviewListVo = (ArrayList<ConReviewListVo>) request.getAttribute("listConReviewListVo");
 	ArrayList<HousepartySigongVo> listSigong = (ArrayList<HousepartySigongVo>) request.getAttribute("listSigong");
 	ArrayList<InteriorPhotoVo> listInteriorPhoto = (ArrayList<InteriorPhotoVo>)request.getAttribute("listInteriorPhoto");
	ArrayList<ConReviewVo> listConReview = (ArrayList<ConReviewVo>)request.getAttribute("listConReview");
 	InteriorInfoVo getInfoVo = (InteriorInfoVo)request.getAttribute("getInfoVo"); 
 %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>인테리어 업체페이지</title>
	<link rel ="stylesheet" href = "css/all.css">
	<link rel ="stylesheet" href = "css/header.css">
	<link rel ="stylesheet" href = "css/footer.css">
	<link rel ="stylesheet" href = "css/interior_detail.css">
	<link rel ="stylesheet" href=" slick/slick.css">
	<link rel ="stylesheet" href="slick/slick-theme.css">
	<script src="js/jquery-3.7.1.min.js"></script>
	<script src="js/header_search.js"></script>
	<script src="js/interior_detail.js"></script>
	<script src="js/jquery-3.7.1.min.js"></script>
	<script src="slick/slick.js"></script>
	<script>
		let conName = '<%=conName%>';  // 전역변수
		let memberId = '<%=loginMemberId%>'; // 전역변수
	</script>
</head>
<body>
	<!--헤더-->
<header>
	<div class="fixed-container" style="height: 81px;">
		<div id = "header">
			<div id = "header_inner">
				<div class="logo"><a href="Controller?command=interior_main"><img src="images/logo.png"/></a></div>
				<div class="homemenu">
					<span class="h_menu"><a href="Controller?command=community_main">커뮤니티</a></span>
					<span class="h_menu"><a href="Controller?command=shopping_main">쇼핑</a></span>
					<span class="h_menu"><a href="Controller?command=interior_main" class="a">인테리어</a></span>
					<span class="h_menu"><a href="Controller?command=Ozip_main">오집in</a></span>
				</div>
				<div class="topSelect">
					<div class="search1">
						<span class="dbg"></span>
						<input type = "text" placeholder = "시공업체 검색(작업중)"/>
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
	<div class="sticky-container" style="height: 52px; top:80px; position:sticky;">
		<div class="menuLine">
			<div class="menuInner">
				<nav id="topMenu">
					<ul>
						<li class="m_line"><a href="Controller?command=interior_main">주거공간시공</a></li>
						<li class="m_line  ja_apt_link"><a>아파트시공사례</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
		<div style="clear:both"></div>
</header>
	
	<div class="sticky-container" style="top:80px; position:sticky; transition: top 0.1s ease 0s; z-index: 100;">
	<!--메인-->
	<main>
		<!--페이지 메뉴-->
		<div class="content">
				<div class="con_menu_line">
					<div class="con_menu_outline">
						<div class="con_menu_inner">
							<!--------------------모두보기------------------------>
							<a class="con_menu_a <%=(tab.equals("1") ? "on" : "")%>" href="#" id="m_all" >
								<span class="con_menu_t">모두보기</span>		
								<span class="con_menu_t">
									<span class="con_menu_t"></span>
								</span>
								<div class="blue_bar_box">
									<div class="blue_bar <%=(tab.equals("1") ? "blue_bar_o" : "")%>" id="m_all_blue"></div>
								</div>							
							</a>
							<!--------------------시공사례------------------------>
							<a class="con_menu_a <%=(tab.equals("2") ? "on" : "")%>" href="#" id="m_sigong">
								<span class="con_menu_t">시공사례</span>	
								<% if(listSigong.size() > 0) { %>	
								<span class="con_menu_t">(<%=listSigong.size() %>)</span>
								<% } %>
								<div class="blue_bar_box">
									<div class="blue_bar <%=(tab.equals("2") ? "blue_bar_o" : "")%>" id="m_sigong_blue"></div>
								</div>							
							</a>
							<!--------------------시공리뷰------------------------>
							<a class="con_menu_a <%=(tab.equals("3") ? "on" : "")%>" href="#" id="m_review">
								<span class="con_menu_t">시공리뷰</span>
								<%if(listConReview.size() > 0) %>
								<span class="con_menu_t">
									<span class="con_menu_t">(</span><%=listConReview.size() %><span class="con_menu_t">)</span>
								</span>
								<div class="blue_bar_box">
									<div class="blue_bar <%=(tab.equals("3") ? "blue_bar_o" : "")%>"  id="m_review_blue"></div>
								</div>							
							</a>
							<!--------------------사진------------------------>
							<a class="con_menu_a <%=(tab.equals("4") ? "on" : "")%>" href="#" id="m_photo">
								<span class="con_menu_t">사진</span>	
								<% if(listInteriorPhoto.size() > 0) { %>	
								<span class="con_menu_t">
									<span class="con_menu_t">(</span><%=listInteriorPhoto.size() %><span class="con_menu_t">)</span>
								</span>
								<% } %>
								<div class="blue_bar_box">
									<div class="blue_bar <%=(tab.equals("4") ? "blue_bar_o" : "")%>"  id="m_photo_blue"></div>
								</div>							
							</a>
							<!--------------------업체정보------------------------>
							<a class="con_menu_a <%=(tab.equals("5") ? "on" : "")%>" href="#" id="m_info">
								<span class="con_menu_t">업체정보</span>		
								<span class="con_menu_t">
									<span class="con_menu_t"></span><span class="con_menu_t"></span>
								</span>
								<div class="blue_bar_box">
									<div class="blue_bar <%=(tab.equals("5") ? "blue_bar_o" : "")%>"  id="m_info_blue"></div>
								</div>							
							</a>
							<!--------------------페이지 메뉴5개 끝------------------------>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--본문내용-->
		<div class="sub_content">
			<!--업체명-->
			<div class="inte_info">
				<div class="inte_info_sticky">
					<div class="sticky-child">
						<article class="inte_info_inner">
							<div class="inte_header">
								<h1><%=sideVo.getName() %></h1>
								<% if(sideVo.getProfessional()==1){ %>
								<div class="ja_junmun_box">
									<span class= "ja_junmun_span">
										<button class = "ja_junmun_btn">
											<span class = ja_junmun_btn_span>
												<svg width="53" height="20" viewBox="0 0 53 20" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M0 4C0 1.79086 1.79086 0 4 0H49C51.2091 0 53 1.79086 53 4V16C53 18.2091 51.2091 20 49 20H4C1.79086 20 0 18.2091 0 16V4Z" fill="#09609C"></path><path d="M9.37 8.03V9.1H10.81V12.37H12.13V5.65H10.81V8.03H9.37ZM9.98 10.15C8.53 9.66 7.9 8.53 7.9 7.44V7.32H9.69V6.27H4.74V7.32H6.55V7.45C6.55 8.61 5.89 9.82 4.38 10.31L5.04 11.36C6.12 11 6.84 10.27 7.25 9.36C7.64 10.19 8.33 10.85 9.34 11.18L9.98 10.15ZM7.38 13.65V11.81H6.06V14.7H12.34V13.65H7.38ZM19.2992 8.43H15.6492V7.07H19.2992V8.43ZM20.5992 6.04H14.3492V9.47H20.5992V6.04ZM15.6092 12.03H14.2892V14.7H20.7392V13.65H15.6092V12.03ZM13.3192 10.2V11.24H16.9492V12.81H18.2692V11.24H21.6592V10.2H13.3192ZM27.0184 8.33V9.4H28.6084V12.38H29.9284V5.65H28.6084V8.33H27.0184ZM22.8184 6.34V7.39H25.6884C25.4684 8.74 24.2584 9.84 22.3384 10.44L22.8784 11.5C25.5584 10.65 27.0984 8.83 27.0984 6.34H22.8184ZM25.2284 13.65V11.72H23.9084V14.7H30.1584V13.65H25.2284ZM37.5077 10.33H38.8277V5.65H37.5077V7H35.8277V8.05H37.5077V10.33ZM36.6277 9.21C35.1877 8.77 34.5577 7.7 34.5577 6.61V5.95H33.2277V6.61C33.2277 7.78 32.5877 8.91 31.0577 9.37L31.7377 10.4C32.7877 10.07 33.5077 9.39 33.9177 8.53C34.3077 9.3 34.9877 9.91 35.9577 10.22L36.6277 9.21ZM34.0677 13.73V13.19H38.8277V10.72H32.7577V11.73H37.5277V12.24H32.7677V14.76H39.0877V13.73H34.0677ZM46.4169 13.71H42.9369V12.88H46.4169V13.71ZM46.4169 11.88H42.9369V11H41.6269V14.75H47.7269V11H46.4169V11.88ZM42.5669 9.33C41.8969 9.33 41.4069 8.92 41.4069 8.23C41.4069 7.54 41.8969 7.13 42.5669 7.13C43.2469 7.13 43.7369 7.54 43.7369 8.23C43.7369 8.92 43.2469 9.33 42.5669 9.33ZM46.4069 5.65V7.68H44.9369C44.6769 6.7 43.7369 6.03 42.5669 6.03C41.1869 6.03 40.1469 6.95 40.1469 8.23C40.1469 9.51 41.1869 10.43 42.5669 10.43C43.7569 10.43 44.6969 9.75 44.9469 8.75H46.4069V10.6H47.7269V5.65H46.4069Z" fill="white"></path></svg>
											</span>
										</button>
									</span>
								</div>
								<% } %>
							</div>
							
							<% if(!(sideVo.getExp()==null)) { %>
							<p><%=sideVo.getExp() %></p>
							<% } %>
							<!--계약자리뷰, 별점내용-->
							<div class="con_re_box">
							<% if(!(sideVo.getGuarantee()==0)) { %>
								<div class="con_re_bold_box">
									<svg width="75" height="16" viewBox="0 0 66 13" fill="none" xmlns="http://www.w3.org/2000/svg" class="css-sphuky"><path d="M19.308 1.418V11.618H17.76V8.558H16.464V7.058H17.76V5.09H16.56C16.488 6.33 16.224 7.482 15.768 8.546C15.312 9.61 14.612 10.538 13.668 11.33C13.444 11.186 13.224 11.038 13.008 10.886C12.792 10.734 12.576 10.582 12.36 10.43C13.344 9.638 14.032 8.738 14.424 7.73C14.816 6.714 15.012 5.65 15.012 4.538V2.99H12.828V1.538H16.584V3.59H17.76V1.418H19.308ZM21.792 11.738H20.208V1.37H21.792V11.738Z" fill="#2F3438"></path><path d="M22.5167 4.442V4.166C22.5167 3.766 22.5887 3.394 22.7327 3.05C22.8767 2.706 23.0767 2.41 23.3327 2.162C23.5967 1.914 23.9047 1.722 24.2567 1.586C24.6167 1.442 25.0127 1.37 25.4447 1.37C25.8687 1.37 26.2567 1.442 26.6087 1.586C26.9687 1.722 27.2807 1.914 27.5447 2.162C27.8007 2.41 28.0007 2.706 28.1447 3.05C28.2967 3.394 28.3727 3.766 28.3727 4.166V4.442C28.3727 4.85 28.2967 5.226 28.1447 5.57C28.0007 5.906 27.8007 6.198 27.5447 6.446C27.2807 6.694 26.9687 6.886 26.6087 7.022C26.2567 7.158 25.8687 7.226 25.4447 7.226C25.0127 7.226 24.6167 7.158 24.2567 7.022C23.9047 6.886 23.5967 6.694 23.3327 6.446C23.0767 6.198 22.8767 5.906 22.7327 5.57C22.5887 5.226 22.5167 4.85 22.5167 4.442ZM31.5407 8.054V11.846H29.9447V9.482H22.9007V8.054H31.5407ZM24.0887 4.166V4.442C24.0887 4.85 24.2087 5.194 24.4487 5.474C24.6967 5.754 25.0287 5.894 25.4447 5.894C25.8527 5.894 26.1807 5.754 26.4287 5.474C26.6767 5.194 26.8007 4.85 26.8007 4.442V4.166C26.8007 3.758 26.6767 3.414 26.4287 3.134C26.1807 2.854 25.8527 2.714 25.4447 2.714C25.0287 2.714 24.6967 2.854 24.4487 3.134C24.2087 3.414 24.0887 3.758 24.0887 4.166ZM31.5407 6.494V7.538H29.9447V1.37H31.5407V2.642H32.8847V3.998H31.5407V5.15H32.8847V6.494H31.5407Z" fill="#2F3438"></path><path d="M33.5974 1.538H39.3574V2.99H37.0894C37.0734 3.446 37.0494 3.89 37.0174 4.322C36.9854 4.754 36.9374 5.174 36.8734 5.582C37.1854 6.47 37.6014 7.33 38.1214 8.162C38.6494 8.994 39.2614 9.718 39.9574 10.334C39.8534 10.422 39.7494 10.506 39.6454 10.586C39.5414 10.674 39.4414 10.758 39.3454 10.838C39.2414 10.926 39.1374 11.01 39.0334 11.09C38.9294 11.178 38.8294 11.262 38.7334 11.342C38.2534 10.878 37.8094 10.354 37.4014 9.77C36.9934 9.186 36.6334 8.582 36.3214 7.958C36.1134 8.59 35.8614 9.198 35.5654 9.782C35.2774 10.358 34.9414 10.906 34.5574 11.426C34.3174 11.306 34.0774 11.182 33.8374 11.054C33.6054 10.926 33.3734 10.794 33.1414 10.658C33.9574 9.538 34.5494 8.366 34.9174 7.142C35.2854 5.918 35.4814 4.534 35.5054 2.99H33.5974V1.538ZM42.3454 6.794V11.738H40.7494V1.37H42.3454V5.27H43.6894V6.794H42.3454Z" fill="#2F3438"></path><path d="M53.3661 1.37V11.738H51.7821V1.37H53.3661ZM50.3781 9.842V11.282H44.4021V5.534H48.1461V2.99H44.4021V1.538H49.7421V6.986H45.9981V9.842H50.3781Z" fill="#2F3438"></path><path d="M63.5107 1.538V6.974H54.5947V1.538H56.1908V2.834H61.9147V1.538H63.5107ZM64.0147 7.85V9.302H61.8908V11.846H60.2948V9.302H57.8107V11.846H56.2267V9.302H54.0907V7.85H64.0147ZM56.1908 5.534H61.9147V4.262H56.1908V5.534Z" fill="#2F3438"></path><path d="M0 2.93682C0 1.86714 0.881439 1 1.96875 1H8.53125C9.61856 1 10.5 1.86714 10.5 2.93682V8.99308C10.5 9.77962 10.0165 10.4881 9.27646 10.7858L5.99521 12.1059C5.5176 12.298 4.9824 12.298 4.50479 12.1059L1.22354 10.7858C0.483515 10.4881 0 9.77962 0 8.99308V2.93682Z" fill="#E3F3FD"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M8.53125 1.73169H1.96875C1.2922 1.73169 0.74375 2.27124 0.74375 2.93682V8.99308C0.74375 9.48248 1.0446 9.92329 1.50506 10.1085L4.78631 11.4286C5.08349 11.5482 5.41651 11.5482 5.71369 11.4286L8.99494 10.1085C9.4554 9.92329 9.75625 9.48248 9.75625 8.99308V2.93682C9.75625 2.27124 9.2078 1.73169 8.53125 1.73169ZM1.96875 1C0.881439 1 0 1.86714 0 2.93682V8.99308C0 9.77962 0.483515 10.4881 1.22354 10.7858L4.50479 12.1059C4.9824 12.298 5.5176 12.298 5.99521 12.1059L9.27646 10.7858C10.0165 10.4881 10.5 9.77962 10.5 8.99308V2.93682C10.5 1.86714 9.61856 1 8.53125 1H1.96875Z" fill="#E3F3FD"></path><path d="M1.53125 3.15202C1.53125 2.79546 1.82506 2.50641 2.1875 2.50641H8.3125C8.67494 2.50641 8.96875 2.79546 8.96875 3.15202V8.87443C8.96875 9.13605 8.80827 9.3718 8.56237 9.47141L5.49987 10.712C5.33981 10.7768 5.16019 10.7768 5.00013 10.712L1.93763 9.47141C1.69174 9.3718 1.53125 9.13605 1.53125 8.87443V3.15202Z" fill="#35C5F0"></path><path d="M5.58058 4.50827C5.47163 4.1999 5.02834 4.19991 4.91939 4.50827L4.57903 5.47156L3.5426 5.49233C3.21083 5.49899 3.07385 5.91374 3.33828 6.11097L4.16435 6.72709L3.86417 7.70322C3.76807 8.0157 4.1267 8.27203 4.39909 8.08556L5.24998 7.50306L6.10088 8.08556C6.37327 8.27203 6.73189 8.01569 6.6358 7.70322L6.33562 6.72709L7.16169 6.11097C7.42612 5.91374 7.28914 5.49899 6.95737 5.49233L5.92094 5.47156L5.58058 4.50827Z" fill="white"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M8.53125 1.73169H1.96875C1.2922 1.73169 0.74375 2.27124 0.74375 2.93682V8.99308C0.74375 9.48248 1.0446 9.92329 1.50506 10.1085L4.78631 11.4286C5.08349 11.5482 5.41651 11.5482 5.71369 11.4286L8.99494 10.1085C9.4554 9.92329 9.75625 9.48248 9.75625 8.99308V2.93682C9.75625 2.27124 9.2078 1.73169 8.53125 1.73169ZM1.96875 1C0.881439 1 0 1.86714 0 2.93682V8.99308C0 9.77962 0.483515 10.4881 1.22354 10.7858L4.50479 12.1059C4.9824 12.298 5.5176 12.298 5.99521 12.1059L9.27646 10.7858C10.0165 10.4881 10.5 9.77962 10.5 8.99308V2.93682C10.5 1.86714 9.61856 1 8.53125 1H1.96875Z" fill="black"></path></svg>
									<button>
										<div>
											<svg width="15" height="15" viewBox="0 0 15 15" preserveAspectRatio="xMidYMid meet"><path fill="#bdbdbd" fill-rule="evenodd" d="M7.5 15a7.5 7.5 0 1 1 0-15 7.5 7.5 0 0 1 0 15zm0-1a6.5 6.5 0 1 0 0-13 6.5 6.5 0 0 0 0 13zm-.86-3.97h1.75v1.7H6.64v-1.7zm-.97-6.58c.46-.3 1.02-.45 1.7-.45.88 0 1.61.21 2.2.63.58.42.87 1.05.87 1.88 0 .5-.13.93-.38 1.28-.15.21-.43.48-.85.81l-.42.32c-.23.18-.38.38-.45.62a2.6 2.6 0 0 0-.08.69H6.68a4.6 4.6 0 0 1 .19-1.37c.1-.25.36-.54.78-.87l.43-.33c.14-.1.25-.22.34-.35.16-.21.23-.45.23-.7 0-.3-.08-.58-.26-.82-.17-.24-.49-.37-.95-.37-.45 0-.77.15-.96.46-.2.3-.29.6-.29.93H4.5c.05-1.11.44-1.9 1.17-2.36z"></path></svg>
										</div>
									</button>
								</div>
								<% } %>
								<div class="con_star_box">
									<div class="con_star_box_inner">
										<a href="#">
											<span aria-label="평균별점쓰기(ex별점4.8점)">
												<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-0" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-0"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-0" fill="#DBDBDB"></use><use clip-path="url(#star-clip-0)" xlink:href="#star-path-0"></use></svg>
												<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-1" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-1"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-1" fill="#DBDBDB"></use><use clip-path="url(#star-clip-1)" xlink:href="#star-path-1"></use></svg>
												<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-2" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-2"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-2" fill="#DBDBDB"></use><use clip-path="url(#star-clip-2)" xlink:href="#star-path-2"></use></svg>
												<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-3" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-3"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-3" fill="#DBDBDB"></use><use clip-path="url(#star-clip-3)" xlink:href="#star-path-3"></use></svg>
												<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-4" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-4"><rect x="0" y="0" width="20.159999999999997" height="24"></rect></clipPath></defs><use xlink:href="#star-path-4" fill="#DBDBDB"></use><use clip-path="url(#star-clip-4)" xlink:href="#star-path-4"></use></svg>
											</span>
										</a>
										<span class="con_star_avg_num"><%=sideVo.getStarpointAvg() %></span>
										<span class="con_num">(오늘의집 계약 <%=count%>개)</span>
									</div>
									
								</div>
								<!--별점 디테일 / 상태바-->
								<div><!--star_avg_detail_num 박스-->
									<div class="star_avg_detail_num">
										<div class="star_avg_detail_box">
											<div class="avg_detail">
												<div class="avg_text">
													<div>소통</div>
												</div>
												<div class="status_bar_box">
													<div>
														<div class="status_bar_num">
															<div class="status_bar">
																<progress class="bar" value="<%=sideVo.getStarCommu() %>" min="0" max="5"></progress>
															</div>
															<div class="status_bar_number">
																<div class="status_bar_number_inner">
																	<div class="number"><%=sideVo.getStarCommu() %></div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>

										<div class="star_avg_detail_box">
											<div class="avg_detail">
												<div class="avg_text">
													<div>가격</div>
												</div>
												<div class="status_bar_box">
													<div>
														<div class="status_bar_num">
															<div class="status_bar">
																<progress class="bar" value="<%=sideVo.getStarPrice() %>" min="0" max="5"></progress>
															</div>
															<div class="status_bar_number">
																<div class="status_bar_number_inner">
																	<div class="number"><%=sideVo.getStarPrice() %></div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
										
										<div class="star_avg_detail_box">
											<div class="avg_detail">
												<div class="avg_text">
													<div>시공결과</div>
												</div>
												<div class="status_bar_box">
													<div>
														<div class="status_bar_num">
															<div class="status_bar">
																<progress class="bar" value="<%=sideVo.getStarResult() %>" min="0" max="5"></progress>
															</div>
															<div class="status_bar_number">
																<div class="status_bar_number_inner">
																	<div class="number"><%=sideVo.getStarResult() %></div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
										
										<div class="star_avg_detail_box">
											<div class="avg_detail">
												<div class="avg_text">
													<div>일정준수</div>
												</div>
												<div class="status_bar_box">
													<div>
														<div class="status_bar_num">
															<div class="status_bar">
																<progress class="bar" value="<%=sideVo.getStarSchedule() %>" min="0" max="5"></progress>
															</div>
															<div class="status_bar_number">
																<div class="status_bar_number_inner">
																	<div class="number"><%=sideVo.getStarSchedule() %></div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
										
										<div class="star_avg_detail_box">
											<div class="avg_detail">
												<div class="avg_text">
													<div>A/S</div>
												</div>
												<div class="status_bar_box">
													<div>
														<div class="status_bar_num">
															<div class="status_bar">
																<progress class="bar" value="<%=sideVo.getStarAs() %>" min="0" max="5"></progress>
															</div>
															<div class="status_bar_number">
																<div class="status_bar_number_inner">
																	<div class="number"><%=sideVo.getStarAs() %></div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!--회색선-->
							<div class="gray_line"></div>
							<!--업체공지-->
							<% if(!(sideVo.getTitle()==null)){ %>
							<a>
								<div class="notice_box">
									<span class="icon1  notice_icon"></span>
									<div class="notice_text">
										<b> <%=sideVo.getTitle() %> </b><%=sideVo.getContent() %>
									</div>
									<span class="icon2  notice_icon"></span>
								</div>
							</a>
							<% } %>
							<!--상담, 리뷰버튼-->
							<div class="btn_big_box">
								<div class="btn_two_box">
									<div class="btn"><button class="btn1">상담신청</button></div>
									<div class="btn"><button class="btn2">리뷰쓰기</button></div>
								</div>
							</div>
						</article>
					</div>
				</div>
			</div>
			<!--내용 공통 틀-->
			<div class="main_content_box">

			<!--모두보기-->
				<div class="all_view  snh <%=(tab.equals("1") ? "on" : "")%>" id="all_view">
				<% if(sideVo.getoStandard()==1) { %>
					<div class="standard">
						<a class="stan_top" href="https://ohou.se/competitions/987">
							<div class="stan_top_text">
								<svg width="107" height="14" viewBox="0 0 107 14" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M8.09237 1.12818C7.7548 0.790607 7.20748 0.790607 6.86991 1.12818L6.11111 1.88698L5.07457 1.60924C4.61344 1.48568 4.13945 1.75934 4.01589 2.22047L3.73815 3.25701L2.70161 3.53475C2.24048 3.65831 1.96682 4.1323 2.09038 4.59343L2.36812 5.62997L1.60932 6.38877C1.27175 6.72634 1.27175 7.27366 1.60932 7.61123L2.36812 8.37003L2.09038 9.40657C1.96682 9.8677 2.24048 10.3417 2.70161 10.4653L3.73815 10.743L4.01589 11.7795C4.13945 12.2407 4.61344 12.5143 5.07457 12.3908L6.11111 12.113L6.86991 12.8718C7.20748 13.2094 7.7548 13.2094 8.09237 12.8718L8.85117 12.113L9.88771 12.3908C10.3488 12.5143 10.8228 12.2407 10.9464 11.7795L11.2241 10.743L12.2607 10.4653C12.7218 10.3417 12.9955 9.86771 12.8719 9.40658L12.5942 8.37003L13.353 7.61123C13.6905 7.27366 13.6905 6.72634 13.353 6.38877L12.5942 5.62997L12.8719 4.59343C12.9955 4.1323 12.7218 3.65831 12.2607 3.53475L11.2241 3.25701L10.9464 2.22047C10.8228 1.75934 10.3488 1.48568 9.88771 1.60924L8.85117 1.88698L8.09237 1.12818Z" fill="white"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M10.2238 5.10576C10.4241 5.30408 10.4257 5.62724 10.2274 5.82756L6.86889 9.22011C6.77056 9.31943 6.6358 9.37409 6.49606 9.37132C6.35632 9.36856 6.22383 9.3086 6.12952 9.20546L4.55239 7.48083C4.36216 7.27281 4.37658 6.94996 4.5846 6.75974C4.79262 6.56951 5.11546 6.58393 5.30569 6.79195L6.52083 8.12074L9.50199 5.1094C9.7003 4.90907 10.0235 4.90745 10.2238 5.10576Z" fill="#2E3B5C"></path><path d="M23.1538 7.76025H20.2007C19.6813 7.76025 19.2122 7.68905 18.7933 7.54663C18.3744 7.39583 18.0142 7.1864 17.7126 6.91832C17.411 6.64187 17.1807 6.31515 17.0215 5.93816C16.8623 5.56117 16.7827 5.1423 16.7827 4.68154C16.7827 4.22916 16.8623 3.81448 17.0215 3.43749C17.1807 3.05213 17.411 2.72541 17.7126 2.45733C18.0142 2.18925 18.3744 1.97982 18.7933 1.82902C19.2122 1.67823 19.6813 1.60283 20.2007 1.60283H23.1538C23.6648 1.60283 24.1298 1.67823 24.5486 1.82902C24.9759 1.97982 25.3403 2.18925 25.6419 2.45733C25.9435 2.72541 26.1738 3.05213 26.333 3.43749C26.5006 3.81448 26.5843 4.22916 26.5843 4.68154C26.5843 5.1423 26.5006 5.56117 26.333 5.93816C26.1738 6.31515 25.9435 6.64187 25.6419 6.91832C25.3403 7.1864 24.9759 7.39583 24.5486 7.54663C24.1298 7.68905 23.6648 7.76025 23.1538 7.76025ZM20.2259 6.22718H23.1161C23.6439 6.22718 24.0669 6.08477 24.3853 5.79993C24.7036 5.50672 24.8628 5.13392 24.8628 4.68154C24.8628 4.24592 24.7036 3.8815 24.3853 3.58829C24.0669 3.2867 23.6439 3.1359 23.1161 3.1359H20.2259C19.6897 3.1359 19.2666 3.2867 18.9567 3.58829C18.6551 3.8815 18.5043 4.24592 18.5043 4.68154C18.5043 5.13392 18.6551 5.50672 18.9567 5.79993C19.2666 6.08477 19.6897 6.22718 20.2259 6.22718ZM26.8734 10.5122V12.0453H16.4811V10.5122H20.7788V8.2252H22.538V10.5122H26.8734Z" fill="white"></path><path d="M37.459 11.1154V12.3972H28.0092V9.25563H35.6746V8.67758H28.0092V7.39583H37.3459V10.5122H29.6805V11.1154H37.459ZM27.4814 5.44808H37.8737V6.75496H27.4814V5.44808ZM37.4339 3.48776V4.79464H28.0092V1.6531H29.6805V3.48776H37.4339Z" fill="white"></path><path d="M45.2801 4.73181C45.2801 5.18419 45.2005 5.60306 45.0413 5.98842C44.8905 6.37379 44.6727 6.7047 44.3879 6.98115C44.103 7.25761 43.7596 7.47542 43.3574 7.63459C42.9553 7.78539 42.5113 7.86078 42.0254 7.86078C41.5228 7.86078 41.0704 7.78539 40.6683 7.63459C40.2745 7.47542 39.9352 7.25761 39.6504 6.98115C39.374 6.7047 39.1603 6.37379 39.0095 5.98842C38.8587 5.60306 38.7833 5.18419 38.7833 4.73181C38.7833 4.2878 38.8587 3.87731 39.0095 3.50032C39.1603 3.11496 39.374 2.77986 39.6504 2.49503C39.9352 2.21857 40.2745 2.00076 40.6683 1.84159C41.0704 1.68242 41.5228 1.60283 42.0254 1.60283C42.5113 1.60283 42.9553 1.68242 43.3574 1.84159C43.7596 2.00076 44.103 2.21857 44.3879 2.49503C44.6727 2.77986 44.8905 3.11496 45.0413 3.50032C45.2005 3.87731 45.2801 4.2878 45.2801 4.73181ZM43.659 4.73181C43.659 4.24592 43.5124 3.83961 43.2192 3.51289C42.926 3.17779 42.5281 3.01024 42.0254 3.01024C41.5228 3.01024 41.1248 3.17779 40.8316 3.51289C40.5384 3.83961 40.3918 4.24592 40.3918 4.73181C40.3918 5.22608 40.5384 5.63657 40.8316 5.96329C41.1248 6.29001 41.5228 6.45337 42.0254 6.45337C42.5281 6.45337 42.926 6.29001 43.2192 5.96329C43.5124 5.63657 43.659 5.22608 43.659 4.73181ZM46.6246 12.46V1.60283H48.2834V12.46H46.6246ZM38.4818 12.0453V10.5248H45.9084V12.0453H38.4818Z" fill="white"></path><path d="M53.6415 3.19874C53.6163 3.33277 53.5912 3.46263 53.5661 3.58829C53.5409 3.71395 53.5158 3.83961 53.4907 3.96527C53.8258 4.44279 54.2446 4.87841 54.7473 5.27215C55.2499 5.66589 55.7903 6.00099 56.3683 6.27745C56.2846 6.38635 56.2008 6.49107 56.117 6.5916C56.0416 6.69213 55.962 6.79266 55.8783 6.89319C55.7945 7.0021 55.7107 7.10681 55.6269 7.20734C55.5515 7.30787 55.4761 7.4084 55.4007 7.50893C54.9232 7.25761 54.4625 6.9644 54.0185 6.6293C53.5745 6.2942 53.1765 5.92559 52.8247 5.52348C52.5482 6.00099 52.2173 6.42824 51.8319 6.80523C51.455 7.17383 51.0403 7.4838 50.5879 7.73512C50.4874 7.65135 50.3868 7.56757 50.2863 7.4838C50.1942 7.39165 50.0978 7.29949 49.9973 7.20734C49.8968 7.11519 49.7962 7.02723 49.6957 6.94345C49.6035 6.8513 49.5114 6.75915 49.4192 6.667C50.1229 6.27326 50.6926 5.79155 51.1282 5.22189C51.5722 4.64384 51.8571 3.96946 51.9827 3.19874H49.8968V1.77876H55.7903V3.19874H53.6415ZM59.2837 7.97388V12.3972H50.2486V7.97388H51.9199V8.82838H57.6375V7.97388H59.2837ZM51.9073 11.0652H57.6375V10.1478H51.9073V11.0652ZM59.2837 1.60283V7.58433H57.625V1.60283H59.2837Z" fill="white"></path><path d="M73.5179 10.5122V12.0453H63.1257V10.5122H73.5179ZM64.0807 8.07441L63.0629 6.78009C64.2943 6.34447 65.3122 5.66589 66.1164 4.74437C66.9291 3.82286 67.4443 2.75473 67.6621 1.54L69.3962 1.82902C69.346 2.12223 69.2789 2.41126 69.1952 2.69609C69.1114 2.97254 69.0108 3.24481 68.8936 3.51289C69.4716 4.19146 70.1628 4.77788 70.967 5.27215C71.7796 5.75804 72.6509 6.11828 73.5807 6.35284L72.676 7.69742C71.7796 7.46285 70.9377 7.10681 70.1502 6.6293C69.3627 6.14341 68.6716 5.58631 68.0768 4.958C67.5741 5.67008 66.9751 6.29839 66.2798 6.84292C65.5845 7.38746 64.8515 7.79795 64.0807 8.07441Z" fill="white"></path><path d="M84.1035 10.8767V12.3972H74.8925V9.0043H76.5638V10.8767H84.1035ZM83.9276 1.60283V9.56978H82.3317V5.8125H81.3516V9.39386H79.7934V1.6531H81.3516V4.36739H82.3317V1.60283H83.9276ZM79.2027 6.90576V8.28803H74.5407V1.77876H78.9389V3.1736H76.124V4.30456H78.876V5.68684H76.124V6.90576H79.2027Z" fill="white"></path><path d="M92.0377 11.9825H85.541V1.77876H91.422V3.29926H87.2123V10.4745H92.0377V11.9825ZM94.7017 7.28274V12.46H93.0304V1.60283H94.7017V5.68684H96.1091V7.28274H94.7017Z" fill="white"></path><path d="M98.3257 6.37798H106.104V7.92361H96.6544V1.77876H105.991V3.31183H98.3257V6.37798ZM106.519 10.5122V12.0453H96.1266V10.5122H106.519Z" fill="white"></path></svg>
								<div>새로운 시공의 기준</div>
							</div>
							<span></span>
						</a>
						<div class="stan_content">
							<div class="stan_con">
								<div class="stan_con_top">
									<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M5.99961 3.90001C4.83981 3.90001 3.89961 4.84021 3.89961 6.00001V8.00001C3.89961 8.49706 3.49667 8.90001 2.99961 8.90001C2.50255 8.90001 2.09961 8.49706 2.09961 8.00001V6.00001C2.09961 3.8461 3.8457 2.10001 5.99961 2.10001H7.99961C8.49667 2.10001 8.89961 2.50295 8.89961 3.00001C8.89961 3.49706 8.49667 3.90001 7.99961 3.90001H5.99961Z" fill="#2F3438"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M17.8975 3.90001C19.0573 3.90001 19.9975 4.84021 19.9975 6.00001V8.00001C19.9975 8.49706 20.4004 8.90001 20.8975 8.90001C21.3946 8.90001 21.7975 8.49706 21.7975 8.00001V6.00001C21.7975 3.8461 20.0514 2.10001 17.8975 2.10001H15.9996C15.5026 2.10001 15.0996 2.50295 15.0996 3.00001C15.0996 3.49706 15.5026 3.90001 15.9996 3.90001H17.8975Z" fill="#2F3438"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M5.99961 20.1C4.83981 20.1 3.89961 19.1598 3.89961 18V16C3.89961 15.5029 3.49667 15.1 2.99961 15.1C2.50255 15.1 2.09961 15.5029 2.09961 16V18C2.09961 20.1539 3.8457 21.9 5.99961 21.9H7.99961C8.49667 21.9 8.89961 21.4971 8.89961 21C8.89961 20.5029 8.49667 20.1 7.99961 20.1H5.99961Z" fill="#2F3438"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M17.8975 20.1C19.0573 20.1 19.9975 19.1598 19.9975 18V16C19.9975 15.5029 20.4004 15.1 20.8975 15.1C21.3946 15.1 21.7975 15.5029 21.7975 16V18C21.7975 20.1539 20.0514 21.9 17.8975 21.9H15.9996C15.5026 21.9 15.0996 21.4971 15.0996 21C15.0996 20.5029 15.5026 20.1 15.9996 20.1H17.8975Z" fill="#2F3438"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M14.7878 10.7941C14.7878 12.7239 13.2235 14.2882 11.2937 14.2882C9.36398 14.2882 7.79961 12.7239 7.79961 10.7941C7.79961 8.86438 9.36398 7.30001 11.2937 7.30001C13.2235 7.30001 14.7878 8.86438 14.7878 10.7941ZM14.1355 15.2617C13.3145 15.785 12.3395 16.0882 11.2937 16.0882C8.36987 16.0882 5.99961 13.718 5.99961 10.7941C5.99961 7.87026 8.36987 5.50001 11.2937 5.50001C14.2176 5.50001 16.5878 7.87026 16.5878 10.7941C16.5878 12.0216 16.1701 13.1516 15.469 14.0495L18.1066 16.6871C18.458 17.0386 18.458 17.6085 18.1066 17.9599C17.7551 18.3114 17.1852 18.3114 16.8338 17.9599L14.1355 15.2617Z" fill="#2F3438"></path></svg>
								</div>
								<div class="stan_con_text">에디터엄선<br> <b>맞춤 시공 업체</b></div>
							</div>
							
							<div class="stan_border"></div>
							
							<div class="stan_con">
								<div class="stan_con_top">
									<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M18 3.8H6C5.33726 3.8 4.8 4.33726 4.8 5V19C4.8 19.6627 5.33726 20.2 6 20.2H13C16.4242 20.2 19.2 17.4242 19.2 14V5C19.2 4.33726 18.6627 3.8 18 3.8ZM6 2C4.34315 2 3 3.34315 3 5V19C3 20.6569 4.34315 22 6 22H13C17.4183 22 21 18.4183 21 14V5C21 3.34315 19.6569 2 18 2H6Z" fill="#2F3438"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M8 7.6C8 7.10294 8.40294 6.7 8.9 6.7H15.1C15.5971 6.7 16 7.10294 16 7.6C16 8.09706 15.5971 8.5 15.1 8.5H8.9C8.40294 8.5 8 8.09706 8 7.6Z" fill="#2F3438"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M8 11.6C8 11.1029 8.40294 10.7 8.9 10.7H15.1C15.5971 10.7 16 11.1029 16 11.6C16 12.0971 15.5971 12.5 15.1 12.5H8.9C8.40294 12.5 8 12.0971 8 11.6Z" fill="#2F3438"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M8 15.6C8 15.1029 8.40294 14.7 8.9 14.7H13.1C13.5971 14.7 14 15.1029 14 15.6C14 16.0971 13.5971 16.5 13.1 16.5H8.9C8.40294 16.5 8 16.0971 8 15.6Z" fill="#2F3438"></path></svg>
								</div>
								<div class="stan_con_text">자재·인건비 표기<br> <b>투명 견적 제공</b></div>
							</div>
							
							<div class="stan_border"></div>
							
							<div class="stan_con">
								<div class="stan_con_top">
									<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M3 11.613V5.58302C3 5.04302 3.43 4.61302 3.97 4.58302C7.65501 4.38328 10.0733 3.04964 11.2216 2.2389C11.6728 1.92037 12.3272 1.92037 12.7784 2.2389C13.9267 3.04964 16.345 4.38328 20.03 4.58302C20.57 4.61302 21 5.04302 21 5.58302V11.613C21 11.613 21 18.1152 12.9428 21.2719C12.3384 21.5087 11.6616 21.5087 11.0572 21.2719C3 18.1152 3 11.613 3 11.613Z" fill="#15B869"></path><path d="M8.08203 11.795L10.5861 14.5332L15.9185 9.14682" stroke="white" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"></path></svg>
								</div>
								<div class="stan_con_text">
									<span>책임보장</span>으로<br>
									<b>맞춤 시공 업체</b>
								</div>
							</div>
						</div>
					</div>
					<% } %>
					<% if(sideVo.getGuarantee()==0) { %>
					<div class =ja_red_box>
						<section class = "ja_red_section">
							<div class = "ja_red_box_inner">
								<div class = ja_red_box>
									<svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M1.50981 9.9613L5.27207 3.18923C6.45318 1.06323 9.51072 1.06322 10.6918 3.18923L14.4541 9.9613C15.602 12.0276 14.1079 14.5668 11.7442 14.5668H4.21969C1.85599 14.5668 0.361891 12.0275 1.50981 9.9613ZM8.00049 5.3501C8.4147 5.3501 8.75049 5.68588 8.75049 6.1001V8.9001C8.75049 9.31431 8.4147 9.6501 8.00049 9.6501C7.58627 9.6501 7.25049 9.31431 7.25049 8.9001V6.1001C7.25049 5.68588 7.58627 5.3501 8.00049 5.3501ZM8.00049 10.25C8.4147 10.25 8.75049 10.5858 8.75049 11V11.0667C8.75049 11.4809 8.4147 11.8167 8.00049 11.8167C7.58627 11.8167 7.25049 11.4809 7.25049 11.0667V11C7.25049 10.5858 7.58627 10.25 8.00049 10.25Z" fill="#FF7777"></path></svg>
									<div class = "ja_red_box_text">남의집에서 <b>책임보장하지 않는 업체</b>에요</div>
								</div>
							</div>
						</section>
					</div>
					<% } %>
					<% if(listConReviewListVo.size() > 0 ) { %>
					<div class="con_review_title">계약자 리뷰</div>
					<div class="con_re_tt_notice_box">
						<div class="con_re_tt_notice">
							<p>모든 시공 리뷰는 <b>100% 계약사실이 확인된 리뷰</b>입니다</p>
						</div>
					</div>
					
					<div class="con_re_box">
						<div class="con_re_small_box">
							<ul class = "ja_con_review_list">
								<%
									for(ConReviewListVo vo : listConReviewListVo) {
								%>
								<li class="con_re">
									<a>
										<div class="con_box_inner">
											<div class="con_box_header">
												<h1><%=vo.getMemberId() %></h1>
											</div>
											<div class="con_t_i">
												<p><%=vo.getContent() %></p>
												<% if(vo.getImgUrl() != null) { %>
												<div>
													<img src="<%=vo.getImgUrl()%>"/>
												</div>
												<% } %>
											</div>
										</div>
									</a>
								</li>
								<% } %>
							</ul>
						</div>
						<% if(listConReviewListVo.size() > 2) { %>
						<div class="con_re_box_add">
							<a class="con_re_box_add_inner" >
								시공리뷰&nbsp;<b><%=listConReviewListVo.size() %>개</b>&nbsp;전체보기
							</a>
						</div>
						<% } %>
					</div>
					<% } %>
					<% if(listSigong.size() > 0) { %>
					<div class="c_case">
						<div class="c_case_header_box">
							<div class="c_case_header">
								<div class="c_case_h1">
									<h1>시공사례</h1>
									<b class="c_case_h1_b"><%=listSigong.size() %></b>
								</div>
								<a class="c_case_h2  c_case_sigong">전체보기</a>
							</div>
						</div>
						<div class="c_case_box">
							<div class="c_case_inner_box">
								<div class="c_case_content">
									<% 
									int idx = 0;
									for(idx=0; idx<=5; idx++) {
										if(idx>listSigong.size()-1) break;
										HousepartySigongVo vo = listSigong.get(idx); 
									%>
									<div class="c_case_element  c_case_sigong_sa">
										<article no="<%=vo.getHousepartyIdx() %>" class="ja_article">
											<a class="c_case_tag_a" ></a>	
											<div class="c_case_img">
												<img src="<%=vo.getCoverImg()%>"/>
											</div>
											<div class="c_case_title">
												<h1 class="c_case_t_h1"><%=vo.getTitle() %></h1>
											</div>
										</article>
									</div>
									<% } %>
								</div>
							</div>
						</div>
					</div>
					<% } %>
					<% if(listInteriorPhoto.size() > 0){ %>
					<div class="con_img">
						<div class="con_img_header_box">
							<div class="con_img_header">
								<div class="con_img_h1">
									<h1>사진</h1>
									<b class="con_img_h1_b"><%=listInteriorPhoto.size() %></b>
								</div>
								<a class="con_img_h2" id="photo_all">전체보기</a>
							</div>
						</div>
						<div class="con_img_content">
							<div class="con_img_content1">
								<div class="con_img_content_box">
								<% 
									int idx = 0;
									for(idx=0; idx<=5; idx++) {
										if(idx>listInteriorPhoto.size()-1) break;
										InteriorPhotoVo vo = listInteriorPhoto.get(idx); 
								%>
									<div class="con_img_element  photo_go">
										<a class="con_img_tag_a">
											<div class="con_img_box">
												<img src="<%=vo.getImgUrl()%>"/>
											</div>
										</a>
									</div>
								<% } %>
								</div>
							</div>
						</div>
						<% } %>
					</div>
				</div> <!--모두보기(all_view 끝!)--> 
				
				
				<!--시공사례-->
				<div class="d_con_content_box  snh<%=(tab.equals("2") ? "on" : "")%>" id="d_con_content_box">
					<div class="d_con_content_inner">
						<div class="d_con_element_box">
						<%for(HousepartySigongVo vo : listSigong) { %>
							<article class="d_con_element">
								<a class="d_con_a_tag" href="Controller?command=houseparty_detail&houseparty_idx=<%=vo.getHousepartyIdx()%>">
								<div class="d_con_img">
									<img src="<%=vo.getCoverImg()%>"/>
								</div>	
								<div class="d_con_text_box">
									<h1 class="d_con_text_h1"><%=vo.getTitle() %></h1>
									<div class="d_con_text_footer_box">
										<div class="d_con_text_footer">
											<div class="d_con_text_footer_text">스크랩 <%=vo.getLikeyCount() %></div>
											<div class="d_con_text_footer_text">조회 <%=vo.getHitCount() %></div>
										</div>
									</div>
								</div>	
								</a>
							</article>
							<% } %>
						</div>
					</div>
				</div> <!--시공사례 끝-->
				
				<!--시공리뷰-->
				<div class="inte_con_re_big_box  snh<%=(tab.equals("3") ? "on" : "")%>" id="inte_con_re_big_box">
					<div class="inte_con_re_header_box">
						<div class="inte_con_re_header_box_inner">
							<div class="inte_con_re_header">
								<p class="inte_con_re_header_p">모든 시공 리뷰는 <b>100% 계약사실이 확인된 리뷰</b>입니다</p>
							</div>
						</div>
					</div>
					<div class="inte_con_re_btn_box">
						<a class="inte_con_re_btn  color" href="#">최신순</a>
						<a class="inte_con_re_btn" href="#">인기순</a>
					</div>
					<div class="inte_con_re_content">
					<% for( ConReviewVo vo : listConReview) { %>
						<!-----------------------리뷰 한 박스 시작-------------------------->
						<div class="inte_con_re_elememt_box">
							<div class="inte_con_re_element">
								<div class="inte_con_re_ele_header">
									<div class="inte_con_re_ele_header_inner">
										<div class="inte_con_re_ele_header_left">
											<a class="inte_con_re_ele_header_left_a">
												<div class="inte_con_re_ele_profile_img">
													<img src="<%=vo.getProfileImg()%>"/>
												</div>
											</a>
										</div>
										<div class="inte_con_re_ele_header_right">
											<address>
												<a class="inte_con_re_writer" href="#">
													<h1 class="inte_con_re_writer_h1"><%=vo.getMemberId() %></h1>
												</a>
												<div class="inte_con_re_writer_add">
													<svg width="75" height="16" viewBox="0 0 66 13" fill="none" xmlns="http://www.w3.org/2000/svg" class="css-sphuky"><path d="M19.308 1.418V11.618H17.76V8.558H16.464V7.058H17.76V5.09H16.56C16.488 6.33 16.224 7.482 15.768 8.546C15.312 9.61 14.612 10.538 13.668 11.33C13.444 11.186 13.224 11.038 13.008 10.886C12.792 10.734 12.576 10.582 12.36 10.43C13.344 9.638 14.032 8.738 14.424 7.73C14.816 6.714 15.012 5.65 15.012 4.538V2.99H12.828V1.538H16.584V3.59H17.76V1.418H19.308ZM21.792 11.738H20.208V1.37H21.792V11.738Z" fill="#2F3438"></path><path d="M22.5167 4.442V4.166C22.5167 3.766 22.5887 3.394 22.7327 3.05C22.8767 2.706 23.0767 2.41 23.3327 2.162C23.5967 1.914 23.9047 1.722 24.2567 1.586C24.6167 1.442 25.0127 1.37 25.4447 1.37C25.8687 1.37 26.2567 1.442 26.6087 1.586C26.9687 1.722 27.2807 1.914 27.5447 2.162C27.8007 2.41 28.0007 2.706 28.1447 3.05C28.2967 3.394 28.3727 3.766 28.3727 4.166V4.442C28.3727 4.85 28.2967 5.226 28.1447 5.57C28.0007 5.906 27.8007 6.198 27.5447 6.446C27.2807 6.694 26.9687 6.886 26.6087 7.022C26.2567 7.158 25.8687 7.226 25.4447 7.226C25.0127 7.226 24.6167 7.158 24.2567 7.022C23.9047 6.886 23.5967 6.694 23.3327 6.446C23.0767 6.198 22.8767 5.906 22.7327 5.57C22.5887 5.226 22.5167 4.85 22.5167 4.442ZM31.5407 8.054V11.846H29.9447V9.482H22.9007V8.054H31.5407ZM24.0887 4.166V4.442C24.0887 4.85 24.2087 5.194 24.4487 5.474C24.6967 5.754 25.0287 5.894 25.4447 5.894C25.8527 5.894 26.1807 5.754 26.4287 5.474C26.6767 5.194 26.8007 4.85 26.8007 4.442V4.166C26.8007 3.758 26.6767 3.414 26.4287 3.134C26.1807 2.854 25.8527 2.714 25.4447 2.714C25.0287 2.714 24.6967 2.854 24.4487 3.134C24.2087 3.414 24.0887 3.758 24.0887 4.166ZM31.5407 6.494V7.538H29.9447V1.37H31.5407V2.642H32.8847V3.998H31.5407V5.15H32.8847V6.494H31.5407Z" fill="#2F3438"></path><path d="M33.5974 1.538H39.3574V2.99H37.0894C37.0734 3.446 37.0494 3.89 37.0174 4.322C36.9854 4.754 36.9374 5.174 36.8734 5.582C37.1854 6.47 37.6014 7.33 38.1214 8.162C38.6494 8.994 39.2614 9.718 39.9574 10.334C39.8534 10.422 39.7494 10.506 39.6454 10.586C39.5414 10.674 39.4414 10.758 39.3454 10.838C39.2414 10.926 39.1374 11.01 39.0334 11.09C38.9294 11.178 38.8294 11.262 38.7334 11.342C38.2534 10.878 37.8094 10.354 37.4014 9.77C36.9934 9.186 36.6334 8.582 36.3214 7.958C36.1134 8.59 35.8614 9.198 35.5654 9.782C35.2774 10.358 34.9414 10.906 34.5574 11.426C34.3174 11.306 34.0774 11.182 33.8374 11.054C33.6054 10.926 33.3734 10.794 33.1414 10.658C33.9574 9.538 34.5494 8.366 34.9174 7.142C35.2854 5.918 35.4814 4.534 35.5054 2.99H33.5974V1.538ZM42.3454 6.794V11.738H40.7494V1.37H42.3454V5.27H43.6894V6.794H42.3454Z" fill="#2F3438"></path><path d="M53.3661 1.37V11.738H51.7821V1.37H53.3661ZM50.3781 9.842V11.282H44.4021V5.534H48.1461V2.99H44.4021V1.538H49.7421V6.986H45.9981V9.842H50.3781Z" fill="#2F3438"></path><path d="M63.5107 1.538V6.974H54.5947V1.538H56.1908V2.834H61.9147V1.538H63.5107ZM64.0147 7.85V9.302H61.8908V11.846H60.2948V9.302H57.8107V11.846H56.2267V9.302H54.0907V7.85H64.0147ZM56.1908 5.534H61.9147V4.262H56.1908V5.534Z" fill="#2F3438"></path><path d="M0 2.93682C0 1.86714 0.881439 1 1.96875 1H8.53125C9.61856 1 10.5 1.86714 10.5 2.93682V8.99308C10.5 9.77962 10.0165 10.4881 9.27646 10.7858L5.99521 12.1059C5.5176 12.298 4.9824 12.298 4.50479 12.1059L1.22354 10.7858C0.483515 10.4881 0 9.77962 0 8.99308V2.93682Z" fill="#E3F3FD"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M8.53125 1.73169H1.96875C1.2922 1.73169 0.74375 2.27124 0.74375 2.93682V8.99308C0.74375 9.48248 1.0446 9.92329 1.50506 10.1085L4.78631 11.4286C5.08349 11.5482 5.41651 11.5482 5.71369 11.4286L8.99494 10.1085C9.4554 9.92329 9.75625 9.48248 9.75625 8.99308V2.93682C9.75625 2.27124 9.2078 1.73169 8.53125 1.73169ZM1.96875 1C0.881439 1 0 1.86714 0 2.93682V8.99308C0 9.77962 0.483515 10.4881 1.22354 10.7858L4.50479 12.1059C4.9824 12.298 5.5176 12.298 5.99521 12.1059L9.27646 10.7858C10.0165 10.4881 10.5 9.77962 10.5 8.99308V2.93682C10.5 1.86714 9.61856 1 8.53125 1H1.96875Z" fill="#E3F3FD"></path><path d="M1.53125 3.15202C1.53125 2.79546 1.82506 2.50641 2.1875 2.50641H8.3125C8.67494 2.50641 8.96875 2.79546 8.96875 3.15202V8.87443C8.96875 9.13605 8.80827 9.3718 8.56237 9.47141L5.49987 10.712C5.33981 10.7768 5.16019 10.7768 5.00013 10.712L1.93763 9.47141C1.69174 9.3718 1.53125 9.13605 1.53125 8.87443V3.15202Z" fill="#35C5F0"></path><path d="M5.58058 4.50827C5.47163 4.1999 5.02834 4.19991 4.91939 4.50827L4.57903 5.47156L3.5426 5.49233C3.21083 5.49899 3.07385 5.91374 3.33828 6.11097L4.16435 6.72709L3.86417 7.70322C3.76807 8.0157 4.1267 8.27203 4.39909 8.08556L5.24998 7.50306L6.10088 8.08556C6.37327 8.27203 6.73189 8.01569 6.6358 7.70322L6.33562 6.72709L7.16169 6.11097C7.42612 5.91374 7.28914 5.49899 6.95737 5.49233L5.92094 5.47156L5.58058 4.50827Z" fill="white"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M8.53125 1.73169H1.96875C1.2922 1.73169 0.74375 2.27124 0.74375 2.93682V8.99308C0.74375 9.48248 1.0446 9.92329 1.50506 10.1085L4.78631 11.4286C5.08349 11.5482 5.41651 11.5482 5.71369 11.4286L8.99494 10.1085C9.4554 9.92329 9.75625 9.48248 9.75625 8.99308V2.93682C9.75625 2.27124 9.2078 1.73169 8.53125 1.73169ZM1.96875 1C0.881439 1 0 1.86714 0 2.93682V8.99308C0 9.77962 0.483515 10.4881 1.22354 10.7858L4.50479 12.1059C4.9824 12.298 5.5176 12.298 5.99521 12.1059L9.27646 10.7858C10.0165 10.4881 10.5 9.77962 10.5 8.99308V2.93682C10.5 1.86714 9.61856 1 8.53125 1H1.96875Z" fill="black"></path></svg>
													<span style="display: inline-block; width: 6px; height: 1px;"></span>
													<%
														String writedate = vo.getWritedate();
														writedate = writedate.split(" ")[0];
														writedate = writedate.replace("-", ".");
													%>
													<span class="inte_con_re_writer_date"><%=writedate %></span><!-- 수정해야함 --> 
													<% if(vo.getoCon() == 1){ %>
													<span class="inte_con_re_writer1">・오늘의집 계약</span>
													<% } else { %>
													<span class="inte_con_re_writer1">・업체 계약</span>
													<% } %>
													<button class="report_btn">신고</button>
												</div>
											</address>
										</div>
									</div>
								</div>
								<!--시공리뷰 > 리뷰 키워드-->
								<div class="inte_con_re_ele_keyword">
									<ul>
										<li class="inte_re_keyword">
											<span class="inte_re_key"><%=vo.getConTime() %></span>
										</li>
										<li class="inte_re_keyword">
											<span class="inte_re_key">
											<% if(vo.getConPriceLow() != 0) { %>
												<%=vo.getConPriceLow() %>만원~
												<%=vo.getConPriceHigh() %>만원</span>
											<% } else { %>
												<%=vo.getConPriceHigh() %>만원 이하
											<% } %>
										</li>
										<li class="inte_re_keyword">
											<span class="inte_re_key"><%=vo.getAddress() %></span>
										</li>
										<li class="inte_re_keyword">
											<span class="inte_re_key"><%=vo.getHomeType() %> </span>
										</li>
										<li class="inte_re_keyword">
											<span class="inte_re_key"><%=vo.getConField() %></span>
										</li>
										<li class="inte_re_keyword">
											<span class="inte_re_key"><%=vo.getPy() %></span>
										</li>
									</ul>
								</div>
								<% if(vo.getImgUrl()!=null){ %>
								<!--시공리뷰 > 리뷰 사진(10장)-->
								<div class="inte_con_re_ele_images_box">
									<div class="inte_con_re_ele_images">
											<% for(String strImgUrl : vo.getImgUrl().split(" ")) { %>
										<div class="interior_images_element_box">
											<div class="interior_images fl">
												<img src="<%=strImgUrl%>"/>
											</div>
										</div>
										<% } %>
									</div>
								</div>
								<% } %>
								<div class="inte_con_re_ele_text">
									<p><%=vo.getContent() %>
									</p>
								</div>
								<div class="inte_con_re_ele_footer_box">
									<div class="inte_con_re_ele_footer" review_idx="<%=vo.getReviewIdx()%>">
										<button type="button" class="ja_product_re_help_btn">도움이 돼요</button>
<!-- 										<button type="button" class="ja_product_re_help_btn on">도움됨</button> -->
										<p><%=vo.getLikeyCount() %> 명에게 도움이 됨</p>
									</div>
								</div>
							</div>
						</div>
						<!-----------------------리뷰 한 박스 끝-------------------------->
						<% } %>
					</div>
				</div><!--시공리뷰 끝-->
				<!--사진-->
				<div class="interior_con_img_big_box  snh<%=(tab.equals("4") ? "on" : "")%>" id="interior_con_img_big_box">
					<div class="interior_con_img_box">
<%-- 				<% if(listInteriorPhoto.size() > 0) { %> --%>
					<% for(InteriorPhotoVo vo : listInteriorPhoto) { %>
						<div class="interior_con_img_element">
							<a class="interior_con_img_a">
								<article class="int_con_img_ar">
									<div class="int_con_img">
										<img src="<%=vo.getImgUrl()%>"/>
										<%if(vo.getImgUrl().contains(" ")) { %>
										<div class="img_add">
											<svg width="18" height="18" viewBox="0 0 18 18" preserveAspectRatio="xMidYMid meet"><g fill="none" fill-rule="evenodd"><path stroke="#000" stroke-opacity=".14" stroke-width=".75" d="M14.27 3.85H15a2.62 2.62 0 0 1 2.62 2.63V15A2.62 2.62 0 0 1 15 17.63H6.49A2.62 2.62 0 0 1 3.85 15v-.73h7.8a2.63 2.63 0 0 0 2.62-2.62v-7.8zM.37 3A2.62 2.62 0 0 1 3 .37h8.52A2.62 2.62 0 0 1 14.15 3v8.52a2.62 2.62 0 0 1-2.63 2.63H3a2.62 2.62 0 0 1-2.63-2.63V3z"></path><path fill="#FFF" fill-opacity=".74" d="M14.64 4.22H15c1.25 0 2.26 1 2.26 2.26V15c0 1.24-1 2.25-2.25 2.25H6.48c-1.25 0-2.26-1-2.26-2.25v-.35h7.43a3 3 0 0 0 3-3V4.22zM.75 3C.75 1.76 1.75.75 3 .75h8.52c1.25 0 2.26 1 2.26 2.25v8.52c0 1.25-1 2.26-2.26 2.26H3c-1.24 0-2.25-1-2.25-2.26V3z"></path></g></svg>
										</div>
										<% } %>
									</div>
								</article>
							</a>
						</div>
						<% } %>
<%-- 				<% } %> --%>
					</div>
				</div><!--사진 끝-->
				<!--업체정보-->
				<div class="con_info_box  snh<%=(tab.equals("5") ? "on" : "")%>" id="con_info_box">
				<% if(getInfoVo.getTitle() != null){ %>
					<div class="con_info_notice_box">
						<div class="con_info_notice_head_box">
							<span class="con_info_notice_head_icon"></span>
							<div class="con_into_notice_head_text"> <%=getInfoVo.getTitle() %> </div>
						</div>
						<div class="con_info_notice_content">
<%=getInfoVo.getContent() %>
						</div>
						<div class="con_info_notice_img">
							<picture>
								<img src="<%=getInfoVo.getImgUrl()%>"/>
							</picture>
						</div>
						<div class="con_info_notice_small_text">본 내용은 파트너가 직접 작성한 내용입니다. 오늘의집은 본 이벤트/공지 내용과 무관하니, 문의사항이 있으면 업체로 직접 문의해주세요.</div>
					</div>
					<hr class="con_info_notice_hr">
					<% } %>
					<div class="con_ini">
						<div class="con_ini_element_box">
							<dt class="con_ini_element_dt">시공분야</dt>
							<dd class="con_ini_element_dd"><%=getInfoVo.getField() %></dd>
						</div>
						<div class="con_ini_element_line"></div>
						<div class="con_ini_element_box">
							<dt class="con_ini_element_dt">최근계약</dt>
							<dd class="con_ini_element_dd"><%=getInfoVo.getRecentContracts() %>건</dd>
						</div>
						<div class="con_ini_element_line"></div>
						<div class="con_ini_element_box">
							<dt class="con_ini_element_dt">A/S</dt>
							<dd class="con_ini_element_dd"><%=getInfoVo.getAsYear() %></dd>
						</div>
						<div class="con_ini_element_line"></div>
						<div class="con_ini_element_box">
							<dt class="con_ini_element_dt">경력</dt>
							<dd class="con_ini_element_dd"><%=getInfoVo.getCareer() %></dd>
						</div>
						<div class="con_ini_element_line"></div>
						<div class="con_ini_element_box">
							<dt class="con_ini_element_dt">제공 서비스</dt>
							<dd class="con_ini_element_dd"><%=getInfoVo.getService() %></dd>
						</div>
					</div>
					<hr class="con_ini_hr">
					<pre class="con_info_pre"></pre>
				</div><!--업체정보 끝-->
			</div>
		</div>
	</main>
<jsp:include page="footer.jsp" flush="true"/>	
	<!--인테리어 > 시공리뷰 > 사진 팝업-->
	<div class="con_inte_rev_img_pop_smallBox_outer">
		<div class="con_inte_rev_img_pop_smallBox">
			<div class="con_inte_review_img_pop">
				<div class="review_img_pop_header">
					<h1>리뷰 사진 보기</h1>
				<div>
					<button class="x">
						<svg width="24" height="24" viewBox="0 0 24 24" fill="none" preserveAspectRatio="xMidYMid meet"><path d="M12 11.292L3.868 3.16l-.707.707L11.293 12 3.16 20.13l.707.707L12 12.706l8.132 8.132.707-.707-8.132-8.132 8.132-8.132-.707-.707L12 11.292z" fill="currentColor"></path></svg>
					</button>
				</div>
				</div>
				<div class="review_img_pop_content_box">
					<!--------------------사진 시작------------------------------>
					<div class="review_img_pop_content">
						<div data-photos-index="0" class="review_img">
							<img src="https://image.ohou.se/i/bucketplace-v2-development/uploads/cards/expert_reviews/169711079078581437.jpeg?gif=1&amp;w=640&amp;h=640&amp;c=c&amp;webp=1"/>
						</div>
					</div>
					<!--------------------사진 끝------------------------------>
					<!--------------------사진 시작------------------------------>
					<div class="review_img_pop_content">
						<div data-photos-index="0" class="review_img">
							<img src=""/>
						</div>
					</div>
					<!--------------------사진 끝------------------------------>
				</div>
			</div>
		</div>
	</div>
	<div class="con_inte_rev_img_pop_bigBox"></div>
	
	
	<!--인테리어 > 사진 > 사진 팝업-->
	<div class="con_inte_photo_img_pop_smallBox_outer">
		<div class="con_inte_photo_img_pop_smallBox">
			<div class="con_int_photo_img_pop">
				<div class="review_photo_imt_pop_header">
					<h1>시공 사진 보기</h1>
				<div>
					<button class="x">
						<svg width="24" height="24" viewBox="0 0 24 24" fill="none" preserveAspectRatio="xMidYMid meet"><path d="M12 11.292L3.868 3.16l-.707.707L11.293 12 3.16 20.13l.707.707L12 12.706l8.132 8.132.707-.707-8.132-8.132 8.132-8.132-.707-.707L12 11.292z" fill="currentColor"></path></svg>
					</button>
				</div>
				</div>
				<div class="photo_img_pop_content_box">
				<% for(InteriorPhotoVo vo : listInteriorPhoto) { %>
					<!--------------------사진 시작------------------------------>
					<div class="photo_img_pop_content">
						<div data-photos-index="0" class="photo_img">
							<img src="<%=vo.getImgUrl()%>"/>
						</div>
					</div>
					<!--------------------사진 끝------------------------------>
				<% } %>
				</div>
			</div>
		</div>
	</div>
	<div class="con_inte_photo_img_pop_bigBox"></div>
</body>
</html>
