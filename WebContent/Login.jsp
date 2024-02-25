<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String msg = (String) request.getAttribute("msg");
	int ozipIdx = 0;
	if(request.getParameter("ozip_idx") != null) {
		ozipIdx = Integer.parseInt(request.getParameter("ozip_idx"));
	}	
	String conName = "";
	if(request.getParameter("conName") != null) {
	      conName = request.getParameter("conName");
	   }
	
	if(msg!=null) {
%>    
		<script>alert("<%=msg%>");</script>
<% 	} %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인 | 라이프스타일 슈퍼앱, 남의집</title>
	<link rel="stylesheet" href="css/Login.css">
	<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
	<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
	<script src="js/jquery-3.7.1.min.js"></script>
	<script>
		function kakaoLogin() {
			Kakao.Auth.login({
				success: function(authObj) {
					//alert(JSON.stringify(authObj));
					console.log(authObj);
					Kakao.Auth.setAccessToken(authObj.access_token); // access토큰값 저장
					Kakao.API.request({
						url: '/v2/user/me',
						success: function (res) {
						    console.log(res);
							//console.log(profile_nickname);
							//console.log(profile_image);
						    //console.log(email, gender, profile_nickname, profile_image, birthday);
						    
						    let id = res.id;
						    let profile_nickname = res.kakao_account.profile.nickname;
						    let profile_image = res.kakao_account.profile.thumbnail_image_url;
						    let account_email = res.kakao_account.email;
							$.ajax({
								type : 'post',
								url : 'Controller',
								data : {"command":"ajax_kakao_id_check", 
										"kakao_id" : Number(id),
										"profile_nickname" : profile_nickname,
										"profile_image" : profile_image,
										"account_email" : account_email
								},
								success: function(data) {
									if(data.result=="OKAY") {
										alert("로그인 되었습니다. " + profile_nickname + "님 안녕하세요!");

										location.href = "Controller?command=login_kakao_result";
									} else if(data.result=="FAIL") {
										alert("회원가입 페이지로 이동합니다.");
										location.href = "Controller?command=create_account_sns_form";
									}
								}
							});
						    
						    
						},
						fail: function (error) {
						    alert('카카오 로그인에 실패했습니다. 관리자에게 문의하세요.' + JSON.stringify(error));
						}
					});
				},
				fail: function(err) {
					alert(JSON.stringify(err));
				}
			});
			return;
			
			
			
			
			
			Kakao.Auth.login({
		      success: function (response) {
		        Kakao.API.request({
		          url: '/v2/user/me',
		          success: function (response) {
		        	  console.log(response);
		        	  const id = response.id;   // ex. 3320786347
		        	  //const nickname = response.properties.nickname;
		        	  //const email = response.kakao_account.email;
		        	  $.ajax({
		        		  type : 'post',
		        		  url : '/user/kakaoLogin',
		        		  data : {"id" : id},   //, "nickname" : nickname, "email" : email},
		        		  dataType : 'text',
		        		  success: function(result){
		        			  console.log(result);
		        			  if(result=="ok"){
/*
									var newNickname = prompt('사용하실 닉네임을 입력해주세요');
		        				  if(newNickname != null){
		        					  $.ajax({
		        						  type : 'post',
		        						  url : 'kakaoSignUp',
		        						  data : {"id" : id, "nickname" : newNickname, "email": email}
		        					  });
		        					  alert(newNickname + "님 환영합니다.");
		        					  location.href = "/video/list";
		        				  }
		        				  else{
		        					  location.href = "/user/signin";
		        				  }
*/
		        			  }
/*
		        			  else{
		        				  $.ajax({
		        					  url : '/user/kakaoLogins',
		        					  data : {"id" : id},
		        					  dataType : 'text',
		        					  type : 'post',
		        					  success : function(data){
		        						  console.log(data);
		                				  alert(data + "님 반갑습니다.")
		                				  location.href = "/video/list";
		        					  }
		        				  })
	
		        			  }
*/		        			  
		        		  }
		        		  
		        	  });   // the end of $.ajax()
		          },
		          fail: function (error) {
		            console.log(error)
		          }
		        })
		      },
		      fail: function (error) {
		        console.log(error)
		      }
			})
		}
	
		$(function() {
			Kakao.init('9d32a123c60cb04c639e136c42ebac2b'); //발급받은 키 중 javascript키를 사용해준다.
			console.log(Kakao.isInitialized()); // true: sdk초기화여부판단
			
			$("#btn_kakao").click(function() {
				kakaoLogin();
			});
			
			$(".naver").click(function(){
				alert("기능 작업중입니다");
			});
			
		});
		
		
	</script>
</head>
<body>
	<div class="page_all">
		<main class="main_tl">
			<div class="login_tl">
				<div class="login_area">
					<a href="Controller?command=interior_main">
						<img class="logo" src="images/today_house_logo.png"/>
						<img class="logo" src="images/logo.png"/>						
					</a>
					<form action="Controller" method="post" class="input_area"><%-- 파라미터를 가져다가 재조립하는게 form태그--%>
						<input type="hidden" name="command" value="login_action"/>
						<input type="hidden" name="ret_cmd" value="<%=request.getParameter("ret_cmd") %>"/>
						<%if(ozipIdx!=0) { %>
						<input type="hidden" name="ozip_idx" value="<%=ozipIdx %>"/>
						<%}%>
						<%if(conName!=null) { %>
                  		<input type="hidden" name="conName" value="<%=conName %>"/>
                  		<%}%>
						<div class="change_color">
							<input type="text" name="email" class="login_email" placeholder="이메일"/>
						</div>
						<div class="change_color">
							<input type="password" name="pw" class="login_password" placeholder="비밀번호"/>
						</div>
						<button class="input_submit">로그인</button>
						<section class="re">
							<a href="Mypage_setting_change_pw.jsp" class="re_pw">비밀번호 재설정</a>
							<a href="Controller?command=create_account_form" class="will_be_member">회원가입</a>
						</section>
					</form>
