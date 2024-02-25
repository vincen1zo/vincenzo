<%@page import="java.util.TreeSet"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat" %>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	DecimalFormat numberFormat = new DecimalFormat("###,###"); 
	AptVo aptVo = (AptVo) request.getAttribute("aptVo");
	int aptIdx = Integer.parseInt(request.getParameter("apt_idx"));
	ArrayList<AptVo> listAptVoNearBy = (ArrayList<AptVo>) request.getAttribute("listAptVoNearBy");
	ArrayList<AptDetailVo> listAptDetail = (ArrayList<AptDetailVo>) request.getAttribute("listAptDetail");
	ArrayList<AptSigongReviewVo> listAptSigongReview = (ArrayList<AptSigongReviewVo>) request.getAttribute("listAptSigongReview");
	ArrayList<AptSigongConVo> listAptSigongCon = (ArrayList<AptSigongConVo>) request.getAttribute("listAptSigongCon");

	TreeSet<Integer> tset = new TreeSet<Integer>();
	for(AptDetailVo vo : listAptDetail)
		tset.add(vo.getPy());

	int paramPy = tset.first();
	try {
		paramPy = Integer.parseInt(request.getParameter("py"));
	} catch(Exception e) { }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아파트 세부페이지</title>
<link rel ="stylesheet" href = "css/all.css">
<link rel ="stylesheet" href = "css/header.css">
<link rel ="stylesheet" href = "css/footer.css">
<link rel ="stylesheet" href = "css/apt_detail.css">
<link rel = "stylesheet" href="slick/slick.css"/>
<link rel = "stylesheet" href="slick/slick-theme.css"/>
<script src="js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=904d213f434a55bb59022ee552d77266&libraries=services"></script>
<script src="js/header_search.js"></script>
<script src="js/apt_detail.js"></script>
<script src="slick/slick.js"></script>

<script>  
	$(function() {  
		$(".nearApt_a").click(function() {
			let apt_idx = $(this).attr("apt_idx");
			location.href = "Controller?command=apt_detail&apt_idx="+apt_idx;
		});
		////https://ssl.pstatic.net/static/maps/mantle/1x/marker-default.png
		let mapContainer = document.getElementById('apt_basic_map'); // 지도를 표시할 div 
	    let mapOption = {
	        center: new kakao.maps.LatLng(<%=aptVo.getLatitude()%>, <%=aptVo.getLongitude()%>), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	       	//setMinLevel(3);
			//setMaxLevel(5);
		}; 
		let map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		map.setMaxLevel(7);
		map.setMinLevel(1);
		
		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		  position: new kakao.maps.LatLng(<%=aptVo.getLatitude()%>, <%=aptVo.getLongitude()%>),
		  clickable: true // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
		});

		// 마커를 지도에 표시합니다.
		marker.setMap(map);
	});
</script>
</head>
<body>
<div id = "container">
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
						<li class="m_line on"><a href="Controller?command=apt_main">아파트시공사례</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
		<div style="clear:both"></div>
