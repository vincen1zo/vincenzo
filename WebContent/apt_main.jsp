<%@page import="java.util.HashMap"%>
<%@page import="vo.AptVo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ArrayList<AptVo> listAptVo =  (ArrayList<AptVo>) request.getAttribute("listAptVo");
	ArrayList<AptVo> listSubscription = (ArrayList<AptVo>) request.getAttribute("listSubscription");
	HashMap<Integer, String> mapAptIdxCompeteRate = (HashMap<Integer, String>) request.getAttribute("mapAptIdxCompeteRate");
	
	double latitude = (double) request.getAttribute("latitude");
	double longitude = (double) request.getAttribute("longitude");
	String address = request.getParameter("address");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>아파트메인페이지</title>
	<script src="js/jquery-3.7.1.min.js"></script>
	<script src="js/header_search.js"></script>
	<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=904d213f434a55bb59022ee552d77266&libraries=services"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<link rel ="stylesheet" href = "css/all.css">
	<link rel ="stylesheet" href = "css/header.css">
	<link rel ="stylesheet" href = "css/footer.css">
	<link rel ="stylesheet" href = "css/apt_main.css">
	<script>
		alert("지도의 마크업은 하늘색은 입력된 주소지로 부터의 가까운 아파트\n남색은 검색된 아파트가 DB에 있는경우\n빨간색은 청약 아파트를 나타내며 클릭시 경쟁률을 보여줍니다");
		function distance(lat1, lon1, lat2, lon2) {
		  const R = 6371; // 지구 반지름 (단위: km)
		  const dLat = deg2rad(lat2 - lat1);
		  const dLon = deg2rad(lon2 - lon1);
		  const a = Math.sin(dLat/2) * Math.sin(dLat/2) +
		            Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) *
		            Math.sin(dLon/2) * Math.sin(dLon/2);
		  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
		  const distance = R * c; // 두 지점 간의 거리 (단위: km)
		  return distance;
		}

		function deg2rad(deg) {
		  return deg * (Math.PI/180);
		}

		// 예시: 서울과 부산 간의 거리를 계산합니다.
		const seoulLat = 37.5665;
		const seoulLon = 126.9780;
		const busanLat = 35.1796;
		const busanLon = 129.0756;
		const dist = distance(seoulLat, seoulLon, busanLat, busanLon);
	</script>
	<script>
		$(function() {
			let mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = {
			        center: new kakao.maps.LatLng(<%=latitude%>, <%=longitude%>), // 지도의 중심좌표
			        level: 3 // 지도의 확대 레벨
			       	//setMinLevel(3);
					//setMaxLevel(5);
		    	}; 
			let map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
//			map.setMaxLevel(7);
			map.setMinLevel(1);
			// 이미지 지도에 표시할 마커입니다
			let imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png', // 마커이미지의 주소입니다    
			    imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
			    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

			// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
			let markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

			let content = null;
			let position = null;
			let customOverlay = null;
			
			let dist2 = 0.0;
			
			<% for(AptVo vo : listAptVo) { %>
			    // 커스텀 오버레이에 표시할 내용입니다     
				// HTML 문자열 또는 Dom Element 입니다 
				// 내 아파트일 때 : <svg width="42" height="42" viewBox="0 0 79 79" fill="none" xmlns="http://www.w3.org/2000/svg" color="#37507D"><path d="M79 39.5C79 61.3152 61.3152 79 39.5 79C17.6848 79 0 61.3152 0 39.5C0 17.6848 17.6848 0 39.5 0C61.3152 0 79 17.6848 79 39.5Z" fill="currentColor"></path><path d="M39.5569 16L32.6826 22.9625H46.4313L39.5569 16Z" fill="white"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M46.4313 22.9625V37H59V59H37.2391V59.0012H20V27.9512H32.6826V22.9625H46.4313ZM28.8859 32H23.9492V37H28.8859V32ZM37.0312 32H41.968V37H37.0312V32ZM41.968 23H37.0312V28H41.968V23ZM23.9492 41H28.8859V46H23.9492V41ZM41.968 41H37.0312V46H41.968V41ZM50.1143 41H55.051V46H50.1143V41ZM28.8859 50H23.9492V55H28.8859V50ZM37.0312 50H41.968V55H37.0312V50ZM55.051 50H50.1143V55H55.051V50Z" fill="white"></path></svg>
				dist2 = Math.pow((<%=latitude - vo.getLatitude()%>),2) + Math.pow(<%=longitude - vo.getLongitude()%>,2);
				if(dist2 < 0.0000002) {  // 내 아파트일 때
					content = '<div class ="marker_item" apt_idx="<%=vo.getAptIdx()%>">'
							+ '		<svg width="42" height="42" viewBox="0 0 79 79" fill="none" xmlns="http://www.w3.org/2000/svg" color="#37507D"><path d="M79 39.5C79 61.3152 61.3152 79 39.5 79C17.6848 79 0 61.3152 0 39.5C0 17.6848 17.6848 0 39.5 0C61.3152 0 79 17.6848 79 39.5Z" fill="currentColor"></path><path d="M39.5569 16L32.6826 22.9625H46.4313L39.5569 16Z" fill="white"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M46.4313 22.9625V37H59V59H37.2391V59.0012H20V27.9512H32.6826V22.9625H46.4313ZM28.8859 32H23.9492V37H28.8859V32ZM37.0312 32H41.968V37H37.0312V32ZM41.968 23H37.0312V28H41.968V23ZM23.9492 41H28.8859V46H23.9492V41ZM41.968 41H37.0312V46H41.968V41ZM50.1143 41H55.051V46H50.1143V41ZM28.8859 50H23.9492V55H28.8859V50ZM37.0312 50H41.968V55H37.0312V50ZM55.051 50H50.1143V55H55.051V50Z" fill="white"></path></svg>'
							+ '		<div class="bottom"><%=vo.getName()%></div>'
							+ '</div>';
				} else {   // 내 아파트가 아닐 때
					content = '<div class ="marker_item" apt_idx="<%=vo.getAptIdx()%>">'
							+ '		<svg width="42" height="42" viewBox="0 0 79 79" fill="none" xmlns="http://www.w3.org/2000/svg" color="#35C5F0"><path d="M79 39.5C79 61.3152 61.3152 79 39.5 79C17.6848 79 0 61.3152 0 39.5C0 17.6848 17.6848 0 39.5 0C61.3152 0 79 17.6848 79 39.5Z" fill="currentColor"></path><path d="M39.5569 16L32.6826 22.9625H46.4313L39.5569 16Z" fill="white"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M46.4313 22.9625V37H59V59H37.2391V59.0012H20V27.9512H32.6826V22.9625H46.4313ZM28.8859 32H23.9492V37H28.8859V32ZM37.0312 32H41.968V37H37.0312V32ZM41.968 23H37.0312V28H41.968V23ZM23.9492 41H28.8859V46H23.9492V41ZM41.968 41H37.0312V46H41.968V41ZM50.1143 41H55.051V46H50.1143V41ZM28.8859 50H23.9492V55H28.8859V50ZM37.0312 50H41.968V55H37.0312V50ZM55.051 50H50.1143V55H55.051V50Z" fill="white"></path></svg>'
							+ '		<div class="bottom"><%=vo.getName()%></div>'
							+ '</div>';
				}
				// 커스텀 오버레이가 표시될 위치입니다 
				position = new kakao.maps.LatLng(<%=vo.getLatitude()%>, <%=vo.getLongitude()%>);  
		
				// 커스텀 오버레이를 생성합니다
				customOverlay = new kakao.maps.CustomOverlay({
				    position: position,
				    content: content,
				    image: markerImage
				});
console.log(<%=vo.getLatitude()%> + " / " + <%=vo.getLongitude()%>);
		
				// 커스텀 오버레이를 지도에 표시합니다
				customOverlay.setMap(map);
			<% 
				} 
			%>
			<% for(AptVo vo : listSubscription) { %>
		    // 커스텀 오버레이에 표시할 내용입니다     
			// HTML 문자열 또는 Dom Element 입니다 
			// 내 아파트일 때 : <svg width="42" height="42" viewBox="0 0 79 79" fill="none" xmlns="http://www.w3.org/2000/svg" color="#37507D"><path d="M79 39.5C79 61.3152 61.3152 79 39.5 79C17.6848 79 0 61.3152 0 39.5C0 17.6848 17.6848 0 39.5 0C61.3152 0 79 17.6848 79 39.5Z" fill="currentColor"></path><path d="M39.5569 16L32.6826 22.9625H46.4313L39.5569 16Z" fill="white"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M46.4313 22.9625V37H59V59H37.2391V59.0012H20V27.9512H32.6826V22.9625H46.4313ZM28.8859 32H23.9492V37H28.8859V32ZM37.0312 32H41.968V37H37.0312V32ZM41.968 23H37.0312V28H41.968V23ZM23.9492 41H28.8859V46H23.9492V41ZM41.968 41H37.0312V46H41.968V41ZM50.1143 41H55.051V46H50.1143V41ZM28.8859 50H23.9492V55H28.8859V50ZM37.0312 50H41.968V55H37.0312V50ZM55.051 50H50.1143V55H55.051V50Z" fill="white"></path></svg>
			dist2 = Math.pow((<%=latitude - vo.getLatitude()%>),2) + Math.pow(<%=longitude - vo.getLongitude()%>,2);
			content = '<div class ="marker_item" apt_idx="<%=vo.getAptIdx()%>" compete_rate="<%=mapAptIdxCompeteRate.get(vo.getAptIdx())%>">'
					+ '		<svg width="42" height="42" viewBox="0 0 79 79" fill="none" xmlns="http://www.w3.org/2000/svg" color="#FF0000"><path d="M79 39.5C79 61.3152 61.3152 79 39.5 79C17.6848 79 0 61.3152 0 39.5C0 17.6848 17.6848 0 39.5 0C61.3152 0 79 17.6848 79 39.5Z" fill="currentColor"></path><path d="M39.5569 16L32.6826 22.9625H46.4313L39.5569 16Z" fill="white"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M46.4313 22.9625V37H59V59H37.2391V59.0012H20V27.9512H32.6826V22.9625H46.4313ZM28.8859 32H23.9492V37H28.8859V32ZM37.0312 32H41.968V37H37.0312V32ZM41.968 23H37.0312V28H41.968V23ZM23.9492 41H28.8859V46H23.9492V41ZM41.968 41H37.0312V46H41.968V41ZM50.1143 41H55.051V46H50.1143V41ZM28.8859 50H23.9492V55H28.8859V50ZM37.0312 50H41.968V55H37.0312V50ZM55.051 50H50.1143V55H55.051V50Z" fill="white"></path></svg>'
					+ '		<div class="bottom"><%=vo.getName()%></div>'
					+ '</div>';
			
			// 커스텀 오버레이가 표시될 위치입니다 
			position = new kakao.maps.LatLng(<%=vo.getLatitude()%>, <%=vo.getLongitude()%>);  
	
			// 커스텀 오버레이를 생성합니다
			customOverlay = new kakao.maps.CustomOverlay({
			    position: position,
			    content: content,
			    image: markerImage
			});


			// 커스텀 오버레이를 지도에 표시합니다
			customOverlay.setMap(map);
		<% 
			} 
		%>

			// 주소-좌표 변환 객체를 생성합니다
			let geocoder = new kakao.maps.services.Geocoder();
			
			$(".search2").click(function() {
				alert("입력된 주소지 거리를 기준으로 가까운 아파트부터 정렬되며 지도에도 나타납니다.");
				new daum.Postcode({
			        oncomplete: function(data) {
			        	//alert("선택한 주소:" + data.address);
			        	
			        	// 주소로 좌표를 검색합니다
			        	geocoder.addressSearch(data.address, function(result, status) {
			        	    // 정상적으로 검색이 완료됐으면 
			        	     if (status === kakao.maps.services.Status.OK) {
			        	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			        	        
			        	        let new_lat = result[0].y;
			        	        let new_lng = result[0].x;

					        	location.href = "Controller?command=apt_main&address=" + encodeURI(data.address) + "&lat=" + new_lat + "&lng=" + new_lng;
			        	    } 
			        	});    
			        	
			        	
						// location.href = "apt_main.jsp?address=" + encodeURI(data.address) + "&lat=<%=latitude%>&lng=<%=longitude%>";
			        	
			        }
			    }).open();
			});
			
			// 지도 상에 있는 아파트 아이콘 클릭시, apt_detail페이지로 이동.
			//$(".marker_item").click(function() {
			$(document).on("click", ".marker_item", function() {
				let apt_idx = $(this).attr("apt_idx");
				let compete_rate = $(this).attr("compete_rate");
				if(compete_rate != null) {
					alert("경쟁률 : " + compete_rate);
					return;
				}
				//alert("클릭한 아파트 apt_idx : " + apt_idx);
				location.href = "Controller?command=apt_detail&apt_idx=" + apt_idx;
			});
		});   // the end of the $(function)
		
	</script>
