<%@page import="java.text.DecimalFormat"%>
<%@page import="vo.*"%>
<%@page import="dao.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ProductDao pDao = new ProductDao();
	CategoryBestDao cbDao = new CategoryBestDao();
	ODealDao odDao = new ODealDao();
	ArrayList<HomeMainHpVo> listHomeMainHpVo = (ArrayList<HomeMainHpVo>) request.getAttribute("listHomeMainHpVo");
	ArrayList<UserInteriorReviewVo> listUserInteriorReviewVo = (ArrayList<UserInteriorReviewVo>) request.getAttribute("listUserInteriorReviewVo"); 
	ArrayList<ODealVo> listODealVo = (ArrayList<ODealVo>) request.getAttribute("listODealVo"); 
	ArrayList<ProductMainImgVo> pmiVo = (ArrayList<ProductMainImgVo>) request.getAttribute("pmiVo");
	ArrayList<ProductAllVo> listProductAllVo = (ArrayList<ProductAllVo>) request.getAttribute("listProductAllVo");
%>

<% if(listHomeMainHpVo==null) { %>
<% } %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>커뮤니티 메인 로그인 전 화면</title>
	<link rel="stylesheet" href="css/community_main.css"/>
	<link rel="stylesheet" href="css/header_kh.css"/>
	<link rel="stylesheet" href="css/footer.css"/>
	<script src="js/jquery-3.7.1.min.js"></script>
	<script src="js/community_main.js"></script>
	<script>
	$(function() {
		$(".search1 > input").focus(function() {
			$(".search1").addClass('click');
		});
		
		$(".search1 > input").blur(function() {
			$(".search1").removeClass('click');
		});
		
		let popMenu = false;
		$(".ja_icon2_btn").click(function(){
			if(!popMenu){
				popMenu = true;
				$(".ja_pop_menu_big_box").addClass("show");
			} else if(popMenu){
				popMenu = false;
				$(".ja_pop_menu_big_box").removeClass("show");
			}
		});
	});
		//
	</script>
	<script> //오늘의 딜
		let arr_date_expire = new Array(<%=listODealVo.size()%>);     // '만기' 배열.
		<% 
			for(int i=0; i<=listODealVo.size()-1; i++) { 
				String s = listODealVo.get(i).getCloseDate();
				int year = Integer.parseInt(s.substring(0,4));
				int month = Integer.parseInt(s.substring(5,7));
				int day = Integer.parseInt(s.substring(8,10));
				int hour = Integer.parseInt(s.substring(11,13));
				int minute = Integer.parseInt(s.substring(14,16));
				int second = Integer.parseInt(s.substring(17));
		%>
			arr_date_expire[<%=i%>] = new Date();
			arr_date_expire[<%=i%>].setYear(<%=year%>);
			arr_date_expire[<%=i%>].setMonth(<%=month%>-1);
			arr_date_expire[<%=i%>].setDate(<%=day%>);
			arr_date_expire[<%=i%>].setHours(<%=hour%>);
			arr_date_expire[<%=i%>].setMinutes(<%=minute%>);
			arr_date_expire[<%=i%>].setSeconds(<%=second%>);
		<% } %>
		
		function draw_all_countdown() {
			for(let i=0; i<=<%=listODealVo.size()-1%>; i++) {
				let d = arr_date_expire[i];
				let d2 = new Date();  // 현재시각 구하기.
				let h = parseInt((d-d2)/1000/3600);   // 3670sec --> 3670/3600 = 1
				let m = parseInt(((d-d2)/1000%3600)/60);   // 3670sec --> 3670%3600 / 60 = 1
				let s = parseInt(((d-d2)/1000%3600)%60);	// 3670sec -> 3670%3600 % 60 = 10
				
				if(d-d2 <= 0) {
					$("#countdown"+i).text("00:00:00 남음");
					continue;
				}
				if(h<10) h = "0" + h;
				if(m<10) m = "0" + m;
				if(s<10) s = "0" + s;
				$("#countdown"+i).text(h + ":" + m + ":" + s + " 남음");
			}
		}
		$(function() {
			$(".odp_de").click(function() {
				let product_idx = $(this).attr("product_idx");
				location.href = "Controller?command=product_detail&product_idx=" + product_idx;
			});
			draw_all_countdown();
			
			let interval = setInterval(function() {
				draw_all_countdown();
			}, 1000);
		});
	</script>
