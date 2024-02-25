$(function(){
	let conName = $(".i_name").text();
	$(".interior2 > button").click(function(){
		alert("작업중에 있습니다.\n 페이지 넘어가는거 확인하신 후 다른 탭 누르실 때 \n주소창에서 &tab=3 은 삭제해주세요")
		location.href="Controller?command=interior_detail&conName="+conName+"&tab=3";
	});
	
	$(".i_re_likey").click(function(){
		alert("작업중입니다");
	});
	
	//신고
	$(".report_btn").click(function(){
		alert("작업중입니다");
	});
});