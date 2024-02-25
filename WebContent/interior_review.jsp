<%@page import="vo.interiorReviewVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String conName = (String)request.getAttribute("conName");
	interiorReviewVo iReviewVo = (interiorReviewVo)request.getAttribute("iReviewVo");
%>
<%
	if(session.getAttribute("loginEmail")==null) {
%>
	<script>
		alert("로그인해주십시오"); 
		location.href="Controller?command=login_form&ret_cmd=interior_review_form&conName=<%=conName%>";
	</script>
<%
} 
%>  


<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<link rel ="stylesheet" href = "css/all.css">
	<link rel ="stylesheet" href = "css/header.css">
	<link rel ="stylesheet" href = "css/footer.css">
	<link rel ="stylesheet" href = "css/interior_review.css">
	<script src="js/jquery-3.7.1.min.js"></script>
	<script src="js/header_search.js"></script>
	<script src="js/interior_review.js"></script>
	<title>인테리어 업체 리뷰작성</title>
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
						<input type = "text" placeholder = "시공업체 검색"/>
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
</header>
<section>
	<form class="ja_re_form" action="Controller?command=interior_review_action" method="post" enctype="multipart/form-data">
		
		<!----------------------리뷰 타이틀 파트---------------------------->
		<div class="ja_form_header">
			<div class="ja_header_inner_box">
				<div class="ja_header_logo">
					<a href="Controller?command=interior_main">
						<img src="images/logo.png"/>
					</a>
				</div>
				<h1>시공업체 리뷰 쓰기</h1>
				<div class="ja_header_notice">
					<div class="ja_notice_inner">
						<div>잠시 소중한 경험을 남겨주시면 <br>다른 오늘의집 유저들에게 큰 도움이 됩니다.</div>
						<div>현재 작업중인 화면입니다.</div>
						<div>텍스트작성, 별점, 셀렉트박스, 체크박스 선택 가능합니다
