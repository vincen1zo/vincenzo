$(function() {
	$(".search1 > input").focus(function() {
		$(".search1").addClass('click');
	});
	
	$(".search1 > input").blur(function() {
		$(".search1").removeClass('click');
	});
	
	
	let popMenu = false;
	$(".ja_icon2_btn").click(function(){
		if(!popMenu){
			popMenu = true;
			$(".ja_pop_menu_big_box").addClass("show");
		} else if(popMenu){
			popMenu = false;
			$(".ja_pop_menu_big_box").removeClass("show");
		}
	});
	
	//사이트설명 버튼 클릭하면 노션으로 이동
	$(".top_icon3").click(function(){
		alert("사이트 설명이 되어있는 [노션]으로 연결합니다.");
	});
});
