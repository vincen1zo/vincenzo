<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.ProductMainImgVo"%>
<%@page import="java.util.Arrays"%>
<%@page import="vo.ProductVo"%>
<%@page import="dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 예를 들어 URL = http://localhost:9094/Vincenzo/product_de.jsp?product_idx=3
	// 여기서 실행하면 exception 뜸! (나중에, 예외처리가 필요)
	int productIdx = Integer.parseInt(request.getParameter("product_idx"));   // ex. 3

	ProductDao pDao = new ProductDao();
	ProductVo pVo = pDao.getProductVoByProductIdx(productIdx);
	String categoryStr = pDao.getCategoryStringFromCategoryIdx(pVo.getCategory()); // ex. "가구>서랍·수납장>수납장"
	String[] arrCategoryStr = categoryStr.split(">");  // ex. ["가구","서랍·수납장","수납장"]
	ArrayList<ProductMainImgVo> listProductMainImgVo = pDao.getListProductMainImgVo(productIdx);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품상세페이지</title>
	<link rel="stylesheet" href="css/all.css">
	<link rel="stylesheet" href="css/header.css">
	<link rel="stylesheet" href="css/footer.css">
	<link rel="stylesheet" href="css/Mypage_menu.css">
	<link rel="stylesheet" href="css/Product_detail_page.css">
	<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
	<script src="js/jquery-3.7.1.min.js"></script>
	<script src="js/header_search.js"></script>
	<script src="js/Product_detail_page.js"></script>
</head>
<body>
	<%-- <jsp:include page="header.jsp" flush="true"/> --%>
	<div id="container">
		<!-- <div id="header" class="b" style="border-bottom:none;"></div>
		<div id="nav" class="b" style="border-bottom:none;"></div> -->
		<div id="content">
			<div class="kh_product_d_top">
				<div class="kh_d_category">
					<ol class="kh_cg_ol">
						<%
						for(int i=0; i<=arrCategoryStr.length-1; i++) {
						%>
							<li>
								<a href="javascript:alert('TODO')" class="kh_co"><%=arrCategoryStr[i]%></a>
								<% if(i<arrCategoryStr.length-1) { %>
									<svg class="icon" width="10" height="10" viewBox="0 0 8 8" fill="currentColor" preserveAspectRatio="xMidYMid meet"><path d="M4.95 4L2.12 1.19l.7-.71 3.54 3.54-3.53 3.53-.7-.7z"></path></svg>
								<% } %>
							</li>
						<%
						}
						%>
					</ol>
				</div>
				<main class="jy_main_page">
				<div class="jy_product_info_page_tl">
				<div class="kh_d_product">
					<div class="kh_dp_left">
						<ul class="kh_dp_coverimg">
							<%
							for(ProductMainImgVo vo : listProductMainImgVo) {
							%>
								<li class="kh_dp_cil">
									<img class="image" src="<%=vo.getImgUrl()%>"/>
								</li>
							<%
							}
							%>
						</ul>
						<div class="kh_dp_img">
							<img class="production-selling-cover-image__entry__image" tabindex="0" alt="상품의 대표 이미지" src=""/>
						</div>
					</div>
					<div class="kh_dp_right">
						<div class="kh_dpr_top">
							<h1 class="kh_dprt_1">
								<p class="kh_dprt1_1">
									<a href="#"><%=pVo.getBrandName() %></a>
								</p>
								<div class="kh_dprt1_2">
									<span class="kh_dprt1_2_1"><%=pVo.getName() %></span>
									<div class="kh_dprt1_2_2">
										<button class="kh_dprt1_2_2_l">
											<svg class="icon icon--stroke" aria-label="좋아요" width="24" height="24" fill="currentColor" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" preserveAspectRatio="xMidYMid meet"><path d="M23.22 7.95c.4 4.94-2.92 9.71-10.92 13.85a.47.47 0 0 1-.42 0C3.88 17.66.56 12.9.96 7.93 1.54 2.48 8.28.3 12.1 4.7c3.8-4.4 10.55-2.22 11.13 3.25z"></path></svg>
											<span class="kh_dprt_lcount"><%=pDao.getLikeyCountByProductIdx(productIdx) %></span>
										</button>
										<button class="kh_dprt1_2_2_r">
											<svg class="icon" aria-label="공유하기" width="24" height="24" viewBox="0 0 24 24" fill="currentColor" preserveAspectRatio="xMidYMid meet"><path d="M9.64 14.646a4.5 4.5 0 1 1 0-5.292l4.54-2.476a4.5 4.5 0 1 1 .63.795l-4.675 2.55c.235.545.365 1.146.365 1.777s-.13 1.232-.365 1.777l4.675 2.55a4.5 4.5 0 1 1-.63.795l-4.54-2.476zM18 8a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7zM6 15.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7zM18 23a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7z"></path></svg>
										</button>
									</div>
								</div>
							</h1>
							<div class="kh_dprt_2">
								<p class="kh_dprt_2_1">
									<a href="#">
<%
	double starpoint = pVo.getStarReviewAvg();
	double[] arrStars = new double[5];   // [0.0, 0.0, 0.0, 0.0, 0.0]
	int idx = 0;  // 배열 arrStars의 인덱스.
	for(int i=1; i<=(int)(starpoint); i++) {
		arrStars[idx++] = 1.0;
	}
	if(idx<=4) {
		arrStars[idx++] = starpoint - (int)starpoint;
	}
%>
<script>
	console.log("<%=Arrays.toString(arrStars)%>");
