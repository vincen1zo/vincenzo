$(function(){
	//리뷰쓰기 버튼 누르면 모달창나오게 + 해당 상품 이미지 들어가게
	$(".ja_re_write_btn").click(function(){
		let imgUrl = $(this).parent().parent().find("img").attr("src");
		$(".ja_review_madal_product_img").attr("src",imgUrl);
		
		let productBrand = $(this).parent().parent().find(".ja_re_product_brand").text();
		$(".ja_re_modal_product_brand").text(productBrand);
		
		let productName = $(this).parent().parent().find(".ja_re_product_name").text();
		$(".ja_re_modal_product_name").text(productName);
		
		let productOption = $(this).parent().parent().find(".ja_re_product_option").text();
		$(".ja_re_modal_product_option").text(productOption)
		
		let productIdx = $(this).parent().parent().attr("product_idx");
		$("#hidden_product_idx").val(productIdx);
		
		let orderIdx = $(this).parent().parent().attr("order_idx");
		$("#hidden_order_idx").val(orderIdx);
		
		let optionIdx = $(this).parent().parent().attr("option_idx");
		$("#hidden_option_idx").val(optionIdx);

		$(".ja_review_modal_bg").show();
		$(".ja_review_modal_inner").show();
	})
	
	// 리뷰쓰기 모달창에서 X버튼 누르면 닫아짐
	$(".ja_review_title_xbtn").click(function(){
		$(".ja_review_modal_inner").hide();
		$(".ja_review_modal_bg").hide();
	});
	
	
	//남의집 리뷰정책 slideUp(), slideDown()
	let ja_review_madal_policy_btn = false;
	$(".ja_review_madal_policy_btn").click(function(){
		if(!ja_review_madal_policy_btn){
		$(".ja_open").slideDown();
		$(".ja_icon").addClass("up");
		
		ja_review_madal_policy_btn = true;
		}else if(ja_review_madal_policy_btn){
			$(".ja_open").slideUp();
			$(".ja_icon").removeClass("up");
			ja_review_madal_policy_btn = false;
		}
	});
	
	// 리뷰쓰기 모달창 > textarea 글자수 표시 + 1000자 글자제한
	$(".ja_review_modal_section > textarea").keyup(function(e){
		let content = $(this).val();
		
		// 글자수 세기
		$(".ja_review_write_cnt_num").text(content.length);
		
		// 글자수 제한
		if(content.length > 1000){
			$(this).val($(this).val().substring(0,1000));
			alert("리뷰 글자수는 1000자까지 가능합니다.")
		}
	});
	
	//별점
	$("label.star").mouseenter(function() { //hover
		let star_class = "";
		let star_name = "";
		if($(this).parents("div").hasClass("ja_re_mo_durability")) { star_class="ja_re_mo_durability"; star_name="내구성"; }
		if($(this).parents("div").hasClass("ja_re_mo_price")) { star_class="ja_re_mo_price"; star_name="가격"; }
		if($(this).parents("div").hasClass("ja_re_mo_design")) { star_class="ja_re_mo_design"; star_name="디자인"; }
		if($(this).parents("div").hasClass("ja_re_mo_destination")) { star_class="ja_re_mo_destination"; star_name="배송"; }
		let star_idx = $("." + star_class + " label.star").index(this);  // 0~4   
		for(let i=0; i<=star_idx; i++) {
			$("." + star_class + " label.star").eq(i).addClass("hover");
		}
	}).mouseleave(function() {
		let star_name = "";
		if($(this).parents("div").hasClass("ja_re_mo_durability")) { star_class="ja_re_mo_durability"; star_name="내구성"; }
		if($(this).parents("div").hasClass("ja_re_mo_price")) { star_class="ja_re_mo_price"; star_name="가격"; }
		if($(this).parents("div").hasClass("ja_re_mo_design")) { star_class="ja_re_mo_design"; star_name="디자인"; }
		if($(this).parents("div").hasClass("ja_re_mo_destination")) { star_class="ja_re_mo_destination"; star_name="배송"; }
		$("." + star_class + " label.star").removeClass("hover");
	}).click(function() {
		let star_name = "";
		let star_class = "";
		if($(this).parents("div").hasClass("ja_re_mo_durability")) { star_class="ja_re_mo_durability"; star_name="내구성"; }
		if($(this).parents("div").hasClass("ja_re_mo_price")) { star_class="ja_re_mo_price"; star_name="가격"; }
		if($(this).parents("div").hasClass("ja_re_mo_design")) { star_class="ja_re_mo_design"; star_name="디자인"; }
		if($(this).parents("div").hasClass("ja_re_mo_destination")) { star_class="ja_re_mo_destination"; star_name="배송"; }
		let star_idx = $("." + star_class + " label.star").index(this);  // 0~4   
		for(let i=0; i<=star_idx; i++) {
			$("." + star_class + " label.star").eq(i).addClass("selected");
		}
		for(let i=star_idx+1; i<=4; i++) {
			$("." + star_class + " label.star").eq(i).removeClass("selected");
		}
		$("#input_"+star_class).val(star_idx+1);
	});
	
	//내가 작성한 리뷰 정렬버튼
	$(".ja_my_re_button").click(function() {
		$(".ja_my_re_button").removeClass('on');
		$(this).addClass('on');
		alert("작업중입니다. 정렬되지않습니다.");
	});
	
	// 파일 선택시 
	$("#file1").on("change", function(e) {
		let files = e.target.files;
		let reader = new FileReader();
		reader.onload = function(e) {
			$("#image1").attr("src", e.target.result);
			$("#image1").css("display", "block");
			$("#btn_remove_file").css("display", "block");
		}
		reader.readAsDataURL(files[0]);
	});
	
	// 파일 삭제버튼 클릭시
	$("#btn_remove_file").click(function() {
		$("#file1").val('');
	    $("#image1").css("display", "none");
	});
	
	//리뷰 삭제버튼 클릭시
	$(".ja_my_re_delete_btn").click(function() {
		let review_idx = $(this).parent().attr("review_idx");
		location.href = "Controller?command=mypage_review_delete&review_idx=" + review_idx;
	});
	
	//리뷰수정 버튼 누르면 모달창나오게 + 해당 상품 이미지 들어가게
	$(".ja_my_re_modification_btn").click(function(){
		alert("리뷰수정창은 작업중입니다.");
	})
	
	// 리뷰쓰기탭에 상품 클릭시 상세페이지로 이동
	$(".ja_review_img").click(function(){
		let productIdx = $(this).parent(".ja_review_product").attr("product_idx");
		location.href = "Controller?command=product_detail&product_idx="+productIdx;
	});
	
});