</header>
	<div id = "content">
		<div id = "main">
			<div class="apt_name">
				<div class="apt_name_inner">
					<div><%=aptVo.getHomeType()%></div>
					<div><%=aptVo.getName()%></div>
					<%
						String noh = numberFormat.format(aptVo.getNoh());
					%>
					<div><%=noh%>세대 · <%=aptVo.getDateCompletion()%></div>
				</div>
			</div>
			
			<div class="line"></div>
			
			<div class="visit">
			<div><img src="https://image.ohou.se/i/bucketplace-v2-development/static/hometour/checklist_banner_web.png?w=640"></div>
			</div>
			
			<div class="line"></div>
			
			<div class="houseTour">
				<div class="houseTour_inner">
						<div class="houseTour_text">
							<div class="text">
								<div>집안구경 👀</div>
								<div class="text1">
								<div>평수별로 집안을 살펴보세요.<br>비슷한 구조의 집도 함께 볼 수 있어요.</div>
								<div><a>
									<span>비슷한 구조란?</span>
									<span><svg width="12" height="12" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M9 15.2C5.57583 15.2 2.8 12.4242 2.8 9C2.8 5.57583 5.57583 2.8 9 2.8C12.4242 2.8 15.2 5.57583 15.2 9C15.2 12.4242 12.4242 15.2 9 15.2ZM9 16.5C13.1421 16.5 16.5 13.1421 16.5 9C16.5 4.85786 13.1421 1.5 9 1.5C4.85786 1.5 1.5 4.85786 1.5 9C1.5 13.1421 4.85786 16.5 9 16.5Z" fill="currentColor"></path><path d="M8.35 6.375V5.25H9.65V6.375H8.35Z" fill="currentColor"></path><path d="M8.35 12.75V7.125H9.65V12.75H8.35Z" fill="currentColor"></path></svg></span>
								</a></div>
								</div>
							</div>
						</div>
						<div class="py_number">
							<ul>
						<% 
							for(int py : tset) {
						%>
								<li><a href="Controller?command=apt_detail&apt_idx=<%=aptIdx %>&py=<%=py %>">
									<button type="button">
										<div class="ja_pyfontColor <%=py==paramPy ? "on" : "" %>"><%=py%>평</div>
									</button>
								</a></li>
					<% } %>
							</ul>
						</div>
					<div id = "ja_py_slick">
					<% 
						for(AptDetailVo vo : listAptDetail) {
							if(paramPy != vo.getPy())
								continue;
					%>
					<div class="py_img">
						<div>
							<!--몇평-->
							<div class="py_text">
								<div><%=vo.getPyType() %></div>
							</div>
							
							<!--도면이미지-->
							<% if(vo.getImgUrl() != null) { %>
							<div class="py_imges">
								<img src="<%=vo.getImgUrl() %>" width="484px" aria-checked="362.52px">
							</div>
							<% } %>
							<% if(vo.getImgUrl() == null) { %>
							<div class="py_imges2">
								<h4 class="ja_h4">해당 평수 평면도 이미지는 준비중입니다.</h4>
							</div>
							<% } %>
							
							<!--평수내용-->
							<div class="py_content">
								<div>
									<div>공급/전용면적</div>
									<div><%=vo.getPy1() %>평/<%=vo.getPy2() %>평</div>
								</div>
								<div>
									<div>세대수</div>
									<div><%=vo.getPyTypeNoh() %>세대</div>
								</div>
								<div>
									<div>방/욕실수</div>
									<div><%=vo.getRoom() %>개/<%=vo.getBath() %>개</div>
								</div>
							</div>
						</div>
					</div>
					<% } %>
				</div>
					<div class="houseparty">
						<div class="houseparty_inner">
						
						<% for(AptDetailVo vo : listAptDetail) { %>
							<div class="houseparty_content">
								<div class="house_img">
									<img src="https://image.ohou.se/i/bucketplace-v2-development/uploads/cards/projects/164932409640689563.jpg?w=256&amp;h=256&amp;c=c&amp;q=80" />
									<div class="our_apt_py">38B (126㎡)</div> <!--우리아파트인경우만 몇평인지-->
								</div>
									<div>
										<div class="apt_box"><span class="our_apt">우리아파트</span></div>
										<h1 class="apt_title">DMC 센트럴아이파크</h1>
										<div></div>
									</div>
								</div>
							<% } %>							
							<div class="houseparty_content">
								<div class="house_img">
									<img src="https://image.ohou.se/i/bucketplace-v2-development/uploads/cards/projects/161087604002218150.jpg?w=256&amp;h=256&amp;c=c&amp;q=80&amp;webp=1" />
									<div></div> <!--우리아파트인경우만 몇평인지-->
								</div>
									<div>
										<div class="apt_box"><span class="similar_apt">비슷한구조</span></div>
										<h1 class="apt_title">[43평 인테리어] 도곡렉슬아파트 4인 가족을 위한 집</h1>
										<div class="tag"><span>3,000만원 ~ 4,000만원</span></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
			<div class="line"></div>
			<%
			if(!(listAptSigongReview.size() == 0)) {
			%>
			<div class="con_review">
				<div class="con_review_title_box">
					<div>
						<h1>우리 아파트 시공리뷰️ 📝</h1>
						<span class="h1_box">
							<span><%=listAptSigongReview.size()%></span>
						</span>
					</div>
					<div>
						<p>실제 시공한 우리 아파트 주민이 작성했어요.</p>
					</div>
				</div>
				<div class="con_review_box">
					<div class="con_review_box_inner">
						<ul class ="con_review_box_ul">
						<%
						 for(AptSigongReviewVo vo : listAptSigongReview) {
						%>
							<!-------------------------리뷰 요소별 시작------------------------------>
							<li class="con_review_box_li">
								<div class="con_review_box_border">
									<a href="Controller?command=apt_review_detail&reviewIdx=<%=vo.getReviewIdx()%>">
										<div class="crbb">
										<%
											if(!(vo.getImgUrl() ==null)) {
										%>
											<div class="con_re_image1">
												<div class="con_re_image2">
													<div class="con_re_image3">
														<div class="con_re_image3_center">
															<div class="con_re_image3_center1">
																<div class="con_re_image3_center2">
																	<img src="<%=vo.getImgUrl()%>"/>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
											<%
											 }
											%>
											<div class="con_re_text1">
												<div class="con_re_text1_1">
													<ul>
														<li><span><%=vo.getPy()%></span></li>
														<% if(vo.getConPriceLow() != 0) { %>
														<li><span><%=vo.getConPriceLow()%>만원~<%=vo.getConPriceHigh()%>만원</span></li>
														<% } %>
														
														<%
															if(vo.getConPriceLow() == 0) {
														%>
														<li><span><%=vo.getConPriceHigh()%>만원이하</span></li>
														<% } %>
													</ul>
												</div>
												<% if(!(vo.getImgUrl() == null)) { %>
												<div class="con_re_text1_2">
													<p>
														<%=vo.getContent()%>
													</p>
												</div>
												<% } %>
												
												<% if(vo.getImgUrl() == null) { %>
												<div class="con_re_text1_3">
													<p>
														<%=vo.getContent()%>
													</p>
												</div>
												<% } %>
												<p>
													<span class="con_re1"><%=vo.getMemberId()%></span>
													<span class="con_re1">∙</span>
													<span class="con_re2"><%=vo.getWritedate()%></span>
												</p>
											</div>
										</div>
									</a>
								</div>
							</li>
							<!-------------------------리뷰 요소별 끝------------------------------>
						<%
						}
						%>
						</ul>
					</div>
				</div>
			</div>
			
			<div class="line"></div>
			<%
			}
			%>
			<%
			if(listAptSigongCon.size() != 0) {
			%>
			<div class="apt_interior">
				<div class="apt_interior_main">
					<h1>우리 아파트 전문 시공업체️ 🏆</h1>
				</div>
				<%
				for(AptSigongConVo vo : listAptSigongCon) {
				%>
				<div class="apt_interior_contentb_box">
					<a href = "Controller?command=interior_detail&conName=<%=vo.getName() %>">
					<div class="apt_int_con_box">
						<div class="apt_int_img">
							<div class="apt_int_img1">
								<img src="<%=vo.getCoverImg() %>" />
							</div>
						</div>
						<div class="apt_int_text_box">
							<div>
								<h2><%=vo.getName() %></h2>
								<div>
									<span></span>
								</div>
							</div>
							<p><%=vo.getExp() %></p>
							<div>
								<span></span>
								<p>우리 아파트 <strong>시공 경험 보유</strong></p>
							</div>
						</div>
					</div>
					</a>
				</div>
			<% } %>
			</div>
			<div class="line"></div>
			<% } %>
			<div class="apt_basic">
				<div class="apt_basic_head">
					<h1>아파트 기본 정보 🏢</h1>
				</div>
				<div class="apt_basic_content">
					<div class="apt_basic_map" id="apt_basic_map">
					</div>
					<dl>
						<div class="apt_basic_text">
							<dt>주소</dt>
							<dd><%=aptVo.getAddress() %></dd>
						</div>
						<div class="apt_basic_text">
							<dt>세대수</dt>
							<dd><%=noh %>세대</dd>
						</div>
						<div class="apt_basic_text">
							<dt>동수</dt>
							<dd><%=aptVo.getDong() %>개</dd>
						</div>
						<div class="apt_basic_text">
							<dt>주차대수</dt>
							<% String parking = numberFormat.format(aptVo.getParking());%>
							<dd><%=parking %>대</dd>
						</div>
					</dl>
				</div>
			</div>
			
			<div class="line"></div>
			
			<div class="nearApt">
				<div class="nearApt_header">
					<h1>가까운 아파트 더 보러갈까요?</h1>
				</div>
				<div class="nearApt_con">
					<div class="nearApt_border">
						<% 
							int cnt = 0;
							for(AptVo vo : listAptVoNearBy) { 
								cnt++;
								if(cnt>8) break;
						%>
						<article>
							<a class="nearApt_a" apt_idx="<%=vo.getAptIdx()%>"></a>
							<div class="nearApt_div">
								<div class="nearApt_div1">
									<svg width="50" height="50" viewBox="0 0 79 79" fill="none" xmlns="http://www.w3.org/2000/svg" color="#35C5F0"><path d="M79 39.5C79 61.3152 61.3152 79 39.5 79C17.6848 79 0 61.3152 0 39.5C0 17.6848 17.6848 0 39.5 0C61.3152 0 79 17.6848 79 39.5Z" fill="currentColor"></path><path d="M39.5569 16L32.6826 22.9625H46.4313L39.5569 16Z" fill="white"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M46.4313 22.9625V37H59V59H37.2391V59.0012H20V27.9512H32.6826V22.9625H46.4313ZM28.8859 32H23.9492V37H28.8859V32ZM37.0312 32H41.968V37H37.0312V32ZM41.968 23H37.0312V28H41.968V23ZM23.9492 41H28.8859V46H23.9492V41ZM41.968 41H37.0312V46H41.968V41ZM50.1143 41H55.051V46H50.1143V41ZM28.8859 50H23.9492V55H28.8859V50ZM37.0312 50H41.968V55H37.0312V50ZM55.051 50H50.1143V55H55.051V50Z" fill="white"></path></svg>
								</div>	
								<h3><%=vo.getName() %></h3>
							</div>
							<span></span>
						</article>
						<% } %>
					</div>
				</div>
			</div>
		</div>
	</div>
<jsp:include page="footer.jsp" flush="true"/>
</div>
</body>
</html> 