</script>
									<span class="kh_dprt_2_1_1">
									<%
										for(int i=0; i<=4; i++) {
											double width = arrStars[i]*24;
									%>
										<% if(arrStars[i]==1.0) { %>
											<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-1.000" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-1.000"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-1.000" fill="#DBDBDB"></use><use clip-path="url(#star-clip-1.000)" xlink:href="#star-path-1.000"></use></svg>
										<% } else if(arrStars[i]==0.0) {%>
											<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-part<%=i%>" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-part<%=i%>"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-part<%=i%>" fill="#DBDBDB"></use></svg>
										<% } else { %>
											<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-part<%=i%>" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-part<%=i%>"><rect x="0" y="0" width="<%=width%>" height="24"></rect></clipPath></defs><use xlink:href="#star-path-part<%=i%>" fill="#DBDBDB"></use><use clip-path="url(#star-clip-part<%=i%>)" xlink:href="#star-path-part<%=i%>"></use></svg>
										<% } %>
									<%
										}
									%>
									</span>
									<span class="kh_dprt_2_1_2">
										<span>
											<span class="kh_dprt2_re_c"><%=pDao.getCountReviewByProductIdx(productIdx) %></span>
											개 리뷰
										</span>
									</span>	
									</a>
								</p>
								<div class="kh_dprt_2_2">
									<span class="kh_dprt2_per">
										<span class="kh_dp2p_num"><%=pVo.getDiscount() %></span>
										<span class="kh_dp2p_per" style="margin-left: -2px;">%</span>
									</span>
									<span class="kh_dprt2_beforep">
										<span class="kh_dp2bp_num"><%=new DecimalFormat("###,###").format(pVo.getBeforePrice()) %></span>
										<span class="kh_dp2bp_won">원</span>
									</span>
									<span class="kh_dprt2_inf">
										<svg class="information-icon" width="16" height="16" viewBox="0 0 16 16" fill="none" preserveAspectRatio="xMidYMid meet"><path d="M8 6.45C7.58579 6.45 7.25 6.11421 7.25 5.7V5.63333C7.25 5.21912 7.58579 4.88333 8 4.88333C8.41421 4.88333 8.75 5.21912 8.75 5.63333V5.7C8.75 6.11421 8.41421 6.45 8 6.45Z" fill="#C2C8CC"></path><path d="M7.25 10.5C7.25 10.9142 7.58579 11.25 8 11.25C8.41421 11.25 8.75 10.9142 8.75 10.5L8.75 7.7C8.75 7.28579 8.41421 6.95 8 6.95C7.58579 6.95 7.25 7.28579 7.25 7.7L7.25 10.5Z" fill="#C2C8CC"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M8.00016 14.6668C11.6821 14.6668 14.6668 11.6821 14.6668 8.00016C14.6668 4.31826 11.6821 1.3335 8.00016 1.3335C4.31826 1.3335 1.3335 4.31826 1.3335 8.00016C1.3335 11.6821 4.31826 14.6668 8.00016 14.6668ZM8.00016 13.1668C10.8536 13.1668 13.1668 10.8536 13.1668 8.00016C13.1668 5.14669 10.8536 2.8335 8.00016 2.8335C5.14669 2.8335 2.8335 5.14669 2.8335 8.00016C2.8335 10.8536 5.14669 13.1668 8.00016 13.1668Z" fill="#C2C8CC"></path></svg>
									</span>
									<div class="kh_dprt2_inf.on"></div>
									<div class="kh_dprt2_afterp">
										<span class="kh_dp2ap_num"><%=new DecimalFormat("###,###").format(pVo.getAfterPrice()) %></span>
										<span class="kh_dp2ap_won">원</span>
										<svg class="icon" aria-label="특가" width="30" height="20" viewBox="0 0 30 20" preserveAspectRatio="xMidYMid meet"><rect width="30" height="20" fill="#F77" rx="4"></rect><path fill="#fff" d="M12.83 7.93v-.97H7.93v-.555h5.228v-.991H6.655v4.063h6.59v-.992H7.928V7.93h4.901zm-6.295 3.747v1.002h5.326v2.037h1.274v-3.04h-6.6zm7.733-.588v-1.024H5.5v1.024h8.768zM23.91 9.782V8.725h-1.405V5H21.24v9.705h1.264V9.782h1.405zm-3.954-3.79h-4.53v1.056h3.147c-.174 1.938-1.623 3.975-3.736 4.945l.773.958c2.974-1.612 4.259-4.03 4.346-6.96z"></path></svg>
										<span class="kh_dp2ap_img">
											<img src="https://assets.ohou.se/web/dist/media/assets/icons/ic-departure-today-c4b771c1162afcd9223631b660e19d73.png" class="icon">
										</span>
									</div>
								</div>
							</div>
							<div class="kh_dprt_3">
								<div class="kh_dprt3_1">
									<div class="kh_dprt3_1_1">
										<span>혜택</span>
									</div>
									<div class="kh_dprt3_1_2">
										<p class="kh_dpr3_boon">
											최대 <b>8%</b> 결제할인 (신한)
										</p>
									</div>
								</div>
								<div class="kh_dprt3_2">
									<div class="kh_dprt3_2_1">
										<span>배송</span>
									</div>
									<div class="kh_dprt3_2_2">
										<span class="kh_dprt322_1"><b>1개당 3,000원</b> 선결제</span>
										<div class="kh_dprt322_2">
											<span class="kh_dprt3222_1">12:00 까지 결제 시
												<span class="kh_dprt3222_2">오늘 출발</span>
											</span>
											<svg class="information-icon" width="18" height="18" viewBox="0 0 18 18" fill="none" preserveAspectRatio="xMidYMid meet"><path d="M9 15.2C5.57583 15.2 2.8 12.4242 2.8 9C2.8 5.57583 5.57583 2.8 9 2.8C12.4242 2.8 15.2 5.57583 15.2 9C15.2 12.4242 12.4242 15.2 9 15.2ZM9 16.5C13.1421 16.5 16.5 13.1421 16.5 9C16.5 4.85786 13.1421 1.5 9 1.5C4.85786 1.5 1.5 4.85786 1.5 9C1.5 13.1421 4.85786 16.5 9 16.5Z" fill="#828C94"></path><path d="M8.35 6.375V5.25H9.65V6.375H8.35Z" fill="#828C94"></path><path d="M8.35 12.75V7.125H9.65V12.75H8.35Z" fill="#828C94"></path></svg>
										</div>
										<span class="kh_dprt322_3">일반택배</span>
										<span class="kh_dprt322_4">
											<svg class="check-icon" width="10" height="9" fill="none" preserveAspectRatio="xMidYMid meet"><path d="M1 3.83l2.153 3.03a1 1 0 001.627.005L9 1" stroke="#BDBDBD" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path></svg>
											<span>제주도/도서산간 지역 3,000원</span>
										</span>
<%
	String[] arrDate = {"일", "월", "화", "수", "목", "금", "토"};
	String strDate = "";  // 요일. ex) "화"
	Calendar cal = Calendar.getInstance();
	cal.add(Calendar.DATE, 2); // 이틀 후.
	strDate = arrDate[cal.get(Calendar.DAY_OF_WEEK)-1];   // (ex)"일"
	if("일".equals(strDate)) { strDate = "월"; }