<!--				<input type="hidden" name="user[email]" value="">
					<input type="hidden" name="user[password]" value="">
 -->					
 					<section>
						<div class="sns_login_button">SNS계정으로 간편 로그인/회원가입</div>
						<!-- <a datatpye="kakao" class="sns"  href="https://accounts.kakao.com/login/?continue=https%3A%2F%2Fkauth.kakao.com%2Foauth%2Fauthorize%3Fproxy%3DeasyXDM_Kakao_ftvt2rd1m8g_provider%26ka%3Dsdk%252F1.43.1%2520os%252Fjavascript%2520sdk_type%252Fjavascript%2520lang%252Fko-KR%2520device%252FWin32%2520origin%252Fhttps%25253A%25252F%25252Fohou.se%26origin%3Dhttps%253A%252F%252Fohou.se%26response_type%3Dcode%26redirect_uri%3Dkakaojs%26state%3D44f6q4wgzli4ycybjakcgh%26through_account%3Dtrue%26client_id%3D3019c756ec77dd7e0a24e56d9d784f77&talk_login=hidden#login" target="_blank"> -->
						<a id="btn_kakao" class="sns" href="#">
							<svg width="48" height="48" viewBox="0 0 48 48" preserveAspectRatio="xMidYMid meet"><g fill="none" fill-rule="evenodd"><path fill="#FFEB00" d="M0 24C0 10.745 10.745 0 24 0s24 10.745 24 24-10.745 24-24 24S0 37.255 0 24z"></path><path fill="#3C2929" d="M24 11.277c8.284 0 15 5.306 15 11.85 0 6.545-6.716 11.85-15 11.85-.92 0-1.822-.066-2.697-.191l-6.081 4.105a.43.43 0 0 1-.674-.476l1.414-5.282C11.777 31.031 9 27.335 9 23.127c0-6.544 6.716-11.85 15-11.85zm6.22 8.407c-.416 0-.718.297-.718.707v5.939c0 .41.289.686.718.686.41 0 .718-.295.718-.686v-1.932l.515-.526 1.885 2.57c.277.374.426.54.691.568.037.003.075.005.112.005.154 0 .66-.04.716-.563.038-.293-.137-.52-.348-.796l-2.043-2.675 1.727-1.743.176-.196c.234-.26.353-.39.353-.587.009-.422-.34-.652-.687-.661-.274 0-.457.15-.57.262l-2.528 2.634v-2.3c0-.422-.288-.706-.717-.706zm-9.364 0c-.56 0-.918.432-1.067.837l-2.083 5.517a.84.84 0 0 0-.065.315c0 .372.31.663.706.663.359 0 .578-.162.69-.51l.321-.97h2.999l.313.982c.111.335.34.498.7.498.367 0 .655-.273.655-.62 0-.056-.017-.196-.081-.369l-2.019-5.508c-.187-.53-.577-.835-1.069-.835zm-2.92.064h-4.452c-.417 0-.642.337-.642.654 0 .3.168.652.642.652h1.51v5.21c0 .464.274.752.716.752.443 0 .718-.288.718-.751v-5.21h1.508c.474 0 .643-.352.643-.653 0-.317-.225-.654-.643-.654zm7.554-.064c-.442 0-.717.287-.717.75v5.707c0 .497.28.794.75.794h2.674c.434 0 .677-.321.686-.627a.642.642 0 0 0-.17-.479c-.122-.13-.3-.2-.516-.2h-1.99v-5.195c0-.463-.274-.75-.717-.75zm-4.628 1.306l.008.01 1.083 3.265h-2.192L20.842 21a.015.015 0 0 1 .028 0z"></path></g></svg>
						</a>
						<a datatype="naver" class="sns  naver"  target="_blank">
						<!-- href="https://nid.naver.com/oauth2.0/authorize?client_id=OwxOJX0gYfOostweRfGd&redirect_uri=https%3A%2F%2Fohou.se%2Fusers%2Fauth%2Fnaver%2Fcallback&response_type=code&state=a00e842733d565e7b0df6094f7c6b37c6b10b506357ce617&svctype=0" -->
							<svg width="48" height="48" viewBox="0 0 48 48" preserveAspectRatio="xMidYMid meet"><g fill="none" fill-rule="evenodd"><path fill="#00C63B" d="M0 24C0 10.745 10.745 0 24 0s24 10.745 24 24-10.745 24-24 24S0 37.255 0 24z"></path><path fill="#FFF" d="M21 25.231V34h-7V15h7l6 8.769V15h7v19h-7l-6-8.769z"></path></g></svg>
						</a>
					</section>
					<a herf="#" class="login_problem">로그인에 문제가 있으신가요?</a>
					<section class="advice">
						<a href="https://contents.ohou.se/projects?writer=self" class="bb" target="_blank">남의집들이 같이 갈래?</a><br/><br/>
						<span class="ja_span1">원활한 사이트 이용을 위해<br/>아래 테스트 아이디와 비밀번호를 입력해주세요</span><br/><br/>
						<span class="ja_span2">테스트 아이디 : <span>또랑이</span><br>테스트 비밀번호 : <span class="ja_num">1234</span></span>
					</section>
				</div>
			</div>
			<footer>
					© bucketplace, Co., Ltd. . All Rights Reserved
			</footer>
		</main>
	</div>
</body>
</html>