<%@page import="vo.OzipDetailVo2"%>
<%@page import="vo.OzipDetailVo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	if(session.getAttribute("loginEmail")==null) {
%>
		<script>alert("로그인부터..."); location.href="Controller?command=login_form";</script>
<%
	} 
%>    
<%
	OzipDetailVo2 vo = (OzipDetailVo2)request.getAttribute("vo");
	ArrayList<OzipDetailVo> listOzipDetailVo = (ArrayList<OzipDetailVo>) request.getAttribute("listOzipDetailVo");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>오집in 질문 글쓰기 | 라이프스타일 슈퍼앱, 오늘의집</title>
	<link rel="stylesheet" href="../css/All.css">
	<!-- <link rel="stylesheet" href="css/header.css"> -->
	<link rel="stylesheet" href="css/footer.css">
	<link rel="stylesheet" href="css/Mypage_shopping.css">
	<link rel="stylesheet" href="css/Ozip_write_page.css">
	<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
	<script src="js/jquery-3.7.1.min.js"></script>
	<script>
		//메뉴 밑줄
		$(function(){
			$(".active").click(function(){
				$(this).addClass('on');
			});
		});
	</script>
</head>
<body>
	<form action="Controller?command=Ozip_modify&ozipIdx=<%=vo.getOzipIdx() %>" method="post">
		<header>
			<div class="fixed-container" style="height: 81px;">
			<div id = "header">
				<div id = "header_inner">
				<div class = "test">
					<div class="logo"><a href="#"><img src="images/logo.png"/></a></div>
					<div class="topSelect">
						<div class="top_icon">
							<div class="top_icon3">
								<button type="submit" id="jy_upload">
									<div><span>수정하기</span></div>
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
					<div class="input_img_area">
						<div class="input_img_area_flex">
							<span class="camera_i_con"></span>
							<span class="img_minfo_i_con">사진을 끌어다 놓으세요</span>
							<span class="img_sinfo_i_con">10장까지 올릴 수 있어요.</span>
						</div>
						<button class="img_bring_here">PC에서 불러오기</button>
					</div>
					<div class="content_content_content">
						<input type="text" name="ozipTitle" class="write_ozip_title" maxlength="30" placeholder="제목을 입력해주세요." value="<%=vo.getOzipTitle() %>"/>
						<% for(OzipDetailVo vo2 : listOzipDetailVo ) { %>
						<textarea class="write_ozip" name="ozipDescription" placeholder="어떤 질문인지 짧은 소개로 시작해보세요.&#10;다양한 태그도 사용 가능해요!"><%=vo2.getOzipDetailDescription() %></textarea>
						<% }%>
					</div>
				</div>
				<div>
					<button  type="button" class="jy_tag_btn">
						클릭하여 주요 키워드를 입력해주세요.
					</button>
				</div>
			</div>
		</div>
	</form>
</body>
</html>