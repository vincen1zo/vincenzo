<%@page import="vo.OzipReplyVo"%>
<%@page import="vo.OzipDetailVo2"%>
<%@page import="vo.OzipDetailVo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ArrayList<OzipDetailVo> listOzipDetailVo = (ArrayList<OzipDetailVo>)request.getAttribute("listOzipDetailVo");
	ArrayList<OzipReplyVo> listOzipReplyVo = (ArrayList<OzipReplyVo>)request.getAttribute("listOzipReplyVo");
	OzipDetailVo2 vo = (OzipDetailVo2)request.getAttribute("vo");
	
	String LoginMemberId = (String)request.getAttribute("ASas");  
	String loginEmail = (String)session.getAttribute("loginEmail");  
	
	int commentPageNum = (Integer)request.getAttribute("commentPageNum");			//현재 페이지
	int startCommentPNum = (Integer)request.getAttribute("startCommentPNum");		//시작숫자
	int endCommentPNum = (Integer)request.getAttribute("endCommentPNum");			//마지막 숫자
	int lastcommentPageNum = (Integer)request.getAttribute("lastcommentPageNum");	//전체 마지막 페이지 숫자
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title><%=vo.getOzipTitle()%> | 예쁜템 모여사는 오늘의집</title>
	<link rel="stylesheet" href="css/Ozip_detail_page.css">
	<link rel="stylesheet" href="css/header.css">
	<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
	<script src="js/jquery-3.7.1.min.js"></script>
	<script src="js/temp_logout.js"></script>
	<script>
    //엔터키 이벤트
    function enterkey() {
    	if(window.event.keyCode == 13) {
    		ajax_ssonda();
    	}
    }
    //댓글 ajax
    function ajax_ssonda() {
//		if (window.event.keyCode == 13) {
			let ozip_idx = <%= vo.getOzipIdx()%>;
	    	let member_id = '<%=session.getAttribute("loginEmail") %>';
	    	let comment = $('.comment_input').val();
	    	
	    	$.ajax({
				url: 'Controller',
				type: 'post',
				data: { command : "ajax_ozip_reply_write",
						ozipIdx : ozip_idx, 
						memberId : member_id, 
						comment : comment
				},
				dataType : 'Json',
				success : function(data) {
					let str = '<div class="jy_comment_area" comment_idx="' + data.comment_idx + '">' 
							+ '		<div class="jy_profile_img">'
							+ '			<img src="images/avatar_mini(2).png">'    
							+ '		</div>'
							+ '		<div class="jy_comment">'
							+ '			<div class="jy_comment_member_id">'
							+ '				<a href="#">' + member_id + '</a>'
							+ '			</div>'
							+ '			<div class="jy_comment_content">'
							+ '				<p class="fl">' + comment + '</p>'
							+ '				<button class="btn_delete fr">삭제</button>'
							+ '				<button class="byn_update fr">수정</button>'
							+ '				<div style="clear:both;"></div>'
							+ '			</div>'
							+ '			<div class="jy_comment_info">'
							+ '				<span>' + data.writedate + '</span>'
							+ '				&nbsp;|&nbsp;'
							+ '				<!-- <a href="#"> 로그인 안했을시-->'
							+ '					<span class="jy_heart"></span>'
							+ '					<span>좋아요</span>'
							+ '				<!-- </a> -->'
							+ '				&nbsp;|&nbsp;'
							+ '				<!-- <a href="#"> -->'
							+ '					<span class="jy_reply_btn">답글 달기</span>'
							+ '				<!-- </a> -->'
							+ '				&nbsp;|&nbsp;'
							+ '				<!-- <a href="#"> -->'
							+ '					<span class="jy_reply_btn">신고</span>'
							+ '				<!-- </a> -->'
							+ '			</div>'
							+ '		</div>'
							+ '	</div>';
					$(".jy_comment_recomment").prepend(str);
				},
				error: function(request, status,error) {
					alert("에러" + request.status);
				}
			});
//		}
	}; 
		//오집인 게시글 삭제
		$(document).ready(function(){
		    $('.jy_ozip_delete_btn').click(function() {
		    	let result = confirm('삭제하시겠습니까?');
		    	if(result) {
		    		location.href="Controller?command=Ozip_delete&ozipIdx=<%=vo.getOzipIdx() %>";
		    	} else { }
		    });	
		    
		    $('.comment_insert').click(function() {
		    	ajax_ssonda();
		    	
		    	<%-- let ozip_idx = <%= vo.getOzipIdx()%>;
		    	let member_id = '<%=session.getAttribute("loginEmail") %>';
		    	let comment = $('.comment_input').val();
		    	
		    	$.ajax({
					url: 'Controller',
					type: 'post',
					data: { command : "ajax_ozip_reply_write",
							ozipIdx : ozip_idx, 
							memberId : member_id, 
							comment : comment
					},
					dataType : 'Json',
					success : function(data) {
						//if(data.result==1) alert("insert되었음.!");
						let str = '<div class="jy_comment_area" comment_idx="' + data.comment_idx + '">' 
								+ '		<div class="jy_profile_img">'
								+ '			<img src="images/avatar_mini(2).png">'    // TODO : image.	
								+ '		</div>'
								+ '		<div class="jy_comment">'
								+ '			<div class="jy_comment_member_id">'
								+ '				<a href="#">' + member_id + '</a>'
								+ '			</div>'
								+ '			<div class="jy_comment_content">'
								+ '				<p class="fl">' + comment + '</p>'
								+ '				<button class="btn_delete fr">삭제</button>'
								+ '				<div style="clear:both;"></div>'
								+ '			</div>'
								+ '			<div class="jy_comment_info">'
								+ '				<span>' + data.writedate + '</span>'
								+ '				&nbsp;|&nbsp;'
								+ '				<!-- <a href="#"> 로그인 안했을시-->'
								+ '					<span class="jy_heart"></span>'
								+ '					<span>좋아요</span>'
								+ '				<!-- </a> -->'
								+ '				&nbsp;|&nbsp;'
								+ '				<!-- <a href="#"> -->'
								+ '					<span class="jy_reply_btn">답글 달기</span>'
								+ '				<!-- </a> -->'
								+ '				&nbsp;|&nbsp;'
								+ '				<!-- <a href="#"> -->'
								+ '					<span class="jy_reply_btn">신고</span>'
								+ '				<!-- </a> -->'
								+ '			</div>'
								+ '		</div>'
								+ '	</div>';
						$(".jy_comment_recomment").prepend(str);
					},
					error: function(request, status,error) {
						alert("에러" + request.status);
					}
				});  --%>
		    });
		    //댓글 삭제 ajax
		    $(document).on("click", ".btn_delete", function() {
		    	let loginEmail = '<%=loginEmail %>';
		    	if(loginEmail == null) { alert("로그인하세요");	}
		    	let commentIdx = $(this).parent().parent().parent().attr("comment_idx");
				//alert(commentIdx);
				let _this = $(this);
				$.ajax({
					url: 'Controller',
					type: 'post',
					data: { commentIdx : commentIdx,
							command : "ajax_ozip_reply_delete",
					},
					success: function(data) {
						if(data.result == "OKAY"){
							alert("삭제되었습니다.");
							_this.parent().parent().parent(".jy_comment_area").remove();
						}
					},
					error: function(request, status,error) {
						alert("에러" + request.status);
					}
				});
		    });
		    
		    //준비중인 기능
		    
		 	$('.byn_update').click(function() {
		 		alert("준비중인 기능입니다.");
		 	});
		 	
		 	$('.jy_camera_icon').click(function() {
		 		alert("준비중인 기능입니다.");
		 	});
		 	$('.content_hashtag_list').click(function() {
		 		alert("준비중인 기능입니다.");
		 	});
		 	$('.ozip_follow').click(function() {
		 		alert("준비중인 기능입니다.");
		 	});
		 	$('.ozip_follow').click(function() {
		 		alert("준비중인 기능입니다.");
		 	});
		 	$('.jy_ozip_modify_btn').click(function() {
		 		alert("추가적인 기능 구현을 위해 준비중입니다.");
		 	});
		});

	</script>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"/>
	<div class="content_all">
		<div class="content_inner">
			<div class="content_title_info">
				<div id="ozip_info">
					<span class="ozip_tag_font">질문과 답변</span>
					<% if(session.getAttribute("loginEmail")!=null && session.getAttribute("loginEmail").equals(vo.getOzipMemberId())) { %>
					<div class="jy_update_btn">
						<button class="jy_ozip_modify_btn" onclick="location.href='Controller?command=Ozip_modify_form&ozipIdx=<%=vo.getOzipIdx() %>'";>수정 </button>
						<span>|</span>	
						<button class="jy_ozip_delete_btn" <%-- onclick="location.href='Controller?command=Ozip_delete&ozipIdx=<%=vo.getOzipIdx() %>'"; --%>>삭제</button>
					</div>
					<% } %>
				</div>
				<p class="ozip_title_font">
					<b><%=vo.getOzipTitle()%></b>
				</p>
				<div class="ozip_writer">
					<div class="ozip_writer_img_member_date">
						<figure>
							<img src="https://image.ohou.se/i/bucketplace-v2-development/uploads/default_images/avatar.png?gif=1&w=36&webp=1"  width=50px height=50px/>
						</figure>
						<div class="ozip_writer_member_date">
							<a href="Controller?command=Mypage_profile_with_ozip">
								<span id="member"><%=vo.getOzipMemberId()%></span>
								<span id="date">1개월전</span>
							</a>					
						</div>
					</div>
					<% if(session.getAttribute("loginEmail")!= vo.getOzipMemberId()) { %>
					<button class="ozip_follow">
							팔로우
					</button>
					<% } %>
				</div>
			</div>
			<!-- 사진, 내용  -->
			<!-- 여기서부터 for문 돌려서 안에 내용 뽑아주기 내용이 null이면 안뽑아주고 빈칸-->
			<div class="content_img_content">
			<%
				for(OzipDetailVo voDetail : listOzipDetailVo) {
			%>
				<% if(voDetail.getOzipDetailImgUrl()!=null && voDetail.getOzipDetailImgUrl().startsWith("http")) { %>
				<img src="<%=voDetail.getOzipDetailImgUrl() %>" class="jy_ozipImgUrl">
				<% } else if(voDetail.getOzipDetailImgUrl()!=null && !voDetail.getOzipDetailImgUrl().startsWith("http")) { %>
				<img src="upload/<%=voDetail.getOzipDetailImgUrl() %>" class="jy_ozipImgUrl">
				<% } else { } %>
				<% if(voDetail.getOzipDetailDescription()!=null) { %>
				<p class="Q_content">
					<%=voDetail.getOzipDetailDescription() %>
				</p>
				<% } else { }%>
			<% } %>
			</div>
			<!--  -->
			<div class="content_hashtag">
					<%
					if(vo.getOzipHashtag()!=null) {
							String[] arrHashtag2 = vo.getOzipHashtag().split(" ");
							for(String tag : arrHashtag2) {	
						
					%> 
				<button class="content_hashtag_list">
						<%=
							tag		
						%>
				</button>
					<%
							}
					}
					%>
			</div>
			<div class="content_hitcount">
				<dl>
					<dt>조회</dt>
					<dd><%=vo.getOzipHitcount() %></dd>
				</dl>
			</div>
			<hr><!-- 경계 -->
			<div class="content_comment">
				<section>
					<p class="comment_main">
						댓글
						<span class="comment_num"><%=vo.getOzipCNum() %></span>
					</p>
					<div class="comment_input_tl">
						<div class="comment_input_outer">
							<figure class="comment_basic_img_tl">
								<img class="comment_basic_img" src="https://image.ohou.se/i/bucketplace-v2-development/uploads/default_images/avatar.png?gif=1&w=36&webp=1"/>
							</figure>
							<div class="incomment_input_tl">
							<% if(session.getAttribute("loginEmail")==null) { %>
							<a href="Controller?command=login_form&ret_cmd=Ozip_detail&ozip_idx=<%=vo.getOzipIdx() %>" class="jy_no_login_comment"></a>
							<%} %>
								<div class="incomment_input_tl_inner">
									<input type="text" class="comment_input" onkeyup="enterkey()" placeholder="따뜻한 댓글은 작성자를 춤추게 합니다.">
									<button class="jy_camera_tl">
										<span class="jy_camera_icon"></span>
									</button>
									<button type="button" class="comment_insert">
										입력
									</button>
								</div>
							</div>
						</div>							
					</div>
					<!-- 댓글창 -->
					<div class="jy_comment_recomment">
					<%String recommentTag = ""; %>
					<%for( OzipReplyVo reVo : listOzipReplyVo ) { %>
						<% if(reVo.getCommentOrder() == 0) {	%>
						<% recommentTag = reVo.getMemberId(); %>
						<div class="jy_comment_area" comment_idx="<%=reVo.getCommentIdx()%>">
							<div class="jy_profile_img">
								<img src="images/avatar_mini(2).png" />	
							</div>
							<div class="jy_comment">
								<div class="jy_comment_member_id">
									<a href="#"><%=reVo.getMemberId() %></a>
								</div>
								<div class="jy_comment_content">
									<p class="fl"><%= reVo.getContent() %></p>
									<% if(reVo.getMemberId().equals(loginEmail)) { %>
										<button class="btn_delete fr">삭제</button>
										<button class="byn_update fr">수정</button>
									<% } %>
									<div style="clear:both;"></div>
									<%if(!(reVo.getImgUrl() == null)) { %>
									<button class="jy_img_popup_btn">
										<img class="jy_recomment_img" src="<%= reVo.getImgUrl()%>">
									</button>
									<%} %>
								</div>
								<div class="jy_comment_info">
									<span><%= reVo.getWritedate() %></span>
									&nbsp;|&nbsp;
									<!-- <a href="#"> 로그인 안했을시-->
										<span class="jy_heart"></span>
										<span>좋아요</span>
									<!-- </a> -->
									&nbsp;|&nbsp;
									<!-- <a href="#"> -->
										<span class="jy_reply_btn">답글 달기</span>
									<!-- </a> -->
									&nbsp;|&nbsp;
									<!-- <a href="#"> -->
										<span class="jy_reply_btn">신고</span>
									<!-- </a> -->
								</div>
							</div>
						</div>
						<% } else { %>
						<div class="jy_recomment_area">
							<div class="jy_profile_img jy_img_right">
								<img src="images/avatar_mini(2).png" />	
							</div>
							<div class="jy_comment">
								<div class="jy_comment_member_id">
									<a href="#"><%=reVo.getMemberId() %></a>
								</div>
								<div class="jy_comment_content">
									<p><span class="jy_comment_tag">@<%=recommentTag %></span> <%= reVo.getContent() %></p>
									<%if(!(reVo.getImgUrl() == null)) { %>
									<button class="jy_img_popup_btn">
										<img class="jy_recomment_img" src="<%= reVo.getImgUrl()%>">
									</button>
									<%} %>
								</div>
								<div class="jy_comment_info"><!-- 대댓글 -->
									<span><%= reVo.getWritedate() %></span>
									&nbsp;|&nbsp;
									<% if(session.getAttribute("loginEmail")==null) { %>
									<a href="Controller>command=login_form&ret_cmd=Ozip_write_form"></a>
									<% } %>
									<span class="jy_heart"></span>
									<span>좋아요</span>
									&nbsp;|&nbsp;
									<span class="jy_reply_btn">답글 달기</span>
									&nbsp;|&nbsp;
									<span class="jy_reply_btn">신고</span>
								</div>
							</div>
						</div>
						<%-- <%=if() %> --%>
						<div class="jy_recomment_input_tl">
							<div class="comment_input_outer">
								<div class="jy_profile_img ">
									<img class="jy_recomment_input_basic_img" src="images/avatar_mini(2).png" />	
								</div>
								<div class="jy_incomment_input_tl_recommet">
									<div class="jy_recomment_input_size">
										<input type="text" class="jy_recomment_input" placeholder="따뜻한 댓글은 작성자를 춤추게 합니다.">
										<button class="jy_camera_tl">
											<span class="jy_camera_icon"></span>
										</button>
										<button type="button" class="recomment_insert">
											입력
										</button>
									</div>
								</div>
							</div>
						</div>
						<% } %>
					<% } %>
					</div>
				</section>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>
