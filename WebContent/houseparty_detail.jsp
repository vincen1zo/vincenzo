<%@page import="dao.HousepartyDao"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="vo.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String loginEmail = (String) session.getAttribute("loginEmail");
	if(loginEmail==null) {
		loginEmail = "또랑이";
%>    
<%
	}
	String loginMemberId = "또랑이";

	HousepartyDao hDao = new HousepartyDao();
	
	int housepartyIdx = (Integer) request.getAttribute("housepartyIdx");
	HousepartyDetailVo hppVo = (HousepartyDetailVo) request.getAttribute("hppVo");
	ArrayList<HousepartyPicWriteVo> listHousepartyPicWriteVo = (ArrayList<HousepartyPicWriteVo>) request.getAttribute("listHousepartyPicWriteVo");
	String[] arrSmallTalk = (String[]) request.getAttribute("arrSmallTalk");
	ArrayList<HousepartyCommentVo> listHousepartyComment = (ArrayList<HousepartyCommentVo>) request.getAttribute("listHousepartyComment");
	%>  
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>집들이_로그인 후</title>
	<link rel="stylesheet" href="css/houseparty_detail.css"/>
	<link rel="stylesheet" href="css/footer.css"/>
	<link rel="stylesheet" href="css/header_kh.css"/>
	<link rel="stylesheet" href="css/all.css"/>
	<script src="js/jquery-3.7.1.min.js"></script>
	<script>
		$(function() {
			$(".t_u_name").click(function() {
				alert("준비 중입니다.");
			});
			//팔로우 버튼 클릭시
			$(".kh_user_follow").click(function() {
				$(this).toggleClass('on');
			});
			//신고하기 버튼 클릭시
			$(".kh_ac_report_btn").click(function() {
				alert("남의집 is Love&Peace");
			});
			//댓글 삭제하기
			$(".kh_direct_comment_delete").click(function() {
				commentIdx = $(this).parents().children(".kh_hp_cc_sub_comment").attr("cname");
				location.href = "Controller?command=houseparty_comment_delete&comment_idx=" + commentIdx + "&houseparty_idx=" + <%=housepartyIdx%>;
			});
			//댓글  수정창 띄우기
			$(".kh_direct_comment_modify").click(function() {
				$(this).parents(".kh_hp_completed_com_sub").find(".hp_cc_modify_comment").css("display", "block");
				let commentContent = $(this).parents().children(".kh_hp_cc_sub_comment").text();
				$('input[name=comment_modify]').val(commentContent);
			});
			// 댓글 입력 버튼 누르고 수정하기
			$('.kh_hp_ci_com_btn2').click(function() {
				commentIdx = $(this).parents().children(".kh_hp_cc_sub_comment").attr("cname");
				$('input[name=comment_idx]').val(commentIdx);
			});
			//팔로우 버튼 클릭시
			$(".kh_user_follow").click(function() {
				let memberId = "또랑이";
				let followedMemberId = $(".kh_hp_user_name").attr("followedmemberid"); 
				alert(followedMemberId);
				let _this = $(this);
				$.ajax({
					type : 'post',
					data : {"command" : "ajax_houseparty_follow",
							"member_id" : memberId,
							"followed_member_id" : followedMemberId},
					url : 'Controller',
					success : function(vo) {
						console.log(vo);
						alert(vo.result);
						if(vo.result=="Follow") {
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
	<div id="container">
		<jsp:include page="header_kh.jsp" flush="true"/>
		<div class="main_top">
			<img src="<%=hppVo.getCoverImg()%>">
		</div>
		<div class="content">
			<div class="sub_con">
				<div class="main_title_user">
					<div class="main_title"><%=hppVo.getTitle()%></div>
					<div class="main_user">
						<button class="top_user">
							<div class="t_u_img">
								<img src="<%=hppVo.getProfileImg()%>">
							</div>
							<span class="kh_hp_user_name fr" followedMemberId="<%=hppVo.getMemberId() %>"><%=hppVo.getMemberId() %></span>
						</button>
						<button class="kh_user_follow">팔로우</button>
					</div>
				</div>
				<div class="information">
					<div class="i_top">
						<div class="i_t">
							<svg xmlns="http://www.w3.org/2000/svg" width="38" height="38"><g fill="none" fill-rule="evenodd"><path d="M0 0h38v38H0z"></path><rect width="19.53" height="23.75" x="3.43" y="7.13" fill="#FFF" stroke="#525B61" rx="2.38"></rect><rect width="3.17" height="3.17" x="8.18" y="17.42" stroke="#525B61" rx="1.27"></rect><rect width="3.17" height="3.17" x="8.18" y="11.08" stroke="#525B61" rx="1.27"></rect><rect width="3.17" height="3.17" x="8.18" y="23.75" stroke="#525B61" rx="1.27"></rect><rect width="3.17" height="3.17" x="15.31" y="17.42" stroke="#525B61" rx="1.27"></rect><rect width="3.17" height="3.17" x="15.31" y="11.08" stroke="#525B61" rx="1.27"></rect><rect width="3.17" height="3.17" x="15.31" y="23.75" stroke="#525B61" rx="1.27"></rect><rect width="8.44" height="8.44" x="26.39" y="19" fill="#EAEBEF" stroke="#525B61" rx="4.22"></rect><rect width="1.58" height="4.22" x="29.56" y="27" fill="#525B61" rx="0.79"></rect></g></svg>
							<span class="i_t_name"><%=hppVo.getHomeType() %></span>
						</div>
						<hr class="i_t_line">
						<div class="i_t">
							<svg xmlns="http://www.w3.org/2000/svg" width="38" height="38"><g fill="none" fill-rule="evenodd"><path d="M0 0h38v38H0z"></path><rect width="26.92" height="23.75" x="5.54" y="7.13" fill="#FFF" stroke="#525B61" rx="2.38"></rect><path fill="#EAEBEF" fill-rule="nonzero" d="M8 7.5h8v23H8a2 2 0 0 1-2-2v-19c0-1.1.9-2 2-2z"></path><rect width="8.44" height="1" x="5.28" y="20" fill="#525B61" rx="0.5"></rect><rect width="10.56" height="1" x="22.17" y="13.72" fill="#525B61" rx="0.5"></rect><rect width="1" height="5.28" x="9.5" y="15.5" fill="#525B61" rx="0.5"></rect><rect width="1" height="5.28" x="25.33" y="14" fill="#525B61" rx="0.5"></rect><rect width="1" height="7.39" x="25.33" y="24" fill="#525B61" rx="0.5"></rect><rect width="1" height="24" x="15.83" y="7" fill="#525B61" rx="0.5"></rect></g></svg>
							<div class="i_t_name"><%=hppVo.getPy() %>평</div>
						</div>
						<hr class="i_t_line">
						<div class="i_t">
							<svg xmlns="http://www.w3.org/2000/svg" height="38" width="38"><g fill-rule="evenodd" fill="none"><path d="M0 0h38v38H0z"></path><g transform="translate(4.75 4.75)"><path d="M15.05 13.2c0 .67-.42 1.3-1.07 1.58l-2.07 1.05a3.2 3.2 0 0 0-1.85 3.87l.85 3.7c.14.44.16.92.06 1.37v.02a2.93 2.93 0 0 1-2.88 2.2H7.8a2.93 2.93 0 0 1-2.88-2.2c-.1-.46-.08-.94.06-1.4l1-3.69a3.2 3.2 0 0 0-1.84-3.87l-2.23-1.05a1.75 1.75 0 0 1-1.07-1.59v-.4h14.2v.4zM1.2 0C.55 0 0 .54 0 1.2v12.14c0 1.22.7 2.11 1.8 2.62l2.2 1c.75.36 1.16 1.44.92 2.24l-1.07 3.56a4.13 4.13 0 0 0 3.97 5.32h.26a4.17 4.17 0 0 0 4.05-3.25v-.02c.15-.68.12-1.4-.08-2.06l-1.07-3.55c-.24-.8.06-1.82.82-2.17l2.2-1.01c1.1-.5 1.9-1.47 1.9-2.68V1.2c0-.66-.54-1.2-1.2-1.2H1.2zm6.75 25.11a.92.92 0 1 0 0-1.84.92.92 0 0 0 0 1.84z" fill-rule="nonzero" fill="#525B61"></path><path d="M15.05 13.2c0 .67-.42 1.3-1.07 1.58l-2.07 1.05a3.2 3.2 0 0 0-1.85 3.87l.85 3.7c.14.44.16.92.06 1.37v.02a2.93 2.93 0 0 1-2.88 2.2H7.8a2.93 2.93 0 0 1-2.88-2.2c-.1-.46-.08-.94.06-1.4l1-3.69a3.2 3.2 0 0 0-1.84-3.87l-2.23-1.05a1.75 1.75 0 0 1-1.07-1.59v-.4h14.2v.4z" fill="#FFF"></path><path d="M.95 11.95h14v-11h-14z" fill="#EAEBEF"></path><rect rx="0.5" fill="#525B61" y="11.95" height="1" width="15.6"></rect></g><path d="M29.22 8.661a.63.63 0 0 1-.084.53c-.32.444-.487.948-.493 1.484l-.036 5.786h-.766l-.324.013.044-5.792a2.56 2.56 0 0 0-.462-1.47.625.625 0 0 1-.085-.542l.719-2.328.802-.002.693 2.315zm1.751 8.876-.003 1.152-.718 1.053a2.7 2.7 0 0 0-.312 2.464l.735 1.913a4.5 4.5 0 0 1 .296 1.615l-.008 3.442a2.84 2.84 0 0 1-2.85 2.849 2.82 2.82 0 0 1-2.843-2.842v-3.436c.003-.558.103-1.1.307-1.62l.705-1.921a2.66 2.66 0 0 0-.299-2.453l-.72-1.059-.004-1.146 5.692-.008zM27.275 5.389a.6.6 0 0 0-.576.431l-.794 2.617a1.786 1.786 0 0 0 .262 1.552c.147.202.216.45.22.693v5.785h-1.26a1 1 0 0 0-.997 1.01l-.006 1.388a1 1 0 0 0 .176.565l.74 1.069c.262.378.309.85.157 1.27l-.71 1.864a5.438 5.438 0 0 0-.367 1.997l.001 3.336a3.94 3.94 0 0 0 3.968 3.965 3.95 3.95 0 0 0 2.812-1.166 3.96 3.96 0 0 0 1.17-2.814l.006-3.343c0-.68-.121-1.358-.366-1.983l-.708-1.86c-.161-.426-.1-.903.152-1.271l.75-1.077c.12-.174.174-.373.177-.573l-.003-1.383a1 1 0 0 0-1.001-1.003l-1.254.01v-5.786c.003-.25.077-.488.224-.694.323-.457.42-1.022.254-1.557l-.789-2.616a.6.6 0 0 0-.575-.435l-1.663.01z" fill-rule="nonzero" fill="#525B61"></path><path d="M29.251 8.695a.62.62 0 0 1-.1.542c-.305.432-.479.941-.485 1.477L28.63 16.5h-.766l-.324.014.044-5.792a2.56 2.56 0 0 0-.462-1.47.625.625 0 0 1-.085-.543l.719-2.327.802-.002.701 2.309zM30.97 17.5l.005 1.147-.732 1.05a2.679 2.679 0 0 0-.297 2.466l.727 1.92a4.52 4.52 0 0 1 .297 1.6l-.01 3.457a2.84 2.84 0 0 1-2.85 2.849 2.83 2.83 0 0 1-2.843-2.842l-.006-3.444c.009-.55.109-1.093.299-1.614l.733-1.917a2.66 2.66 0 0 0-.299-2.453l-.728-1.053.004-1.152 5.692-.008z" fill="#FFF"></path></g></svg>
							<span class="i_t_name"><%=hppVo.getPart() %></span>
						</div>
						<hr class="i_t_line">
						<div class="i_t">
							<svg xmlns="http://www.w3.org/2000/svg" width="39" height="38"><g fill="none" fill-rule="evenodd"><path d="M1 0h38v38H1z"></path><path fill="#EAEBEF" d="m1.409 30.382.489-3.553 1.063-2.294 1.154-1.749.898-1.073 1.136-.704.747-.659 1.015.412 1.562.951h2.982l1.422-.951.762-.412 1.12 1.064 1.563 1.372 1.201 1.507.814 1.974.595 2.432.257 2.207v-.524z"></path><path fill="#525B61" fill-rule="nonzero" stroke="#525B61" stroke-width="0.1" d="M15.322 20.596a7.108 7.108 0 0 0 2.577-5.477c0-3.926-3.194-7.119-7.12-7.119-3.925 0-7.119 3.193-7.119 7.119 0 2.2 1.004 4.17 2.577 5.476C3.034 22.301 1 25.818 1 29.75a.468.468 0 1 0 .937 0c0-3.761 2.032-7.092 5.18-8.537a7.072 7.072 0 0 0 3.662 1.026 7.066 7.066 0 0 0 3.656-1.022c3.153 1.446 5.187 4.762 5.187 8.533a.468.468 0 1 0 .937 0c0-3.942-2.032-7.448-5.237-9.154zm-4.543.705a6.188 6.188 0 0 1-6.181-6.182 6.188 6.188 0 0 1 6.181-6.182 6.189 6.189 0 0 1 6.183 6.182 6.19 6.19 0 0 1-6.183 6.182z"></path><path fill="#FFF" d="M10.78 21.301a6.188 6.188 0 0 1-6.182-6.182 6.188 6.188 0 0 1 6.181-6.182 6.189 6.189 0 0 1 6.183 6.182 6.19 6.19 0 0 1-6.183 6.182z"></path><path fill="#EAEBEF" d="m19.2 30.382.489-3.553 1.062-2.294 1.155-1.749.898-1.073 1.136-.704.746-.659 1.016.412 1.562.951h2.982l1.422-.951.762-.412 1.12 1.064 1.563 1.372 1.201 1.507.813 1.974.596 2.432.257 2.207v-.524z"></path><path fill="#525B61" fill-rule="nonzero" stroke="#525B61" stroke-width="0.1" d="M33.522 20.596a7.108 7.108 0 0 0 2.577-5.477c0-3.926-3.194-7.119-7.12-7.119-3.925 0-7.119 3.193-7.119 7.119 0 2.2 1.004 4.17 2.576 5.476-3.202 1.706-5.236 5.223-5.236 9.155a.468.468 0 1 0 .937 0c0-3.761 2.032-7.092 5.18-8.537a7.069 7.069 0 0 0 3.662 1.026 7.071 7.071 0 0 0 3.656-1.022c3.153 1.446 5.187 4.762 5.187 8.533a.468.468 0 1 0 .937 0c0-3.942-2.032-7.448-5.237-9.154zm-4.543.705a6.188 6.188 0 0 1-6.181-6.182 6.188 6.188 0 0 1 6.181-6.182 6.188 6.188 0 0 1 6.182 6.182 6.19 6.19 0 0 1-6.182 6.182z"></path><path fill="#FFF" d="M28.98 21.301a6.188 6.188 0 0 1-6.182-6.182 6.188 6.188 0 0 1 6.181-6.182 6.188 6.188 0 0 1 6.182 6.182 6.19 6.19 0 0 1-6.182 6.182z"></path><path fill="#525B61" fill-rule="nonzero" d="M10.731 18.495c1.136 0 2.213-.498 2.766-1.329.204-.277.116-.665-.204-.859a.657.657 0 0 0-.902.194c-.32.471-.961.748-1.66.748-.698 0-1.339-.277-1.659-.748a.713.713 0 0 0-.902-.194c-.292.194-.379.582-.204.859.553.83 1.6 1.33 2.765 1.33zm18.276 0c1.136 0 2.213-.498 2.766-1.329.204-.277.116-.665-.204-.859a.657.657 0 0 0-.902.194c-.32.471-.96.748-1.66.748-.698 0-1.339-.277-1.659-.748a.713.713 0 0 0-.902-.194c-.291.194-.379.582-.204.859.553.83 1.601 1.33 2.765 1.33z"></path></g></svg>
							<span class="i_t_name"><%=hppVo.getFamilyType() %></span>
						</div>
					</div>
					<hr class="i_line">
					<div class="i_bottom">
						<div class="i_b">
							<div class="i_b_l">공간</div>
							<div class="i_b_r"><%=hppVo.getHomeType() %></div>
						</div>
						<div class="i_b">
							<div class="i_b_l">평수</div>
							<div class="i_b_r"><%=hppVo.getPy() %>평</div>
						</div>
						<div class="i_b">
							<div class="i_b_l">작업</div>
							<div class="i_b_r"><%=hppVo.getWorker() %></div>
						</div>
						<div class="i_b">
							<div class="i_b_l">분야</div>
							<div class="i_b_r"><%=hppVo.getPart() %></div>
						</div>
						<div class="i_b">
							<div class="i_b_l">가족형태</div>
							<div class="i_b_r"><%=hppVo.getPart() %></div>
						</div>
						<div class="i_b">
							 <div class="i_b_l">지역</div>
							<div class="i_b_r"><%=hppVo.getArea() %></div>
						</div>
						<div class="i_b">
							<div class="i_b_l">스타일</div>
							<div class="i_b_r"><%=hppVo.getStyle() %></div>
						</div>
					</div>
				</div>
				
				<% if(arrSmallTalk != null || arrSmallTalk.length>0) { %>
				<div class="kh_small_talk">
					<p class="kh_st_1">
						<span class="kh_st_1_1"><%=arrSmallTalk[0] %></span> <!-- 📍 이 집의 핵심 포인트! -->
					</p>
					<p class="kh_st_2">
							<% for(int i=1; i<=arrSmallTalk.length-1; i++) { %>
								<span class="st2_1">✔</span>
								<%=arrSmallTalk[i] %> <br>
							<% } %>
					</p>
				</div>
				<% } %>
				
				<p class="empty"></p>
				
				<%-- <% int cnt=0; %> --%>
				<!-- 시이작 -->
				<% for(HousepartyPicWriteVo pwVo : listHousepartyPicWriteVo) { %>
					<%-- <% if(cnt++==2) break; %> --%>
					<% if(pwVo.getSmallTalk()==null) {  %>
						<div class="kh_pic_write">
							<% if(pwVo.getTitle()!=null) { %>
								<div class="kh_write_title">
									<span class="kh_wt"><%=pwVo.getTitle() %></span>
								</div>
							<% } %>
							<% if(pwVo.getImgUrl()!=null) { %>
								<% ArrayList<HousepartyPlusIconVo> listVo = hDao.getListHousepartyPlusIconVo(pwVo.getPicWriteIdx()); %>
								<span class="kh_pic">
									<div class="kh_sub_pic">
										<img src="<%=pwVo.getImgUrl()%>"/>
										<!-- ................... -->
										<% 
											for(HousepartyPlusIconVo vo : listVo) {
												if(vo.getNote()==null) {
										%>		
												<div class="kh_plus" product_idx="<%=vo.getProductIdx() %>" style="left:<%=vo.getxCoordinates()%>%; top:<%=vo.getyCoordinates()%>%;">
													<button type="button" class="kh_sub_p"><span class="sp_1"></span></button>
												</div>
										<%
												} else { 										
										%>
												<div class="kh_plus" product_idx="<%=vo.getProductIdx() %>" style="left:<%=vo.getxCoordinates()%>%; top:<%=vo.getyCoordinates()%>%;">
													<button type="button" class="kh_sub_p"><span class="sp_1"></span></button>
												</div>
										<%
												}
											}
										%>
									</div>
									<% if(listVo.size() > 0) { %>
										<div class="sub_prod">
											<div class="s_pd">
												<ul class=spd>
													<% 
														for(HousepartyPlusIconVo vo : listVo) {
															String imgSrc = hDao.getFirstImgUrlByProductIdx(vo.getProductIdx());
													%>
														<% if(imgSrc!=null) { %>
															<li class="s_product" product_idx="<%=vo.getProductIdx()%>">
																<span class=spd_img>
																	<img src="<%=imgSrc%>"/>
																</span>
															</li>
														<% } %>
													<% } %>
												</ul>
											</div>
										</div>
									<% } %>
								</span>
							<% } %>			
							<p class="kh_write"><%=pwVo.getContent()==null ? "" : pwVo.getContent() %></p>
							<p class="kh_sub_write"></p>
						</div>
					<% 
						} else { 
							String smallTalk = pwVo.getSmallTalk();
							if(!pwVo.getSmallTalk().split("<br>")[0].contains("핵심 포인트")) {
								smallTalk = smallTalk.replace("<br><br>", "<br>");
								String[] array1 = smallTalk.split("<br>");
					%>
						<div class="kh_small_talk">
							<p class="kh_st_1">
								<span class="kh_st_1_1"><%=array1[0] %></span>
							</p>
							<p class="kh_st_2">
								<% for(int i=1; i<=array1.length-1; i++) { %>
									<%=array1[i]%> <br>
								<% } %>
							</p>
						</div>
					<%
							}
						} 
					%>
				<% } %>
				<!-- pic&write 끝 -->
				<!-- 하단부분 중 날짜 좋아요 조회수 시작 -->
				<div class="kh_all_count">
					<div class="kh_allcount_else">
						<span class="kh_acelse_writedate"><%= hppVo.getWriteDate() %></span>
						<span class="kh_acelse_sub">좋아요</span>
						<span class="kh_acelse_count"><%= hppVo.getLikeyCount() %></span>
						<span class="kh_acelse_sub">조회</span>
						<span class="kh_acelse_count"><%= new DecimalFormat("###,###").format(hppVo.getHitCount())%></span>
					</div>
					<div class="kh_allcount_report">
						<button type="button" class="kh_ac_report_btn">신고하기</button>
					</div>
				</div>
				<hr class="i_line">
				<!-- 하단부분 중 유저 -->
				<div class="kh_hp_user">
					<div class="kh_hp_user_imp">
						<div class="kh_hp_user_img">
							<img src="<%=hppVo.getProfileImg()%>"/>
						</div>
						<div class="kh_hp_user_name" followedMemberId="<%=hppVo.getMemberId() %>"><%=hppVo.getMemberId() %></div>
					</div>
					<button class="kh_user_follow">팔로우</button>
				</div>
				<hr class="i_line">
				
				<!-- 집들이 댓글부분 시작 -->
				<div class="kh_hp_comment">
					<div class="kh_hp_com_title">댓글<span class="kh_hp_ct_count"><%=listHousepartyComment.size() %></span></div>
					<div class="kh_hp_com_input">
						<div class="kh_hp_ci_uimg">
							<img src="https://bucketplace-v2-development.s3.amazonaws.com/uploads/default_images/avatar.png"/>
						</div>
						<form action="Controller?command=houseparty_comment_write" method="post">
							<input type="hidden" name="houseparty_idx" value="<%=housepartyIdx%>"/>
							<input type="hidden" name="member_id" value="<%=loginMemberId %>"/>
							<%-- <% if(session.getAttribute("loginEmail")==null) { %>
								<a href="Controller?command=login_form&ret_cmd=houseparty_detail&houseparty_idx=<%= hppVo.getHousepartyIdx() %>" class="kh_no_login_comment"></a>
							<%} %> --%>
							<div class="kh_hp_ci_comment">
								<input type="text" name="comment" placeholder="칭찬과 격려의 댓글은 작성자에게 큰 힘이 됩니다:)" class="kh_hp_ci_com_text"/>
								<button class="kh_hp_ci_com_btn">입력</button>
							</div>
						</form>
					</div>	
				<% for(HousepartyCommentVo vo : listHousepartyComment) {
						if(vo.getCommentOrder()==0) {	
				%>
					<div class="kh_hp_main_completed_comment">
					
						<div class="kh_hp_completed_comment">
							<div class="kh_hp_completed_com_userimg">
								<% if(vo.getProfileImg() != null) { %>
								<img src="<%=vo.getProfileImg()%>"/>
								<% } else { %>
								<img src="https://bucketplace-v2-development.s3.amazonaws.com/uploads/default_images/avatar.png"/>
								<% } %>
							</div>
							<div class="kh_hp_completed_com_sub">
								<div class="kh_hp_cc_sub_space_between">
									<div class="kh_hp_cc_sub_username"><%=vo.getMemberId() %></div>
									<div class="kh_hp_cc_sub_else">
										<button type=button class="kh_direct_comment_modify">수정</button>
										<button type=button class="kh_direct_comment_delete">삭제</button>
									</div>
								</div>
								<div class="kh_hp_cc_sub_comment" cname="<%= vo.getCommentIdx() %>"><%= vo.getHpComment() %></div>
									<form action= "Controller" method="post">
									<input type="hidden" name="command" value="houseparty_comment_modify" />
									<input type="hidden" name="comment_idx" value=""/>
									<input type="hidden" name="houseparty_idx" value="<%=housepartyIdx%>" />
										<div class="hp_cc_modify_comment">
											<input type=text class="kh_comment_modify kh_hp_ci_com_text" name="comment_modify" value=""/>
											<button class="kh_hp_ci_com_btn kh_hp_ci_com_btn2">입력</button>
										</div>
									</form>
								<div class="kh_hp_cc_sub_else">
									<div class="kh_hp_cc_sub_else_date"><%=vo.getWriteDate() %></div>
									<div class="kh_hp_cc_sub_else_sub">
										<div class="kh_hp_cc_subelse_s_point">・</div>
										<div class="kh_hp_cc_subelse_l_count">
											<span class="kh_hp_cc_subelse_l_icon"></span>
											<span class="kh_hp_cc_subelse_sub_con">좋아요</span>
										</div>
									</div>
									<div class="kh_hp_cc_sub_else_sub">
										<div class="kh_hp_cc_subelse_s_point">・</div>
										<span class="kh_hp_cc_subelse_sub_con">답글달기</span>
									</div>
									<div class="kh_hp_cc_sub_else_sub">
										<div class="kh_hp_cc_subelse_s_point">・</div>
										<span class="kh_hp_cc_subelse_sub_con">신고</span>
									</div>
									<div class="kh_hp_cc_sub_else_recomment"></div>
									<div class="kh_hp_cc_sub_else_report"></div>
								</div>
							</div>
						</div>
					</div>
						<% } else { 
							String toWhom = hDao.getMemberIdByCommentIdx(vo.getReCommentIdx());
						%>
						<div class="kh_hp_completed_recomment">
							<div class="kh_hp_completed_recom">
								<div class="kh_hp_completed_com_userimg">
									<% if(vo.getProfileImg() != null) { %>
									<img src="<%=vo.getProfileImg()%>"/>
									<% } else { %>
									<img src="https://bucketplace-v2-development.s3.amazonaws.com/uploads/default_images/avatar.png"/>
									<% } %>
								</div>
								<div class="kh_hp_completed_com_sub">
									<div class="kh_hp_cc_sub_username"><%=vo.getMemberId() %></div>
									<div class="kh_hp_cc_sub_comment">
										<button class="kh_hp_cc_sub_recom_usertag">@<%=toWhom %></button>
										<%=vo.getHpComment() %>
									</div>
									<div class="kh_hp_cc_sub_else">
										<div class="kh_hp_cc_sub_else_date"><%=vo.getWriteDate() %></div>
										<div class="kh_hp_cc_sub_else_sub">
											<div class="kh_hp_cc_subelse_s_point">・</div>
											<div class="kh_hp_cc_subelse_l_count">
												<span class="kh_hp_cc_subelse_l_icon"></span>
												<span class="kh_hp_cc_subelse_sub_con">좋아요</span>
											</div>
										</div>
										<div class="kh_hp_cc_sub_else_sub">
											<div class="kh_hp_cc_subelse_s_point">・</div>
											<span class="kh_hp_cc_subelse_sub_con">답글달기</span>
										</div>
										<div class="kh_hp_cc_sub_else_sub">
											<div class="kh_hp_cc_subelse_s_point">・</div>
											<span class="kh_hp_cc_subelse_sub_con">신고</span>
										</div>
										<div class="kh_hp_cc_sub_else_recomment"></div>
										<div class="kh_hp_cc_sub_else_report"></div>
									</div>
								</div>
							</div>
						</div>
						<% } %>
					<% } %>
				</div>
				<div class="last"></div>
			</div>		
		</div>
		<jsp:include page="footer.jsp" flush="true"/>
	</div>		
</body>
</html>