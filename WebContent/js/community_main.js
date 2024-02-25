$(function(){
	$(".main_random").click(function() {
		location.href="Controller?command=houseparty_detail&houseparty_idx=2";
	});
	$(".z_t_sub2").click(function() {
			location.href="Controller?command=houseparty&filtering=st_modern";
		});
		
	$(".b_t_2").click(function() {
		location.href="Controller?command=shopping_main";
	});
	
	// 메인 대문이미지 누르면 해당 집들이 상세로 이동
	$(".kh_h_title_img").click(function(){
		location.href = "Controller?command=houseparty_detail&houseparty_idx=2";
	});
	
	// [어서와 모던스타일은 처음이지?]에 이미지 선택하면 해당 집들이 상세로 이동
	$(".zip_h_p").click(function(){
		let housepartyidx = $(this).attr("housepartyIdx");
		location.href = "Controller?command=houseparty_detail&houseparty_idx="+housepartyidx;
	});
	
	//[오늘의 딜]에 이미지 선택하면 해당 상품 상세페이지로 이동
	$(".o_d_product").click(function(){
		let productIdx = $(this).attr("product_idx");
		location.href = "Controller?command=product_detail&product_idx="+productIdx;
	});
	
	//[오늘의 딜] 더보기 누르면 오늘의딜 페이지로 이동
	$("#o_d_t_2").click(function(){
		location.href = "Controller?command=o_deal";
	});
	
	//[유저들의 인테리어 시공리뷰] 더보기 누르면 인테리어 메인으로 이동
	$("#i_t_2").click(function(){
		location.href = "Controller?command=interior_main";
	});
	
	//
	$(".b_product").click(function(){
		let productIdx = $(this).attr("productIdx");
		location.href = "Controller?command=product_detail&product_idx="+productIdx;
	});
});