<!-- 							<div>*단, 계약금액 100만원 이하인 경우, 최대 10,000포인트 <br>(기본 4,000p + 사진 3,000p + 상세주소 3,000p)</div> -->
						</div>
					</div>
				</div>
				<div class="ja_store_name">
					<span class="ja_con_r_img">
						<img src="<%=iReviewVo.getProfileImgUrl()%>"/>
					</span>
					<span class="ja_con_name"><%=iReviewVo.getName() %></span>
				</div>
			</div>
		</div>
		<!----------------------리뷰 내용 파트---------------------------->
		<div class="ja_form_content">
			<!--핸드폰번호-->
			<div>
				<div class="ja_re_phone">
					<div>고객님의 핸드폰 번호를 알려주세요.</div>
					<p>허위 리뷰를 가려내고 포인트를 지급하는 용도로만 사용됩니다</p>
					<div>
						<div>
							<input type="tel" maxlength="3" placeholder="010">
							<span>-</span>
							<input type="tel" maxlength="4" placeholder="1234">
							<span>-</span>
							<input type="tel" maxlength="4" placeholder="5678">
						</div>
					</div>
				</div>
			</div>
			<!--별점+총평-->
			<div>
				<div class="ja_re_star_notice">
					<div>
						<div>
							<svg width="18" height="18" viewBox="0 0 18 18" fill="none" preserveAspectRatio="xMidYMid meet"><path d="M9 16.5C13.1421 16.5 16.5 13.1421 16.5 9C16.5 4.85786 13.1421 1.5 9 1.5C4.85786 1.5 1.5 4.85786 1.5 9C1.5 13.1421 4.85786 16.5 9 16.5ZM8.3501 5.25H9.6501V6.375H8.3501V5.25ZM8.3501 7.125H9.6501V12.75H8.3501V7.125Z" fill="#2F3438"></path></svg>
						</div>
						<div>안심하고 솔직하게 평가하세요</div>
					</div>
					<p>별점은 <strong>모든 평점을 종합해서</strong>  반영하기 때문에, 고객님께서 몇 점을 주셨는지 업체가 알 수 없습니다.</p>
				</div>
				<input type="hidden" id="input_ja_re_commu" name="input_ja_re_commu"/>
				<input type="hidden" id="input_ja_re_price" name="input_ja_re_price"/>
				<input type="hidden" id="input_ja_re_result" name="input_ja_re_result"/>
				<input type="hidden" id="input_ja_re_schedule" name="input_ja_re_schedule"/>
				<input type="hidden" id="input_ja_re_as" name="input_ja_re_as"/>
				<!---------------별점 소통------------------>
				<div class="ja_re_box  ja_re_commu">
					<div class="ja_re_title">소통</div>
					<div class="ja_re_explanation">상담, 계약, 시공 전반적인 과정에서 시공업체와의 소통만족도입니다</div>

					<div class="ja_re_star_avg_img">
						<ul>
							<li>
								<label class="star star_padding" aria-label="별점 1점">
									<input type="radio" value="1"/>
									<svg class="star" fill="currentColor" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 36 36"><path fill-rule="evenodd" d="M18 30.7l-9 3.8c-1.5.7-2.6-.2-2.5-1.8l.8-9.7L1 15.6c-1-1.3-.6-2.6 1-3l9.5-2.2 5-8.3c1-1.5 2.3-1.5 3.1 0l5 8.3 9.6 2.2c1.6.4 2 1.7 1 3L28.7 23l.8 9.7c.1 1.6-1 2.5-2.5 1.8l-9-3.8z"></path></svg>
								</label>
							</li>
							<li>
								<label class="star star_padding" aria-label="별점 2점">
									<input type="radio" value="2"/>
									<svg class="star" fill="currentColor" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 36 36"><path fill-rule="evenodd" d="M18 30.7l-9 3.8c-1.5.7-2.6-.2-2.5-1.8l.8-9.7L1 15.6c-1-1.3-.6-2.6 1-3l9.5-2.2 5-8.3c1-1.5 2.3-1.5 3.1 0l5 8.3 9.6 2.2c1.6.4 2 1.7 1 3L28.7 23l.8 9.7c.1 1.6-1 2.5-2.5 1.8l-9-3.8z"></path></svg>
								</label>
							</li>
							<li>
								<label class="star star_padding" aria-label="별점 3점">
									<input type="radio" value="3"/>
									<svg class="star" fill="currentColor" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 36 36"><path fill-rule="evenodd" d="M18 30.7l-9 3.8c-1.5.7-2.6-.2-2.5-1.8l.8-9.7L1 15.6c-1-1.3-.6-2.6 1-3l9.5-2.2 5-8.3c1-1.5 2.3-1.5 3.1 0l5 8.3 9.6 2.2c1.6.4 2 1.7 1 3L28.7 23l.8 9.7c.1 1.6-1 2.5-2.5 1.8l-9-3.8z"></path></svg>
								</label>
							</li>
							<li>
								<label class="star star_padding" aria-label="별점 4점">
									<input type="radio" value="4"/>
									<svg class="star" fill="currentColor" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 36 36"><path fill-rule="evenodd" d="M18 30.7l-9 3.8c-1.5.7-2.6-.2-2.5-1.8l.8-9.7L1 15.6c-1-1.3-.6-2.6 1-3l9.5-2.2 5-8.3c1-1.5 2.3-1.5 3.1 0l5 8.3 9.6 2.2c1.6.4 2 1.7 1 3L28.7 23l.8 9.7c.1 1.6-1 2.5-2.5 1.8l-9-3.8z"></path></svg>
								</label>
							</li>
							<li>
								<label class="star" aria-label="별점 5점">
									<input type="radio" value="5"/>
									<svg class="star" fill="currentColor" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 36 36"><path fill-rule="evenodd" d="M18 30.7l-9 3.8c-1.5.7-2.6-.2-2.5-1.8l.8-9.7L1 15.6c-1-1.3-.6-2.6 1-3l9.5-2.2 5-8.3c1-1.5 2.3-1.5 3.1 0l5 8.3 9.6 2.2c1.6.4 2 1.7 1 3L28.7 23l.8 9.7c.1 1.6-1 2.5-2.5 1.8l-9-3.8z"></path></svg>
								</label>
							</li>
						</ul>
					</div>
				</div>
				<!---------------별점 가격------------------>
				<div class="ja_re_box  ja_re_price">
					<div class="ja_re_title">가격</div>
					<div class="ja_re_explanation">시공 결과 대비 시공 금액이 적정한지에 대한 만족도입니다</div>
					<div class="ja_re_star_avg_img">
						<ul>
							<li>
								<label class="star  star_padding" aria-label="별점 1점">
									<input type="radio" value="1"/>
									<svg class="star" fill="currentColor" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 36 36"><path fill-rule="evenodd" d="M18 30.7l-9 3.8c-1.5.7-2.6-.2-2.5-1.8l.8-9.7L1 15.6c-1-1.3-.6-2.6 1-3l9.5-2.2 5-8.3c1-1.5 2.3-1.5 3.1 0l5 8.3 9.6 2.2c1.6.4 2 1.7 1 3L28.7 23l.8 9.7c.1 1.6-1 2.5-2.5 1.8l-9-3.8z"></path></svg>
								</label>
							</li>
							<li>
								<label class="star star_padding" aria-label="별점 2점">
									<input type="radio" value="2"/>
									<svg class="star" fill="currentColor" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 36 36"><path fill-rule="evenodd" d="M18 30.7l-9 3.8c-1.5.7-2.6-.2-2.5-1.8l.8-9.7L1 15.6c-1-1.3-.6-2.6 1-3l9.5-2.2 5-8.3c1-1.5 2.3-1.5 3.1 0l5 8.3 9.6 2.2c1.6.4 2 1.7 1 3L28.7 23l.8 9.7c.1 1.6-1 2.5-2.5 1.8l-9-3.8z"></path></svg>
								</label>
							</li>
							<li>
								<label class="star star_padding" aria-label="별점 3점">
									<input type="radio" value="3"/>
									<svg class="star" fill="currentColor" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 36 36"><path fill-rule="evenodd" d="M18 30.7l-9 3.8c-1.5.7-2.6-.2-2.5-1.8l.8-9.7L1 15.6c-1-1.3-.6-2.6 1-3l9.5-2.2 5-8.3c1-1.5 2.3-1.5 3.1 0l5 8.3 9.6 2.2c1.6.4 2 1.7 1 3L28.7 23l.8 9.7c.1 1.6-1 2.5-2.5 1.8l-9-3.8z"></path></svg>
								</label>
							</li>
							<li>
								<label class="star star_padding" aria-label="별점 4점">
									<input type="radio" value="4"/>
									<svg class="star" fill="currentColor" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 36 36"><path fill-rule="evenodd" d="M18 30.7l-9 3.8c-1.5.7-2.6-.2-2.5-1.8l.8-9.7L1 15.6c-1-1.3-.6-2.6 1-3l9.5-2.2 5-8.3c1-1.5 2.3-1.5 3.1 0l5 8.3 9.6 2.2c1.6.4 2 1.7 1 3L28.7 23l.8 9.7c.1 1.6-1 2.5-2.5 1.8l-9-3.8z"></path></svg>
								</label>
							</li>
							<li>
								<label class="star" aria-label="별점 5점">
									<input type="radio" value="5"/>
									<svg class="star" fill="currentColor" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 36 36"><path fill-rule="evenodd" d="M18 30.7l-9 3.8c-1.5.7-2.6-.2-2.5-1.8l.8-9.7L1 15.6c-1-1.3-.6-2.6 1-3l9.5-2.2 5-8.3c1-1.5 2.3-1.5 3.1 0l5 8.3 9.6 2.2c1.6.4 2 1.7 1 3L28.7 23l.8 9.7c.1 1.6-1 2.5-2.5 1.8l-9-3.8z"></path></svg>
								</label>
							</li>
						</ul>
					</div>
				</div>
				<!---------------별점 시공결과------------------>
				<div class="ja_re_box  ja_re_result">
					<div class="ja_re_title">시공결과</div>
					<div class="ja_re_explanation">시공의 퀄리티와 마감처리 등 전반적인 결과에 대한 만족도입니다</div>
					<div class="ja_re_star_avg_img">
						<ul>
							<li>
								<label class="star  star_padding" aria-label="별점 1점">
									<input type="radio" value="1"/>
									<svg class="star" fill="currentColor" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 36 36"><path fill-rule="evenodd" d="M18 30.7l-9 3.8c-1.5.7-2.6-.2-2.5-1.8l.8-9.7L1 15.6c-1-1.3-.6-2.6 1-3l9.5-2.2 5-8.3c1-1.5 2.3-1.5 3.1 0l5 8.3 9.6 2.2c1.6.4 2 1.7 1 3L28.7 23l.8 9.7c.1 1.6-1 2.5-2.5 1.8l-9-3.8z"></path></svg>
								</label>
							</li>
							<li>
								<label class="star star_padding" aria-label="별점 2점">
									<input type="radio" value="2"/>
									<svg class="star" fill="currentColor" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 36 36"><path fill-rule="evenodd" d="M18 30.7l-9 3.8c-1.5.7-2.6-.2-2.5-1.8l.8-9.7L1 15.6c-1-1.3-.6-2.6 1-3l9.5-2.2 5-8.3c1-1.5 2.3-1.5 3.1 0l5 8.3 9.6 2.2c1.6.4 2 1.7 1 3L28.7 23l.8 9.7c.1 1.6-1 2.5-2.5 1.8l-9-3.8z"></path></svg>
								</label>
							</li>
							<li>
								<label class="star star_padding" aria-label="별점 3점">
									<input type="radio" value="3"/>
									<svg class="star" fill="currentColor" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 36 36"><path fill-rule="evenodd" d="M18 30.7l-9 3.8c-1.5.7-2.6-.2-2.5-1.8l.8-9.7L1 15.6c-1-1.3-.6-2.6 1-3l9.5-2.2 5-8.3c1-1.5 2.3-1.5 3.1 0l5 8.3 9.6 2.2c1.6.4 2 1.7 1 3L28.7 23l.8 9.7c.1 1.6-1 2.5-2.5 1.8l-9-3.8z"></path></svg>
								</label>
							</li>
							<li>
								<label class="star star_padding" aria-label="별점 4점">
									<input type="radio" value="4"/>
									<svg class="star" fill="currentColor" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 36 36"><path fill-rule="evenodd" d="M18 30.7l-9 3.8c-1.5.7-2.6-.2-2.5-1.8l.8-9.7L1 15.6c-1-1.3-.6-2.6 1-3l9.5-2.2 5-8.3c1-1.5 2.3-1.5 3.1 0l5 8.3 9.6 2.2c1.6.4 2 1.7 1 3L28.7 23l.8 9.7c.1 1.6-1 2.5-2.5 1.8l-9-3.8z"></path></svg>
								</label>
							</li>
							<li>
								<label class="star" aria-label="별점 5점">
									<input type="radio" value="5"/>
									<svg class="star" fill="currentColor" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 36 36"><path fill-rule="evenodd" d="M18 30.7l-9 3.8c-1.5.7-2.6-.2-2.5-1.8l.8-9.7L1 15.6c-1-1.3-.6-2.6 1-3l9.5-2.2 5-8.3c1-1.5 2.3-1.5 3.1 0l5 8.3 9.6 2.2c1.6.4 2 1.7 1 3L28.7 23l.8 9.7c.1 1.6-1 2.5-2.5 1.8l-9-3.8z"></path></svg>
								</label>
							</li>
						</ul>
					</div>
				</div>
				<!---------------별점 일정준수------------------>
				<div class="ja_re_box  ja_re_schedule">
					<div class="ja_re_title">일정준수</div>
					<div class="ja_re_explanation">협의한 일정대로 차질 없이 진행되었는지에 대한 평가입니다</div>
					<div class="ja_re_star_avg_img">
						<ul>
							<li>
								<label class="star  star_padding" aria-label="별점 1점">
									<input type="radio" value="1"/>
									<svg class="star" fill="currentColor" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 36 36"><path fill-rule="evenodd" d="M18 30.7l-9 3.8c-1.5.7-2.6-.2-2.5-1.8l.8-9.7L1 15.6c-1-1.3-.6-2.6 1-3l9.5-2.2 5-8.3c1-1.5 2.3-1.5 3.1 0l5 8.3 9.6 2.2c1.6.4 2 1.7 1 3L28.7 23l.8 9.7c.1 1.6-1 2.5-2.5 1.8l-9-3.8z"></path></svg>
								</label>
							</li>
							<li>
								<label class="star star_padding" aria-label="별점 2점">
									<input type="radio" value="2"/>
									<svg class="star" fill="currentColor" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 36 36"><path fill-rule="evenodd" d="M18 30.7l-9 3.8c-1.5.7-2.6-.2-2.5-1.8l.8-9.7L1 15.6c-1-1.3-.6-2.6 1-3l9.5-2.2 5-8.3c1-1.5 2.3-1.5 3.1 0l5 8.3 9.6 2.2c1.6.4 2 1.7 1 3L28.7 23l.8 9.7c.1 1.6-1 2.5-2.5 1.8l-9-3.8z"></path></svg>
								</label>
							</li>
							<li>
								<label class="star star_padding" aria-label="별점 3점">
									<input type="radio" value="3"/>
									<svg class="star" fill="currentColor" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 36 36"><path fill-rule="evenodd" d="M18 30.7l-9 3.8c-1.5.7-2.6-.2-2.5-1.8l.8-9.7L1 15.6c-1-1.3-.6-2.6 1-3l9.5-2.2 5-8.3c1-1.5 2.3-1.5 3.1 0l5 8.3 9.6 2.2c1.6.4 2 1.7 1 3L28.7 23l.8 9.7c.1 1.6-1 2.5-2.5 1.8l-9-3.8z"></path></svg>
								</label>
							</li>
							<li>
								<label class="star star_padding" aria-label="별점 4점">
									<input type="radio" value="4"/>
									<svg class="star" fill="currentColor" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 36 36"><path fill-rule="evenodd" d="M18 30.7l-9 3.8c-1.5.7-2.6-.2-2.5-1.8l.8-9.7L1 15.6c-1-1.3-.6-2.6 1-3l9.5-2.2 5-8.3c1-1.5 2.3-1.5 3.1 0l5 8.3 9.6 2.2c1.6.4 2 1.7 1 3L28.7 23l.8 9.7c.1 1.6-1 2.5-2.5 1.8l-9-3.8z"></path></svg>
								</label>
							</li>
							<li>
								<label class="star" aria-label="별점 5점">
									<input type="radio" value="5"/>
									<svg class="star" fill="currentColor" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 36 36"><path fill-rule="evenodd" d="M18 30.7l-9 3.8c-1.5.7-2.6-.2-2.5-1.8l.8-9.7L1 15.6c-1-1.3-.6-2.6 1-3l9.5-2.2 5-8.3c1-1.5 2.3-1.5 3.1 0l5 8.3 9.6 2.2c1.6.4 2 1.7 1 3L28.7 23l.8 9.7c.1 1.6-1 2.5-2.5 1.8l-9-3.8z"></path></svg>
								</label>
							</li>
						</ul>
					</div>
				</div>
				<!---------------별점 A/S------------------>
				<div class="ja_re_box  ja_re_as">
					<div class="ja_re_title">A/S</div>
					<div class="ja_re_explanation">시공업체의 A/S 보장에 대한 신뢰도 및 실행력에 대한 만족도입니다</div>
					<div class="ja_re_star_avg_img">
						<ul>
							<li>
								<label class="star  star_padding" aria-label="별점 1점">
									<input type="radio" value="1"/>
									<svg class="star" fill="currentColor" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 36 36"><path fill-rule="evenodd" d="M18 30.7l-9 3.8c-1.5.7-2.6-.2-2.5-1.8l.8-9.7L1 15.6c-1-1.3-.6-2.6 1-3l9.5-2.2 5-8.3c1-1.5 2.3-1.5 3.1 0l5 8.3 9.6 2.2c1.6.4 2 1.7 1 3L28.7 23l.8 9.7c.1 1.6-1 2.5-2.5 1.8l-9-3.8z"></path></svg>
								</label>
							</li>
							<li>
								<label class="star star_padding" aria-label="별점 2점">
									<input type="radio" value="2"/>
									<svg class="star" fill="currentColor" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 36 36"><path fill-rule="evenodd" d="M18 30.7l-9 3.8c-1.5.7-2.6-.2-2.5-1.8l.8-9.7L1 15.6c-1-1.3-.6-2.6 1-3l9.5-2.2 5-8.3c1-1.5 2.3-1.5 3.1 0l5 8.3 9.6 2.2c1.6.4 2 1.7 1 3L28.7 23l.8 9.7c.1 1.6-1 2.5-2.5 1.8l-9-3.8z"></path></svg>
								</label>
							</li>
							<li>
								<label class="star star_padding" aria-label="별점 3점">
									<input type="radio" value="3"/>
									<svg class="star" fill="currentColor" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 36 36"><path fill-rule="evenodd" d="M18 30.7l-9 3.8c-1.5.7-2.6-.2-2.5-1.8l.8-9.7L1 15.6c-1-1.3-.6-2.6 1-3l9.5-2.2 5-8.3c1-1.5 2.3-1.5 3.1 0l5 8.3 9.6 2.2c1.6.4 2 1.7 1 3L28.7 23l.8 9.7c.1 1.6-1 2.5-2.5 1.8l-9-3.8z"></path></svg>
								</label>
							</li>
							<li>
								<label class="star star_padding" aria-label="별점 4점">
									<input type="radio" value="4"/>
									<svg class="star" fill="currentColor" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 36 36"><path fill-rule="evenodd" d="M18 30.7l-9 3.8c-1.5.7-2.6-.2-2.5-1.8l.8-9.7L1 15.6c-1-1.3-.6-2.6 1-3l9.5-2.2 5-8.3c1-1.5 2.3-1.5 3.1 0l5 8.3 9.6 2.2c1.6.4 2 1.7 1 3L28.7 23l.8 9.7c.1 1.6-1 2.5-2.5 1.8l-9-3.8z"></path></svg>
								</label>
							</li>
							<li>
								<label class="star" aria-label="별점 5점">
									<input type="radio" value="5"/>
									<svg class="star" fill="currentColor" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 36 36"><path fill-rule="evenodd" d="M18 30.7l-9 3.8c-1.5.7-2.6-.2-2.5-1.8l.8-9.7L1 15.6c-1-1.3-.6-2.6 1-3l9.5-2.2 5-8.3c1-1.5 2.3-1.5 3.1 0l5 8.3 9.6 2.2c1.6.4 2 1.7 1 3L28.7 23l.8 9.7c.1 1.6-1 2.5-2.5 1.8l-9-3.8z"></path></svg>
								</label>
							</li>
						</ul>
					</div>
				</div>
				<!---------------별점 총평------------------>
				<div class="ja_re_box  ja_re_total">
					<div class="ja_re_title">총평</div>
					<div class="ja_re_explanation">인테리어 시공 전문가님의 서비스와 작업물 전반에 대하여 간단한 총평을 부탁드립니다. (최소 60자)</div>
					<div class="ja_re_star_text">
						<textarea placeholder="처음 상담부터 친절하셨고, 작업도 꼼꼼하게 해주셨어요. 주변 사람들과 비교해보니 퀄리티 대비 가격도 합리적인 편이었습니다. 5개월 정도 지났는데 현재까지 하자는 없고, A/S도 약속해 주셔서 걱정 없이 지내고 있습니다. 주변에 엄청 추천하고 있어요!" class="ja_re_start_textarea"></textarea>
					</div>
				</div>
			</div>
			<!--시공사진~시공가격-->
			<div>
				<!----------------시공사진------------------>
				<div class="ja_re_box  ja_re_photo">
					<div class="ja_re_title">시공 사진 <span>(선택)</span></div>
					<div class="ja_re_explanation"><span>포인트 지급을 위해 최소 3장 이상</span>의 시공 사진을 업로드 해주세요. (최대 10장)</div>
					<div class="ja_re_up_photo_box">
						<ul>
							<li>
								<button type="button">
									<span>
										<svg class="icon" width="24" height="24" preserveAspectRatio="xMidYMid meet"><path fill="#424242" fill-rule="nonzero" d="M6 4.9l1.2-3c.1-.3.4-.6.8-.6h8c.4 0 .7.3.8.6l1.2 3h5.1c.5 0 .9.4.9.9v16c0 .5-.4.9-.9.9H1a.9.9 0 0 1-.9-1v-16c0-.4.4-.8.9-.8h5zM12 19a5.5 5.5 0 1 0 0-11 5.5 5.5 0 0 0 0 11z"></path></svg>
										<div>사진올리기</div>
									</span>
								</button>
							</li>
						</ul>
					</div>
				</div>
				<!----------------시공주소------------------>
				<div class="ja_re_box  ja_re_adress">
					<div class="ja_re_title">시공 주소</div>
					<div class="ja_re_explanation">상세주소까지 입력하시면 추가 포인트 지급!<br/><span>상세주소의 경우, 확인용으로만 사용하고 노출되지 않습니다.</span></div>
					<div class="ja_re_adress_box">
						<div>
							<input class="ja_re_adress1" type="text" readonly>
							<button class="ja_re_blue_btn" type="button">주소찾기</button>
						</div>
						<textarea placeholder="상세 주소를 입력해주세요 (선택)" class="ja_re_adress1  ja_re_adress2"></textarea>
					</div>
				</div>
				<!----------------시공계약서 추가------------------>
				<div class="ja_re_box  ja_re_add_file">
					<div class="ja_re_title">시공 계약서 추가<span>(선택)</span></div>
					<div class="ja_re_explanation">계약서 및 견적서 등의 실제 시공 했음을 확인할 수 있는 자료를 첨부해주세요. (확인용으로만 사용되며 외부에 절대로 노출되지 않습니다.)</div>
					<div class="ja_re_file_box">
						<div>
							<button class="ja_re_blue_btn  ja_re_btn" type="button">파일첨부</button>
						</div>
					</div>
				</div>
				<!----------------시공시기------------------>
				<div class="ja_re_box  ja_re_work_date">
					<div class="ja_re_title">시공시기</div>
					<div class="ja_re_slect_box">
						<div>
							<div class="ja_re_slect_arrow_box  ja_re_slect_inner">
								<select class="ja_re_slect ja_re_slect_size1">
									<option value="">연도 선택</option>
									<option value="0">2023년</option>
									<option value="1">2022년</option>
									<option value="2">2021년</option>
									<option value="3">2020년</option>
									<option value="4">2019년</option>
									<option value="5">2018년</option>
									<option value="6">2017년</option>
									<option value="7">2016년</option>
									<option value="8">2015년</option>
									<option value="9">2014년</option>
									<option value="10">2013년</option>
									<option value="11">2012년</option>
									<option value="12">2011년</option>
									<option value="13">2010년</option>
									<option value="14">2009년</option>
									<option value="15">2008년</option>
									<option value="16">2007년</option>
									<option value="17">2006년</option>
									<option value="18">2005년</option>
									<option value="19">2004년</option>
									<option value="20">2003년</option>
								</select>
								<span class="ja_re_slect_arrow">
									<svg class="icon" width="10" height="10" preserveAspectRatio="xMidYMid meet" style="fill: currentcolor;"><path fill-rule="evenodd" d="M0 3l5 5 5-5z"></path></svg>
								</span>
							</div>
							<div class="ja_re_slect_arrow_box  ja_re_slect_inner">
								<select class="ja_re_slect ja_re_slect_size1">
									<option value="">월 선택</option>
									<option value="0">1월</option>
									<option value="1">2월</option>
									<option value="2">3월</option>
									<option value="3">4월</option>
									<option value="4">5월</option>
									<option value="5">6월</option>
									<option value="6">7월</option>
									<option value="7">8월</option>
									<option value="8">9월</option>
									<option value="9">10월</option>
									<option value="10">11월</option>
									<option value="11">12월</option>
								</select>
								<span class="ja_re_slect_arrow">
									<svg class="icon" width="10" height="10" preserveAspectRatio="xMidYMid meet" style="fill: currentcolor;"><path fill-rule="evenodd" d="M0 3l5 5 5-5z"></path></svg>
								</span>
							</div>
						</div>
					</div>
				</div>
				<!----------------건물 유형------------------>
				<div class="ja_re_box  ja_re_home_type">
					<div class="ja_re_title">건물유형</div>
					<div class="ja_re_slect_box">
						<div>
							<div class="ja_re_slect_arrow_box  ja_re_slect_inner">
								<select class="ja_re_slect ja_re_slect_size2">
									<option value="">유형 선택</option>
									<option value="0">원룸&amp;오피스텔</option>
									<option value="1">아파트</option>
									<option value="2">빌라&amp;연립</option>
									<option value="3">단독주택</option>
									<option value="4">사무공간</option>
									<option value="5">상업공간</option>
									<option value="6">기타</option>
								</select>
								<span class="ja_re_slect_arrow">
									<svg class="icon" width="10" height="10" preserveAspectRatio="xMidYMid meet" style="fill: currentcolor;"><path fill-rule="evenodd" d="M0 3l5 5 5-5z"></path></svg>
								</span>
							</div>
						</div>
					</div>
				</div>
				<!----------------시공 분야------------------>
				<div class="ja_re_box  ja_re_field">
					<div class="ja_re_title">시공 분야</div>
					<div class="ja_re_slect_box">
						<div>
							<div class="ja_re_slect_arrow_box  ja_re_slect_inner">
								<select class="ja_re_slect ja_re_slect_size2">
									<option value="">분야 선택</option>
									<option value="0">종합리모델링</option>
									<option value="1">도배</option>
									<option value="2">욕실</option>
									<option value="3">페인트</option>
									<option value="4">마루</option>
									<option value="5">도어</option>
									<option value="6">조명</option>
									<option value="7">주방</option>
									<option value="8">전문디자인</option>
									<option value="9">방산시장</option>
									<option value="10">기타</option>
									<option value="11">장판</option>
									<option value="12">목공</option>
									<option value="13">타일</option>
									<option value="14">시트필름</option>
									<option value="15">창호</option>
									<option value="16">블라인드</option>
								</select>
								<span class="ja_re_slect_arrow">
									<svg class="icon" width="10" height="10" preserveAspectRatio="xMidYMid meet" style="fill: currentcolor;"><path fill-rule="evenodd" d="M0 3l5 5 5-5z"></path></svg>
								</span>
							</div>
						</div>
					</div>
				</div>
				<!----------------시공 평수------------------>
				<div class="ja_re_box  ja_re_py">
					<div class="ja_re_title">시공 평수</div>
					<div class="ja_re_slect_box">
						<div>
							<div class="ja_re_slect_arrow_box  ja_re_slect_inner">
								<select class="ja_re_slect ja_re_slect_size2">
									<option value="">평수 선택</option>
									<option value="0">10평 미만</option>
									<option value="1">10평대</option>
									<option value="2">20평대</option>
									<option value="3">30평대</option>
									<option value="4">40평대</option>
									<option value="5">50평 이상</option>
								</select>
								<span class="ja_re_slect_arrow">
									<svg class="icon" width="10" height="10" preserveAspectRatio="xMidYMid meet" style="fill: currentcolor;"><path fill-rule="evenodd" d="M0 3l5 5 5-5z"></path></svg>
								</span>
							</div>
						</div>
					</div>
				</div>
				<!----------------시공 가격------------------>
				<div class="ja_re_box  ja_work_price">
					<div class="ja_re_title">시공 가격</div>
					<div class="ja_re_slect_box">
						<div>
							<div class="ja_re_slect_arrow_box  ja_re_slect_inner">
								<select class="ja_re_slect ja_re_slect_size2">
									<option value="">가격 선택</option>
									<option value="0">100만원 이하</option>
									<option value="1">100 ~ 500만원</option>
									<option value="2">500 ~ 1,000만원</option>
									<option value="3">1,000 ~ 2,000만원</option>
									<option value="4">2,000 ~ 3,000만원</option>
									<option value="5">3,000 ~ 5,000만원</option>
									<option value="6">5,000 ~ 7,000만원</option>
									<option value="7">7,000 ~ 1억원 이하</option>
									<option value="8">1억원 이상</option>
								</select>
								<span class="ja_re_slect_arrow">
									<svg class="icon" width="10" height="10" preserveAspectRatio="xMidYMid meet" style="fill: currentcolor;"><path fill-rule="evenodd" d="M0 3l5 5 5-5z"></path></svg>
								</span>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!--동의약관-->
			<div>
				<div class="ja_review_agree_box">
					<div class="ja_review_agree_inner">
						<div class="ja_all_check_box">
							<div class="ja_all_check_inner">
								<label class="blue_check">
									<input type="checkbox"/>
									<span><svg width="1em" height="1em" viewBox="0 0 16 16" class="_2UftR"><path fill="currentColor" d="M6.185 10.247l7.079-7.297 1.435 1.393-8.443 8.703L1.3 8.432l1.363-1.464z"></path></svg></span>
									<div><span>모두 동의합니다.</span></div>
								</label>
							</div>
						</div>
						<hr class="ja_agree_hr">
						<div class="ja_agree">
							<div>
								<label class="blue_check">
									<input type="checkbox"/>
									<span><svg width="1em" height="1em" viewBox="0 0 16 16" class="_2UftR"><path fill="currentColor" d="M6.185 10.247l7.079-7.297 1.435 1.393-8.443 8.703L1.3 8.432l1.363-1.464z"></path></svg></span>
									<div>개인정보수집 및 이용 동의(필수)</div>
								</label>
							</div>
						</div>
						<div class="ja_agree_text_box">
							<div class="ja_agree_text_inner">
								<ol>
									<li>1. 수집항목: 휴대전화번호, 주소, 계약서 내 계약자 정보(오늘의집 상담신청 이력이 없는 시공 건에 한합니다)</li>
									<li>2. 수집 및 이용 목적: 이용자 식별, 리뷰 작성에 따른 보상 지급, 서비스 활용(집합건물명까지의 주소 및 평형정보 등은 노출기준 수립 등 작성하신 리뷰의 원활한 노출을 위해 이용됩니다), 서비스 개선을 위한 데이터 통계 및 분석, 맞춤형 콘텐츠 및 서비스 등 제공 또는 추천</li>
									<li>3. 보유 및 이용 기간: <b>동의 철회시까지. 단, 관련 법령의 규정에 따라 거래 관계 확인을 위해 개인정보를 일정기간 보유할 수 있습니다.</b></li>
									<li>4. 개인정보 수집에 동의하지 않으실 수 있으며, 동의하지 않는 경우 리뷰 작성 및 노출이 제한될 수 있습니다.</li>
								</ol>
							</div>
						</div>
					</div>
					<div class="ja_review_agree_inner">
							<div class="ja_agree">
							<div>
								<label class="blue_check">
									<input type="checkbox"/>
									<span><svg width="1em" height="1em" viewBox="0 0 16 16" class="_2UftR"><path fill="currentColor" d="M6.185 10.247l7.079-7.297 1.435 1.393-8.443 8.703L1.3 8.432l1.363-1.464z"></path></svg></span>
									<div>개인정보수집 및 이용 동의 (선택)</div>
								</label>
							</div>
						</div>
						<div class="ja_agree_text_box">
							<div class="ja_agree_text_inner">
								<ol>
									<li>1. 수집항목: 계약서 내 계약자 정보(오늘의집 상담신청 이력이 있는 시공 건), 상세주소</li>
									<li>2. 수집 및 이용 목적: 시공 사실 확인 및 계약 인증, 추가 리뷰 보상 지급</li>
									<li>3. 보유 및 이용 기간: <b>리뷰 보상 지급 종료 시까지</b></li>
									<li>4. 개인정보 제공에 동의하지 않으실 수 있으며, 동의하지 않으셔도 서비스 이용은 가능하나 계약 인증이 되지 않아 리뷰 보상 지급이 축소/제한될 수 있습니다.</li>
								</ol>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!--완료버튼-->
			<div class="ja_con_review_submit">
				<button>완료</button>
			</div>
		</div>
	</form>
</section>
<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>