</head>
<body>
<div id = "container">
<header>
	<div class="fixed-container" style="height: 81px;">
		<div id = "header">
			<div id = "header_inner">
				<div class="logo"><a href="Controller?command=interior_main"><img src="images/logo.png"/></a></div>
				<div class="homemenu">
					<span class="h_menu"><a href="Controller?command=community_main">커뮤니티</a></span>
					<span class="h_menu"><a href="Controller?command=shopping_main">쇼핑</a></span>
					<span class="h_menu"><a href="Controller?command=interior_main" class="a">인테리어</a></span>
					<span class="h_menu"><a href="Controller?command=Ozip_main">오집in</a></span>
				</div>
				<div class="topSelect">
					<div class="search1">
						<span class="dbg"></span>
						<input type = "text" placeholder = "시공업체 검색(작업중)"/>
					</div>
					<div class="top_icon">
					<div class="top_icon1">
						<!-----------------------------------좋아요------------------------------------------>
						<a href="Controller?command=likey_book" style = "margin-right: 15px;"> 
							<span class = "ja_icon_likey"></span>
							<span class = "ja_icon_red_num">
								<span type = "fill" class = "ja_icon_num">1</span>
							</span>
						</a> 
						<!----------------------------------------------------------------------------------->
						<!-----------------------------------새소식------------------------------------------>
						<a href="Controller?command=new" style = "margin-right: 15px;">
							<span class = "ja_icon_new"></span>
							<span class = "ja_icon_red_num">
								<span type = "fill" class = "ja_icon_num">1</span>
							</span>
						</a>
						<!------------------------------------------------------------------------------------>
						<!-----------------------------------장바구니----------------------------------------->
						<a href="Controller?command=basket" style = "margin-right: 15px;">
							<span class = "ja_icon_basket"></span>
							<span class = "ja_icon_red_num">
								<span type = "fill" class = "ja_icon_num">1</span>
							</span>
						</a> 
						<!------------------------------------------------------------------------------------>
					</div>
					<!-----------------------------------프로필사진----------------------------------------->
					<div class="top_icon2">
						<div style="margin-left: -16px;">
							<button class = 'ja_icon2_btn'>
								<img src="https://image.ohou.se/i/bucketplace-v2-development/uploads/default_images/avatar.png?w=72&amp;h=72&amp;c=c">
							</button>
						</div> 
					</div>
					<!------------------------------------------------------------------------------------>
					<!-----------------------------------글쓰기----------------------------------------->
					<div class="top_icon3">
						<a href="https://ebony-drink-dc2.notion.site/2d90666c160c4c01aba3fe268e46ec25"><div><span>사이트설명</span></div></a>
					</div>
					<!------------------------------------------------------------------------------------>
					</div>
				</div>
				<!---------------------------마이페이지/로그아웃 시작--------------------------->
				<div class = "ja_pop_menu_big_box">
					<div class = "ja_pop_menu_box">
						<div class = "ja_pop_menu">
							<a class = "ja_pop_menu_title" href = "Controller?command=Mypage_profile_with_ozip">마이페이지</a>	
							<a class = "ja_pop_menu_title" href = "Controller?command=QA">고객센터</a>						
							<a class = "ja_pop_menu_title" href = "Controller?command=logout">로그아웃</a>					
						</div>						
					</div>
				</div>
				<!---------------------------마이페이지/로그아웃 끝--------------------------->
				<div style="clear:both;"></div>
			</div>
		</div>
	</div>
	<div class="sticky-container" style="height: 52px; top:80px; position:sticky;">
		<div class="menuLine">
			<div class="menuInner">
				<nav id="topMenu">
					<ul>
						<li class="m_line"><a href="Controller?command=interior_main">주거공간시공</a></li>
						<li class="m_line on"><a href="Controller?command=apt_main">아파트시공사례</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
		<div style="clear:both"></div>
