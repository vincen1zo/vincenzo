<%@page import="java.text.DecimalFormat"%>
<%@page import="vo.BasketVo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("loginEmail")==null) {
%>
	<script>alert("로그인해주십시오"); location.href="Controller?command=login_form&ret_cmd=basket";</script>
<%
	} 
%>        
<%
	DecimalFormat decFormat = new DecimalFormat("###,###");
	String memberId = (String)request.getAttribute("memberId");
	ArrayList<BasketVo> listBasket = (ArrayList<BasketVo>)request.getAttribute("listBasket"); 
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta charset="UTF-8">
	<link rel ="stylesheet" href = "css/all.css">
	<link rel ="stylesheet" href = "css/header.css">
	<link rel ="stylesheet" href = "css/footer.css">
	<link rel ="stylesheet" href = "css/basket.css">
	<script src="js/jquery-3.7.1.min.js"></script>
	<script src="js/header_search.js"></script>
	<script src="js/basket.js"></script>
	<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	<title>장바구니</title>
	<script>
	alert("현재는 select만 작업된 상태입니다.");
		function requestPay(price) {
		    // IMP.request_pay(param, callback) 결제창 호출
		    var uid = '';
		    IMP.init('imp03731685');
		    IMP.request_pay({ // param
		        pg: 'kakaopay',
		        pay_method: "card",
		        merchant_uid: "merchant_" + new Date().getTime(), //가맹점 주문번호 (아임포트를 사용하는 가맹점에서 중복되지 않은 임의의 문자열을 입력)
		        name: "남의집 상품구매", //결제창에 노출될 상품명
		        amount: price, //금액
		        buyer_email : "<%=memberId%>", 
		        buyer_name : "<%=memberId%>",
		        buyer_tel : "1234-1234",
		    }, function (rsp) { // callback
		        if (rsp.success) { // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
		        	alert("결제되었습니다.");   
		    		location.href = "Controller?command=mypage_review_form"; //주소수정하기
	            } else {
	                alert("결제에 실패하였습니다! / 에러 내용: " +  rsp.error_msg + "error");
	            }
	        });
		}	
		$(function(){
			$("#btn_purchase").click(function() {
				let total_price = $(this).prev().find("#final_price").text().replaceAll(",","").replaceAll("원","");
				alert(total_price + "원을 결제합니다.");
				requestPay(total_price);
			});
		});
	</script>
</head>
<body>
<!--header-->
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
					<input type = "text" placeholder = "통합검색(작업중)"/>
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

<!--main-->
<main>
	<div class="content">
		<div class="div_l">
			<div class="header">
				<div>
					<label class="blue_check">
						<input type="checkbox"/>
						<span><svg width="1em" height="1em" viewBox="0 0 16 16" class="_2UftR"><path fill="currentColor" d="M6.185 10.247l7.079-7.297 1.435 1.393-8.443 8.703L1.3 8.432l1.363-1.464z"></path></svg></span>
					</label>
					<span>모두선택</span>
				</div>
				<div>
					<span>품절 모두 삭제</span>
					<span class="vertical"></span>
					<span>선택삭제</span>
				</div>
			</div>
			<!---------------(item 시작)------------------------>
			<% for(BasketVo vo : listBasket) { %>
			<div class="item" order_idx="<%=vo.getOrderIdx()%>">
				<div class="item_header">
					<%=vo.getBrandName() %> 배송
				</div>
				<div class="item_content">           
					<div class="content_l fl">
						<div>
							<label class="blue_check">
								<input type="checkbox"/>
								<span><svg width="1em" height="1em" viewBox="0 0 16 16" class="_2UftR"><path fill="currentColor" d="M6.185 10.247l7.079-7.297 1.435 1.393-8.443 8.703L1.3 8.432l1.363-1.464z"></path></svg></span>
							</label>
						</div>
					</div>
					<div class="content_r fl">
						<div class="today_o">
<!-- 							<img src="images/ico_departure_today.png"/> -->
							<span></span><!-- 평일 15:30까지 결제시 -->
							<span></span><!--오늘출발 마감  -->
							<span></span><!--12/13 (수) 발송 예정  -->
						</div>
						<button class="btn_x">
							<svg width="12" height="12" viewBox="0 0 12 12" fill="currentColor" preserveAspectRatio="xMidYMid meet"><path fill-rule="nonzero" d="M6 4.6L10.3.3l1.4 1.4L7.4 6l4.3 4.3-1.4 1.4L6 7.4l-4.3 4.3-1.4-1.4L4.6 6 .3 1.7 1.7.3 6 4.6z"></path></svg>
						</button>
						<!-- the 3rd div: 이미지와 상품명 -->
						<div class="ja_product_idx" productIdx=<%=vo.getProductIdx() %>>
							<div class="fl">
								<img src="<%=vo.getImgUrl()%>"/>
							</div>
							<div class="fl">
								<h1>[<%=vo.getBrandName() %>] <%=vo.getName() %></h1>
								<p><%=vo.getDeliCost() %> | <%=vo.getDeli() %></p>
							</div>
							<div style="clear:both;"></div>
						</div>
						<!-- the 4th div: div4qty -->
						<div class="div4qty">
							<span class="soldout_badge">품절</span>
							<% if(vo.getOption1Value() != null ) { %>
							<h1><%=vo.getOption1Value() %></h1>
							<% } %>
							<% if(vo.getOption1Value() == null ) { %>
							<h1><%=vo.getName() %></h1>
							<% } %>
							<div class="btn_x2"></div>
							<% String optionPrice = decFormat.format(vo.getOption1Price()); %>
							<p class="unit_price"><%=optionPrice %>원</p>
							<div class="qty_box">
								<span class="btn_minus"></span>
<%-- 								<span><%=vo.getQty() %></span> --%>
								<input type='text' class="qty" value="<%=vo.getQty()%>">
								<span class="btn_plus"></span>
							</div>
						</div>
						<div class="div_bottom">
							<span class="fl"></span><!--옵션변경  -->
							<span class="fl"></span><!-- 바로구매 -->
							<span class="fr  item_price"><%=optionPrice %>원</span>
							<div style="clear:both;"></div>
						</div>
					</div>
					<div style="clear:both;"></div>
				</div>
				<div class="item_footer">
				<% if(vo.getFreeDeli() != 0) { %>
					<div>배송비 3,000원</div>
				<% } %>
				<% if(vo.getFreeDeli() == 0) { %>
					<div>배송비 무료</div>
				<% } %>
				</div>
			</div>
			<!---------------(item 끝)------------------------>
		</div>
		<div class="div_r">
			<div class="summary_box">
				<div class="summary_item">
					<span>총 상품금액</span>
					<span id="product_total"><%=optionPrice %>원</span>
				</div>
				<div class="summary_item">
					<span>총 배송비</span>
					<span>+ 0원</span><!-- + 12,000원 -->
				</div>
				<div class="summary_item">
					<span>총 할인금액</span>
					<span>- 0원</span><!-- - 24,500원 -->
				</div>
				<div class="summary_item">
					<span>결제금액</span>
					<span id="final_price"><%=optionPrice %>원</span>
				</div>
			</div>
			<button id="btn_purchase">상품 구매하기</button><!-- 개 상품 구매하기 -->
		</div>
		<% } %>
	</div>
</main>
<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>