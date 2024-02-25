$(function() {
	//시공리뷰 > 정렬버튼 
	$(".inte_con_re_btn").click(function() {
		$(".inte_con_re_btn").removeClass('color');
		$(this).addClass('color');
		alert("작업중입니다. 정렬되지않습니다");
	});
	
	// 팝업 관련 스크롤 막기(시공리뷰 사진)
	$(".con_inte_rev_img_pop_bigBox").on('mousewheel', function(event) {
		event.stopPropagation();
		event.preventDefault();
	});
	$(".con_inte_rev_img_pop_smallBox_outer").on('mousewheel', function(event) {
		event.stopPropagation();

	    let currY = $(this).scrollTop();
	    let postHeight = $(this).height();
		let scrollHeight = $('.con_inte_rev_img_pop_smallBox').height();
		let scrollPercent = (currY / (scrollHeight - postHeight)) * 100;
		//console.log(scrollPercent);

		if(scrollPercent==100) {
			event.preventDefault();
			$('.con_inte_rev_img_pop_smallBox_outer').scrollTop(
				$('.con_inte_rev_img_pop_smallBox_outer').scrollTop()-1
			);
		}
	});
	
	// 팝업 관련 스크롤 막기(사진)
	$(".con_inte_photo_img_pop_bigBox").on('mousewheel', function(event) {
		event.stopPropagation();
		event.preventDefault();
	});
	$(".con_inte_photo_img_pop_smallBox_outer").on('mousewheel', function(event) {
		event.stopPropagation();

	    let currY = $(this).scrollTop();
	    let postHeight = $(this).height();
		let scrollHeight = $('.con_inte_photo_img_pop_smallBox').height();
		let scrollPercent = (currY / (scrollHeight - postHeight)) * 100;
		//console.log(scrollPercent);

		if(scrollPercent==100) {
			event.preventDefault();
			$('.con_inte_photo_img_pop_smallBox_outer').scrollTop(
				$('.con_inte_photo_img_pop_smallBox_outer').scrollTop()-1
			);
		}
	});
	//페이지 메뉴에 마우스 클릭했을 때 색고정, 밑줄뜨기, 해당 div show
	$(".con_menu_a").click(function(){
		$(".con_menu_a").removeClass("on"); // 전체지우고 
		$(this).addClass("on");//클릭만 준다
		
		$(".con_menu_a .blue_bar_o").removeClass('blue_bar_o');
		$(this).find('.blue_bar').addClass('blue_bar_o');
		
		$('.snh').removeClass('on');
		let idx = $('.con_menu_a').index($(this));
		$(".snh").eq(idx).addClass('on');
	});
	
	//리뷰쓰기버튼 > 리뷰쓰기 페이지뜨기
	$(".btn_two_box .btn2").click(function() {
		location = "Controller?command=interior_review_form&conName="+conName;
	});
	
	//모두보기>리뷰전체보기 > 시공리뷰 화면 나오게
	$(".con_re_box_add").click(function(){
		$(".con_menu_a").removeClass("on"); // 전체지우고 
		$("#m_review").addClass("on");//클릭만 준다
		
		$(".con_menu_a .blue_bar_o").removeClass('blue_bar_o');
		$("#m_review_blue").addClass('blue_bar_o');
		
		$('.snh').removeClass('on');
		$("#inte_con_re_big_box").addClass('on');
	})
	
	//모두보기 > 리뷰 하나 클릭하면 > 시공리뷰 화면 나오게
	$(".con_re").click(function(){
		$(".con_menu_a").removeClass("on"); // 전체지우고 
		$("#m_review").addClass("on");//클릭만 준다
		
		$(".con_menu_a .blue_bar_o").removeClass('blue_bar_o');
		$("#m_review_blue").addClass('blue_bar_o');
		
		$('.snh').removeClass('on');
		$("#inte_con_re_big_box").addClass('on');
	})
	
	//상담신청 누르면 "준비중입니다" 뜨기
	$(".btn1").click(function(){
		alert("준비중입니다");
	});
	
	//전체보기하면 해당 div 열림(시공사례)
	$(".c_case_sigong").click(function(){
		$(".con_menu_a").removeClass("on");  
		$("#m_sigong").addClass("on");
		
		$(".con_menu_a .blue_bar_o").removeClass('blue_bar_o');
		$("#m_sigong_blue").addClass('blue_bar_o');
		
		$('.snh').removeClass('on');
		$("#d_con_content_box").addClass('on');
	})
	
	//이미지 클릭하면 해당 집들이페이지로 이동(시공사례)
	$(".c_case_sigong_sa").click(function(){
		let houepartyIdx = $(this).children(".ja_article").attr("no");
		location.href = "Controller?command=houseparty_detail&houseparty_idx="+houepartyIdx;
	});
	
	//전체보기하면 해당 div 열림(공지)
	$(".notice_box").click(function(){
		$(".con_menu_a").removeClass("on");  
		$("#m_info").addClass("on");
		
		$(".con_menu_a .blue_bar_o").removeClass('blue_bar_o');
		$("#m_info_blue").addClass('blue_bar_o');
		
		$('.snh').removeClass('on');
		$("#con_info_box").addClass('on');
	})
	
	//전체보기하면 해당 div 열림(사진)
	$("#photo_all").click(function(){
		$(".con_menu_a").removeClass("on");  
		$("#m_photo").addClass("on");
		
		$(".con_menu_a .blue_bar_o").removeClass('blue_bar_o');
		$("#m_photo_blue").addClass('blue_bar_o');
		
		$('.snh').removeClass('on');
		$("#interior_con_img_big_box").addClass('on');
	})
	
	// 사진하나 클릭하면 해당 div 열림(사진)
	$(".photo_go").click(function(){
		$(".con_menu_a").removeClass("on");  
		$("#m_photo").addClass("on");
		
		$(".con_menu_a .blue_bar_o").removeClass('blue_bar_o');
		$("#m_photo_blue").addClass('blue_bar_o');
		
		$('.snh').removeClass('on');
		$("#interior_con_img_big_box").addClass('on');
	})
	
	//모두보기 > 리뷰 > 이미지에 마우스 올리면 hover
	$(".con_re_small_box").hover(function(){
		$(this).find("button").css("opacity","1");
	},function(){
		$(this).find("button").css("opacity","0");
	});
	
	// slick  > 리뷰가 2개 이상이면 실행
	let cnt = $(".ja_con_review_list > .con_re").length;
	if(cnt>2) {
		$(".ja_con_review_list").slick({
			slidesToShow: 2,
			slidesToScroll: 2
		});
	}	
	/***********사진팝업 시작***********/
	// 사진 > 이미지 클릭시 팝업창 열기
	$(".interior_con_img_element").click(function(){
		$(".con_inte_photo_img_pop_bigBox").addClass("on");		
		$(".con_inte_photo_img_pop_smallBox_outer").addClass("on");		
	});
	
	// 사진 > X 클릭시 팝업창 닫기
	$(".x").click(function(){
		$(".con_inte_photo_img_pop_bigBox").removeClass("on");				
		$(".con_inte_photo_img_pop_smallBox_outer").removeClass("on");
	});
	/***********사진팝업끝***********/
	
	/***********리뷰사진 팝업 시작***********/
	// 사진 > 이미지 클릭시 팝업창 열기
	$(".inte_con_re_ele_images").click(function(){
		$(".con_inte_photo_img_pop_bigBox").addClass("on");		
		$(".con_inte_rev_img_pop_smallBox_outer").addClass("on");		
	});
	
	// 사진 > X 클릭시 팝업창 닫기
	$(".x").click(function(){
		$(".con_inte_photo_img_pop_bigBox").removeClass("on");				
		$(".con_inte_rev_img_pop_smallBox_outer").removeClass("on");
	});
	/***********리뷰사진 팝업 끝***********/
	
	/*도움이됐어요*/
	$(".ja_product_re_help_btn").click(function(){
		let reviewIdx = $(this).parent().attr("review_idx");
		let _this = $(this);
		$.ajax({
			type: 'post',
			data: {member_id : memberId, review_idx:reviewIdx, command:"ajax_review_like"},
			url: 'Controller',
			success: function(data){ 
				let now_num = _this.parent().find("p").text();
				now_num = Number(now_num.substring(0, now_num.indexOf('명')).trim())
				if(data.result=="INSERTED")
					_this.parent().find("p").text((now_num + 1)+' 명에게 도움이 됨');
				else if(data.result=="DELETED")
					_this.parent().find("p").text((now_num - 1)+' 명에게 도움이 됨');
			},
			error: function(r, s, e){
				alert("[에러] code:" + r.status
						+ "messgage:" + r.responseText
						+ "error:" + e)
			}
		});
	});
	
	// standard 클릭하면 alert
	$(".stan_top").click(function(){
		alert("외부페이지로 이동합니다.");
	})
	
	//신고
	$(".report_btn").click(function(){
		alert("작업중입니다");
	});
	
	//링크alert
	$(".ja_apt_link").click(function(){
		alert("공공데이터API 문제로 인해 20초 후 화면이 보여집니다.");
		location.href = "Controller?command=apt_main";
	});
});