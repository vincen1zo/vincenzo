<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	if(session.getAttribute("loginEmail")==null) {
%>
		<script>alert("로그인해주십시오"); location.href="Controller?command=login_form&ret_cmd=Ozip_write_form";</script>
<%
	} 
%>    
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>오집in 질문 글쓰기 | 라이프스타일 슈퍼앱, 오늘의집</title>
	<!-- <link rel="stylesheet" href="../css/All.css"> -->
	<!-- <link rel="stylesheet" href="css/header.css"> -->
	<link rel="stylesheet" href="css/footer.css">
	<link rel="stylesheet" href="css/Mypage_shopping.css">
	<link rel="stylesheet" href="css/Ozip_write_page.css">
	<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
	<script src="js/jquery-3.7.1.min.js"></script>
	<script>
		let global_idx=1;
		$(function() {
			$(".jy_img_plus_btn").click(function() {
				global_idx++;
				let s = '<div id="jy_input_second' + global_idx + '" class="jy_input_second">'
						+ '<div class="input_img_area">'
						+ '	<div class="input_img_area_flex">'
						+ '		<span class="camera_i_con"></span>'
						+ '		<span class="img_minfo_i_con">사진을 끌어다 놓으세요</span>'
						+ '		<span class="img_sinfo_i_con">10장까지 올릴 수 있어요.</span>'
						+ '	</div>'
						+ ' <img id="image' + global_idx + '" src="" style="display:none; max-width:390px; margin:0 auto;"/>'
						+ '	<label class="img_bring_here">'
						+ '		PC에서 불러오기'
						+ '		<input type="file" name="imgFile' + global_idx + '" class="jy_input_img" value="PC에서 불러오기"/>'
						+ '	</label>'
						+ '</div>'
						+ '<div class="content_content_content">'
						+ '	<textarea class="write_ozip" name="OzipDescription' + global_idx + '" placeholder="어떤 질문인지 짧은 소개로 시작해보세요.&#10;다양한 태그도 사용 가능해요!"></textarea>'
						+ '</div>'
						+ '</div>';
				$("#div_right").append(s);
			});
			
			//$("input[type=file]").on("change", function(e) {
			$(document).on("change", "input[type=file]", function(e) {
				let idx = $(this).attr("name").substring(7);
//alert("idx : " + idx);
				$("#image"+idx).prev().css("display","none");

				let files = e.target.files;
				let reader = new FileReader();
				reader.onload = function(e) {
					//let str = '<img src="'+e.target.result+'"/>';
					//$("#file1").parent().parent().append(str);
					$("#image"+idx).attr("src", e.target.result);
					$("#image"+idx).css("display", "block");
					//$("#btn_remove_file").css("display", "block");
					
					
					let s2 = '<div id="jy_btn_img_btn' + global_idx + '" class="jy_btn_img_btn">'
							+ '	<button class="jy_move_bar_tl" type="button"><div class="jy_move_bar"></div></button>'
							+ '	<div class="jy_img">'
							+ '		<div class="jy_img_flex">'
							+ '			<div class="jy_img_box">'
							+ '				<img class="jy_images" src="' + e.target.result + '"/>'
							+ '			</div>';
					if(global_idx>1) {
						s2 += '			<button class="jy_img_delete_btn" type="button"><svg width="24" height="24" fill="currentColor" viewBox="0 0 24 24" preserveAspectRatio="xMidYMid meet"><path d="M6 19V7h12v12a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2zM19 4v2H5V4h3.5l1-1h5l1 1H19z"></path></svg></button>';
					}
					s2 += '		</div>'
							+ '	</div>'
							+ '	<button class="jy_move_bar_tl" type="button"><div class="jy_move_bar"></div></button>'
							+ '</div>';
					
					$("#div_left > .jy_images_mini_tl").append(s2);
				}
				reader.readAsDataURL(files[0]);
			});
			
			// 삭제버튼 클릭시
			$(document).on("click", ".jy_img_delete_btn", function() {
				let idx = $(this).parents(".jy_btn_img_btn").attr("id").substring(14);
//alert("delete idx : " + idx);
				$("#jy_input_second"+idx).remove();
				$("#jy_btn_img_btn"+idx).remove();
			});
			
			$("#jy_upload").click(function() {
				$("#input_global_idx").val(global_idx);
			});			
		});
	</script>
