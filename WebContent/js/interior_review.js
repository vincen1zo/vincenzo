$(function() {
	$("label.star").mouseenter(function() {
		//alert("!");
		let star_class = "";
		let star_name = "";
		if($(this).parents("div").hasClass("ja_re_commu")) { star_class="ja_re_commu"; star_name="소통"; }
		if($(this).parents("div").hasClass("ja_re_price")) { star_class="ja_re_price"; star_name="가격"; }
		if($(this).parents("div").hasClass("ja_re_result")) { star_class="ja_re_result"; star_name="시공결과"; }
		if($(this).parents("div").hasClass("ja_re_schedule")) { star_class="ja_re_schedule"; star_name="일정준수"; }
		if($(this).parents("div").hasClass("ja_re_as")) { star_class="ja_re_as"; star_name="A/S"; }
		//alert(star_name);
		let star_idx = $("." + star_class + " label.star").index(this);  // 0~4   
		//alert(star_name + " [" + star_idx + "]");
		for(let i=0; i<=star_idx; i++) {
			$("." + star_class + " label.star").eq(i).addClass("hover");
		}
	}).mouseleave(function() {
		let star_name = "";
		if($(this).parents("div").hasClass("ja_re_commu")) { star_class="ja_re_commu"; star_name="소통"; }
		if($(this).parents("div").hasClass("ja_re_price")) { star_class="ja_re_price"; star_name="가격"; }
		if($(this).parents("div").hasClass("ja_re_result")) { star_class="ja_re_result"; star_name="시공결과"; }
		if($(this).parents("div").hasClass("ja_re_schedule")) { star_class="ja_re_schedule"; star_name="일정준수"; }
		if($(this).parents("div").hasClass("ja_re_as")) { star_class="ja_re_as"; star_name="A/S"; }
		$("." + star_class + " label.star").removeClass("hover");
	}).click(function() {
		let star_name = "";
		let star_class = "";
		if($(this).parents("div").hasClass("ja_re_commu")) { star_class="ja_re_commu"; star_name="소통"; }
		if($(this).parents("div").hasClass("ja_re_price")) { star_class="ja_re_price"; star_name="가격"; }
		if($(this).parents("div").hasClass("ja_re_result")) { star_class="ja_re_result"; star_name="시공결과"; }
		if($(this).parents("div").hasClass("ja_re_schedule")) { star_class="ja_re_schedule"; star_name="일정준수"; }
		if($(this).parents("div").hasClass("ja_re_as")) { star_class="ja_re_as"; star_name="A/S"; }
		let star_idx = $("." + star_class + " label.star").index(this);  // 0~4   
		for(let i=0; i<=star_idx; i++) {
			$("." + star_class + " label.star").eq(i).addClass("selected");
		}
		for(let i=star_idx+1; i<=4; i++) {
			$("." + star_class + " label.star").eq(i).removeClass("selected");
		}
		$("#input_"+star_class).val(star_idx+1);
	});
	
	$(".ja_con_review_submint").click(function(){
		location.href = "Controller?command=interior_action";
	});
	
	//alert
	$(".ja_re_up_photo_box").click(function(){
		alert("기능 작업중입니다.");
	});
	
	$(".ja_re_blue_btn").click(function(){
		alert("기능 작업중입니다.")
	});
	
	$(".ja_con_review_submit").click(function(){
		alert("기능작업중으로 인테리어 메인화면으로 이동합니다.")
	});
});