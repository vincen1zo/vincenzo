<%@page import="vo.QAMainVo"%>
<%@page import="vo.QAVo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String paramCategory = (String) request.getAttribute("paramCategory");
	ArrayList<QAVo> listQARet = (ArrayList<QAVo>) request.getAttribute("listQA");
	ArrayList<QAMainVo> listQARet2 = (ArrayList<QAMainVo>) request.getAttribute("listQAMain");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>남의집 고객센터</title>
	<link rel="stylesheet" href="css/QA.css">
	<link rel="stylesheet" href="css/header.css">
	<link rel="stylesheet" href="css/footer.css">
	<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
	<script src="js/jquery-3.7.1.min.js"></script>
	<script src="js/QA.js"></script>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"/>
	<div class="QA_tl">
		<section class="QA_quick_tl">
			<div class="QA_quick_in">
				<div>
					<h2 class="help_what">무엇을 도와드릴까요?</h2>
					<ul>
					<%for(QAMainVo vo : listQARet2) {  %>
						<%if(vo.getq().length() < 50) { %>
							<li class="QA_quick "><a class="jy_QQb" href="#"><span class="mark">Q</span><%=vo.getq() %></a></li>
						<% } else {%>
							<li class="QA_quick"><a href="#"><span class="mark">Q</span>카카오 계정으로 로그인하면 이미 가입되었다고 합니다.</a></li>
						<% } %>
					<% } %>
					</ul>
				</div>
				<div class="QA_request_tl">
					<h2 class="QA_request_little_title">
						고객센터
						<span class="time">09:00 ~ 18:00</span>
					</h2>
					<div class="footer_box1_3">
						<div class="footer_box1_3c">평일: 전체 문의 상담</div>
						<div class="footer_box1_3c">토요일, 공휴일: 오늘의집 직접배송, 이사/시공/제품설치 문의 상담</div>
						<div class="footer_box1_3c">일요일: 휴무</div>
					</div>
					<div class="call_tl">
						<span class="call_icon"></span><strong>1111-1111</strong>
					</div>
					<div class="one_one_tl">
						<button class="one_one">상담하기</button>
						<a href="#">이메일 문의하기</a>
						<button class="email_copy">이메일 주소 복사하기</button>
					</div>
				</div>			
			</div>
		</section>
		<hr>
		<div class="QA_tag_tl">
			<nav class="QA_tag_line1">
				<div class="QA_tag <%= paramCategory.equals("전체") ? "chose" : "" %>"><span>전체</span></div>
				<div class="QA_tag <%= paramCategory.equals("주문/결제") ? "chose" : "" %>"><span>주문/결제</span></div>
				<div class="QA_tag <%= paramCategory.equals("배송관련") ? "chose" : "" %>"><span>배송관련</span></div>
				<div class="QA_tag <%= paramCategory.equals("취소/환불") ? "chose" : "" %>"><span>취소/환불</span></div>
				<div class="QA_tag <%= paramCategory.equals("반품/교환") ? "chose" : "" %>"><span>반품/교환</span></div>
				<div class="QA_tag <%= paramCategory.equals("증빙서류발급") ? "chose" : "" %>"><span>증빙서류발급</span></div>
				<div class="QA_tag <%= paramCategory.equals("로그인/회원정보") ? "chose" : "" %>"><span>로그인/회원정보</span></div>
				<div class="QA_tag <%= paramCategory.equals("서비스/기타") ? "chose" : "" %>"><span>서비스/기타</span></div>		
			</nav>
		</div>
		<section class="QA_quick_tl2">
			<ul class="QA_list_tl">
				<% for(QAVo vo : listQARet) { %>
				<li class="QA_list_unit">	<!--  -->
					<div class="jy_QA_b_tl">
						<button class="QA_b" btn="false" >
							<span>
								<span class="mark v2 jy_bold">Q</span>
								<%= vo.getQuestion()%>
							</span>
							<span class="expand_b">
							</span>
						</button>
					</div>
					<div class="jy_QA_answer_area jy_displaynone">
						<p><%= vo.getAnswer()%></p>
					</div>
				</li>					<!--  -->
				<%
					}
				%>
			</ul>
		</section>	
	</div>
	<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>