</head>
<body>
<!-- <img src="upload/월시.jpg"/> -->
	<form action="Controller?command=Ozip_write_upload" method="post" enctype="multipart/form-data">
		<input type="hidden" id="input_global_idx" name="global_idx"/>
		<input type="hidden" name="command" value="Ozip_write_upload"/>
		
		<!-- <input type="hidden" value=""> -->
		<header>
			<div class="fixed-container" style="height: 81px;">
			<div id = "header">
				<div id = "header_inner">
					<div class = "test">
						<div class="logo"><a href="Controller?command=community_main"><img src="images/logo.png"/></a></div>
						<div class="topSelect">
							<div class="top_icon">
								<div class="top_icon3">
									<button id="jy_upload">
										<div><span>올리기</span></div>
									</button>
								</div>
							</div>
						</div>
					</div>
					<div style="clear:both;"></div>
				</div>
			</div>
		</div>			
		<div style="clear:both"></div>
	</header>
		<div class="page_all">
			<div class="write_content_tl"><!-- 사진 , 글 content 들어감 -->
				<div class="asdfg">
					<div id="div_left">   
						<div class="jy_images_mini_tl">

						<%-- <!-- 좌측 이미지 반복 -->
							<div class="jy_btn_img_btn">
								<button class="jy_move_bar_tl" type="button"><div class="jy_move_bar"></div></button>
								<div class="jy_img">
									<div class="jy_img_flex">
										<div class="jy_img_box">
											<img class="jy_images" src="images/dog.jpg"/>
										</div>
										<button class="jy_img_delete_btn" type="button"><svg width="24" height="24" fill="currentColor" viewBox="0 0 24 24" preserveAspectRatio="xMidYMid meet"><path d="M6 19V7h12v12a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2zM19 4v2H5V4h3.5l1-1h5l1 1H19z"></path></svg></button>
									</div>
								</div>
								<button class="jy_move_bar_tl" type="button"><div class="jy_move_bar"></div></button>
							</div>
							<!-- //좌측 이미지 반복 -->  --%>
						</div>
						<div>	
							<button type="button" class="jy_img_plus_btn">
								<span class="jy_plus"></span>
							</button>
						</div>
					</div>
					<div id="div_right">
						<div class="jy_input_frist">
							<div class="input_img_area">
								<div class="input_img_area_flex">
									<span class="camera_i_con"></span>
									<span class="img_minfo_i_con">사진을 업로드 하세요.</span>
									<span class="img_sinfo_i_con">10장까지 올릴 수 있어요.</span>
								</div>
								<img id="image1" src="" style="display:none; max-width:390px; margin:0 auto;"/>
								<label class="img_bring_here">
									PC에서 불러오기
									<input type="file" name="imgFile1" class="jy_input_img" value="PC에서 불러오기"/>
								</label>
							</div>
							<div class="content_content_content">
								<input type="text" name="OzipTitle" class="write_ozip_title" maxlength="30" placeholder="제목을 입력해주세요."/>
								<!-- <div class="write_ozip" name="OzipDescription" spellcheck="false" contenteditable="true" placeholder="어떤 질문인지 짧은 소개로 시작해보세요.&#10;다양한 태그도 사용 가능해요!"></div> -->
								<textarea class="write_ozip" name="OzipDescription1" placeholder="어떤 질문인지 짧은 소개로 시작해보세요.&#10;다양한 태그도 사용 가능해요!"></textarea>
							</div>
						</div>
						<%--
						<!-- 이미지 업로드 반복 -->
						<div class="jy_input_second">
							<div class="input_img_area">
								<div class="input_img_area_flex">
									<span class="camera_i_con"></span>
									<span class="img_minfo_i_con">사진을 끌어다 놓으세요</span>
									<span class="img_sinfo_i_con">10장까지 올릴 수 있어요.</span>
								</div>
								<img id="image2" src="" style="display:none; max-width:390px; margin:0 auto;"/>
								<label class="img_bring_here">
									PC에서 불러오기
									<input type="file" name="imgFile2" class="jy_input_img" value="PC에서 불러오기"/>
								</label>
							</div>
							<div class="content_content_content">
								<textarea class="write_ozip" name="OzipDescription2" placeholder="어떤 질문인지 짧은 소개로 시작해보세요.&#10;다양한 태그도 사용 가능해요!"></textarea>
							</div>
						</div>
						<!-- //이미지 업로드 반복 -->
						 --%>
					</div>
				</div>
				<div>
					<input class="jy_hashtag_input" type="text" name="hashtag" placeholder="주요 키워드를 입력해주세요." maxlength="45">
				</div>
			</div>
		</div>
	</form>
</body>
</html>