</head>
<body>
	<div id="container">
		<jsp:include page="header_kh.jsp" flush="true"/>
		<div class="sticky-container" style="height: 52px; top:80px; position:sticky;">
		<div class="menuLine">
			<div class="menuInner">
				<nav id="topMenu">
					<ul>
						<li class="m_line on"><a href="Controller?command=community_main">홈</a></li>
						<li class="m_line"><a href="Controller?command=houseparty">집들이</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
		<div id="content">
			<div class="main_random">
				<img src="https://image.ohou.se/i/bucketplace-v2-development/uploads/projects/cover_images/169207216945115911.jpg?w=1920&amp;h=601&amp;c=c">
				<div class = main_title>
					<span class=h_title>이런 조명 봤어?💡 난 봤어!</span>
					<span class="user">
						<img src="https://bucketplace-v2-development.s3.amazonaws.com/uploads/users/profile_images/169207146663446038.png">
						<span>hyess_j</span>
					</span>
				</div>
			</div>
			<div id="h_p_zip">
				<div class=zip_title>
					<div class="z_t_sub1">
						<span>어서와 모던스타일은 처음이지🤩?.zip(*°▽°*)</span>
					</div>
					<div class="z_t_sub2 fr">더보기</div>
				</div>
				<% for(int i=0; i<=3; i++) { %>
				<div class="zip_h_p fl" housepartyIdx="<%=listHomeMainHpVo.get(i).getHousepartyIdx()%>">
					<div class="h_p_zip_img">
						<img src="<%=listHomeMainHpVo.get(i).getCoverImg()%>">
						<div class="h_p_zip_likey">
							<svg class="icon icon--stroke" aria-label="좋아요" width="24" height="24" fill="currentColor" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" preserveAspectRatio="xMidYMid meet"><path d="M23.22 7.95c.4 4.94-2.92 9.71-10.92 13.85a.47.47 0 0 1-.42 0C3.88 17.66.56 12.9.96 7.93 1.54 2.48 8.28.3 12.1 4.7c3.8-4.4 10.55-2.22 11.13 3.25z"></path></svg>
						</div>
					</div>
					<div class="h_p_zip_title">
						<span class="content_sb"><%= listHomeMainHpVo.get(i).getSubheadColor() %></span>	
						<span class="content_b"><%=listHomeMainHpVo.get(i).getSubhead() %></span>	
					</div>
				</div>
				<% } %>
			</div>
			<div id="o_deal">
				<div id="o_d_title">
					<div id="o_d_t_1">오늘의딜</div>
					<div id="o_d_t_2">더보기</div>
				</div>
				<div id="o_d_p_all">
					<%
					int idx = 0;
					int odi = 0;
					for(odi=0; odi<=3; odi++) {
						ODealVo odvo = listODealVo.get(odi);
					%>
					<div class="o_d_product fl" product_idx="<%= odvo.getProductIdx() %>">
						<div id="o_d_p_1">
							<%
								ArrayList<ProductMainImgVo> pmivo = pDao.getListProductMainImgVo(odvo.getProductIdx());
								String strImageMain = pmivo.get(0).getImgUrl();
							%>
							<img class="image"  src="<%= strImageMain%>">
							<div class="countdown_css" id="countdown<%=idx++%>">00:00:00남음</div>
							<div id="o_d_likey">
								<svg class="icon icon--stroke" aria-label="좋아요" width="24" height="24" fill="currentColor" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" preserveAspectRatio="xMidYMid meet"><path d="M23.22 7.95c.4 4.94-2.92 9.71-10.92 13.85a.47.47 0 0 1-.42 0C3.88 17.66.56 12.9.96 7.93 1.54 2.48 8.28.3 12.1 4.7c3.8-4.4 10.55-2.22 11.13 3.25z"></path></svg>
							</div>
						</div>
						<div id="o_d_p_2">
							<div id="odp2_1">
								<span class="odp2_1_1"><%= odvo.getBrandName() %></span>
								<span class="odp2_1_2"><%= odvo.getName() %></span>
							</div>
							<div id="odp2_2">
								<span class="odp2_2_1"><%= odvo.getDiscount() %>
									<span class="odp2_per">%</span>
								</span>
								<span class="odp2_2_2"><%= new DecimalFormat("###,###").format(odvo.getAfterPrice()) %></span>
							</div>
							<div id="odp2_3">
								<svg class="icon" width="24" height="24" viewBox="0 0 24 24" preserveAspectRatio="xMidYMid meet"><path fill="currentColor" fill-rule="evenodd" d="M12 19.72l-5.677 2.405c-.76.322-1.318-.094-1.247-.906l.533-6.142-4.042-4.656c-.54-.624-.317-1.283.477-1.467l6.006-1.39L11.23 2.28c.426-.707 1.122-.699 1.542 0l3.179 5.282 6.006 1.391c.805.187 1.011.851.477 1.467l-4.042 4.656.533 6.142c.072.822-.497 1.224-1.247.906L12 19.72z"></path></svg>
								<span class="odp3_st"><%= odvo.getStarReviewAvg() %></span>
								<span class="odp3_re">리뷰 242</span>
							</div>
							<div id="odp2_4">
								<img src="https://assets.ohou.se/web/dist/media/assets/icons/ic-departure-today-c4b771c1162afcd9223631b660e19d73.png" class="icon">
							</div>
							<div id="odp2_5">평일 16:00까지 결제시</div>
							<div id="odp2_6">
							<%
								if(odvo.getFreeDeli() == 0) {
							%>
								<svg class="icon" aria-label="무료배송" width="47" height="20" viewBox="0 0 47 20" preserveAspectRatio="xMidYMid meet"><g fill="none" fill-rule="evenodd"><rect width="47" height="20" fill="#000" fill-opacity=".07" fill-rule="nonzero" rx="4"></rect><path fill="#757575" d="M12.73 5.38v3.96h-6.6V5.38h6.6zm-2.68 9.43H8.76v-3.25H5v-1.03h8.86v1.03h-3.81v3.25zm1.4-6.49V6.41H7.43v1.91h4.04zm11.08 2.7h-1.42v1.54h2.26v1.02h-8.86v-1.02h2.24v-1.53h-1.1V7.78h5.32V6.65H15.6V5.63h6.66V8.8h-5.33v1.18h5.61v1.04zm-4.53 0v1.54h1.87v-1.53H18zm14.37 3.78h-1.23V9.86h-.8v4.49h-1.2V5.18h1.2v3.66h.8V5h1.23v9.8zm-4.2-2.54h-3.9V6.01h1.27v2.26h1.36V6h1.28v6.26zm-1.27-1.01v-2h-1.36v2h1.36zm14.49 1.71c0 1.13-1.25 1.82-3.41 1.82s-3.42-.7-3.42-1.82 1.25-1.82 3.4-1.82c2.18 0 3.43.7 3.43 1.82zm-3.41-6.05c-.5 1.13-2.1 1.9-3.51 2.1l-.54-1c1.64-.17 3.39-1.06 3.39-2.54V5.2h1.33v.28c0 1.48 1.99 2.47 3.4 2.53l-.55 1.01c-1.31-.18-3.03-.97-3.52-2.1zm4.42 3.78h-8.86V9.66h3.79V8.4h1.29v1.26h3.78v1.03zm-2.33 2.27c0-.5-.83-.8-2.1-.8s-2.08.3-2.08.8c0 .51.81.8 2.08.8s2.1-.29 2.1-.8z"></path></g></svg>
							<% } %>
								<svg class="icon" aria-label="특가" width="30" height="20" viewBox="0 0 30 20" preserveAspectRatio="xMidYMid meet"><rect width="30" height="20" fill="#F77" rx="4"></rect><path fill="#fff" d="M12.83 7.93v-.97H7.93v-.555h5.228v-.991H6.655v4.063h6.59v-.992H7.928V7.93h4.901zm-6.295 3.747v1.002h5.326v2.037h1.274v-3.04h-6.6zm7.733-.588v-1.024H5.5v1.024h8.768zM23.91 9.782V8.725h-1.405V5H21.24v9.705h1.264V9.782h1.405zm-3.954-3.79h-4.53v1.056h3.147c-.174 1.938-1.623 3.975-3.736 4.945l.773.958c2.974-1.612 4.259-4.03 4.346-6.96z"></path></svg>
							</div>
						</div>
					</div> 
					<% }%> 
				</div>
			</div>
			<div id="interior">
				<div id="in_title">
					<div id="i_t_1">유저들의 인테리어 시공 리뷰</div>
					<div id="i_t_2">더보기</div>
					<!-- 더보기 입력 시 인테리어/생활 메인으로 이동 -->
				</div>
				<!-- 시이작 -->
				<% for(int i=0; i<=2; i++) { %>
					<div class="in_re fl">
						<a href="Controller?command=apt_review_detail&reviewIdx=<%=listUserInteriorReviewVo.get(i).getReviewIdx()%>">
							<div class="in_re_img">
								<img src="<%=listUserInteriorReviewVo.get(i).getImgUrl() %>">
							</div>
							<div class="in_re_con">
								<p class="i_r_c_1"><%=listUserInteriorReviewVo.get(i).getName() %></p>
								<p class="i_r_c_2"><%=listUserInteriorReviewVo.get(i).getContent() %></p>
							</div>
						</a>
					</div>
				<% } %>
				<!-- 끄읕 -->
			</div>
			<div id="best">
				<div id="b_title">
					<div class="b_t_1">베스트</div>
					<div class="b_t_2">더보기</div>
				</div>
				<% 
				int bpidx = 1;
				for(int i=0; i<=2; i++) { %>
				<div class="b_product fl" productIdx=<%=listProductAllVo.get(i).getProductIdx() %>>
					<div class="b_p_img">
						<img class="image" alt="" src="<%=listProductAllVo.get(i).getImgUrl()%>">
						<div class="b_p_i_likey">
							<svg class="icon icon--stroke" aria-label="좋아요" width="24" height="24" fill="currentColor" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" preserveAspectRatio="xMidYMid meet"><path d="M23.22 7.95c.4 4.94-2.92 9.71-10.92 13.85a.47.47 0 0 1-.42 0C3.88 17.66.56 12.9.96 7.93 1.54 2.48 8.28.3 12.1 4.7c3.8-4.4 10.55-2.22 11.13 3.25z"></path></svg>
						</div>
					</div>
					<div class="b_p_num">
						<svg width="26" height="30" fill="none"><path fill-rule="evenodd" clip-rule="evenodd" d="m13 24.25-13 5V0h26v29.25l-13-5Z" fill="rgba(53, 197, 240, 0.86)"></path></svg>
						<span class="bp_no"><%= bpidx %></span>
					</div>
					<div class="b_p_con">
						<div class="b_p_1">
							<span class="bp_1_1"><%= listProductAllVo.get(i).getBarndName() %></span>
							<span class="bp_1_2"><%= listProductAllVo.get(i).getName() %></span>
						</div>
						<div class="b_p_2">
							<span class="bp_2_1"><%=listProductAllVo.get(i).getDiscount()%>
								<span class="bp2_per">%</span>
							</span>
							<span class="bp_2_2"><%=new DecimalFormat("###,###").format(listProductAllVo.get(i).getAfterPrice()) %></span>
						</div>
						<div class="b_p_3">
							<svg class="icon" width="24" height="24" viewBox="0 0 24 24" preserveAspectRatio="xMidYMid meet"><path fill="currentColor" fill-rule="evenodd" d="M12 19.72l-5.677 2.405c-.76.322-1.318-.094-1.247-.906l.533-6.142-4.042-4.656c-.54-.624-.317-1.283.477-1.467l6.006-1.39L11.23 2.28c.426-.707 1.122-.699 1.542 0l3.179 5.282 6.006 1.391c.805.187 1.011.851.477 1.467l-4.042 4.656.533 6.142c.072.822-.497 1.224-1.247.906L12 19.72z"></path></svg>
							<span class="bp3_st"><%= listProductAllVo.get(i).getStarReviewAvg() %></span>
							<span class="bp3_re">리뷰 1<%-- <%=pDao.getCountReviewByProductIdx(vo.getProductIdx()) %> --%></span>
						</div>
						<div class="b_p_4">
							<img src="https://assets.ohou.se/web/dist/media/assets/icons/ic-third-party-logistic-424d7e1cdf3e1f2ac518a6a269f09e12.png" class="icon">
						</div>
						<div class="b_p_5">
							<svg class="icon" aria-label="무료배송" width="47" height="20" viewBox="0 0 47 20" preserveAspectRatio="xMidYMid meet"><g fill="none" fill-rule="evenodd"><rect width="47" height="20" fill="#000" fill-opacity=".07" fill-rule="nonzero" rx="4"></rect><path fill="#757575" d="M12.73 5.38v3.96h-6.6V5.38h6.6zm-2.68 9.43H8.76v-3.25H5v-1.03h8.86v1.03h-3.81v3.25zm1.4-6.49V6.41H7.43v1.91h4.04zm11.08 2.7h-1.42v1.54h2.26v1.02h-8.86v-1.02h2.24v-1.53h-1.1V7.78h5.32V6.65H15.6V5.63h6.66V8.8h-5.33v1.18h5.61v1.04zm-4.53 0v1.54h1.87v-1.53H18zm14.37 3.78h-1.23V9.86h-.8v4.49h-1.2V5.18h1.2v3.66h.8V5h1.23v9.8zm-4.2-2.54h-3.9V6.01h1.27v2.26h1.36V6h1.28v6.26zm-1.27-1.01v-2h-1.36v2h1.36zm14.49 1.71c0 1.13-1.25 1.82-3.41 1.82s-3.42-.7-3.42-1.82 1.25-1.82 3.4-1.82c2.18 0 3.43.7 3.43 1.82zm-3.41-6.05c-.5 1.13-2.1 1.9-3.51 2.1l-.54-1c1.64-.17 3.39-1.06 3.39-2.54V5.2h1.33v.28c0 1.48 1.99 2.47 3.4 2.53l-.55 1.01c-1.31-.18-3.03-.97-3.52-2.1zm4.42 3.78h-8.86V9.66h3.79V8.4h1.29v1.26h3.78v1.03zm-2.33 2.27c0-.5-.83-.8-2.1-.8s-2.08.3-2.08.8c0 .51.81.8 2.08.8s2.1-.29 2.1-.8z"></path></g></svg>
							<svg class="icon" aria-label="특가" width="30" height="20" viewBox="0 0 30 20" preserveAspectRatio="xMidYMid meet"><rect width="30" height="20" fill="#F77" rx="4"></rect><path fill="#fff" d="M12.83 7.93v-.97H7.93v-.555h5.228v-.991H6.655v4.063h6.59v-.992H7.928V7.93h4.901zm-6.295 3.747v1.002h5.326v2.037h1.274v-3.04h-6.6zm7.733-.588v-1.024H5.5v1.024h8.768zM23.91 9.782V8.725h-1.405V5H21.24v9.705h1.264V9.782h1.405zm-3.954-3.79h-4.53v1.056h3.147c-.174 1.938-1.623 3.975-3.736 4.945l.773.958c2.974-1.612 4.259-4.03 4.346-6.96z"></path></svg>
						</div>
						<div class="b_p_6">
							<img src="https://image.ohou.se/i/bucketplace-v2-development/static/productions/card-promotion-badge.png?w=36&amp;w=40&amp;h=32">
							<span class="bp_6_1">최대 5% 결제할인</span>
						</div>
					</div>
				</div>	
				<%
					bpidx++;
				 } 
				%>
			</div>
		</div>
		<jsp:include page="footer.jsp" flush="true"/>	
	</div>
</body>
</html>