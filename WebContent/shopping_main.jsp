<%@page import="java.text.DecimalFormat"%>
<%@page import="vo.*"%>
<%@page import="dao.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	CategoryBestDao cabeDao = new CategoryBestDao();
	ProductDao pDao = new ProductDao();
	ArrayList<ProductVo> listProductVo = (ArrayList<ProductVo>) request.getAttribute("listProductVo"); 
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>쇼핑_카테고리+베스트</title>
	<link rel ="stylesheet" href = "css/all.css">
	<link rel ="stylesheet" href = "css/header_kh.css">
	<link rel ="stylesheet" href = "css/best_product.css">
	<link rel ="stylesheet" href = "css/category.css">
	<script src="js/jquery-3.7.1.min.js"></script>
	<script>
		alert("죄송하니다. 상품 전체가 출력되기까지 시간이 조금 걸립니다. & 현재 카테고리 가구 외의 다른 부분은 작업진행중에 있습니다.")
		//헤더 검색창 색 변경
		$(function() {
			$()
			$(".search1 > input").focus(function() {
				$(".search1").addClass('click');
			});
			$(".search1 > input").blur(function() {
				$(".search1").removeClass('click');
			});

			//메뉴 밑줄
			$(".m_line").click(function(){
				$(this).addClass('on');
	  		});
			$(".m_line:nth-child(1)").addClass('on');  
			$(".category .expandable").click(function() {
				$(this).toggleClass('rotate180');
				if($(this).hasClass('rotate180'))	
					$(this).next().slideDown();		
				else 
					$(this).next().slideUp();
			});
			
			// 카테고리3선택 시, 상세페이지 이동. 
			$(".depth3>div:not(.expandable)").click(function(e) {
				e.stopPropagation();
				let cate_name3 = $(this).text();
				let cate_name2 = $(this).parents(".depth2").find("div").eq(0).text();
				let cate_name1 = $(this).parents(".depth1").find("div").eq(0).text();
				//alert("!!! : " + cate_name);
				location.href = "Controller?command=shopping_main&cate_name3=" + cate_name3 + "&cate_name2=" + cate_name2 + "&cate_name1=" + cate_name1;
				
			});
			// 카테고리2선택 시, 상세페이지 이동.
			$(".depth2>div:not(.expandable)").click(function(e) {
				e.stopPropagation();
				let cate_name2 = $(this).text();
				let cate_name1 = $(this).parents(".depth1").find("div").eq(0).text();
				//alert("!! : " + cate_name);
				location.href = "Controller?command=shopping_main&cate_name2=" + cate_name2 + "&cate_name1=" + cate_name1;
			});
			// 상품 선택
			$(".product").click(function() {
				let product_idx = Number($(this).attr("product_idx"));
				location.href = "Controller?command=product_detail&product_idx=" + product_idx;
			});
			//좋아요 버튼 누르기(ajax)
			$(".p_i_likey").click(function(e) {
				e.stopPropagation();
				let productIdx = $(this).parents(".product").attr("product_idx");
				let memberId = "<%=session.getAttribute("member_id")%>"; // TODO : 세션에 있는 값 넣기.
				let _this = $(this);
				$.ajax({
					type : 'post',
					data : {"command" : "ajax_product_likey",
							"product_idx" : productIdx,
							"member_id" : memberId},
					url : 'Controller',
					success : function(vo) {
						alert(vo.result);
						if(vo.result=="INSERTED") {
							_this.addClass('on');
						} else if(vo.result="DELETED") {
							_this.removeClass('on');
						}
					}, 
					error: function(r,s,e) {
						alert("[에러] code : " + r.status
								+ "message : " + r.responseText
								+ "error : " + e);
					}
				});
			});
		});
	</script>
</head>
<body>
<jsp:include page="header_kh.jsp" flush="true"/>
<div class="sticky-container" style="height: 52px; top:80px; position:sticky;">
		<div class="menuLine">
			<div class="menuInner">
				<nav id="topMenu">
					<ul>
						<li class="m_line on"><a href="Controller?command=shopping_main">홈</a></li>
						<li class="m_line"><a href="Controller?command=o_deal">오늘의딜</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
