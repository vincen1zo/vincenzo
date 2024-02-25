$(function() {
	$(window).scroll(function () {
		console.log($(window).scrollTop());
		if($(window).scrollTop() >= 399){
			$('.QA_tag_line1').addClass('fixed');
		}
		if($(window).scrollTop() <= 400) {
			$('.QA_tag_line1').removeClass('fixed')
		}
	});
	
	$(".QA_b").click(function() {
		$(this).parents(".jy_QA_b_tl").next().slideToggle(200);
		
		if($(this).attr("btn")=="false") {
			$(this).parents(".jy_QA_b_tl").addClass("jy_remove_botLine");
			$(this).addClass("jy_bold");
			$(this).find(".expand_b").addClass("rotate");
			$(this).attr("btn","true");
		} else if($(this).attr("btn")=="true") {
			$(this).parents(".jy_QA_b_tl").removeClass("jy_remove_botLine");
			$(this).removeClass("jy_bold");
			$(this).find(".expand_b").removeClass("rotate");
			$(this).attr("btn","false");
		}

	});
	
	$(".QA_tag").click(function() {
		let cate = $(this).find("span").text();
		location.href = "Controller?command=QA&category=" + cate;
	})
	
	// alert 모음
	$(".QA_quick ").click(function(){
		alert("해당 슬라이드 작업중입니다.");
	})
	
	$(".one_one_tl").click(function(){
		alert("작업중입니다");
	});
});