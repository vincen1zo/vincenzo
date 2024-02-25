$(function() {
	// sort_btn 클릭시 색 변경
	$(".ja_sort_btn_border").click(function(){
		$(".ja_sort_btn_border").removeClass('on');
		$(this).addClass('on');
		alert("작업중으로 정렬이 변경되지 않습니다");
	});
	//정렬 > 책임보장 체크박스 표시
	$(".ja_sort_gor_check_box").click(function(){
		if(!$(this).hasClass('on')){
			$(".ja_sort_gor_check_box").addClass('on');
			$(".ja_sort_gor_check").addClass('on');
		} else {
			$(".ja_sort_gor_check_box").removeClass('on');
			$(".ja_sort_gor_check").removeClass('on');
		}
	});
	
	// 주소검색 > 검색창 클릭시 색 변경
	$(".ja_madal_select_input").click(function(){
		$(".ja_madal_select_input").removeClass('on');
		$(this).addClass('on');
	});
	
	
	//이미지에 마우스 올리면 hover
	$(".ja_content_ele_img_list").hover(function(){
		$(this).find("button").css("opacity","1");
	},function(){
		$(this).find("button").css("opacity","0");
	});
	
	//업체 상세페이지로 넘어가기
	$(".ja_content_ele_inner").click(function(){
		let conName = $(this).find(".ja_content_ele_text_title1").text();
		location.href="Controller?command=interior_detail&conName=" + conName;
	});
	
	// 배너 외부서버이동
	$(".ja_banner").click(function(){
		alert("외부서버로 이동합니다");
	});
	
	//시공지주소 alert
	$(".ja_select_box").click(function(){
		alert("입력된 주소지 거리를 기준으로 가까운 업체부터 정렬됩니다");
	});
	
	//링크alert
	$(".ja_apt_link").click(function(){
		alert("공공데이터API 문제로 인해 20초 후 화면이 보여집니다.");
		location.href = "Controller?command=apt_main";
	});
});