<%@page import="vo.ProductDetailVo"%>
<%@page import="vo.ProductDetailImgVo"%>
<%@page import="vo.ProductOption1Vo"%>
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
	String memberId = "또랑이";
	
	int productIdx = (Integer) request.getAttribute("productIdx");
	ProductVo pVo = (ProductVo) request.getAttribute("pVo");
	ProductDetailVo pDetailVo = (ProductDetailVo) request.getAttribute("pDetailVo");
	String[] arrCategoryStr = (String[]) request.getAttribute("arrCategoryStr");
	ArrayList<ProductMainImgVo> listProductMainImgVo = (ArrayList<ProductMainImgVo>) request.getAttribute("listProductMainImgVo");
	ArrayList<ProductDetailImgVo> listProductDetailImgVo = (ArrayList<ProductDetailImgVo>) request.getAttribute("listProductDetailImgVo");
	String strOption1Text = (String) request.getAttribute("strOption1Text");
	ArrayList<ProductOption1Vo> listProductOption1Vo = (ArrayList<ProductOption1Vo>) request.getAttribute("listProductOption1Vo"); 
	int danIlOptionIdx = (Integer) request.getAttribute("danIlOptionIdx");
	int likeCount = (Integer) request.getAttribute("likeCount");
	int reviewCount = (Integer) request.getAttribute("reviewCount");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품상세페이지</title>
	<link rel="stylesheet" href="css/all.css">
	<link rel="stylesheet" href="css/product_de.css"/>
	<link rel="stylesheet" href="css/Mypage_shopping.css">	<!-- 상품_detail_page_상품정보,리뷰,문의 메뉴바 -->
	<link rel="stylesheet" href="css/Product_detail_page.css">
	<link rel="stylesheet" href="css/footer.css">
	<script src="js/jquery-3.7.1.min.js"></script>
	<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	<script>
	alert("상품 상세 내 리뷰, 문의, 배송및환불 부분 현재 작업중입니다.");
	function update_total_price() {
		let new_price = 0;
		$("li .kh_dprb1_sep").each(function(idx, item) {
			new_price += Number($(item).text().replace("원",""));
		});
		$("#total_price").text(new_price);
	}	
	
	function requestPay(price, order_idx) {
	    var uid = '';
	    IMP.init('imp03731685');
	    IMP.request_pay({ // param
	        pg: 'kakaopay',
	        pay_method: "card",
	        merchant_uid: "merchant_" + new Date().getTime(),
	        name: "남의집 상품구매",
	        amount: price, //금액
	        buyer_email : "<%=memberId%>", 
	        buyer_name : "<%=memberId%>",
	        buyer_tel : "1234-1234",
	    }, function (rsp) {
	        if (rsp.success) {
	    		$.ajax({
					url: "PayUpdateBasketServlet",
					type: "post",
					data: {
						command: "pay_update_basket",
						order_idx: order_idx
					},
					success: function(data) {
						console.log(data);
						if(data.result==1) {
							alert("결제 완료되었습니다. 두두둥!");         
							location.href = "community_main.jsp";
						}
					}
	    		});
	            } else {
	                alert("결제에 실패하였습니다! / 에러 내용: " +  rsp.error_msg + "error");
	            }
	        });
		}	
	
		$(function() {
			$(".kh_dp_img > img").attr("src", "<%=listProductMainImgVo.get(0).getImgUrl()%>");
			
			$(".kh_dprb3_1").click(function() {
				alert("준비중입니다. - 장바구니");
			});
			
			$(document).on("click", ".kh_dprb1_so_del", function() {
				$(this).parents("li").remove();
				update_total_price();
			});
			
			$("#btn_pay").click(function() {
				let order_str = ""; 
				
				$(".kh_dprb1_2 li").each(function(idx, item) {
					let option_idx = Number($(item).find("div").attr("option_idx"));
					let qty = Number($(item).find(".kh_dprb1_sen_num").text());
					if(order_str.length>0) 
						order_str += "/";
					order_str += (option_idx + "_" + qty);
				});
				
				let total_price = $("#total_price").text();
				$.ajax({
					url: "PayInsertBasketServlet",
					type: "post",
					data: { command: "pay_insert_basket", 
							order_str: order_str,
							product_idx : <%=productIdx%>,
							payment : "카카오페이",
							total_price : total_price
					},
					success: function(data) {
						if(data.result==1) {
							alert(total_price + "원을 결제합니다");
							requestPay(total_price, data.order_idx);
						}
					}
				});

				let product_idx = <%=productIdx%>;
			});
			
			$(document).on("click", ".kh_dprb1_sel_op .kh_dprb1_sen_pl", function() {
				let current_num = Number($(this).prev().text());
				$(this).prev().text(current_num + 1);

				let unit_price = Number($(this).parents(".kh_dprb1_sel_op").attr("unit_price"));
				let new_price = unit_price * (current_num + 1);
				$(this).parents(".kh_dprb1_sel_op").find(".kh_dprb1_sep").text(new_price);
				
				update_total_price();
			});
			
			$(document).on("click", ".kh_dprb1_sel_op .kh_dprb1_sen_mi", function() {
				let current_num = Number($(this).next().text());
				if(current_num-1 < 1) return;
				$(this).next().text(current_num - 1);

				let unit_price = Number($(this).parents(".kh_dprb1_sel_op").attr("unit_price"));
				let new_price = unit_price * (current_num - 1);
				$(this).parents(".kh_dprb1_sel_op").find(".kh_dprb1_sep").text(new_price);
				
				update_total_price();
			});
			
			$(".kh_dprb1_opt").change(function() {
				let selected = $(this).val();
				if(selected=="") return;
				let price = selected.split("_")[0];
				let name = selected.split("_")[1];
				let option_idx = selected.split("_")[2];

				let cnt = 0;
				$(".kh_dprb1_2 div.kh_dprb1_sel_op").each(function(idx, item) {
					let o_idx = $(item).attr("option_idx");
					if(o_idx==option_idx) 
						cnt++;
				});
				if(cnt>0) {
					alert("이미 선택한 옵션입니다.");
					return;
				}
				
				// <li> 요소 추가.
				let str1 = '<li>'
					+'<div class="kh_dprb1_sel_op" option_idx="'+ option_idx + '" unit_price=' + price + '>'
					+'	<h2 class="kh_dprb1_so_name">' + name + '</h2>'
					+'	<button class="kh_dprb1_so_del">'
					+'		<span class="kh_dprb1_sd"></span>'
					+'	</button>'
					+'	<div class="kh_dprb1_so_else">'
					+'		<div class="kh_dprb1_se_num">'
					+'			<span class="kh_dprb1_sen_mi"></span>'
					+'			<button class="kh_dprb1_sen_num">1</button>'
					+'			<span class="kh_dprb1_sen_pl"></span>'
					+'		</div>'
					+'		<div class="kh_dprb1_se_price">'
					+'			<span class="kh_dprb1_sep">'
					+'				' + price
					+'				<span>원</span>'
					+'			</span>'
					+'		</div>'
					+'	</div>'
					+'</div>'
					+'</li>';
				$(".kh_dprb1_2").append(str1);
				
				update_total_price();
			});
			
			//메뉴 밑줄
			$(".m_line").click(function(){
				$(this).addClass('on');
			});
			//
			$(".jy_product_btn").click(function(){
				$('.jy_product_btn').removeClass("y_active_on");
				$(this).addClass('y_active_on');
			});
			//상품정보 태그 고정
			$(window).scroll(function () {
				console.log($(window).scrollTop());
				if($(window).scrollTop() >= 895){
					$('.jy_product_detail_info_menubar_tl').addClass('fixed');
				}
				if($(window).scrollTop() <= 896) {
					$('.jy_product_detail_info_menubar_tl').removeClass('fixed');
				}
				if($(window).scrollTop() >= 900){
					$('.jy_product_buying_tl_sticky').addClass('sticky');
				}
				if($(window).scrollTop() <= 901) {
					$('.jy_product_buying_tl_sticky').removeClass('sticky');
				}
			});
			//  사진 위에 마우스 쓱
			$(".kh_dp_coverimg li").mouseenter(function() {
				let img_src = $(this).find("img").attr("src");
				$(".kh_dp_img img").attr("src", img_src);
			});
			
			//문의하기 버튼
			$(".ja_qa_write_btn").click(function() {
				$(".kh_qa_write_btn_box_modal").show();
			});
			//문의유형 버튼			
		});
	</script>