%>										
										<div class="kh_dprt322_5">
											<svg class="delivery-time-icon" width="24" height="24" fill="none" preserveAspectRatio="xMidYMid meet"><path fill-rule="evenodd" clip-rule="evenodd" d="M13.303 5.04l.394.92L7 8.83V12a.5.5 0 01-1 0V8.17l7.303-3.13z" fill="#00B8F0"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M10.197 4.628a.5.5 0 00-.394 0L4.269 7 10 9.456 15.73 7l-2.427-1.04-3.106-1.332zM3.5 14.341V7.758l6 2.572v6.912L3.803 14.8a.5.5 0 01-.303-.46zm7 2.9l1.534-.657a5 5 0 014.466-5.56V7.759l-6 2.572v6.912zm.09 1.05l1.664-.713A5.002 5.002 0 0022 16a5 5 0 00-4.5-4.975V7.659a1.5 1.5 0 00-.91-1.378l-2.893-1.24-3.106-1.332a1.5 1.5 0 00-1.182 0l-6 2.572A1.5 1.5 0 002.5 7.659v6.682c0 .6.358 1.142.91 1.378l6 2.572a1.5 1.5 0 001.18 0zM17 20a4 4 0 100-8 4 4 0 000 8zm.5-6.5a.5.5 0 00-1 0v2H15a.5.5 0 000 1h2a.5.5 0 00.5-.5v-2.5z" fill="#3F474D"></path></svg>
											<span class="kh_dprt3225_1">
												<span class="kh_dprt3225_2">모레(<%=strDate%>)</span> 도착 예정</span>
											<svg class="information-icon" width="18" height="18" viewBox="0 0 18 18" fill="none" preserveAspectRatio="xMidYMid meet"><path d="M9 15.2C5.57583 15.2 2.8 12.4242 2.8 9C2.8 5.57583 5.57583 2.8 9 2.8C12.4242 2.8 15.2 5.57583 15.2 9C15.2 12.4242 12.4242 15.2 9 15.2ZM9 16.5C13.1421 16.5 16.5 13.1421 16.5 9C16.5 4.85786 13.1421 1.5 9 1.5C4.85786 1.5 1.5 4.85786 1.5 9C1.5 13.1421 4.85786 16.5 9 16.5Z" fill="#828C94"></path><path d="M8.35 6.375V5.25H9.65V6.375H8.35Z" fill="#828C94"></path><path d="M8.35 12.75V7.125H9.65V12.75H8.35Z" fill="#828C94"></path></svg>
										</div>
									</div>
								</div>
							</div>
							<a class="kh_dprt_4" href="#">
								<div class="kh_dprt4_1">
									<svg width="24" height="24" fill="none" preserveAspectRatio="xMidYMid meet"><path d="M3.972 8.694c0-.26.212-.472.472-.472h12.278a.472.472 0 010 .945H4.444a.472.472 0 01-.472-.473z" fill="#35C5F0"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M17.51 5.5H6.492a1 1 0 00-.93.632l-.99 2.5A1 1 0 005.498 10h13.004a1 1 0 00.927-1.368l-.99-2.5a1 1 0 00-.93-.632zM3.642 8.263a2.002 2.002 0 001.397 2.684V17.5a2.5 2.5 0 002.5 2.5H16.474a2.5 2.5 0 002.487-2.5v-6.553a2.002 2.002 0 001.398-2.684l-.99-2.5a2 2 0 00-1.86-1.263H6.493a2 2 0 00-1.86 1.263l-.99 2.5zM6.04 17.5V11h11.921v6.5a1.5 1.5 0 01-1.487 1.5v-4a2 2 0 00-2-2h-.97a2 2 0 00-2 2v4H7.54a1.5 1.5 0 01-1.5-1.5zm6.464 1.5h2.97v-4a1 1 0 00-1-1h-.97a1 1 0 00-1 1v1h.847a.5.5 0 110 1h-.847v2zM8 13h1.5v1.5H8V13zm-1 0a1 1 0 011-1h1.5a1 1 0 011 1v1.5a1 1 0 01-1 1H8a1 1 0 01-1-1V13z" fill="#3F474D"></path></svg>
									<span class="kh_dprt4_bn"><%=pVo.getBrandName() %></span>
								</div>
								<div class="kh_dprt4_2">
									<span>브랜드홈</span>
									<svg width="14" height="14" fill="none" preserveAspectRatio="xMidYMid meet"><path d="M4.083 11.375L8.312 7 4.083 2.625l.803-.875L9.916 7l-5.03 5.25-.803-.875z" fill="#828C94"></path></svg>
								</div>
							</a>
						</div>
						<div class="kh_dpr_bottom">
							<section class="kh_dprb_1">
								<div class="kh_dprb1_1">
									<select class="kh_dprb1_opt" name="option_d1">
										<option value>색상</option>
										<option value="버터">버터(49,900원)</option>
										<option value="그레이">그레이(49,900원)</option>
									</select>
								</div>
								<ul class="kh_dprb1_2">
									<li>
										<div class="kh_dprb1_sel_op">
											<h2 class="kh_dprb1_so_name">버터</h2>
											<button class="kh_dprb1_so_del">
												<span class="kh_dprb1_sd"></span>
											</button>
											<div class="kh_dprb1_so_else">
												<div class="kh_dprb1_se_num">
													<span class="kh_dprb1_sen_mi"></span>
													<button class="kh_dprb1_sen_num">1</button>
													<span class="kh_dprb1_sen_pl"></span>
												</div>
												<div class="kh_dprb1_se_price">
													<span class="kh_dprb1_sep">
														49,900
														<span>원</span>
													</span>
												</div>
											</div>
										</div>
									</li>
								</ul>
							</section>
							<p class="kh_dprb_2">
								<span class="kh_dprb2_1">주문금액</span>
								<span class="kh_dprb2_2">
									<span>0</span>원
								</span>
							</p>
							<div class="kh_dprb_3">
								<button type="button" class="kh_dprb3_1">장바구니</button>
								<button type="button" class="kh_dprb3_2">바로구매</button>
							</div>
						</div>
					</div>
				</div>
			</div>			
		</div>
		</div>
		<!------------------------- 상품페이지 상세 메뉴바 시작 ----------------------------------->
		<div class="jy_product_detail_info_menubar_tl">
			<nav class="jy_product_detail_info_menubar">
				<ol class="jy_product_detail_info_menubar_list">
					<li><a class="jy_product_btn y_active_on" href="#">상품정보</a></li>
					<li><a class="jy_product_btn" href="#">리뷰<span class="jy_product_review_count">260</span></a></li>
					<li><a class="jy_product_btn" href="#">문의<span class="jy_product_inquiry_count">22</span></a></li>
					<li><a class="jy_product_btn" href="#">배송/환불</a></li>
					<li><a class="jy_product_btn" href="#">추천</a></li>
				</ol>
			</nav>
		</div>
		<!------------------------- 상품페이지 상세 메뉴바 끝 ----------------------------------->
		<!------------------------- 상품페이지 상세 정보 사진 리뷰등등 시작 ----------------------------------->
		<div class="jy_detail_info_tl">
			<div class="jy_detail_info_photo_tl">
				<div class="jy_detail_info_photo_tl2">
					<div class="jy_all_detail_imgs">
						<img class="jy_product_selling_description__notice_image jy_img_size" src="https://image.ohou.se/i/bucketplace-v2-development/uploads/admins/productions/notice/170237175975569015.jpg?gif=1&w=720"/>
						<video class="jy_product_selling_description__notice_image jy_video_size" src="http://immhome.godohosting.com/etc/fluffy/video.mp4" autoplay="autoplay" loop="loop" muted=""  playsinline=""></video>
						<img class="jy_product_selling_description__notice_image jy_img_size" src="https://exit.ohou.se/b7b3ebf74752b67751b3bfb5f86a092c2904accd/immhome.godohosting.com/etc/fluffy/01.jpg"/>
						<img class="jy_product_selling_description__notice_image jy_img_size" src="https://exit.ohou.se/29babe8abe7e271e408e2407fbc0f260de5de2af/immhome.godohosting.com/etc/fluffy/02.jpg"/>
						<img class="jy_product_selling_description__notice_image jy_img_size" src="https://exit.ohou.se/658d4a664a369c6cc3d55fef23e3e8d398a5c499/immhome.godohosting.com/etc/fluffy/03.jpg"/>
						<img class="jy_product_selling_description__notice_image jy_img_size" src="https://exit.ohou.se/28495a9268ddddbf973e95ec7ac041f99544ed33/immhome.godohosting.com/etc/fluffy/04.jpg"/>
						<img class="jy_product_selling_description__notice_image jy_img_size" src="https://exit.ohou.se/780e87718961f5310b754ebb5614a313e8715570/immhome.godohosting.com/etc/fluffy/05.jpg"/>
						<img class="jy_product_selling_description__notice_image jy_img_size" src="https://exit.ohou.se/dac5418ccc77c9a27d5dc900fc3a7a42fd07f962/immhome.godohosting.com/etc/fluffy/06.jpg"/>
					</div>
					<table class="jy_product_table">
						<tbody class="jy_product_tbody">
							<tr class="jy_product_tr">
								<th class="jy_product_th">품명 및 모델명</th>
								<td class="jy_product_td">포이포이 플러티 티슈케이스</td>
							</tr>
							<tr class="jy_product_tr">
								<th class="jy_product_th">법에 의한 인증ㆍ허가 등을 받았음을 확인할 수 있는 경우 그에 대한 사항</th>
								<td class="jy_product_td">내용없음</td>
							</tr>
							<tr class="jy_product_tr">
								<th class="jy_product_th">제조국 또는 원산지</th>
								<td class="jy_product_td">대한민국</td>
							</tr>
							<tr class="jy_product_tr">
								<th class="jy_product_th">제조자, 수입품의 경우 수입자를 함께 표기</th>
								<td class="jy_product_td">아엠홈</td>
							</tr>
							<tr class="jy_product_tr">
								<th class="jy_product_th">A/S 책임자와 전화번호 또는 소비자 상담 관련 전화번호</th>
								<td class="jy_product_td">아엠홈 1661-3162</td>
							</tr>
  						</tbody>
					</table>
				</div>
			</div>
			<!-- 내가 고른 옵션 틀 -->
			<div class="jy_product_buying_tl">
				<div class="jy_product_buying_tl_sticky">
					<div class="jy_product_buying_">
						<div class="jy_input_input_input">
							<section class="jy_real_input">
								<div class="jy_product_option_select_tl">
									<select class="jy_product_option_select">
										<option class="jy_item" value="0">컬러</option>
										<option class="jy_item" value="1">다크블랙(29700원)</option>
										<option class="jy_item" value="2" disabled>스카이블루(29700원)</option>
										<option class="jy_item" value="3">오렌지(29700원)</option>
										<option class="jy_item" value="4">퍼플(29700원)</option>
										<option class="jy_item" value="5" disabled>라이트그린(29700원)</option>
									</select>
								</div>
								<ul	class="jy_pick_up_option">
								
								</ul>
							</section>
							<p class="jy_basic_pay_font">
								<span class="jy_basic_font">주문금액</span>
								<span class="jy_pay_font"><span class="jy_pay_font">0</span>원</span>
							</p>
							<div class="jy_product_button_tl">
								<button class="jy_product_btn_right jy_heart_b"><span class="jy_heart_icon"></span></button>
								<button class="jy_product_btn_right jy_jang_ba">장바구니</button>
								<button class="jy_product_btn_right jy_ba_ro">바로구매</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		<!------------------------- 상품페이지 상세 정보 사진 끝 -------------------------------->
		<!------------------------- 상품페이지 상세 리뷰 시작 -------------------------------->
		<div class="ja_review_box">
			<div class="ja_review_header">
				<h1 class="ja_review_header_title">리뷰
					<span class="ja_review_num">271</span>
				</h1>
				<div class="ja_review_write_btn_box">
					<button class="ja_review_write_btn">리뷰쓰기</button>
				</div>
			</div>
			<div class="ja_production_review_feed">
				<!----------별점통계---------->
				<div class="ja_review_star_avg_box">
					<div class="ja_review_star_avg_inner">
						<div class="ja_review_star_avg_left">
							<span class="ja_star_icon">
								<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-0" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-0"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-0" fill="#DBDBDB"></use><use clip-path="url(#star-clip-0)" xlink:href="#star-path-0"></use></svg>
								<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-1" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-1"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-1" fill="#DBDBDB"></use><use clip-path="url(#star-clip-1)" xlink:href="#star-path-1"></use></svg>
								<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-2" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-2"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-2" fill="#DBDBDB"></use><use clip-path="url(#star-clip-2)" xlink:href="#star-path-2"></use></svg>
								<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-3" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-3"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-3" fill="#DBDBDB"></use><use clip-path="url(#star-clip-3)" xlink:href="#star-path-3"></use></svg>
								<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-4" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-4"><rect x="0" y="0" width="17.357933579335793" height="24"></rect></clipPath></defs><use xlink:href="#star-path-4" fill="#DBDBDB"></use><use clip-path="url(#star-clip-4)" xlink:href="#star-path-4"></use></svg>
							</span>
							<span class="ja_review_star_avg">4.7</span>
						</div>
						<div class="ja_review_star_avg_right">
							<div class="ja_review_star_avg_bar_box">
								<div class="ja_star_avg_bar_tl">
									<div class="ja_star_avg_bar_score  ja_five">5점</div>
									<div class="ja_star_avg_bar">
										<div class="ja_star_avg_bar_bg"></div>
										<div class="ja_star_avg_bar_color" style="width: 76.7528%;"></div>
									</div>
									<div class="ja_five ja_star_avg_bar_number">208</div>
								</div>
								<div class="ja_star_avg_bar_tl">
									<div class="ja_star_avg_bar_score">4점</div>
									<div class="ja_star_avg_bar">
										<div class="ja_star_avg_bar_bg"></div>
										<div class="ja_star_avg_bar_color" style="width: 20.2952%;;"></div>
									</div>
									<div class="ja_star_avg_bar_number">55</div>
								</div>
								<div class="ja_star_avg_bar_tl">
									<div class="ja_star_avg_bar_score">3점</div>
									<div class="ja_star_avg_bar">
										<div class="ja_star_avg_bar_bg"></div>
										<div class="ja_star_avg_bar_color" style="width: 1.84502%;"></div>
									</div>
									<div class="ja_star_avg_bar_number">5</div>
								</div>
								<div class="ja_star_avg_bar_tl">
									<div class="ja_star_avg_bar_score">2점</div>
									<div class="ja_star_avg_bar">
										<div class="ja_star_avg_bar_bg"></div>
										<div class="ja_star_avg_bar_color" style="width: 0.738007%;"></div>
									</div>
									<div class="ja_star_avg_bar_number">2</div>
								</div>
								<div class="ja_star_avg_bar_tl">
									<div class="ja_star_avg_bar_score">1점</div>
									<div class="ja_star_avg_bar">
										<div class="ja_star_avg_bar_bg"></div>
										<div class="ja_star_avg_bar_color" style="width: 0.369004%;"></div>
									</div>
									<div class="ja_star_avg_bar_number">1</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!----------리뷰정렬---------->
				<div class="ja_review_filter_box">
					<div class="ja_review_filter_tl">
						<div class="ja_filter_order_list">
							<button type="button" class="ja_order_list_btn  on">베스트순</button>
							<button type="button" class="ja_order_list_btn">최신순</button>
						</div>
					</div>
				</div>
				<!----------리뷰내용---------->
				<div class="ja_review_feed_box">
				<!--------------------리뷰내용 반복-------------------->	
					<div class="ja_review_feed_container  ja_hr">
						<article class="ja_review_feed_item">
							<!----------프로필사진,닉네임,별점평균,작성일자,오늘의집구매---------->			
							<div class="ja_re_profile_add">
								<a href="#">
									<img src="https://image.ohou.se/image/central_crop/bucketplace-v2-development/uploads-users-profile_images-165528479224899065.jpeg/80/80" class="ja_review_profile_img"/>
								</a>
								<div class="ja_re_profile_wirter_info">
									<p class="ja_re_memeber_id">우읕</p>
									<button class="ja_re_star_avg_btn" type="button">
										<span class="ja_re_star_avg_span" aria-label="별점 5.0점">
											<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-5" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-5"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-5" fill="#DBDBDB"></use><use clip-path="url(#star-clip-5)" xlink:href="#star-path-5"></use></svg>
											<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-5" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-5"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-5" fill="#DBDBDB"></use><use clip-path="url(#star-clip-5)" xlink:href="#star-path-5"></use></svg>
											<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-5" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-5"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-5" fill="#DBDBDB"></use><use clip-path="url(#star-clip-5)" xlink:href="#star-path-5"></use></svg>
											<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-5" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-5"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-5" fill="#DBDBDB"></use><use clip-path="url(#star-clip-5)" xlink:href="#star-path-5"></use></svg>
											<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-5" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-5"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-5" fill="#DBDBDB"></use><use clip-path="url(#star-clip-5)" xlink:href="#star-path-5"></use></svg>
										</span>
									</button>
									<span class="ja_re_writedate">2023.12.18 ∙ 오늘의집 구매</span>
								</div>
							</div>
							<!----------별점---------->
							<div class="ja_re_detail_star">
								<div class="ja_re_detail_star_left">
									<span class="ja_re_detail_star_title">내구성</span>
									<span class="ja_re_detail_star_img" aria-label="별점5.0점">
										<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-30" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-30"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-30" fill="#DBDBDB"></use><use clip-path="url(#star-clip-30)" xlink:href="#star-path-30"></use></svg>
										<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-31" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-31"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-31" fill="#DBDBDB"></use><use clip-path="url(#star-clip-31)" xlink:href="#star-path-31"></use></svg>
										<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-31" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-31"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-31" fill="#DBDBDB"></use><use clip-path="url(#star-clip-31)" xlink:href="#star-path-31"></use></svg>
										<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-31" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-31"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-31" fill="#DBDBDB"></use><use clip-path="url(#star-clip-31)" xlink:href="#star-path-31"></use></svg>
										<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-31" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-31"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-31" fill="#DBDBDB"></use><use clip-path="url(#star-clip-31)" xlink:href="#star-path-31"></use></svg>
									</span>
									<br/>
									<span class="ja_re_detail_star_title">디자인</span>
									<span class="ja_re_detail_star_img" aria-label="별점5.0점">
										<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-30" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-30"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-30" fill="#DBDBDB"></use><use clip-path="url(#star-clip-30)" xlink:href="#star-path-30"></use></svg>
										<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-31" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-31"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-31" fill="#DBDBDB"></use><use clip-path="url(#star-clip-31)" xlink:href="#star-path-31"></use></svg>
										<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-31" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-31"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-31" fill="#DBDBDB"></use><use clip-path="url(#star-clip-31)" xlink:href="#star-path-31"></use></svg>
										<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-31" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-31"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-31" fill="#DBDBDB"></use><use clip-path="url(#star-clip-31)" xlink:href="#star-path-31"></use></svg>
										<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-31" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-31"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-31" fill="#DBDBDB"></use><use clip-path="url(#star-clip-31)" xlink:href="#star-path-31"></use></svg>
									</span>
								</div>
								
								<div class="ja_re_detail_star_right">
									<span class="ja_re_detail_star_title">가격</span>
									<span class="ja_re_detail_star_img" aria-label="별점5.0점">
										<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-30" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-30"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-30" fill="#DBDBDB"></use><use clip-path="url(#star-clip-30)" xlink:href="#star-path-30"></use></svg>
										<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-31" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-31"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-31" fill="#DBDBDB"></use><use clip-path="url(#star-clip-31)" xlink:href="#star-path-31"></use></svg>
										<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-31" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-31"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-31" fill="#DBDBDB"></use><use clip-path="url(#star-clip-31)" xlink:href="#star-path-31"></use></svg>
										<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-31" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-31"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-31" fill="#DBDBDB"></use><use clip-path="url(#star-clip-31)" xlink:href="#star-path-31"></use></svg>
										<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-31" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-31"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-31" fill="#DBDBDB"></use><use clip-path="url(#star-clip-31)" xlink:href="#star-path-31"></use></svg>
									</span>
									<br/>
									<span class="ja_re_detail_star_title">배송</span>
									<span class="ja_re_detail_star_img" aria-label="별점5.0점">
										<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-30" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-30"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-30" fill="#DBDBDB"></use><use clip-path="url(#star-clip-30)" xlink:href="#star-path-30"></use></svg>
										<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-31" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-31"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-31" fill="#DBDBDB"></use><use clip-path="url(#star-clip-31)" xlink:href="#star-path-31"></use></svg>
										<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-31" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-31"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-31" fill="#DBDBDB"></use><use clip-path="url(#star-clip-31)" xlink:href="#star-path-31"></use></svg>
										<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-31" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-31"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-31" fill="#DBDBDB"></use><use clip-path="url(#star-clip-31)" xlink:href="#star-path-31"></use></svg>
										<svg fill="#35C5F0" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><defs><path id="star-path-31" d="M11.9996 19.7201L6.32294 22.1251C5.5626 22.4472 5.005 22.0311 5.0755 21.2188L5.60855 15.0767L1.5671 10.421C1.02579 9.79745 1.24924 9.13855 2.04358 8.95458L8.04973 7.56354L11.2287 2.28121C11.6545 1.57369 12.3502 1.5826 12.7706 2.28121L15.9496 7.56354L21.9557 8.95458C22.7602 9.1409 22.9667 9.8053 22.4322 10.421L18.3907 15.0767L18.9238 21.2188C18.9952 22.0414 18.4271 22.4432 17.6764 22.1251L11.9996 19.7201Z"></path><clipPath id="star-clip-31"><rect x="0" y="0" width="24" height="24"></rect></clipPath></defs><use xlink:href="#star-path-31" fill="#DBDBDB"></use><use clip-path="url(#star-clip-31)" xlink:href="#star-path-31"></use></svg>
									</span>
								</div>
							</div>
							<!----------옵션---------->
							<div class="ja_re_option">
								<p class="ja_re_option_name">스카이블루</p>
							</div>
							<!----------사진---------->
							<button type="button" class="ja_re_photo_btn">
								<img class="ja_re_photo_img" src="https://image.ohou.se/i/bucketplace-v2-development/uploads/cards/snapshots/170290017012671252.jpeg?gif=1&amp;w=144&amp;h=144&amp;c=c&amp;webp=1">
							</button>
							<!----------리뷰내용---------->
							<p class="ja_review_description">몬스터주식회사 생각나서 귀염고 너무 예뻐용</p>
							<!----------도움이돼요 버튼---------->
							<div class="ja_product_re_help_box">
								<button type="button" class="ja_product_re_help_btn">도움이 돼요</button>
								<button type="button" class="ja_product_re_help_btn on">도움됨</button>
								<div class="ja_product_re_help_text">
									<span class="ja_product_re_help">2</span>명에게 도움이 되었습니다.
								</div>
							</div>
						</article>
					</div>
					<!--------------------리뷰내용 반복끝-------------------->
				</div>
				<!----------리뷰페이징---------->
				<ul class="ja_review_paging_box">
					<li class="ja_review_paging_arrow_box">
						<button class="ja_review_paging_arrow_btn  ja_paging_left" type="button">
							<svg width="1em" height="1em" viewBox="0 0 24 24"><path fill="currentColor" d="M6 19.692L8.25 22 18 12 8.25 2 6 4.308 13.5 12z"></path></svg>
						</button>
					</li>
					<li>
						<button class="ja_paging_num" type="button">1</button>
					</li>
					<li>
						<button class="ja_paging_num  on" type="button">2</button>
					</li>
					<li>
						<button class="ja_paging_num" type="button">3</button>
					</li>
					<li>
						<button class="ja_paging_num" type="button">4</button>
					</li>
					<li>
						<button class="ja_paging_num" type="button">5</button>
					</li>
					<li>
						<button class="ja_paging_num" type="button">6</button>
					</li>
					<li>
						<button class="ja_paging_num" type="button">7</button>
					</li>
					<li>
						<button class="ja_paging_num" type="button">8</button>
					</li>
					<li>
						<button class="ja_paging_num" type="button">9</button>
					</li>
					<li class="ja_review_paging_arrow_box">
						<button class="ja_review_paging_arrow_btn  ja_paging_right" type="button">
							<svg width="1em" height="1em" viewBox="0 0 24 24"><path fill="currentColor" d="M6 19.692L8.25 22 18 12 8.25 2 6 4.308 13.5 12z"></path></svg>
						</button>
					</li>
				</ul>
			</div>
		</div>
		<!------------------------- 상품페이지 상세 리뷰 끝 -------------------------------->
		<!------------------------- 상품페이지 상세 문의 시작 -------------------------------->
		<div class="ja_qa_box">
			<div class="ja_qa_header">
				<h1 class="ja_qa_header_title">문의
					<span class="ja_qa_num">26</span>
				</h1>
				<div class="ja_qa_write_btn_box">
					<button class="ja_qa_write_btn">문의하기</button>
				</div>
			</div>
			<div class="ja_question_feed">
				<div class="ja_question_feed_list">
					<!------------------------- 상품페이지 상세 문의 반복부분시작 -------------------------------->
					<article class="ja_product_question_feed_item">
						<div class="ja_product_qa_header">비구매 | 상품 |
							<span class="ja_answered">답변완료</span>
						</div>
						<p class="ja_product_qa_author">죽* | 2024년 01월 06일 21시 33분</p>
						<div class="ja_question_item">
							<span class="ja_question_badge">Q&nbsp;</span>
							<p class="ja_question_content"><span class="ja_question_content_option">라이트그린<br/></span>재입고 언제되나요??</p>
						</div>
						<div class="ja_answer_item">
							<span class="ja_answer_badge">A&nbsp;</span>
							<p class="ja_answer_write_date">
								<span class="ja_answer_author">아엠홈🏡</span>&nbsp;
								<span class="ja_answer_date">2024년 01월 08일 09시 04분</span>
							</p>
							<p class="ja_answer_content">안녕하세요, 아엠홈입니다.
