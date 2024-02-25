<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	long kakaoId = 0;
	String profileNickname = null;
	String profileImage = null;
	String accountEmail = null;
	if((session.getAttribute("kakao_id")) != null) {
		kakaoId = (Long) session.getAttribute("kakao_id");
		profileNickname = (String) session.getAttribute("profile_nickname");
		profileImage = (String) session.getAttribute("profile_image");
		accountEmail = (String) session.getAttribute("account_email");
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>비밀번호 변경 | 라이프스타일 슈퍼앱, 오늘의집</title>
	<link rel="stylesheet" href="css/all.css">
	<link rel="stylesheet" href="css/header.css">
	<link rel="stylesheet" href="css/footer.css">
	<link rel="stylesheet" href="css/Mypage_shopping.css">
	<link rel="stylesheet" href="css/Mypage_setting.css">
	<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
	<script src="js/jquery-3.7.1.min.js"></script>
	<script>
		//헤더 검색창 색 변경
		$(function() {
			$(".search1 > input").focus(function() {
				$(".search1").addClass('click');
			});
			$(".search1 > input").blur(function() {
				$(".search1").removeClass('click');
			});
		
		//메뉴 밑줄
			$(".active").click(function(){
				$(this).addClass('on');
			});
		//비밀번호가 빈칸일 경우
			/* $('.pw1').focusout(function() {
				if ($('.pw1').val().length === 0) {
					$('.jy_pw_not_equals_blank1').css('display', 'block');
				} else {
					$('.jy_pw_not_equals_blank1').css('display', 'none');
				}
			}); */
			$('.pw2').focusout(function() {
				if ($('.pw2').val().length === 0) {
					$('.jy_pw_not_equals_blank1').css('display', 'block');
				} else {
					$('.jy_pw_not_equals_blank1').css('display', 'none');
				}
			});
		
		//비밀번호 형식맞는지
			/* let reg = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,25}$/;
			$('.pw1').focusout(function() {
				let pw1 = $('.pw1').val();
				if(!reg.test(pw1)) {
					$('.jy_pw_not_equals_eight1').css('display', 'block');
				} else if(reg.test(pw1) || $('.pw1').val().length === 0) {
					$('.jy_pw_not_equals_eight1').css('display', 'none');
				}
			});
			
			$('.pw2').focusout(function() {
				let pw2 = $('input[name=newPw2]').val();
				if(!reg.test(pw2)) {
					$('.jy_pw_not_equals_eight2').css('display', 'block');
				} else {
					$('.jy_pw_not_equals_eight1').css('display', 'none');
				}
			}); */
		
		
		//비밀번호 불일치 안내글
			/* $('.pw2').focusout(function() {
				let pw1 = $('.pw1').val();
				let pw2 = $('input[name=newPw2]').val();
				if(pw1!="" || pw2!="") {
					if(pw1 == pw2) {
						$('.jy_pw_not_equals').css('display', 'none');
					} else if(pw2.length() == 0) {
						$('.jy_pw_not_equals').css('display', 'block');
					} else {
						$('.jy_pw_not_equals').css('display', 'block');
					}
				}
			}); */
			
		//비밀번호 변경버튼	
			/* $('.change_pw_btn').click(function() {
				let pw1 = $('.pw1').val();
				let pw2 = $('input[name=newPw2]').val();
				if(pw1 == pw2) {
					alert("비밀번호가 변경되었습니다. 다시 로그인해주세요.");
				} else {
					alert("비밀번호가 일치하지 않습니다.");
				}
			}); */
			
		//닉네임 중복검사
			$('.jy_size_check_id').focusout(function() {
				let blank = $('input[name=memberId]').val();
				if(blank.length === 0) {
					$('.jy_warning_message_view_member_id').css('display', 'block');
					$(".jy_warning_message_view_member_id_same").css('display','none');
				} else if(!(blank.length === 0)) {
					$('.jy_warning_message_view_member_id').css('display', 'none');
					//닉네임중복체크
					$.ajax({
						url: 'Controller',
						type: 'post',
						data: { 'blank': blank , "command" : "ajax_member_id_check"},
						dataType : 'Json',
						success : function(data) {
							if(data.result == "OKAY") {
								$(".jy_warning_message_view_member_id_same").css('display','none');
							} else if(data.result == "FAIL") {
								$(".jy_warning_message_view_member_id_same").css('display','block');
							}
						},
						error: function(request, status,error) {
							alert("에러" + request.status);
						}
					}); 
				}
			});
		});
	</script>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"/>
	<!-- <div class="mypage_menu_tl">
		<nav class="up MYmenu">
			<ul class="up_menu_inner">
				<li class="nav_button">
					<a class="active" href="#">프로필</a>
				</li>
				<li class="nav_button">
					<a class="active" href="#">나의 쇼핑</a>
				</li>
				<li class="nav_button">
					<a class="active" href="#">나의 리뷰</a>
				</li>
				<li class="nav_button">
					<a class="active" href="#">설정</a>
				</li>
			</ul>
		</nav>
		<nav class="down MYmenu">
			<ul class="up_menu_inner">
				<li class="nav_button downb">
					<a class="active" href="#">회원정보수정</a>
				</li>
				<li class="nav_button downb">
					<a class="active" href="#">알림 설정</a>
				</li>
				<li class="nav_button downb">
					<a class="active" href="#">사용자 숨기기 설정</a>
				</li>
				<li class="nav_button downb">
					<a class="active" href="#">비밀번호 변경</a>
				</li>
			</ul>
		</nav>
	</div> -->
	<div class="change_pw_tl">
		<h1>추가정보 입력</h1>
		<form action="Controller?command=create_account_sns" method="post">
			<div class="change_pw_new">이메일</div>
			<div class="new_pw_input_tl1">
				<div class="new_pw_input_tl2">
					<!-- <input class="new_pw_input pw1" type="email" name="email"/> -->
					<input class="new_pw_input pw1" type="email" id="input_member_id" name="email" value="<%=accountEmail%>" readonly>
				</div>
			</div>
			<div class="change_pw_new ">닉네임</div>
			다른 유저와 겹치지 않도록 입력해주세요. (2~15자)
			<div class="new_pw_input_tl1">
				<div class="new_pw_input_tl2">
					<input class="new_pw_input pw2 jy_size_check_id" type="text" name="memberId"/>
					<div class="jy_warning_message_view_member_id jy_warning_font_pw">필수 입력 항목입니다.</div>
					<div class="jy_warning_message_view_member_id_same jy_warning_font_pw">사용중인 닉네임입니다.</div>
				</div>
			</div>
			<button class="change_pw_btn">회원가입 완료</button>
		</form>
	</div>
	<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>