</head>
<body>
	<jsp:include page="header_kh.jsp" flush="true"/>
	<div id="container">
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
				<% if(danIlOptionIdx==-1) { %>
					<div class="kh_d_product">
				<% } else { %>
					<div class="kh_d_product" danil_option_idx="<%=danIlOptionIdx%>">
				<% } %>
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
											<span class="kh_dprt_lcount"><%=likeCount %></span>
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
	double[] arrStars = new double[5]; 
	int idx = 0; 
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
											<span class="kh_dprt2_re_c"><%=reviewCount %></span>
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
	String strDate = ""; 
	Calendar cal = Calendar.getInstance();
	cal.add(Calendar.DATE, 2); 
	strDate = arrDate[cal.get(Calendar.DAY_OF_WEEK)-1];
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
									<% if(danIlOptionIdx==-1) { %>
										<option value=""><%=strOption1Text %></option>
										<!-- 아아악!!!! -->
										<%
										for(ProductOption1Vo vo : listProductOption1Vo) {
										%>
											<option value="<%=vo.getOption1Price()%>_<%=vo.getOption1Value()%>_<%=vo.getOptionIdx() %>" ><%=vo.getOption1Value()%>(<%=vo.getOption1Price()%>원)</option>
										<%
										}
										%>
									<% } else if(danIlOptionIdx>-1) { %>
										<option value="">선택</option>
										<option value="<%=listProductOption1Vo.get(0).getOption1Price() %>_단일상품_<%=danIlOptionIdx%>">단일상품 (<%=listProductOption1Vo.get(0).getOption1Price() %>)</option>
									<% } %>
									</select>
								</div>
								<ul class="kh_dprb1_2">
								</ul>
							</section>
							<p class="kh_dprb_2">
								<span class="kh_dprb2_1">주문금액</span>
								<span class="kh_dprb2_2">
									<span id="total_price">0</span>원
								</span>
							</p>
							<div class="kh_dprb_3">
								<button type="button" class="kh_dprb3_1">장바구니</button>
								<button type="button" id="btn_pay" class="kh_dprb3_2">바로구매</button>
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
					<% for(ProductDetailImgVo vo : listProductDetailImgVo) { %>
						<img class="jy_product_selling_description__notice_image jy_img_size" src="<%=vo.getImgUrl()%>"/>
						<% if(vo.getImgUnderText()!=null) { %>
							<%=vo.getImgUnderText()%>
						<% } %>
 					<% } %>
					</div>
					<table class="jy_product_table">
						<tbody class="jy_product_tbody">
							<% if(pDetailVo.getModelName()!=null) { %>
							<tr class="jy_product_tr">
								<th class="jy_product_th">품명 및 모델명</th> 
								<td class="jy_product_td"><%=pDetailVo.getModelName() %></td>
							</tr>
							<% } %>
							<% if(pDetailVo.getLawCertified()!=null) { %>
							<tr class="jy_product_tr">
								<th class="jy_product_th">법에 의한 인증ㆍ허가 등을 받았음을 확인할 수 있는 경우 그에 대한 사항</th>
								<td class="jy_product_td"><%=pDetailVo.getLawCertified() %></td>
							</tr>
							<% } %>
							<% if(pDetailVo.getCountry()!=null) { %>
							<tr class="jy_product_tr">
								<th class="jy_product_th">제조국 또는 원산지</th>
								<td class="jy_product_td"><%=pDetailVo.getCountry() %></td>
							</tr>
							<% } %>
							<% if(pDetailVo.getManufacturer()!=null) { %>
							<tr class="jy_product_tr">
								<th class="jy_product_th">제조자, 수입품의 경우 수입자를 함께 표기</th>
								<td class="jy_product_td"><%=pDetailVo.getManufacturer() %></td>
							</tr>
							<% } %>
							<% if(pDetailVo.getAsNumber()!=null) { %>
							<tr class="jy_product_tr">
								<th class="jy_product_th">A/S 책임자와 전화번호 또는 소비자 상담 관련 전화번호</th>
								<td class="jy_product_td"><%=pDetailVo.getAsNumber() %></td>
							</tr>
							<% } %>
  						</tbody>
					</table>
				</div>
			</div>
		<!------------------------- 상품페이지 상세 정보 사진 리뷰등등 끄읕 ----------------------------------->
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
							<p class="ja_answer_content">안녕하세요, 아엠홈입니다. 소량 재입고 되어 아엠홈 공식 홈페이지에서만 구매 가능합니다. 
										https://www.immhome.co.kr/?pn=product.view&amp;cuid=&amp;pcode=L7476-I2635-F5696 감사합니다.
							</p>
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
	</main>
	<jsp:include page="footer.jsp" flush="true"/>
	</div>
</body>
</html>