소량 재입고 되어 아엠홈 공식 홈페이지에서만 구매 가능합니다.
https://www.immhome.co.kr/?pn=product.view&amp;cuid=&amp;pcode=L7476-I2635-F5696

감사합니다.</p>
						</div>
					</article>
					<!------------------------- 상품페이지 상세 문의 반복부분끝 -------------------------------->
				</div>
				<ul class="ja_review_paging_box">   <!--리뷰페이징과 동일--> 
					<li class="ja_review_paging_arrow_box">
						<button class="ja_review_paging_arrow_btn  ja_paging_left" type="button">
							<svg width="1em" height="1em" viewBox="0 0 24 24"><path fill="currentColor" d="M6 19.692L8.25 22 18 12 8.25 2 6 4.308 13.5 12z"></path></svg>
						</button>
					</li>
					<li>
						<button class="ja_paging_num" type="button">1</button>
					</li>
					<li>
						<button class="ja_paging_num  on" type="button">2</button>
					</li>
					<li>
						<button class="ja_paging_num" type="button">3</button>
					</li>
					<li>
						<button class="ja_paging_num" type="button">4</button>
					</li>
					<li>
						<button class="ja_paging_num" type="button">5</button>
					</li>
					<li>
						<button class="ja_paging_num" type="button">6</button>
					</li>
					<li>
						<button class="ja_paging_num" type="button">7</button>
					</li>
					<li>
						<button class="ja_paging_num" type="button">8</button>
					</li>
					<li>
						<button class="ja_paging_num" type="button">9</button>
					</li>
					<li class="ja_review_paging_arrow_box">
						<button class="ja_review_paging_arrow_btn  ja_paging_right" type="button">
							<svg width="1em" height="1em" viewBox="0 0 24 24"><path fill="currentColor" d="M6 19.692L8.25 22 18 12 8.25 2 6 4.308 13.5 12z"></path></svg>
						</button>
					</li>
				</ul>
			</div>
		</div>
		
		<!------------------------- 상품페이지 상세 문의 끝 -------------------------------->
		<!------------------------- 상품페이지 상세 배송 시작 -------------------------------->
		<div class="ja_box">
			<div class="ja_header">
				<h1 class="ja_header_title">배송</h1>
			</div>
			<table class="jy_product_table">
				<tbody class="jy_product_tbody">
					<tr class="jy_product_tr">
						<th class="jy_product_th">배송</th>
						<td class="jy_product_td">일반택배</td>
					</tr>
					<tr class="jy_product_tr">
						<th class="jy_product_th">배송비</th>
						<td class="jy_product_td">3,000원 <small>(80,000원 이상 구매시 무료배송)</small></td>
					</tr>
					<tr class="jy_product_tr">
						<th class="jy_product_th">도서산간 추가 배송비</th>
						<td class="jy_product_td">3,000원</td>
					</tr>
					<tr class="jy_product_tr">
						<th class="jy_product_th">배송불가 지역</th>
						<td class="jy_product_td">배송불가 지역이 없습니다.</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!------------------------- 상품페이지 상세 배송 끝 -------------------------------->
		<!------------------------- 상품페이지 상세 교환/환불 시작 -------------------------------->
		<div class="ja_box">
			<div class="ja_header">
				<h1 class="ja_header_title">교환/환불</h1>
			</div>
			<table class="jy_product_table">
				<tbody class="jy_product_tbody">
					<tr class="jy_product_tr">
						<th class="jy_product_th">반품배송비</th>
						<td class="jy_product_td">3,000원 (최초 배송비가 무료인 경우 6,000원 부과)</td>
					</tr>
					<tr class="jy_product_tr">
						<th class="jy_product_th">교환배송비</th>
						<td class="jy_product_td">6,000원</td>
					</tr>
					<tr class="jy_product_tr">
						<th class="jy_product_th">보내실 곳</th>
						<td class="jy_product_td">서울 서초구 서초대로74길 4 삼성생명서초타워 25, 27층 오늘의집(남의집)</td>
					</tr>
				</tbody>
			</table>
			<h2 class="ja_exchange_notice">반품/교환 사유에 따른 요청 가능 기간</h2>
			<p class="ja_exchange_note">반품 시 먼저 판매자와 연락하셔서 반품사유, 택배사, 배송비, 반품지 주소 등을 협의하신 후 반품상품을 발송해 주시기 바랍니다.</p>
			<ol class="ja_exchange_ol">
				<li>구매자 단순 변심은 상품 수령 후 7일 이내&nbsp;<small>(구매자 반품배송비 부담)</small></li>
				<li>표시/광고와 상이, 계약내용과 다르게 이행된 경우 상품 수령 후 3개월 이내, 그 사실을 안 날 또는 알 수 있었던 날로부터 30일 이내.<br>둘 중 하나 경과 시 반품/교환 불가&nbsp;<small>(판매자 반품배송비 부담)</small></li>
			</ol>
			<h2 class="ja_exchange_notice">반품/교환 불가능 사유</h2>
			<p class="ja_exchange_note">아래와 같은 경우 반품/교환이 불가능합니다.</p>
			<ol class="ja_exchange_ol">
				<li>반품요청기간이 지난 경우</li>
				<li>구매자의 책임 있는 사유로 상품 등이 멸실 또는 훼손된 경우&nbsp;<small>(단, 상품의 내용을 확인하기 위하여 포장 등을 훼손한 경우는 제외)</small></li>
				<li>포장을 개봉하였으나 포장이 훼손되어 상품가치가 현저히 상실된 경우&nbsp;<small>(예: 식품, 화장품)</small></li>
				<li>구매자의 사용 또는 일부 소비에 의하여 상품의 가치가 현저히 감소한 경우&nbsp;<small>(라벨이 떨어진 의류 또는 태그가 떨어진 명품관 상품인 경우)</small></li>
				<li>시간의 경과에 의하여 재판매가 곤란할 정도로 상품 등의 가치가 현저히 감소한 경우&nbsp;<small>(예: 식품, 화장품)</small></li>
				<li>고객주문 확인 후 상품제작에 들어가는 주문제작상품</li>
				<li>복제가 가능한 상품 등의 포장을 훼손한 경우&nbsp;<small>(CD/DVD/GAME/도서의 경우 포장 개봉 시)</small></li>
			</ol>
		</div>
		<!------------------------- 상품페이지 상세 교환/환불 끝 -------------------------------->
		<!------------------------- 상품페이지 상세 판매자정보 시작 -------------------------------->
		<div class="ja_box">
			<div class="ja_header">
				<h1 class="ja_header_title">판매자 정보</h1>
			</div>
				<table class="jy_product_table">
				<tbody class="jy_product_tbody">
					<tr class="jy_product_tr">
						<th class="jy_product_th">상호</th>
						<td class="jy_product_td">주식회사 아엠홈</td>
					</tr>
					<tr class="jy_product_tr">
						<th class="jy_product_th">대표자</th>
						<td class="jy_product_td">허진아</td>
					</tr>
					<tr class="jy_product_tr">
						<th class="jy_product_th">사업장소재지</th>
						<td class="jy_product_td">경기 부천시 도약로281번길 17 3층</td>
					</tr>
					<tr class="jy_product_tr">
						<th class="jy_product_th">고객센터 전화번호</th>
						<td class="jy_product_td">02-1661-3162</td>
					</tr>
					<tr class="jy_product_tr">
						<th class="jy_product_th">E-mail</th>
						<td class="jy_product_td">immhome@naver.com</td>
					</tr>
					<tr class="jy_product_tr">
						<th class="jy_product_th">사업자 등록번호</th>
						<td class="jy_product_td">622-86-01216</td>
					</tr>
					<tr class="jy_product_tr">
						<th class="jy_product_th">통신판매업 신고번호</th>
						<td class="jy_product_td">2018-경기부천-1560</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!------------------------- 상품페이지 상세 판매자정보 끝 -------------------------------->
	</div>
	</main>
	<footer id="footer">
		<div class="footer_box">
			<div class="footer_box1">
				<div class="footer_box1_1">
					<a href="#">고객센터</a>
					<span></span>
				</div>
				<div class="footer_box1_2">
					<a href="#">1670-0876</a>
					<time datetime="09:00">09:00</time> ~
					<time datetime="18:00">18:00</time>
				</div>
				<div class="footer_box1_3">
					<div>평일: 전체 문의 상담</div>
					<div>토요일, 공휴일: 오늘의집 직접배송, 이사/시공/제품설치 문의 상담</div>
					<div>일요일: 휴무</div>
				</div>
				<div class="footer_box1_4">
					<button class="footer_box1-4_box">카톡 상담(평일 09:00~18:00)</button>
					<a href="#" class="footer_box1-4_box">이메일 문의</a>
				</div>
			</div>
			<div class="footer_box_hr"></div>
			<div class="footer_box2">
				<a href="#">회사소개</a>
				<a href="#">채용정보</a>
				<a href="#">이용약관</a>
				<a href="#" class="box2_font">개인정보 처리방침</a>
				<a href="#">공지사항</a>
				<a href="#">안전거래센터</a>
				<a href="#">입점신청</a>
				<a href="#">제휴/광고 문의</a>
				<a href="#">사업자 구매 회원</a>
				<a href="#">시공파트너 안내</a>
				<a href="#">상품광고 소개</a>
				<a href="#">고객의 소리</a>
			</div>
			<div class="footer_box_hr"></div>
			<div class="footer_box3">
				<div class="box3_1">
					<div class="box3_1_1">
						<div><span class="box3">|</span>(주)버킷플레이스</div>
						<div><span class="box3">|</span>대표이사 이승재</div>
						<div><span class="box3">|</span>서울 서초구 서초대로74길 4 삼성생명서초타워 25층, 27층</div>
						<div><span class="box3">|</span>contact@bucketplace.net</div>
						<div>
							<span class="box3">|</span>
							<span>사업자등록번호 119-86-91245</span>
							<a target="_blank" href="https://www.ftc.go.kr/bizCommPop.do?wrkr_no=1198691245"> 사업자정보확인</a>
						</div>
						<div><span class="box3">|</span>통신판매업신고번호 제2018-서울서초-0580호</div>
					</div>
				</div>
				<div class="box3_2">
					<span>고객님이 현금결제한 금액에 대해 우리은행과 채무지급보증 계약을 체결하여 안전거래를 보장하고 있습니다.</span>
					<a target="_blank" href="https://image.ohou.se/i/bucketplace-v2-development/uploads/static/images/167904458404594951.jpg?w=1440">서비스가입사실확인</a>
				</div>
				<div class="box3_3">
					<div>
						<img src="https://assets.ohou.se/design-system/8f5b2c2e98ea1196.png" width="32" height="32"/>
						<div class="box3_3_1">
							<span>오늘의집 서비스 운영</span> <br>
							2021. 09. 08 ~ 2024. 09. 07
						</div>
					</div>
					<div>
						<img src="https://assets.ohou.se/design-system/d5fb816a58bb6a06.png" width="32" height="32"/>
					</div>
					<div>
						<a href="https://www.pipc.go.kr/np/cop/bbs/selectBoardArticle.do?bbsId=BS213&amp;mCode=C040050000&amp;nttId=8926" target="_blank" rel="noreferrer">
							<img src="https://assets.ohou.se/design-system/ad1cf869a6c58058.png" width="32" height="32">
						</a>
					</div>
				</div>
				<div>
					(주)버킷플레이스는 통신판매중개자로 거래 당사자가 아니므로, 판매자가 등록한 상품정보 및 거래 등에 대해 책임을 지지 않습니다. 
					단, (주)버킷플레이스가 판매자로 등록 판매한 상품은 판매자로서 책임을 부담합니다.
				</div>
				<div class="link">
					<a href="https://www.youtube.com/channel/UCBKtitA1RwY7F32rCniV1dA" target="_blank" rel="noreferrer" aria-label="오늘의집 Youtube 링크 버튼" class="css-1a5klid"><svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="css-8n6bc3"><circle cx="12" cy="12" r="11" fill="currentColor"></circle><path d="M18.7086 8.63031C18.5472 8.02758 18.0736 7.55392 17.4709 7.39258C16.3783 7.09985 12.0002 7.09985 12.0002 7.09985C12.0002 7.09985 7.62199 7.09985 6.53062 7.39258C5.92789 7.55392 5.45423 8.02758 5.29289 8.63031C5.00016 9.72168 5.00016 12.0001 5.00016 12.0001C5.00016 12.0001 5.00016 14.2785 5.29289 15.3699C5.45423 15.9726 5.92789 16.4462 6.53062 16.6076C7.62199 16.9003 12.0002 16.9003 12.0002 16.9003C12.0002 16.9003 16.3783 16.9003 17.4697 16.6076C18.0724 16.4462 18.5461 15.9726 18.7074 15.3699C19.0002 14.2785 19.0002 12.0001 19.0002 12.0001C19.0002 12.0001 19.0002 9.72168 18.7074 8.63031H18.7086Z" fill="white"></path><path d="M10.6013 14.0994L14.2396 11.9997L10.6013 9.8999V14.0994Z" fill="currentColor"></path></svg></a>
					<a href="https://www.instagram.com/todayhouse" target="_blank" rel="noreferrer" aria-label="오늘의집 Instagram 링크 버튼" class="css-1a5klid"><svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="css-8n6bc3"><circle cx="12" cy="12" r="11" fill="currentColor"></circle><path d="M9.10061 5.04896C8.3558 5.0841 7.84718 5.20296 7.40253 5.37768C6.94235 5.55702 6.5523 5.79768 6.16422 6.18717C5.77614 6.57665 5.53715 6.96698 5.35907 7.42786C5.18673 7.87349 5.06997 8.38253 5.03707 9.12776C5.00417 9.87299 4.99689 10.1125 5.00053 12.0135C5.00417 13.9144 5.01257 14.1527 5.04869 14.8995C5.08425 15.6441 5.20269 16.1526 5.37741 16.5974C5.55703 17.0576 5.79742 17.4475 6.18704 17.8357C6.57666 18.2239 6.96671 18.4624 7.42871 18.6407C7.87392 18.8128 8.3831 18.9301 9.12819 18.9627C9.87328 18.9953 10.1131 19.0029 12.0135 18.9993C13.9139 18.9956 14.1531 18.9872 14.8997 18.9518C15.6464 18.9164 16.1522 18.7971 16.5971 18.6232C17.0573 18.4432 17.4475 18.2032 17.8354 17.8134C18.2234 17.4237 18.4622 17.0331 18.6402 16.5719C18.8126 16.1267 18.9298 15.6175 18.9622 14.873C18.9948 14.1258 19.0025 13.8872 18.9988 11.9866C18.9952 10.0859 18.9867 9.84765 18.9513 9.10116C18.9158 8.35467 18.7972 7.84773 18.6227 7.40266C18.4428 6.94248 18.2027 6.55285 17.8132 6.16435C17.4237 5.77584 17.0328 5.53714 16.5718 5.35962C16.1263 5.18728 15.6174 5.06982 14.8723 5.03762C14.1272 5.00542 13.8874 4.99716 11.9863 5.0008C10.0852 5.00444 9.84724 5.01256 9.10061 5.04896ZM9.18237 17.7034C8.49986 17.6737 8.12928 17.5603 7.88232 17.4654C7.55527 17.3394 7.32231 17.1871 7.07619 16.9433C6.83007 16.6996 6.67886 16.4658 6.55118 16.1394C6.45528 15.8925 6.33978 15.5223 6.30786 14.8398C6.27314 14.1021 6.26586 13.8807 6.2618 12.0118C6.25774 10.1429 6.26488 9.92171 6.29722 9.18376C6.32634 8.50181 6.44044 8.13081 6.53522 7.88399C6.66122 7.55652 6.81299 7.32398 7.05729 7.078C7.30159 6.83201 7.53469 6.68053 7.86132 6.55285C8.108 6.45653 8.47816 6.34201 9.16039 6.30953C9.89862 6.27453 10.1198 6.26753 11.9884 6.26347C13.857 6.25941 14.0788 6.26641 14.8173 6.29889C15.4992 6.32857 15.8704 6.44155 16.1169 6.53689C16.4441 6.66289 16.6769 6.81423 16.9229 7.05896C17.1689 7.30368 17.3205 7.53594 17.4482 7.86327C17.5447 8.10925 17.6592 8.47927 17.6914 9.16192C17.7265 9.90015 17.7345 10.1215 17.7379 11.9899C17.7412 13.8584 17.7346 14.0803 17.7023 14.818C17.6725 15.5005 17.5594 15.8712 17.4643 16.1184C17.3383 16.4454 17.1864 16.6785 16.9419 16.9243C16.6975 17.1701 16.4647 17.3216 16.1379 17.4493C15.8915 17.5455 15.5209 17.6603 14.8393 17.6928C14.101 17.7275 13.8798 17.7348 12.0105 17.7388C10.1412 17.7429 9.92074 17.7353 9.18251 17.7034M14.889 8.25877C14.8898 8.72273 15.2664 9.09822 15.7304 9.09738C16.1943 9.09654 16.5698 8.71993 16.569 8.25597C16.5681 7.792 16.1915 7.41652 15.7276 7.41736C15.7276 7.41736 15.7274 7.41736 15.7273 7.41736C15.2635 7.41834 14.8881 7.79494 14.889 8.25877ZM8.4055 12.007C8.40942 13.9922 10.0217 15.5979 12.0065 15.5941C13.9913 15.5904 15.5981 13.9782 15.5943 11.993C15.5905 10.0078 13.9778 8.40171 11.9928 8.40563C10.0077 8.40955 8.40172 10.0221 8.4055 12.007ZM9.66635 12.0045C9.66383 10.7158 10.7064 9.669 11.9951 9.66648C13.2839 9.66396 14.3306 10.7066 14.3332 11.9953C14.3357 13.284 13.2931 14.3308 12.0044 14.3333C10.7158 14.336 9.66901 13.2936 9.66635 12.0051V12.0045Z" fill="white"></path></svg></a>
					<a href="https://www.facebook.com/interiortoday" target="_blank" rel="noreferrer" aria-label="오늘의집 Facebook 링크 버튼" class="css-1a5klid"><svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="css-8n6bc3"><g clip-path="url(#clip0_21132_87052)"><path d="M23 12C23 5.92486 18.0751 1 12 1C5.92486 1 1 5.92486 1 12C1 17.4903 5.02252 22.0412 10.2812 22.8664V15.1797H7.48828V12H10.2812V9.57656C10.2812 6.81969 11.9235 5.29688 14.4361 5.29688C15.6397 5.29688 16.8984 5.51172 16.8984 5.51172V8.21875H15.5114C14.145 8.21875 13.7188 9.06674 13.7188 9.93664V12H16.7695L16.2818 15.1797H13.7188V22.8664C18.9775 22.0412 23 17.4905 23 12Z" fill="currentColor"></path><path d="M16.2818 15.1797L16.7695 12H13.7188V9.93664C13.7188 9.06674 14.145 8.21875 15.5114 8.21875H16.8984V5.51172C16.8984 5.51172 15.6397 5.29688 14.4361 5.29688C11.9235 5.29688 10.2812 6.81969 10.2812 9.57656V12H7.48828V15.1797H10.2812V22.8664C10.8413 22.9542 11.4152 23 12 23C12.5848 23 13.1587 22.9542 13.7188 22.8664V15.1797H16.2818Z" fill="white"></path></g><defs><clipPath id="clip0_21132_87052"><rect width="22" height="22" fill="white" transform="translate(1 1)"></rect></clipPath></defs></svg></a>
					<a href="https://story.kakao.com/ch/bucketplace" target="_blank" rel="noreferrer" aria-label="오늘의집 KakaoStory 링크 버튼" class="css-1a5klid"><svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="css-8n6bc3"><circle cx="12" cy="12" r="11" fill="currentColor"></circle><path d="M14.6548 6.5H9.34617C8.98953 6.5 8.70036 6.77492 8.70036 7.11427V12.4991C8.70036 12.8382 8.98953 13.1132 9.34617 13.1132H11.7936C11.7768 13.7122 11.5225 14.3691 11.1359 14.9432C10.7632 15.4965 10.1507 16.0415 9.81838 16.3021C9.80983 16.3089 9.80136 16.3154 9.79337 16.3217C9.72167 16.3871 9.66939 16.4632 9.66826 16.5686C9.66714 16.6486 9.71075 16.7105 9.75928 16.7761L9.77173 16.7896L11.4662 18.6074C11.4662 18.6074 11.549 18.6908 11.6175 18.7066C11.6948 18.7243 11.7823 18.7265 11.8429 18.6818C14.7987 16.5067 15.2256 13.7794 15.2999 12.3034C15.3001 12.295 15.3004 7.11427 15.3004 7.11427C15.3004 6.77492 15.0114 6.5 14.6548 6.5Z" fill="white"></path></svg></a>
					<a href="https://naver.me/51ckkDZh" target="_blank" rel="noreferrer" aria-label="오늘의집 NaverPost 링크 버튼" class="css-1a5klid"><svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="css-8n6bc3"><circle cx="12" cy="12" r="11" fill="currentColor"></circle><path d="M7.96631 5.76685H16.033V13.8335H7.96631V5.76685ZM12.5913 8.24889V9.81433L11.4126 8.24889H10.1381V11.3515H11.4082V9.78601L12.5872 11.3515H13.8612V8.24889H12.5913Z" fill="white"></path><path d="M7.96631 14.454H16.033L14.5204 16.3156H9.47869L7.96631 14.454Z" fill="white"></path><path d="M9.98281 16.9361H14.0161L11.9993 19.4181L9.98281 16.9361Z" fill="white"></path></svg></a>
				</div>
				<p>Copyright 2014. bucketplace, Co., Ltd. All rights reserved.</p>
			</div>
		</div>
	</footer>
</body>
</html>