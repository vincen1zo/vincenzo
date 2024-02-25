// 가격 올라가기
function calc_total_price() {
		let total_price = 0;
		$(".item_price").each(function(idx, item) {
			let price = Number( $(item).text().replace('원','') );
			total_price += price;
		});
		$("#product_total").text(total_price + '원');
		$("#final_price").text('총 ' + total_price + '원');
	} 

$(function() {
	// + 버튼 누르면 상품 갯수에 맞춰서 가격 변경
	$(".btn_plus").click(function() {
		let new_value = Number( $(this).parent().find(".qty").val() ) + 1; //getter / val()에 값이 비어있으면 원래 가지고 있는 값을뽑아온다. 
		$(this).parent().find(".qty").val(new_value);//setter
		
		let unit_price = 
			$(this).parent().parent().find(".unit_price").text();
		unit_price = Number( unit_price.replace('원','').replaceAll(',','') );
		
		let qty = 
			Number( $(this).parent().find('.qty').val() );
			
		let item_price = unit_price * qty;
		$(this).parents(".content_r").find('.item_price').text(item_price + '원');
		
		calc_total_price();
	});
	
	// - 버튼 누르면 상품 갯수에 맞춰서 가격 변경
	$(".btn_minus").click(function() {
		let new_value = Number( $(this).parent().find(".qty").val() ) - 1;
		if(new_value < 0) new_value = 0;
		$(this).parent().find(".qty").val(new_value);
		
		let unit_price = 
			$(this).parent().parent().find(".unit_price").text();
		unit_price = Number( unit_price.replace('원','').replaceAll(',','') );
		let qty = 
			Number( $(this).parent().find('.qty').val() );
		let item_price = unit_price * qty;
		$(this).parents(".content_r").find('.item_price').text(item_price + '원');
		
		calc_total_price();
	});
		
	//alert 모음
	$(".btn_x").click(function(){
		alert("삭제기능 작업중입니다");
	});
	
	//상품 선택하면 해당 상품 상세페이지로 이동
	$(".ja_product_idx").click(function(){
		let productIdx = $(this).attr("productIdx");
		location.href = "Controller?command=product_detail&product_idx="+productIdx;
	})

});