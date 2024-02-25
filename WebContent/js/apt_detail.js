$(function(){
	// slick  > 리뷰가 2개 이상이면 실행
	let cnt = $(".con_review_box_li").length;
	if(cnt>2) {
		$(".con_review_box_ul").slick({
			slidesToShow: 2,
			slidesToScroll: 2
		});
	}	
	
	$("#ja_py_slick").slick({
			dots: true,
			slidesToshow: 1,
			slidesToScroll: 1
		});
	
	// 리뷰 > 이미지에 마우스 올리면 hover
	$(".con_review_box_ul").hover(function(){
		$(this).find("button").css("opacity","1");
	},function(){
		$(this).find("button").css("opacity","0");
	});
	
	// 평수 > 이미지에 마우스 올리면 hover
	$("#ja_py_slick").hover(function(){
		$(this).find("button").css("opacity","1");
	},function(){
		$(this).find("button").css("opacity","0");
	});	
		
	
});