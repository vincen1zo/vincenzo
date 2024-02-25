$(function() {
	$('.jy_temp_logout').click(function() {
		alert("로그아웃되었습니다.");
		location.href="Controller?command=logout";
	});
});