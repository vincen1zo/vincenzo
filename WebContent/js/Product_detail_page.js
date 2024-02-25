$(function() {
		$(".kh_dp_img > img").attr("src", "<%=listProductMainImgVo.get(0).getImgUrl()%>");
			
			$(".kh_dprb3_1").click(function() {
				alert("준비중입니다. - 장바구니");
			});
			$(".kh_dprb3_2").click(function() {
				alert("준비중입니다. - 바로구매");
			});
			
			//메뉴 밑줄
			$(".m_line").click(function(){
				$(this).addClass('on');
			});
		//
			$(".jy_product_btn").click(function(){
				$('.jy_product_btn').removeClass("y_active_on");
				$(this).addClass('y_active_on');
			});
		//상품정보 태그 고정
			$(window).scroll(function () {
				console.log($(window).scrollTop());
				if($(window).scrollTop() >= 895){
					$('.jy_product_detail_info_menubar_tl').addClass('fixed');
				}
				if($(window).scrollTop() <= 896) {
					$('.jy_product_detail_info_menubar_tl').removeClass('fixed')
				}
				if($(window).scrollTop() >= 900){
					$('.jy_product_buying_tl_sticky').addClass('sticky');
				}
				if($(window).scrollTop() <= 901) {
					$('.jy_product_buying_tl_sticky').removeClass('sticky')
				}
			});
	});