</header>
		<div id = "sidebar">
			<div class = "search">
				<a>
				<div class="search2">
					<% if(address == null) { %>
						<div>주소 또는 아파트 이름을 입력해주세요.</div>
					<% } else { %>
						<div><%=address %></div>
					<% } %>
					<span class="dbg"></span>
				</div>
				</a>
			</div>
			
			<div class = "under"></div>
			<div class = "n_apt"><span>주변아파트</span></div>
			
			<!-- 위치따라 , 지도따라 갯수 늘어남 > 반복 -->
			<% 
				for(AptVo vo : listAptVo) { 
					String strSelected = "";
					
					double dist2 = Math.pow((latitude - vo.getLatitude()) ,2) + Math.pow((longitude - vo.getLongitude()),2);
					if(dist2 < 0.0000002) {  // 내 아파트일 때
						strSelected = "selected";						
					}
			%>
			<a href="Controller?command=apt_detail&apt_idx=<%=vo.getAptIdx()%>"><!-- &apt_idx= -->
				<div class = "apt <%=strSelected %>">
					<div>
						<span class="apt_name1"><%=vo.getName() %></span><br/>
						<span class="apt_name2"><%=vo.getHomeType() %> ・ <%=vo.getNoh() %>세대</span>
						<span class="apt_arrow"></span>
					</div>
				</div>
			</a>
			<!-- 반복 끝 -->
 			<% } %> 
		</div>
		<div id = "map"></div>
</div>	
</body>
</html>