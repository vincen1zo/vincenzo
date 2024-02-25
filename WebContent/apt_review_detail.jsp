<%@page import="vo.AptReveiwPhotoVo"%>
<%@page import="vo.AptConReviewVo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	AptConReviewVo ConReviewByReviewIdxVo = (AptConReviewVo)request.getAttribute("ConReviewByReviewIdxVo");
	ArrayList<AptReveiwPhotoVo> listAptReviewPhoto =(ArrayList<AptReveiwPhotoVo>)request.getAttribute("listAptReviewPhoto");
%>    
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>아파트 시공리뷰</title>
	<link rel ="stylesheet" href = "css/all.css">
	<link rel ="stylesheet" href = "css/header.css">
	<link rel ="stylesheet" href = "css/footer.css">
	<link rel ="stylesheet" href = "css/apt_review_detail.css">
	<script src="js/jquery-3.7.1.min.js"></script>
	<script src="js/header_search.js"></script>
	<script src="js/apt_review_detail.js"></script>
</head>
<body>
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
						<li class="m_line"><a href="Controller?command=apt_main">아파트시공사례</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
		<div style="clear:both"></div>
</header>
<div id="content">
	<section class="section_box">
		<div>
			<!--작성자-->
			<address class="review_writer">
				<a href="#" class="user_profile">
					<img src="<%=ConReviewByReviewIdxVo.getProfileImg() %>" height="0">
				</a>
				<div class="writer_name">
					<a href="#">
						<h1><%=ConReviewByReviewIdxVo.getMemberId() %></h1>
					</a>
					<div class="writer_date">
						<svg width="75" height="16" viewBox="0 0 66 13" fill="none" xmlns="http://www.w3.org/2000/svg" class="css-1ijrn93"><path d="M19.308 1.418V11.618H17.76V8.558H16.464V7.058H17.76V5.09H16.56C16.488 6.33 16.224 7.482 15.768 8.546C15.312 9.61 14.612 10.538 13.668 11.33C13.444 11.186 13.224 11.038 13.008 10.886C12.792 10.734 12.576 10.582 12.36 10.43C13.344 9.638 14.032 8.738 14.424 7.73C14.816 6.714 15.012 5.65 15.012 4.538V2.99H12.828V1.538H16.584V3.59H17.76V1.418H19.308ZM21.792 11.738H20.208V1.37H21.792V11.738Z" fill="#2F3438"></path><path d="M22.5167 4.442V4.166C22.5167 3.766 22.5887 3.394 22.7327 3.05C22.8767 2.706 23.0767 2.41 23.3327 2.162C23.5967 1.914 23.9047 1.722 24.2567 1.586C24.6167 1.442 25.0127 1.37 25.4447 1.37C25.8687 1.37 26.2567 1.442 26.6087 1.586C26.9687 1.722 27.2807 1.914 27.5447 2.162C27.8007 2.41 28.0007 2.706 28.1447 3.05C28.2967 3.394 28.3727 3.766 28.3727 4.166V4.442C28.3727 4.85 28.2967 5.226 28.1447 5.57C28.0007 5.906 27.8007 6.198 27.5447 6.446C27.2807 6.694 26.9687 6.886 26.6087 7.022C26.2567 7.158 25.8687 7.226 25.4447 7.226C25.0127 7.226 24.6167 7.158 24.2567 7.022C23.9047 6.886 23.5967 6.694 23.3327 6.446C23.0767 6.198 22.8767 5.906 22.7327 5.57C22.5887 5.226 22.5167 4.85 22.5167 4.442ZM31.5407 8.054V11.846H29.9447V9.482H22.9007V8.054H31.5407ZM24.0887 4.166V4.442C24.0887 4.85 24.2087 5.194 24.4487 5.474C24.6967 5.754 25.0287 5.894 25.4447 5.894C25.8527 5.894 26.1807 5.754 26.4287 5.474C26.6767 5.194 26.8007 4.85 26.8007 4.442V4.166C26.8007 3.758 26.6767 3.414 26.4287 3.134C26.1807 2.854 25.8527 2.714 25.4447 2.714C25.0287 2.714 24.6967 2.854 24.4487 3.134C24.2087 3.414 24.0887 3.758 24.0887 4.166ZM31.5407 6.494V7.538H29.9447V1.37H31.5407V2.642H32.8847V3.998H31.5407V5.15H32.8847V6.494H31.5407Z" fill="#2F3438"></path><path d="M33.5974 1.538H39.3574V2.99H37.0894C37.0734 3.446 37.0494 3.89 37.0174 4.322C36.9854 4.754 36.9374 5.174 36.8734 5.582C37.1854 6.47 37.6014 7.33 38.1214 8.162C38.6494 8.994 39.2614 9.718 39.9574 10.334C39.8534 10.422 39.7494 10.506 39.6454 10.586C39.5414 10.674 39.4414 10.758 39.3454 10.838C39.2414 10.926 39.1374 11.01 39.0334 11.09C38.9294 11.178 38.8294 11.262 38.7334 11.342C38.2534 10.878 37.8094 10.354 37.4014 9.77C36.9934 9.186 36.6334 8.582 36.3214 7.958C36.1134 8.59 35.8614 9.198 35.5654 9.782C35.2774 10.358 34.9414 10.906 34.5574 11.426C34.3174 11.306 34.0774 11.182 33.8374 11.054C33.6054 10.926 33.3734 10.794 33.1414 10.658C33.9574 9.538 34.5494 8.366 34.9174 7.142C35.2854 5.918 35.4814 4.534 35.5054 2.99H33.5974V1.538ZM42.3454 6.794V11.738H40.7494V1.37H42.3454V5.27H43.6894V6.794H42.3454Z" fill="#2F3438"></path><path d="M53.3661 1.37V11.738H51.7821V1.37H53.3661ZM50.3781 9.842V11.282H44.4021V5.534H48.1461V2.99H44.4021V1.538H49.7421V6.986H45.9981V9.842H50.3781Z" fill="#2F3438"></path><path d="M63.5107 1.538V6.974H54.5947V1.538H56.1908V2.834H61.9147V1.538H63.5107ZM64.0147 7.85V9.302H61.8908V11.846H60.2948V9.302H57.8107V11.846H56.2267V9.302H54.0907V7.85H64.0147ZM56.1908 5.534H61.9147V4.262H56.1908V5.534Z" fill="#2F3438"></path><path d="M0 2.93682C0 1.86714 0.881439 1 1.96875 1H8.53125C9.61856 1 10.5 1.86714 10.5 2.93682V8.99308C10.5 9.77962 10.0165 10.4881 9.27646 10.7858L5.99521 12.1059C5.5176 12.298 4.9824 12.298 4.50479 12.1059L1.22354 10.7858C0.483515 10.4881 0 9.77962 0 8.99308V2.93682Z" fill="#E3F3FD"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M8.53125 1.73169H1.96875C1.2922 1.73169 0.74375 2.27124 0.74375 2.93682V8.99308C0.74375 9.48248 1.0446 9.92329 1.50506 10.1085L4.78631 11.4286C5.08349 11.5482 5.41651 11.5482 5.71369 11.4286L8.99494 10.1085C9.4554 9.92329 9.75625 9.48248 9.75625 8.99308V2.93682C9.75625 2.27124 9.2078 1.73169 8.53125 1.73169ZM1.96875 1C0.881439 1 0 1.86714 0 2.93682V8.99308C0 9.77962 0.483515 10.4881 1.22354 10.7858L4.50479 12.1059C4.9824 12.298 5.5176 12.298 5.99521 12.1059L9.27646 10.7858C10.0165 10.4881 10.5 9.77962 10.5 8.99308V2.93682C10.5 1.86714 9.61856 1 8.53125 1H1.96875Z" fill="#E3F3FD"></path><path d="M1.53125 3.15202C1.53125 2.79546 1.82506 2.50641 2.1875 2.50641H8.3125C8.67494 2.50641 8.96875 2.79546 8.96875 3.15202V8.87443C8.96875 9.13605 8.80827 9.3718 8.56237 9.47141L5.49987 10.712C5.33981 10.7768 5.16019 10.7768 5.00013 10.712L1.93763 9.47141C1.69174 9.3718 1.53125 9.13605 1.53125 8.87443V3.15202Z" fill="#35C5F0"></path><path d="M5.58058 4.50827C5.47163 4.1999 5.02834 4.19991 4.91939 4.50827L4.57903 5.47156L3.5426 5.49233C3.21083 5.49899 3.07385 5.91374 3.33828 6.11097L4.16435 6.72709L3.86417 7.70322C3.76807 8.0157 4.1267 8.27203 4.39909 8.08556L5.24998 7.50306L6.10088 8.08556C6.37327 8.27203 6.73189 8.01569 6.6358 7.70322L6.33562 6.72709L7.16169 6.11097C7.42612 5.91374 7.28914 5.49899 6.95737 5.49233L5.92094 5.47156L5.58058 4.50827Z" fill="white"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M8.53125 1.73169H1.96875C1.2922 1.73169 0.74375 2.27124 0.74375 2.93682V8.99308C0.74375 9.48248 1.0446 9.92329 1.50506 10.1085L4.78631 11.4286C5.08349 11.5482 5.41651 11.5482 5.71369 11.4286L8.99494 10.1085C9.4554 9.92329 9.75625 9.48248 9.75625 8.99308V2.93682C9.75625 2.27124 9.2078 1.73169 8.53125 1.73169ZM1.96875 1C0.881439 1 0 1.86714 0 2.93682V8.99308C0 9.77962 0.483515 10.4881 1.22354 10.7858L4.50479 12.1059C4.9824 12.298 5.5176 12.298 5.99521 12.1059L9.27646 10.7858C10.0165 10.4881 10.5 9.77962 10.5 8.99308V2.93682C10.5 1.86714 9.61856 1 8.53125 1H1.96875Z" fill="black"></path></svg>
						<% 
							String writedate = ConReviewByReviewIdxVo.getWritedate();
							writedate = writedate.split(" ")[0];
							writedate = writedate.replace("-", ".");
						%>
						<span><%=writedate %></span>
						<span>・남의집 계약</span>
						<button class="report_btn">신고</button>
					</div>
				</div>
			</address>
			
			<!--키워드-->
			<div class="i_re_keyowrd">
				<ul class="i_re_keyowrd_ul">
					<li><span><%=ConReviewByReviewIdxVo.getConTime() %></span></li>
					<li><span><%=ConReviewByReviewIdxVo.getConPriceLow() %>만원~<%=ConReviewByReviewIdxVo.getConPriceHigh() %>만원</span></li>
					<li><span><%=ConReviewByReviewIdxVo.getAddress() %></span></li>
					<li><span><%=ConReviewByReviewIdxVo.getHomeType() %></span></li>
					<li><span><%=ConReviewByReviewIdxVo.getConField() %></span></li>
					<li><span><%=ConReviewByReviewIdxVo.getPy() %></span></li>
				</ul>						
			</div>
			
			<!--리뷰내용-->
			<div class="i_re_content">
				<p><%=ConReviewByReviewIdxVo.getContent() %></p>
			</div>
			
			<!--사진-->
			<ul class="i_re_img">
			<% for( AptReveiwPhotoVo vo : listAptReviewPhoto) { %>
				<li>
					<img src="<%=vo.getImgUrl()%>"></img>
				</li>
			<% } %>
			</ul>
			
			<!--좋아요-->
			<div class="i_re_likey">
				<button>도움이 됐어요</button>
				<p><%=ConReviewByReviewIdxVo.getLikeyCoun() %> 명에게 도움이 됨</p>
			</div>
		</div>
		
		<!--시공사례보기-->
		<div>
			<div class="con_add">
				<div class="con_add1">
					이 업체의 <strong>다양한 시공사례</strong>가<br>보고 싶다면
				</div>
				<a href="Controller?command=interior_detail&conName=<%=ConReviewByReviewIdxVo.getName() %>">시공사례 보기</a>
			</div>
		</div>
	</section>
	
	<!--업체로 넘어가는 부분-->
	<div class="interior_page">
		<div class="interior_sticy">
			<div class="interior1">
				<div class="interior2"> 
					<div>
						<div class="interior_text">
							<a href="Controller?command=interior_detail&conName=<%=ConReviewByReviewIdxVo.getName() %>">
								<div>
									<span class="i_name"><%=ConReviewByReviewIdxVo.getName() %></span>
									<span class="i_logo">
										<svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M3.65012 6.37461V14.9996C3.65012 15.0548 3.69489 15.0996 3.75012 15.0996H14.2501C14.3053 15.0996 14.3501 15.0548 14.3501 14.9996V6.37461H15.6501V14.9996C15.6501 15.7728 15.0233 16.3996 14.2501 16.3996H3.75012C2.97692 16.3996 2.35012 15.7728 2.35012 14.9996V6.37461H3.65012Z" fill="#2F3438"></path><path d="M8.59407 0.992045C8.83146 0.802131 9.16878 0.802131 9.40617 0.992045L16.9062 6.99204C17.1865 7.2163 17.2319 7.62534 17.0077 7.90566C16.7834 8.18598 16.3744 8.23143 16.0941 8.00717L9.00012 2.33202L1.90617 8.00717C1.62585 8.23143 1.21681 8.18598 0.992557 7.90566C0.768301 7.62534 0.81375 7.2163 1.09407 6.99204L8.59407 0.992045Z" fill="currentColor"></path></svg>
									</span>
								</div>
							</a>
							<span>
								<svg fill="#35C5F0" width="13" height="13" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-0.968" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-0.968"><rect x="0" y="0" width="23.232" height="24"></rect></clipPath></defs><use xlink:href="#star-path-0.968" fill="#DBDBDB"></use><use clip-path="url(#star-clip-0.968)" xlink:href="#star-path-0.968"></use></svg>
								<span class="star_con_re1"><%=ConReviewByReviewIdxVo.getStarPoingAvg() %></span>
								<span class="star_con_re2">・</span>
								<span class="star_con_re3">계약자리뷰</span>
								<span class="star_con_re4">&nbsp; <%=ConReviewByReviewIdxVo.getConReview() %></span>
							</span>
						</div>
					</div>
					<button><span>리뷰 더보기</span></button>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>