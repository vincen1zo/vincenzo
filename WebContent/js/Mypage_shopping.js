//헤더 검색창 색 변경
$(function() {
	$(".search1 > input").focus(function() {
		$(".search1").addClass('click');
	});
	$(".search1 > input").blur(function() {
		$(".search1").removeClass('click');
	});
	// 글자만
	 $(".upb").click(function(){
			$('.upb').removeClass("y_active_on_just_color");
			$(this).addClass('y_active_on_just_color');
		}); 
//소메뉴 밑줄
	$(".downb").click(function(){
		$('.downb').removeClass("y_active_on");
		$(this).addClass('y_active_on');
	});
//누른 버튼에 따라 display none제거
	$(".b1").click(function(){
		$('.all_ol').show();
		$('.all_po').hide();
	});
	$(".b3").click(function(){
		$('.all_po').show();
		$('.all_ol').hide();
	});
//상품문의 주문문의 버튼 display: none제거버튼
	$(".product").click(function(){
		$('.all_in_1, .all_in_2').show();
		$('.all_in_4, .all_in_3').hide();
	});
	$(".order").click(function(){
		$('.all_in_4, .all_in_3').show();
		$('.all_in_1, .all_in_2').hide();
	});
//상품문의 주문문의 밑줄
	$(".button").click(function() {
		$('.button').removeClass("y_on");
		$(this).addClass("y_on");
	});

//삭제버튼
	$(".delete_b").click(function() {
		let inquiryIdx = $(this).attr('inquiryIdx');
		let _this = $(this);
		$.ajax({
			url: 'Controller',
			type: 'post',
			data: { inquiryIdx : inquiryIdx,
					command : "ajax_mypage_inquiry_delete",
			},
			success: function(data) {
				if(data.result == "OKAY"){
					alert("삭제되었습니다.");
					_this.parent(".myinquiry_content").remove();
				}
			},
			error: function(request, status,error) {
				alert("에러" + request.status);
			}
		});
		
	});
	
	//상품 상세페이지연결
	$(".b_prodduct_info").click(function(){
		let productIdx = $(this).parent(".b_prodduct_area").attr("productIdx");
		location.href="Controller?command=product_detail&product_idx="+productIdx;
	});
	
	//alert
	$(".order_number_tl").click(function(){
		alert("페이지 작업중입니다\n아래상품을 클릭하면 해당 상세페이지로 이동합니다.");
	});
	
	$(".order-list_menu_unit").click(function(){
		alert("작업중입니다");
	});
	
	//오늘의 딜로 연결
	$(".event_banner").click(function(){
		location.href="Controller?command=o_deal";
	});
});