<%@page import="vo.MypageShoppingOrequestVo"%>
<%@page import="vo.MypageShoppingPrequestVo"%>
<%@page import="vo.MypageShoppingListVo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%
	if(session.getAttribute("loginEmail")==null) {
%>
		<script>alert("로그인해주십시오"); location.href="Controller?command=login_form&ret_cmd=Mypage_profile_with_ozip";</script>
<%
	} 
%>    
<%
ArrayList<MypageShoppingListVo> listRet = (ArrayList<MypageShoppingListVo>) request.getAttribute("listRet");
ArrayList<MypageShoppingPrequestVo> PListRet = (ArrayList<MypageShoppingPrequestVo>) request.getAttribute("PListRet");
ArrayList<MypageShoppingOrequestVo> OListRet = (ArrayList<MypageShoppingOrequestVo>) request.getAttribute("OListRet");
int[] arr = (int[])request.getAttribute("arr");

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>마이페이지(나의쇼핑)</title>
	<link rel="stylesheet" href="css/all.css">
	<link rel="stylesheet" href="css/header.css">
	<link rel="stylesheet" href="css/footer.css">
	<link rel="stylesheet" href="css/Mypage_shopping.css">
	<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
	<script src="js/jquery-3.7.1.min.js"></script>
	<script src="js/Mypage_shopping.js"></script>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"/>
	<div class="mypage_menu_tl">
		<nav class="up MYmenu">
			<ul class="up_menu_inner">
				<li class="nav_button">
					<a class="active upb" href="Controller?command=Mypage_profile_with_ozip">프로필</a>
				</li>
				<li class="nav_button">
					<a class="active upb y_active_on_just_color" href="Controller?command=Mypage_shopping_list_form">나의 쇼핑</a>
				</li>
				<li class="nav_button">
					<a class="active upb" href="Controller?command=mypage_review_form">나의 리뷰</a>
				</li>
				<li class="nav_button">
					<a class="active upb" href="Controller?command=Mypage_setting_edit_user_info_form">설정</a>
				</li>
			</ul>
		</nav>
		<nav class="down MYmenu">
			<ul class="up_menu_inner">
				<li class="nav_button under">
					<a class="active downb b1 y_active_on" href="#">주문배송내역 조회</a>
				</li>
				<li class="nav_button under">
					<a class="active downb" href="Controller?command=likey_book">좋아요한 상품</a>
				</li>
				<li class="nav_button under">
					<a class="active downb b3" href="#">나의 문의내역</a>
				</li>
				<li class="nav_button under">
					<a class="active downb" href="Controller?command=QA">고객센터</a>
				</li>
			</ul>
		</nav>
	</div>
		<!-- 나의 쇼핑-주문배송내역 -->
		<div class="all_ol">
		<div class="order-list">
			<div class="event_banner">
				<img alt="" src="https://image.ohou.se/i/bucketplace-v2-development/uploads/exhibitions/descriptions/170202163102476603.png?gif=1&w=1920&q=100">
			</div>
			<div class="order-list_menu">
				<a href="#" class="order-list_menu_unit"><div><div class="unit_title">장바구니</div><div class="unit_value"><%=arr[0] %></div></div><span class="oarrowo"></span></a>
				<a href="#" class="order-list_menu_unit"><div><div class="unit_title">결제완료</div><div class="unit_value"><%=arr[1] %></div></div><span class="oarrowo"></span></a>
				<a href="#" class="order-list_menu_unit"><div><div class="unit_title">배송준비</div><div class="unit_value"><%=arr[2] %></div></div><span class="oarrowo"></span></a>
				<a href="#" class="order-list_menu_unit"><div><div class="unit_title">배송중</div><div class="unit_value"><%=arr[3] %></div></div><span class="oarrowo"></span></a>
				<a href="#" class="order-list_menu_unit"><div><div class="unit_title">배송완료</div><div class="unit_value"><%=arr[4] %></div></div><span class="oarrowo"></span></a>
				<a href="#" class="order-list_menu_unit"><div><div class="unit_title">구매확정</div><div class="unit_value"><%=arr[5] %></div></div></a>
			</div>
			<div class="b_product_tl">
				<!-- <div class="b_prodduct_filter_line">
					<div class="b_prodduct_filter_bar">
						<div class="filter">기간<svg class="icon" width="12" height="12" viewBox="0 0 12 12" fill="currentColor" preserveAspectRatio="xMidYMid meet"><path d="M6.069 6.72l4.123-3.783 1.216 1.326-5.32 4.881L.603 4.273l1.196-1.346z"></path></svg></div>
						<div class="filter">주문상태<svg class="icon" width="12" height="12" viewBox="0 0 12 12" fill="currentColor" preserveAspectRatio="xMidYMid meet"><path d="M6.069 6.72l4.123-3.783 1.216 1.326-5.32 4.881L.603 4.273l1.196-1.346z"></path></svg></div>
					</div>
				</div> -->
				<%for(MypageShoppingListVo vo : listRet) {%>
				<section class="b_prodduct_area" productIdx="<%=vo.getProductIdx() %>" >
					<div class="order_number_tl">
						<%if(vo.getProcessedState()=="구매확정"){ %>
						<span class="order_number"><%=vo.getOrderIdx() %><span id="ww"></span></span><%= vo.getOrderDate()%><a href="#">상세보기<span class="rarrowr"></span></a>	
						<%} else {%>
						<span class="order_number"><%=vo.getOrderIdx() %><span id="ww"></span></span><%= vo.getPaymentDate()%><a href="#">상세보기<span class="rarrowr"></span></a>
						<%} %>
					</div>
					<div class="b_prodduct_info">
						<div class="order_state"><%=vo.getProcessedState() %></div>
						<div class="b_prodduct_info_option">
							<div>
								<img src="<%=vo.getImgUrl()%>"/>
								<div>
									<a href="#"><%=vo.getBrandName()%></a><a href="#"><%=vo.getName()%></a>
								</div>
								<div class="selected_option">
									<%if(vo.getOptionValue()!=null) {%>
									<div class="option_name"><%= vo.getOptionValue()%></div>
									<%} %>
									<div class="price"><span><%= vo.getAfterPrice()%>원</span><span id="tt"></span><%=vo.getQty() %>개</div>
									<div class="deli_type">일반택배</div>
								</div>
							</div>
						</div>
						<div class="b_prodduct_info_deli">
							<div id="div_deli">선결제배송비 3,000원</div>
							<div><b><%=vo.getBrandName() %></b>🏡&nbsp;&nbsp;<a href="#">02-XXXX-XXXX</a></div>
						</div>
					</div>
				</section>
				<%} %>
			</div>
		</div>
		</div>
		<!-- 나의 쇼핑-주문배송내역끝 -->
		<!-- 나의 쇼핑-나의문의내역-상품문의 주문문의 전체 시작 -->
		<div class="all_po"> <!-- class=all -->
			<div class="myinquiry_tl">
				<div class="myinquiry_product_order all_po">
					<button class="button product y_on">상품문의</button>
					<button class="button order">주문문의</button>
				</div>
				<%if(arr[6]>0) {%>
				<div class="all_in_1"><!-- all in -->
				<% int cnt = 0;
				for(MypageShoppingPrequestVo vo : PListRet) {	%>
				<%-- <% if(vo.getOrderIdx()==-1) { %> --%>
				<%	if(cnt > 1) {%>
				<hr>
				<%} %>
				<div class="myinquiry_content all_in"><!-- 반복 -->
					<div class="myinquiry_content_title">
						<span class="myinquiry_state"><%=vo.getProcessedState() %></span><span class="myinquiry_title">상품</span><span class="myinquiry_writedate"><%=vo.getqWritedate() %></span>
					</div>
					<ul class="p_name_optioin">
						<li><span>상품</span><a href="#"><%=vo.getName() %></a></li>
						<li><span>옵션</span>
							<span>
								<%if(vo.getOption1Value()==null && vo.getOption2Value()==null && vo.getOption3Value()==null) {} 
								  else {%>
								<%=vo.getOption1Value() + vo.getOption2Value() + vo.getOption3Value() %>
								<%} %>
							</span>
						</li>
					</ul>
					<div class="myinquiry_content_content">
						<span class="mark">Q</span>
						<div>상품문의&#10;&#10;<%=vo.getQ() %></div>
					</div>
					<div class="myinquiry_content_answer_tl">
						<div class="myinquiry_content_answer"><%=vo.getA() %></div>
						<div class="myinquiry_content_answer_writer_writedate">
							<span class="writer_writedate"><%=vo.getBrandName() %></span>
							<span class="writer_writedate comma">·</span>
							<span class="writer_writedate"><%=vo.getaWritedate() %></span>
						</div>
					</div>
					<a class="delete_b" inquiryIdx="<%=vo.getInquiryIdx() %>">삭제</a>
				</div>
				<% cnt++; 
				} %>
			</div>
				<%-- <%} %> --%>
				
		<!-- 나의 쇼핑-나의문의내역-상품문의 있을때-끝 -->
		<!-- 나의 쇼핑-나의문의내역-상품문의 없을때- -->
			<%} else { %>
			<div class="all_in_2">
				<div class="no_myinquiry">
					아직 문의한 내역이 없습니다.
				</div>
			</div>
			<%}%>
		<!-- 나의 쇼핑-나의문의내역-상품문의 없을때-끝 -->
		<!-- 나의 쇼핑-나의문의내역-주문문의 있을때 -->
			<%if(arr[7]>0) {  int cnt = 0;%>
			<div class="all_in_4"><!-- all_in -->
					<%for(MypageShoppingOrequestVo vo2 : OListRet) {%>
					<%	if(cnt > 1) {%>
				<hr>
				<%} %>
				<div class="myinquiry_content">
					<div class="myinquiry_content_title">
						<span class="myinquiry_state"><%=vo2.getStatus() %></span><span class="myinquiry_title">주문</span><span class="myinquiry_writedate"><%=vo2.getqWritedate() %></span>
					</div>
					<ul class="p_name_optioin">
						<li><span>상품</span><a href="#"><%=vo2.getName() %></a></li>
						<li><span>옵션</span>
							<span>
								<%if(vo2.getOption1Value()==null && vo2.getOption2Value()==null && vo2.getOption3Value()==null) {} 
								  else {%>
								<%=vo2.getOption1Value() + vo2.getOption2Value() + vo2.getOption3Value() %>
								<%} %>
							</span>
						</li>
					</ul>
					<div class="myinquiry_content_content">
						<span class="mark">Q</span>
						<div>주문번호: <%=vo2.getOrderIdx() %>&#10;&#10;<%=vo2.getQ() %></div>
					</div>
					<div class="myinquiry_content_answer_tl">
						<div class="myinquiry_content_answer"><%=vo2.getA() %>	</div>
						<div class="myinquiry_content_answer_writer_writedate">
							<span class="writer_writedate"><%=vo2.getBrandName() %></span>
							<span class="writer_writedate comma">·</span>
							<span class="writer_writedate"><%=vo2.getaWritedate() %></span>
						</div>
					</div>
					<a class="delete_b" inquiryIdx="<%=vo2.getInquiryIdx() %>">삭제</a>
				</div>
					<%cnt++;
					} %>
			</div>
	<!-- 나의 쇼핑-나의문의내역-주문문의 있을때-끝 -->
	<!-- 나의 쇼핑-나의문의내역-주문문의 없을때 -->
			<%} else { %>
			<div class="all_in_3">
				<div class="no_myinquiry">
					주문문의 내역이 없습니다.
				</div>
			</div>
			<%} %>
		<!-- 나의 쇼핑-나의문의내역-주문문의 없을때-끝 -->	
		</div>
	</div>
	<!-- 나의 쇼핑-나의문의내역-상품문의 주문문의 전체 끝 -->
	<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>