<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>마이페이지(비밀번호변경)</title>
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
			$('.pw1').focusout(function() {
				if ($('.pw1').val().length === 0) {
					$('.jy_pw_not_equals_blank1').css('display', 'block');
					$('.jy_pw_not_equals_eight1').css('display', 'none');
				} else {
					$('.jy_pw_not_equals_blank1').css('display', 'none');
				}
			});
			$('.pw2').focusout(function() {
				if ($('.pw2').val().length === 0) {
					$('.jy_pw_not_equals').css('display', 'block');
				} else {
					$('.jy_pw_not_equals').css('display', 'none');
				}
			});
		
		//비밀번호 형식맞는지
			let reg = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,25}$/;
			$('.pw1').focusout(function() {
				let pw1 = $('.pw1').val();
				if(!reg.test(pw1) && $('.pw1').val().length != 0) {
					$('.jy_pw_not_equals_eight1').css('display', 'block');
					$('.jy_pw_not_equals_blank1').css('display', 'none');
				} else if(reg.test(pw1) || $('.pw1').val().length === 0) {
					$('.jy_pw_not_equals_eight1').css('display', 'none');
				}
			});
			
			$('.pw2').focusout(function() {
				let pw2 = $('input[name=newPw2]').val();
				if(!reg.test(pw2) && $('.pw2').val().length != 0) {
					$('.jy_pw_not_equals_eight2').css('display', 'block');
					
				} else {
					$('.jy_pw_not_equals_eight1').css('display', 'none');
				}
			});
		
		
		//비밀번호 불일치 안내글
			$('.pw2').focusout(function() {
				let pw1 = $('.pw1').val();
				let pw2 = $('input[name=newPw2]').val();
				if(pw1!="" || pw2!="") {
					if(pw1 == pw2) {
						$('.jy_pw_not_equals').css('display', 'none');
					} else if(pw2.length == 0) {
						$('.jy_pw_not_equals').css('display', 'block');
					} else {
						$('.jy_pw_not_equals').css('display', 'block');
					}
				}
			});
			
		//비밀번호 변경버튼	
			$('.change_pw_btn').click(function() {
				let pw1 = $('.pw1').val();
				let pw2 = $('input[name=newPw2]').val();
				if(pw1 == pw2) {
					alert("비밀번호가 변경되었습니다. 다시 로그인해주세요.");
				} else {
					alert("비밀번호가 일치하지 않습니다.");
				}
			});
		});
	</script>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"/>
	<div class="mypage_menu_tl">
		<nav class="up MYmenu">
			<ul class="up_menu_inner">
				<li class="nav_button">
					<a class="active" href="Controller?command=Mypage_profile_with_ozip">프로필</a>
				</li>
				<li class="nav_button">
					<a class="active" href="Controller?command=Mypage_shopping_list_form">나의 쇼핑</a>
				</li>
				<li class="nav_button">
					<a class="active" href="Controller?command=mypage_review_form">나의 리뷰</a>
				</li>
				<li class="nav_button">
					<a class="active" href="Controller?command=Mypage_setting_edit_user_info_form">설정</a>
				</li>
			</ul>
		</nav>
		<nav class="down MYmenu">
			<ul class="up_menu_inner">
				<li class="nav_button downb">
					<a class="active" href="Controller?command=Mypage_setting_edit_user_info_form">회원정보수정</a>
				</li>
				<li class="nav_button downb">
					<a class="active" href="Controller?command=Mypage_setting_change_pw_form">비밀번호 변경</a>
				</li>
			</ul>
		</nav>
	</div>
	<div class="change_pw_tl">
		<h1>비밀번호 변경</h1>
		<form action="Controller?command=Mypage_setting_change_pw" method="post">
			<div class="change_pw_new">새 비밀번호</div>
			<div class="change_pw_new_con">영문, 숫자를 포함한 8자이상의 비밀번호를 입력해주세요.</div>
			<div class="new_pw_input_tl1">
				<div class="new_pw_input_tl2">
					<input class="new_pw_input pw1" type="password" name="newPw1" required />
					<div class="jy_pw_not_equals_eight1 jy_warning_font_pw">비밀번호는 영문, 숫자를 포함하여 8자 이상이어야 합니다.</div>
					<div class="jy_pw_not_equals_blank1 jy_warning_font_pw">필수 입력 항목입니다.</div>
				</div>
			</div>
			<div class="change_pw_new">새 비밀번호</div>
			<div class="new_pw_input_tl1">
				<div class="new_pw_input_tl2">
					<input class="new_pw_input pw2" type="password" name="newPw2" required />
					<div class="jy_pw_not_equals jy_warning_font_pw">비밀번호가 일치하지않습니다.</div>
					<div class="jy_pw_not_equals_eight2 jy_warning_font_pw">비밀번호는 영문, 숫자를 포함하여 8자 이상이어야 합니다.</div>
				</div>
			</div>
			<button class="change_pw_btn">비밀번호 변경</button>
		</form>
	</div>
	<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>