<main>
	<div class="content">
		<div class="contetn_inner">
			<!--카테고리-->
			<div class="category">
				<h2>가구</h2>
				<div class="depth1">
					<div class="expandable">침대</div>
					<div class="depth2">
						<div class="expandable">침대프레임</div>
						<div class="depth3">
							<div>일반침대</div>
							<div>수납침대</div>
							<div>저상형침대</div>
							<div>패밀리침대</div>
							<div>이층·벙커침대</div>
							<div>하단매트리스·파운데이션</div>
							<div>모션베드</div>
							<div>돌침대·흙침대</div>
							<div>접이식침대</div>
						</div>						
						<div class="expandable">침대+매트리스</div>
						<div class="depth3">
							<div>일반침대</div>
							<div>수납침대</div>
							<div>저상형침대</div>
							<div>패밀리침대</div>
							<div>이층·벙커침대</div>
							<div>투매트리스</div>
							<div>모션베드</div>
							<div>침대부속가구</div>
						</div>
					</div>
					<!-- 패턴 끝: 아래는 위와 동일한 패턴으로 작성함 (아래는 분석할 필요 없어요) -->					
					<div class="expandable">매트리스·토퍼</div>
					<div class="depth2">
						<div class="expandable">매트리스</div>
						<div class="depth3">
							<div>스프링매트리스</div>
							<div>라텍스매트리스</div>
							<div>폼매트리스</div>
						</div>
						<div>토퍼</div>
					</div>
					<div class="expandable">테이블·식탁·책상</div>
					<div class="depth2">
						<div>거실·소파테이블</div>
						<div>사이드테이블</div>
						<div class="expandable">식탁</div>
						<div class="depth3">
							<div>식탁·입식테이블</div>
							<div>홈바·아일랜드식탁</div>
							<div>식탁+의자</div>
						</div>	
						<div class="expandable">책상</div>
						<div class="depth3">
							<div>일반책상</div>
							<div>좌식책상</div>
							<div>모션·스탠딩책상</div>
							<div>독서실책상</div>
							<div>학원·사무용책상</div>
						</div>	
						<div class="expandable">좌식테이블</div>
						<div class="depth3">
							<div>접이식테이블</div>
							<div>비접이식테이블</div>
							<div>교자상</div>
						</div>	
					</div>
					<div class="expandable">소파</div>
					<div class="depth2">
						<div>일반소파</div>
						<div>리클라이너</div>
						<div>소파베드</div>
						<div>좌식소파</div>
						<div>소파스툴</div>
					</div>
					<div class="expandable">서랍·수납장</div>
					<div class="depth2">
						<div>서랍장</div>
						<div>수납장</div>
						<div>캐비닛</div>
						<div class="expandable">주방수납장</div>
						<div class="depth3">	
							<div>렌지대</div>
							<div>그릇장</div>
							<div>상부장</div>
							<div>하부장</div>
							<div>키큰장</div>
							<div>상부장+하부장</div>
						</div>
						<div>협탁</div>
					</div>
					<div class="expandable">거실장·TV장</div>
					<div class="depth2">
						<div>일반거실장</div>
						<div>높은거실장·사이드보드</div>
						<div>TV스탠드</div>
					</div>
					<div class="expandable">선반</div>
					<div class="depth2">
						<div class="expandable">벽선반</div>
						<div class="depth3">
							<div>무지주선반</div>
							<div>지주선반</div>
							<div>찬넬선반</div>
						</div>
						<div>스탠드선반</div>
						<div>앵글·조립식선반</div>
					</div>
					<div class="expandable">진열장·책장</div>
					<div class="depth2">
						<div>진열장·장식장</div>
						<div>책장</div>
						<div>매거진랙</div>
					</div>
					<div class="expandable">의자</div>
					<div class="depth2">
						<div>인테리어의자</div>
						<div>스툴·벤치</div>
						<div>빈백</div>
						<div>안락의자</div>
						<div>흔들의자</div>
						<div>학생·사무용의자</div>
						<div>게이밍의자</div>
						<div>좌식의자·자세보정의자</div>
						<div>바체어</div>
						<div>발받침</div>
					</div>
					<div class="expandable">행거·옷장</div>
					<div class="depth2">
						<div>옷장</div>
						<div>붙박이장</div>
						<div>드레스룸</div>
						<div class="expandable">헹거</div>
						<div class="depth3">
							<div>고정·설치형행거</div>
							<div>이동식행거</div>
							<div>스탠드행거</div>
							<div>스탠드형옷걸이</div>
						</div>
					</div>
					<div class="expandable">거울</div>
					<div class="depth2">
						<div>전신거울</div>
						<div>벽거울</div>
						<div>탁상거울</div>
					</div>
					<div class="expandable">화장대·콘솔</div>
					<div class="depth2">
						<div>일반화장대</div>
						<div>수납화장대</div>
						<div>좌식·미니화장대</div>
						<div>접이식화장대</div>
						<div>콘솔</div>
						<div>화장대+의자</div>
					</div>
					<div class="expandable">유아동가구</div>
					<div class="depth2">
						<div class="expandable">침대</div>
						<div class="depth3">
							<div>일반침대</div>
							<div>벙커침대</div>
							<div>이층침대·이단침대</div>
							<div>아기침대·범퍼침대</div>
						</div>
						<div class="expandable">수납장·옷장</div>
						<div class="depth3">
							<div>서랍장·수납장</div>
							<div>옷장</div>
							<div>책장·책꽂이</div>
							<div>교구장·장난감정리함</div>
						</div>
						<div class="expandable">책상</div>
						<div class="depth3">
							<div>입식책상</div>
							<div>좌식공부상</div>
						</div>
						<div class="expandable">의자·소파</div>
						<div class="depth3">
							<div>일반의자·책상의자</div>
							<div>소파·빈백</div>
							<div>아기의자</div>
						</div>
						<div>놀이기구</div>
						<div>안전문·침대가드</div>
					</div>
					<div class="expandable">야외가구</div>
					<div class="depth2">
						<div>야외테이블</div>
						<div>야외테이블+의자</div>
						<div>야외의자</div>
						<div>창고·파라솔·기타</div>
					</div>
					<div class="expandable">가벽·파티션</div>
					<div class="depth2">
						<div>인테리어파티션</div>
						<div>사무용파티션</div>
					</div>
					<div class="expandable">공간별가구</div>
					<div class="depth2">
						<div class="expandable">거실</div>
						<div class="depth3">
							<div>소파</div>
							<div>거실장·TV장</div>
							<div>거실·소파테이블</div>
							<div>사이드테이블</div>
							<div>식탁·입식테이블</div>
							<div>인테리어의자</div>
							<div>선반</div>
							<div>수납장</div>
						</div>
						<div class="expandable">침실</div>
						<div class="depth3">
							<div>침대프레임</div>
							<div>침대+매트리스</div>
							<div>매트리스</div>
							<div>토퍼</div>
							<div>협탁</div>
							<div>화장대</div>
							<div>화장대+의자</div>
							<div>거울</div>
							<div>수납장</div>
						</div>
						<div class="expandable">주방</div>
						<div class="depth3">
							<div>식탁</div>
							<div>홈바·아일랜드식탁</div>
							<div>식탁+의자</div>
							<div>식탁의자</div>
							<div>바체어</div>
							<div>렌지대</div>
							<div>그릇장</div>
							<div>상·하부장 단품</div>
							<div>상·하부장 세트</div>
							<div>키큰장</div>
							<div>선반</div>
						</div>
						<div class="expandable">옷장·드레스룸</div>
						<div class="depth3">
							<div>옷장</div>
							<div>붙박이장</div>
							<div>드레스룸</div>
							<div>행거</div>
							<div>서랍장</div>
							<div>전신거울</div>
							<div>벽거울</div>
							<div>탁상거울</div>
						</div>
						<div class="expandable">서재·공부방</div>
						<div class="depth3">
							<div>일반책상</div>
							<div>스탠딩책상</div>
							<div>독서실책상</div>
							<div>좌식책상</div>
							<div>학생·사무용의자</div>
							<div>게이밍체어</div>
							<div>인테리어의자</div>
							<div>책장</div>
							<div>스탠드선반</div>
						</div>
						<div class="expandable">아이방</div>
						<div class="depth3">
							<div>침대</div>
							<div>수납장·옷장</div>
							<div>책상</div>
							<div>의자·소파</div>
							<div>안전문·침대가드</div>
						</div>
					</div>
				</div>
				<div class="separator"></div>
				<h2>패브릭</h2>
				<h2>가전·디지털</h2>
				<h2>주방용품</h2>
				<h2>식품</h2>
				<h2>데코·식물</h2>
				<h2>조명</h2>
				<h2>수납·정리</h2>
				<h2>생활용품</h2>
				<h2>생필품</h2>
				<h2>유아·아동</h2>
				<h2>반려동물</h2>
				<h2>캠핑·레저</h2>
				<h2>공구·DIY</h2>
				<h2>인테리어시공</h2>
				<h2>렌탈</h2>
				<h2>장보기</h2>
				<h2>혼수·신혼</h2>
			</div>
			<!--오른쪽메인내용-->
			<div class="r_content">
				<div class="a_product">
				<% if(listProductVo.size()==0) { %>
					<h1 style="width:400px; margin:auto; color:grey;">해당 카테고리 상품이 없습니다.</h1>
				<% } %>
				<% 
					int idx = 1;
				%> 
				<%
					for(ProductVo vo : listProductVo) {
						ArrayList<ProductMainImgVo>  listMainImg = pDao.getListProductMainImgVo(vo.getProductIdx());
						String strImageMain = listMainImg.get(0).getImgUrl();
				%>
					<div class="product fl" product_idx="<%=vo.getProductIdx()%>">
						<div class="p_img">
							<div class="p_num">
							<% 
								if(idx <= 3) {
							%>
								<svg width="26" height="30" fill="none"><path fill-rule="evenodd" clip-rule="evenodd" d="m13 24.25-13 5V0h26v29.25l-13-5Z" fill="rgba(53, 197, 240, 0.86)"></path></svg>
								<span class="pc_no"><%= idx %></span>
							<%
								} else {
							%>
								<svg width="26" height="30" fill="none"><path fill-rule="evenodd" clip-rule="evenodd" d="m13 24.25-13 5V0h26v29.25l-13-5Z" fill="rgba(190, 190, 190, 0.86)"></path></svg>
								<span class="pc_no"><%= idx %></span>
							<%
								}
								idx++;
							%>	
							</div>
							<img class="image" alt="" src="<%=strImageMain%>"/>
							<div class="p_i_likey">
								<svg class="icon icon--stroke" aria-label="좋아요" width="24" height="24" fill="currentColor" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" preserveAspectRatio="xMidYMid meet"><path d="M23.22 7.95c.4 4.94-2.92 9.71-10.92 13.85a.47.47 0 0 1-.42 0C3.88 17.66.56 12.9.96 7.93 1.54 2.48 8.28.3 12.1 4.7c3.8-4.4 10.55-2.22 11.13 3.25z"></path></svg>
							</div>
						</div>
						<div class="p_con">
							<div class="p_c_1">
								<span class="pc_1_1"><%=vo.getBrandName() %></span>
								<span class="pc_1_2"><%=vo.getName() %></span>
							</div>
							<div class="p_c_2">
								<span class="pc_2_1"><%=vo.getDiscount() %>
									<span class="pc2_per">%</span>
								</span>
								<span class="pc_2_2"><%=new DecimalFormat("###,###").format(vo.getAfterPrice()) %></span>
							</div>
							<div class="p_c_3">
								<svg class="icon" width="24" height="24" viewBox="0 0 24 24" preserveAspectRatio="xMidYMid meet"><path fill="currentColor" fill-rule="evenodd" d="M12 19.72l-5.677 2.405c-.76.322-1.318-.094-1.247-.906l.533-6.142-4.042-4.656c-.54-.624-.317-1.283.477-1.467l6.006-1.39L11.23 2.28c.426-.707 1.122-.699 1.542 0l3.179 5.282 6.006 1.391c.805.187 1.011.851.477 1.467l-4.042 4.656.533 6.142c.072.822-.497 1.224-1.247.906L12 19.72z"></path></svg>
								<span class="pc3_st"><%=vo.getStarReviewAvg() %></span>
								<span class="pc3_re">리뷰 <%=pDao.getCountReviewByProductIdx(vo.getProductIdx()) %></span>
							</div>
							<div class="p_c_4">
								<% if("가전·디지털".equals(cabeDao.getDepth1ByCategoryIdx(vo.getCategory()))) { %>
									<img src="https://assets.ohou.se/web/dist/media/assets/icons/ic-third-party-logistic-424d7e1cdf3e1f2ac518a6a269f09e12.png" class="icon"/>
								<% } %>
							</div>
							<div class="p_c_5">
								<svg class="icon" aria-label="무료배송" width="47" height="20" viewBox="0 0 47 20" preserveAspectRatio="xMidYMid meet"><g fill="none" fill-rule="evenodd"><rect width="47" height="20" fill="#000" fill-opacity=".07" fill-rule="nonzero" rx="4"></rect><path fill="#757575" d="M12.73 5.38v3.96h-6.6V5.38h6.6zm-2.68 9.43H8.76v-3.25H5v-1.03h8.86v1.03h-3.81v3.25zm1.4-6.49V6.41H7.43v1.91h4.04zm11.08 2.7h-1.42v1.54h2.26v1.02h-8.86v-1.02h2.24v-1.53h-1.1V7.78h5.32V6.65H15.6V5.63h6.66V8.8h-5.33v1.18h5.61v1.04zm-4.53 0v1.54h1.87v-1.53H18zm14.37 3.78h-1.23V9.86h-.8v4.49h-1.2V5.18h1.2v3.66h.8V5h1.23v9.8zm-4.2-2.54h-3.9V6.01h1.27v2.26h1.36V6h1.28v6.26zm-1.27-1.01v-2h-1.36v2h1.36zm14.49 1.71c0 1.13-1.25 1.82-3.41 1.82s-3.42-.7-3.42-1.82 1.25-1.82 3.4-1.82c2.18 0 3.43.7 3.43 1.82zm-3.41-6.05c-.5 1.13-2.1 1.9-3.51 2.1l-.54-1c1.64-.17 3.39-1.06 3.39-2.54V5.2h1.33v.28c0 1.48 1.99 2.47 3.4 2.53l-.55 1.01c-1.31-.18-3.03-.97-3.52-2.1zm4.42 3.78h-8.86V9.66h3.79V8.4h1.29v1.26h3.78v1.03zm-2.33 2.27c0-.5-.83-.8-2.1-.8s-2.08.3-2.08.8c0 .51.81.8 2.08.8s2.1-.29 2.1-.8z"></path></g></svg>
								<svg class="icon" aria-label="특가" width="30" height="20" viewBox="0 0 30 20" preserveAspectRatio="xMidYMid meet"><rect width="30" height="20" fill="#F77" rx="4"></rect><path fill="#fff" d="M12.83 7.93v-.97H7.93v-.555h5.228v-.991H6.655v4.063h6.59v-.992H7.928V7.93h4.901zm-6.295 3.747v1.002h5.326v2.037h1.274v-3.04h-6.6zm7.733-.588v-1.024H5.5v1.024h8.768zM23.91 9.782V8.725h-1.405V5H21.24v9.705h1.264V9.782h1.405zm-3.954-3.79h-4.53v1.056h3.147c-.174 1.938-1.623 3.975-3.736 4.945l.773.958c2.974-1.612 4.259-4.03 4.346-6.96z"></path></svg>
							</div>
							<div class="p_c_6">
								<img src="https://image.ohou.se/i/bucketplace-v2-development/static/productions/card-promotion-badge.png?w=36&amp;w=40&amp;h=32">
								<span class="pc_6_1">최대 5% 결제할인</span>
							</div>
						</div>
					</div>
					<% 
						}
					%>
				</div>
			</div>
		</div>
	</div>
</main>	
</body>
</html>