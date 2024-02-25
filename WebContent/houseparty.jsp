<%@page import="vo.*"%>
<%@page import="dao.HousepartyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>
<%
	ArrayList<HousepartyVo> listHouseparty = (ArrayList<HousepartyVo>) request.getAttribute("listHouseparty");
	String paramFiltering = request.getParameter("filtering"); 
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>인테리어의 시작은 예쁜 집 구경부터! 오늘의집 집들이</title>
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
	<link rel="stylesheet" href="css/houseparty.css"/>
	<link rel="stylesheet" href="css/footer.css"/>
	<script src="js/jquery-3.7.1.min.js"></script>
	<script> 
		$(function() {
			$(".kh_subfilter_btn").click(function() {
				$(this).toggleClass('on');
			});
			$(".kh_sub_filter > span").click(function() {
				$(this).toggleClass('on');
			});
			$("#div_select_box .sub_select").click(function() {
				let idx = $("#div_select_box .sub_select").index(this);
				let cls = "";
				if(idx==0) cls="sorting";
				else if(idx==1) cls="housetype";
				else if(idx==2) cls="py";
				else if(idx==3) cls="budget";
				else if(idx==4) cls="fmtype";
				else if(idx==5) cls="style";
				else if(idx==6) cls="detailpart";
				else if(idx==7) cls="part";
				else if(idx==8) cls="partner";

				if($(".kh_filter ." + cls).css("display") != "flex") {
					$(".kh_filter > div").css("display", "none");
					$(".kh_filter ." + cls).css("display", "flex");
				} else {
					$(".kh_filter ." + cls).css("display", "none");
				}
			});
			$(".content_inner").click(function() {
				let houseparty_idx = $(this).attr("houseparty_idx");
				location.href = "Controller?command=houseparty_detail&houseparty_idx=" + houseparty_idx;
			});
			
			// 동적으로 생성된 태그에 클릭이벤트 달기
			$(document).on("click", ".kh_select_filter svg", function() {
				location.href = "Controller?command=houseparty";
			});
			
			// 필터링 : .kh_sub_filter span   / .kh_sub2_filter button
			$(".kh_sub_filter span").click(function() {
				let fname = $(this).attr("fname");
				location.href = "Controller?command=houseparty&filtering=" + fname;
			});
			$(".kh_sub2_filter button").click(function() {
				let fname = $(this).attr("fname");
				location.href = "Controller?command=houseparty&filtering=" + fname;
			});
			
			// 페이지 로딩 후 실행할 것들
			let t;
			if('<%=paramFiltering%>'=='null') {
				$(".kh_select_filter > span").parents("#kh_choice").remove();
			} else {
				t = $("[fname='<%=paramFiltering%>']").text();
			}
			
			$(".kh_select_filter > span").text(t);
			
			// let idx = $("[fname='<%=paramFiltering%>']").parents(".kh_filter").index();
			let idx = $(".kh_filter").index($("[fname='<%=paramFiltering%>']").parents(".kh_filter"));
			
			if(idx>=0) {
				$(".sub_select").eq(idx).addClass("on");
			}
			$("[fname='<%=paramFiltering%>']").addClass("kh_sub_filter_on");

			//좋아요 버튼 누르기(ajax)
			$(".picture_likey").click(function(e) {
				e.stopPropagation();
				let housepartyIdx = $(this).parents(".content_inner").attr("houseparty_idx");
				let memberId = "또랑이";
				let _this = $(this);
				$.ajax({
					type : 'post',
					data : {"command" : "ajax_houseparty_likey",
							"houseparty_idx" : housepartyIdx,
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
<div class=container>
	<jsp:include page="header_kh.jsp" flush="true"/>
	<div class="sticky-container" style="height: 52px; top:80px; position:sticky;">
		<div class="menuLine">
			<div class="menuInner">
				<nav id="topMenu">
					<ul>
						<li class="m_line"><a href="Controller?command=community_main">홈</a></li>
						<li class="m_line on"><a href="Controller?command=houseparty">집들이</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
	<div id="div_content">
		<div id="div_select_box">
			<div>
				<span class="sub_select fl">
					정렬
					<span class ="_v"></span>
				</span>
				<span class="sub_select fl">
					주거형태
					<span class ="_v"></span>
				</span>
				<span class="sub_select fl">
					평수
					<span class ="_v"></span>
				</span>
				<span class="sub_select fl">
					예산
					<span class ="_v"></span>
				</span>
				<span class="sub_select fl">
					가족형태
					<span class ="_v"></span>
				</span>
				<span class="sub_select fl">
					스타일
					<span class ="_v"></span>
				</span>
				<span class="sub_select fl">
					세부공사
					<span class ="_v"></span>
				</span>
				<span class="sub_select fl">
					분야
					<span class ="_v"></span>
				</span>
				<span class="sub_select fl">
					작업자
					<span class ="_v"></span>
				</span>
				<span style="clear:both;"></span>
			</div>
			<div id="kh_choice">
				<button class="kh_select_filter">
					<span>소리지르는 내가 권민희란다!</span>
					<svg class="css-126zg1g eim60ry1" width="12" height="12" fill="currentColor" size="16" name="dismiss_thick"><path d="M6 4.94 3.879 2.817l-1.061 1.06L4.939 6 2.818 8.121l1.06 1.061L6 7.061l2.121 2.121 1.061-1.06L7.061 6l2.121-2.121-1.06-1.061L6 4.939zM6 12A6 6 0 1 1 6 0a6 6 0 0 1 0 12z"></path></svg>
				</button>
			</div>
		</div>	
		<div id="div_total">전체 수 <%-- <%= hpcVo.getHousepartyIdx() %> --%></div>
		<%
			for(HousepartyVo vo : listHouseparty) {
		%>
			<!-- 반복 -->
			<div class="content_inner fl" houseparty_idx="<%=vo.getHousepartyIdx()%>">
				<div class="picture">
					<img src="<%=vo.getCoverImg()%>"> 
					<div class="picture_likey">
						<svg class="icon icon--stroke" aria-label="좋아요" width="24" height="24" fill="currentColor" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" preserveAspectRatio="xMidYMid meet"><path d="M23.22 7.95c.4 4.94-2.92 9.71-10.92 13.85a.47.47 0 0 1-.42 0C3.88 17.66.56 12.9.96 7.93 1.54 2.48 8.28.3 12.1 4.7c3.8-4.4 10.55-2.22 11.13 3.25z"></path></svg>
					</div>
				</div>
				<div id="commu_title">
					<p><%=vo.getTitle()%></p>
				</div>
				<div id="member_id">
					<div id="user_pic">
						<img src="<%=vo.getProfileImg()%>"> 
					</div>
					<span class="user_name"><%=vo.getName() %></span>
				</div>
				<div id="likey_hit">
					<span class="sub_l_h">스크랩 <%=vo.getLikeyCount() %></span>
					<span class="sub_l_h">조회 <%=vo.getHitCount() %></span>
				</div>
			</div>
			<!-- //반복 -->
		<%
		}
		%>   
		<div class="kh_filter">
			<div class="kh_sub_filter sorting">
				<span <%-- class="kh_sub_filter_on" --%> fname="recent">최신순</span>
				<span fname="popular">인기순</span>
				<span fname="past">과거순</span>
			</div>
		</div>
		<div class="kh_filter">
			<div class="kh_sub_filter housetype">
				<span fname="ono">원룸&오피스텔</span>
				<span fname="apt">아파트</span>
				<span fname="villant">빌라&연립</span>
				<span fname="dandok">단독주택</span>
				<span fname="office">사무공간</span>
				<span fname="ht_etc">기타</span>
			</div>
		</div>
		<div class="kh_filter">
			<div class="kh_sub2_filter py">
				<div>
					<button class="kh_subfilter_btn" fname="1_9py">1-9평</button>
					<button class="kh_subfilter_btn" fname="10spy">10평대</button>
					<button class="kh_subfilter_btn" fname="20spy">20평대</button>
					<button class="kh_subfilter_btn" fname="30spy">30평대</button>
					<button class="kh_subfilter_btn" fname="40spy">40평대</button>
					<button class="kh_subfilter_btn" fname="50spy">50평대</button>
					<button class="kh_subfilter_btn" fname="60spy">60평대</button>
					<!-- <button class="kh_subfilter_btn">70평대 이상</button> -->
				</div>
			</div>
		</div>
		<div class="kh_filter">
			<div class="kh_sub2_filter budget">
				<div>
					<button class="kh_subfilter_btn" fname="under1m">1백만원 미만</button>
					<button class="kh_subfilter_btn" fname="1ms">1백만원대</button>
					<button class="kh_subfilter_btn" fname="2ms">2백만원대</button>
					<button class="kh_subfilter_btn" fname="3ms">3백만원대</button>
					<button class="kh_subfilter_btn" fname="4ms">4백만원대</button>
					<button class="kh_subfilter_btn" fname="5ms">5백만원대</button>
					<button class="kh_subfilter_btn" fname="10ms">1천만원대</button>
					<button class="kh_subfilter_btn" fname="20ms">2천만원대</button>
					<button class="kh_subfilter_btn" fname="30ms">3천만원대</button>
					<button class="kh_subfilter_btn" fname="over40ms">4천만원 이상</button>
				</div>
			</div>
		</div>
		<div class="kh_filter">
			<div class="kh_sub_filter fmtype">
				<span fname="family1">싱글라이프</span>
				<span fname="family12">신혼 부부</span>
				<span fname="family123">아기가 있는 집</span>
				<span fname="family3school">취학 자녀가 있는 집</span>
				<span fname="familyparents">부모님과 함께 사는 집</span>
				<span fname="family_etc">기타</span>
			</div>
		</div>
		<div class="kh_filter">
			<div class="kh_sub_filter style" style="height: 250px; overflow:auto;">
				<span fname="st_modern">모던</span>
				<span fname="st_minisimple">미니멀&심플</span>
				<span fname="st_natural">내추럴</span>
				<span fname="st_neurope">북유럽</span>
				<span fname="st_vintage_retro">빈티지&레트로</span>
				<span fname="st_cls_ant">클래식&앤틱</span>
				<span fname="st_ft_pro">프렌치&프로방스</span>
				<span fname="st_lov_rom">러블리&로맨틱</span>
				<span fname="st_industrial">인더스트리얼</span>
				<span fname="st_kor_asia">한국&아시아</span>
				<span fname="st_uni_mix">유니크&믹스매치</span>
			</div>
		</div>
		<div class="kh_filter">
			<div class="kh_sub_filter detailpart" style="height: 300px; overflow:auto;">
				<span fname="d_hmaru">헤링본 마루</span>
				<span fname="d_dr_badak">대리석 바닥</span>
				<span fname="d_wmaru">원목마루</span>
				<span fname="d_porcelain_tile">포세린타일</span>
				<span fname="d_polishing_tile">폴리싱타일</span>
				<span fname="d_kitchen_remo">주방리모델링</span>
				<span fname="d_lighting">조명시공</span>
				<span fname="d_folding_door">폴딩도어</span>
				<span fname="d_middle_door">중문</span>
				<span fname="d_partition">가벽&파티션</span>
				<span fname="d_sliding_door">슬라이딩도어</span>
				<span fname="d_atryl">아트월</span>
				<span fname="d_balcony">발코니확장</span>
			</div>
		</div>
		<div class="kh_filter">
			<div class="kh_sub_filter part">
				<span fname="p_remodeling">리모델링</span>
				<span fname="p_homestyling">홈스타일링</span>
				<span fname="p_detailpart">부분공사</span>
				<span fname="p_construct">건축</span>
			</div>
		</div>
		<div class="kh_filter">
			<div class="kh_sub_filter partner">
				<span fname="w_remodeling" style="line-height: 30px;">셀프·DIY<br/>
					<span class="kh_subfilter_partner_ver">인테리어 전과정을 직접 하는 것.</span>
				</span>
				<span fname="w_homestyling" style="line-height: 30px;">반셀프<br/>
					<span class="kh_subfilter_partner_ver">디자인, 공정순서 등 시공계획은 본인이 직접하고, 실제 공사는 각 분야 전문가를 찾아 맡기는 것.</span>
				</span>
				<span fname="w_detail_construct" style="line-height: 30px;">전문가<br/>
					<span class="kh_subfilter_partner_ver">인테리어 업체/전문가가 리모델링 계획부터 공사까지 총괄하는 것.</span>
				</span>
			</div>
		</div>
	</div>		
	<jsp:include page="footer.jsp" flush="true"/>
</div>	
</body>
</html>