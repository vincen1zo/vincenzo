//헤더 검색창 색 변경
	$(function() {
		// 대메뉴 밑줄
		 $(".upb").click(function(){
				$(".upb").removeClass("y_active_on_just_color");
				$(this).addClass('y_active_on_just_color');
			}); 
	//소메뉴 밑줄
		$(".downb").click(function(){
			$(".downb").removeClass("y_active_on");
			$(this).addClass("y_active_on");
	//화면바뀜		
			$(".ja_menu_content").removeClass('on');
			let idx = $(".downb").index($(this));
			$(".ja_menu_content").eq(idx).addClass('on');
			
		});
	});