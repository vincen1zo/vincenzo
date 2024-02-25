<%@page import="common.DBConnection"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String dateExpire = "";
%>
<%
	/* long kakaoId = 0;
	String profileNickname = null;
	String profileImage = null;
	if((session.getAttribute("kakao_id")) != null) {
		kakaoId = (Long) session.getAttribute("kakao_id");
		profileNickname = (String) session.getAttribute("profile_nickname");
		profileImage = (String) session.getAttribute("profile_image");
	} */
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원가입 | 라이프스타일 슈퍼앱, 오늘의집</title>
	<link rel="stylesheet" href="css/all.css"/>
	<link rel="stylesheet" href="css/Create_account.css"/>
	<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
	<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
	<script src="js/jquery-3.7.1.min.js"></script>
	<script>
		function draw_time(minute, second) {
			if(minute<0 || second<0) {
				minute = 0;
				second = 0;
			}
			if(second<10) second="0" + second;
			$("#min").text(minute);
			$("#sec").text(second);
		}
		
		let d2 = new Date();

		$(function() {
			$(".jy_email_submit").click(function() {
				
				let member_id = $("#input_member_id").val();
				//let email = $("#input_email").val();
				let blankEmail = $('input[name=email]').val() +"@"+ $('select[class=jy_pick_email] option:selected').text();
				if($('input[name=email]').val().length === 0) {$('input[name=email]').focus(); }
				else if($('input[name=email]').val().length != 0 && member_id.length != 0 ) {
					$('.jy_email_code_tl').css('display','block');
				$.ajax({
					url: 'Controller',
					type: 'post',
					data: {
						command: "ca_form_email_Authentication",
						memberId: member_id,
						email: blankEmail
					},
					
					success: function(data) {
						if(data.result=="OKAY") {
							alert("메일을 발송했습니다.");
							//let dateExpire = data.dateExpire;
							//alert("dateExpire : " + dateExpire);
						} else if(data.result=="FAIL") {
							alert("메일을 발송하지 못했습니다.");
							return;
						}
						let authenticationCode = parseInt(data.authenticationCode);
						alert(authenticationCode);
						
						let year = parseInt(data.year);
						let month = parseInt(data.month);
						let day = parseInt(data.day);
						let hour = parseInt(data.hour);
						let minute = parseInt(data.minute);
						let second = parseInt(data.second);
						let d = new Date();
						d.setYear(year);
						d.setMonth(month-1);
						d.setDate(day);
						d.setHours(hour);
						d.setMinutes(minute);
						d.setSeconds(second);
						
						d2 = new Date();
						let min_left = parseInt((d-d2)/1000/60);
						let sec_left = parseInt((d-d2)/1000%60);	
						draw_time(min_left, sec_left);
						
						let interval = setInterval(function() {
							d2 = new Date();
							let min_left = parseInt((d-d2)/1000 / 60);
							let sec_left = parseInt((d-d2)/1000 % 60);	
							
							draw_time(min_left, sec_left);
							if(min_left<=0 && sec_left<=0) {
								clearInterval(interval);
								if(sec_left == 0) {
							 		$('jy_warning_message_authentication_code_timeout').css('display','block');
							 		$('.disabled').attr('disabled');
							 	}
							}
						}, 1000);
					},
					error: function(request, status,error) {
						alert("에러" + request.status);
					}
				});
				}
			});
			
			$('.jy_reEmail_submit').click(function() {
				let member_id = $("#input_member_id").val();
				//let email = $("#input_email").val();
				let blankEmail = $('input[name=email]').val() +"@"+ $('select[class=jy_pick_email] option:selected').text();
				if($('input[name=email]').val().length === 0) {$('input[name=email]').focus(); }
				else if($('input[name=email]').val().length != 0 && member_id.length != 0 ) {
					$('.jy_email_code_tl').css('display','block');
				$.ajax({
					url: 'Controller',
					type: 'post',
					data: {
						command: "ca_re_form_email_Authentication",
						memberId: member_id,
						email: blankEmail
					},
					
					success: function(data) {
						if(data.result=="OKAY") {
							alert("메일을 발송했습니다.");
							//let dateExpire = data.dateExpire;
							//alert("dateExpire : " + dateExpire);
						} else if(data.result=="FAIL") {
							alert("메일을 발송하지 못했습니다.");
							return;
						}
						let authenticationCode = parseInt(data.authenticationCode);
						alert(authenticationCode);
						
						let year = parseInt(data.year);
						let month = parseInt(data.month);
						let day = parseInt(data.day);
						let hour = parseInt(data.hour);
						let minute = parseInt(data.minute);
						let second = parseInt(data.second);
						let d = new Date();
						d.setYear(year);
						d.setMonth(month-1);
						d.setDate(day);
						d.setHours(hour);
						d.setMinutes(minute);
						d.setSeconds(second);
						
						d2 = new Date();
						let min_left = parseInt((d-d2)/1000/60);
						let sec_left = parseInt((d-d2)/1000%60);	
						draw_time(min_left, sec_left);
						
						let interval = setInterval(function() {
							d2 = new Date();
							let min_left = parseInt((d-d2)/1000 / 60);
							let sec_left = parseInt((d-d2)/1000 % 60);	
							
							draw_time(min_left, sec_left);
							if(min_left<=0 && sec_left<=0) {
								clearInterval(interval);
								if(sec_left == 0) {
							 		$('jy_warning_message_authentication_code_timeout').css('display','block');
							 		$('.disabled').attr('disabled');
							 	}
							}
						}, 1000);
					},
					error: function(request, status,error) {
						alert("에러" + request.status);
					}
				});
				}
			});
		});
		
		<%
			//dateExpire = (String) request.getAttribute("dateExpire");
			//String dateExpire = "2024-02-03 18:48:21";   // from DB
/* 			String year = dateExpire.substring(0,4);  // "2024"
			String month = dateExpire.substring(5,7);  // "02"
			String day = dateExpire.substring(8,10);   // "03"
			String hour = dateExpire.substring(11,13);
			String minute = dateExpire.substring(14,16);
			String second = dateExpire.substring(17);
			System.out.println(year + "/" + month + "/" +day + "  " + hour + ":" + minute + ":" + second);
 */		%>
					
		$(function() {
			/* $('input[type=checkbox]').click(function() {
				if($(this).val==0) {
					$(this).val(1);
				} else {
					$(this).val(0);
				}
			}); */
			//체크박스 모두 체크
			$(".jy_input_check_argee_all").click(function() {
				let ox = $(this).is(":checked");
				/* alert("! ox : " + ox); */
				if(ox) {
					$('input:checkbox').prop('checked', true);
				} else {
					$('input:checkbox').prop('checked', false);
				}
			});
			/* $('input:checkbox[name="agree1"]').click(function() {
				$('input:checkbox[name="agree1"]').prop('checked', 1);
				let ox1 = $(this).is(":checked");
				alert("! ox1 : " + ox1);
			}); */
			//회원가입버튼
			$('.jy_ca_submit_btn').click(function() {
				let agree1 = $("input:checkbox[name='agree1']").is(":checked");
				let agree2 = $("input:checkbox[name='agree2']").is(":checked");
				let agree3 = $("input:checkbox[name='agree3']").is(":checked");
				
				
				if(!agree1 || !agree2 || !agree3) {
					$(".jy_warning_message_view_checkbox").css('display','block');
					alert("약관에 동의해주세요.");
					/* location.href="Controller?command=create_account_form"; */
				} else if(($('.jy_ca_input_size').val().length === 0)) {
					alert("필수 입력 항목을 입력해주세요.");
				}
			});
			//이메일 형식 체크 
			$('.jy_size_check_email' ).focusout(function() {
				let reg = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/i;
				let blankEmail = $('input[name=email]').val() +"@"+ $('select[class=jy_pick_email] option:selected').text();
				if(blankEmail.length === 0) {
					$('.jy_warning_message_view_email').css('display', 'block');
					$(".jy_email_submit").css('color','rgb(194, 200, 204)');
					$(".jy_email_submit").css('border','1px solid rgb(218, 220, 224)');
					$(".jy_email_submit").css(' background','rgb(247, 248, 250)'); 
					$(".jy_email_submit").click(function() {
						$('.jy_size_check_email' ).focus();
					});
				} else if(!reg.test(blankEmail)) {
					$('.jy_warning_message_view_email_wrong').css('display', 'block');
					$(".jy_email_submit").css('color','rgb(194, 200, 204)');
					$(".jy_email_submit").css('border','1px solid rgb(218, 220, 224)');
					$(".jy_email_submit").css(' background','rgb(247, 248, 250)'); 
				} else {
					$('.jy_warning_message_view_email').css('display', 'none');
					$('.jy_warning_message_view_email_wrong').css('display', 'none');
					$(".jy_email_submit").css('color','#35c5f0');
					$(".jy_email_submit").css('border','1px solid #35c5f0');
					$(".jy_email_submit").css('background','white');
				}
			});
			//이메일 select
			$('.jy_pick_email').change(function() {
				//이메일중복체크
				let blankEmail = $('input[name=email]').val() +"@"+ $('select[class=jy_pick_email] option:selected').text();
				let email = $('input[name=email]').val();
				if(email.length === 0) {
					$('.jy_warning_message_view_email_wrong').css('display', 'block');
					return;
				} else {
					$('.jy_warning_message_view_email_wrong').css('display', 'none');
				}
				$.ajax({
					url: 'Controller',
					type: 'post',
					data: { 'blankEmail': blankEmail , "command" : "ajax_email_check"},
					dataType : 'Json',
					success : function(data) {
						if(data.result == "OKAY") {
							$(".jy_warning_message_view_email_same").css('display','none');
							//이메일 인증 버튼 활성화
							$(".jy_email_submit").css('color','#35c5f0');
							$(".jy_email_submit").css('border','1px solid #35c5f0');
							$(".jy_email_submit").css('background','white');
						} else if(data.result == "FAIL") {
							$(".jy_warning_message_view_email_same").css('display','block');
							$(".jy_email_submit").css('color','rgb(194, 200, 204)');
							$(".jy_email_submit").css('border','1px solid rgb(218, 220, 224)');
						}
					},
					error: function(request, status,error) {
						alert("에러" + request.status);
					}
				}); 
			});
			
			//이메일 확인 버튼 클릭 이벤트
			$('.disabled').click(function() {
				$('.jy_warning_message_authentication_code_check').css('display', 'none');
				let authenticationCode = $('input[name=authentication_code]').val();
				let blankEmail = $('input[name=email]').val() +"@"+ $('select[class=jy_pick_email] option:selected').text();
				if(authenticationCode.length !=6) {
					$('.jy_warning_message_authentication_code_check').css('display','block');
				} else {
					$('.jy_warning_message_authentication_code_check').css('display','none');
					$.ajax({
						url: 'Controller',
						type: 'post',
						data: { 'authenticationCode' : authenticationCode ,
								'email' : blankEmail,
								"command" : "ajax_email_authenticationCode"},
						dataType : 'Json',
						success : function(data) {
							if(data.result == "OKAY") {
								$(".jy_email_code_tl").css('display','none');
								$('.jy_checked_authentication_code_correct').css('display','block')
							} else if(data.result == "FAIL") {
								$('.jy_warning_message_authentication_code_check').css('display', 'block');
								$('.jy_checked_authentication_code_correct').css('display','none')
							}
						},
						error: function(request, status,error) {
							alert("에러" + request.status);
						}
					}); 
				}
			});
			
			$('.jy_size_check_pw').focusout(function() {
				let blank1 = $('input[name=pw]').val();
				/* let blank2 = $('input[name=pwCheck]').val(); */
				let regPw = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,25}$/;
				if(blank1.length === 0) {
					$('.jy_warning_message_view_pw').css('display', 'block');
					$('.jy_warning_message_view_pw_form1').css('display', 'none');
				} else if(!regPw.test(blank1)) {
					$('.jy_warning_message_view_pw_form1').css('display', 'block');
					$('.jy_warning_message_view_pw').css('display', 'none');
				} /* else if(blank2.length != blank1.length) {
					$('.jy_warning_message_view_pw_form2').css('display', 'block');
					$('.jy_warning_message_view_pw').css('display', 'none');
				} */ else {
					$('.jy_warning_message_view_pw').css('display', 'none');
					$('.jy_warning_message_view_pw_form1').css('display', 'none');
				}
			});
			$('.jy_size_check_pw_check').focusout(function() {
				let blank1 = $('input[name=pw]').val();
				let blank2 = $('input[name=pwCheck]').val();
				let regPw = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,25}$/;
				if(blank2.length === 0) {
					$('.jy_warning_message_view_pw_check').css('display', 'block');
					$('.jy_warning_message_view_pw_form2').css('display', 'none');
				} else if(!regPw.test(blank2)) {
					$('.jy_warning_message_view_pw_form2').css('display', 'block');
					$('.jy_warning_message_view_pw').css('display', 'none');
				} else if(blank2.length != blank1.length) {
					$('.jy_warning_message_view_pw_form2').css('display', 'block');
					$('.jy_warning_message_view_pw').css('display', 'none');
				} else {
					$('.jy_warning_message_view_pw_check').css('display', 'none');
					$('.jy_warning_message_view_pw_form2').css('display', 'none');
				}
			});
			$('.jy_size_check_id').focusout(function() {
				let blank = $('input[name=memberId]').val();
				if(blank.length === 0) {
					$('.jy_warning_message_view_member_id').css('display', 'block');
					$(".jy_warning_message_view_member_id_same").css('display','none');
				} else if(!(blank.length === 0)) {
					$('.jy_warning_message_view_member_id').css('display', 'none');
					//닉네임중복체크
					$.ajax({
						url: 'Controller',
						type: 'post',
						data: { 'blank': blank , "command" : "ajax_member_id_check"},
						dataType : 'Json',
						success : function(data) {
							if(data.result == "OKAY") {
								$(".jy_warning_message_view_member_id_same").css('display','none');
							} else if(data.result == "FAIL") {
								$(".jy_warning_message_view_member_id_same").css('display','block');
							}
						},
						error: function(request, status,error) {
							alert("에러" + request.status);
						}
					}); 
				}
			});
			
			$('input:checkbox').click(function() {
				let agree1 = $("input:checkbox[name='agree1']").is(":checked");
				let agree2 = $("input:checkbox[name='agree2']").is(":checked");
				let agree3 = $("input:checkbox[name='agree3']").is(":checked");
				if(agree1 && agree2 && agree3) {
					$(".jy_warning_message_view_checkbox").css('display','none');
				}
			});
		});  // The end of the $(function)
		
		/*                      */
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
			
			
			<%--
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
			})--%>
		}
	
		$(function() {
			Kakao.init('9d32a123c60cb04c639e136c42ebac2b'); //발급받은 키 중 javascript키를 사용해준다.
			console.log(Kakao.isInitialized()); // true: sdk초기화여부판단
			
			$("#btn_kakao").click(function() {
				kakaoLogin();
			});
		});
		
		
	</script>
</head>
<body>
	<div class="jy_page_all_ca">
		<section class="jy_ca_tl">
			<a href="#">
				<img class="jy_logo_small1" src="images/today_house_logo.png"/>
				<img class="jy_logo_small2" src="images/logo.png"/>
			</a>
			<div class="jy_ca_content">
				<h1>회원가입</h1>
				<div class="jy_sns_ca_tl">
					<div class="jy_sns_ca_text">SNS계정으로 간편하게 회원가입</div>
					<ul class="jy_sns_link">
						<li><!-- <a href="/users/auth/kakao" title="카카오톡으로 가입하기" class="css-4zleql e111gxds0" -->
							<a id="btn_kakao" class="sns" href="#"><svg width="48" height="48" viewBox="0 0 48 48" preserveAspectRatio="xMidYMid meet"><g fill="none" fill-rule="evenodd"><path fill="#FFEB00" d="M0 24C0 10.745 10.745 0 24 0s24 10.745 24 24-10.745 24-24 24S0 37.255 0 24z"></path><path fill="#3C2929" d="M24 11.277c8.284 0 15 5.306 15 11.85 0 6.545-6.716 11.85-15 11.85-.92 0-1.822-.066-2.697-.191l-6.081 4.105a.43.43 0 0 1-.674-.476l1.414-5.282C11.777 31.031 9 27.335 9 23.127c0-6.544 6.716-11.85 15-11.85zm6.22 8.407c-.416 0-.718.297-.718.707v5.939c0 .41.289.686.718.686.41 0 .718-.295.718-.686v-1.932l.515-.526 1.885 2.57c.277.374.426.54.691.568.037.003.075.005.112.005.154 0 .66-.04.716-.563.038-.293-.137-.52-.348-.796l-2.043-2.675 1.727-1.743.176-.196c.234-.26.353-.39.353-.587.009-.422-.34-.652-.687-.661-.274 0-.457.15-.57.262l-2.528 2.634v-2.3c0-.422-.288-.706-.717-.706zm-9.364 0c-.56 0-.918.432-1.067.837l-2.083 5.517a.84.84 0 0 0-.065.315c0 .372.31.663.706.663.359 0 .578-.162.69-.51l.321-.97h2.999l.313.982c.111.335.34.498.7.498.367 0 .655-.273.655-.62 0-.056-.017-.196-.081-.369l-2.019-5.508c-.187-.53-.577-.835-1.069-.835zm-2.92.064h-4.452c-.417 0-.642.337-.642.654 0 .3.168.652.642.652h1.51v5.21c0 .464.274.752.716.752.443 0 .718-.288.718-.751v-5.21h1.508c.474 0 .643-.352.643-.653 0-.317-.225-.654-.643-.654zm7.554-.064c-.442 0-.717.287-.717.75v5.707c0 .497.28.794.75.794h2.674c.434 0 .677-.321.686-.627a.642.642 0 0 0-.17-.479c-.122-.13-.3-.2-.516-.2h-1.99v-5.195c0-.463-.274-.75-.717-.75zm-4.628 1.306l.008.01 1.083 3.265h-2.192L20.842 21a.015.015 0 0 1 .028 0z"></path></g></svg></a>
						</li>
						<li>
							<a href="/users/auth/naver" title="네이버로 가입하기" class="css-4zleql e111gxds0"><svg width="48" height="48" viewBox="0 0 48 48" preserveAspectRatio="xMidYMid meet"><g fill="none" fill-rule="evenodd"><path fill="#00C63B" d="M0 24C0 10.745 10.745 0 24 0s24 10.745 24 24-10.745 24-24 24S0 37.255 0 24z"></path><path fill="#FFF" d="M21 25.231V34h-7V15h7l6 8.769V15h7v19h-7l-6-8.769z"></path></g></svg></a>
						</li>
					</ul>
				</div>
				<form id="jy_form" action="Controller?command=create_account" method="post">
					<%-- <%if((session.getAttribute("kakao_id")) != null ) { %>
					<input type="hidden" name="kakao_id" value="<%=kakaoId%>"/>
					<input type="hidden" name="profile_image" value="<%=profileImage%>"/>
					<%} %> --%>
					<div class="jy_all_input_tl">
						<label class="jy_top_input_title">닉네임</label>
						<div class="jy_input_infomation_text">다른 유저와 겹치지 않도록 입력해주세요 (2~15자)</div>
						<label>
							<%-- <% if(profileNickname==null) { %> --%>
								<input class="jy_ca_input_size jy_size_check_id" type="text" id="input_member_id" name="memberId" placeholder="별명 (2~15자)" maxlength="15">
							<%-- <% } else { %> --%>
								<%-- <input class="jy_ca_input_size jy_size_check_id" type="text" id="input_member_id" name="memberId" placeholder="별명 (2~15자)" value="<%=profileNickname%>" readonly> --%>
							<%-- <% } %> --%>
							
						</label>
						<div class="jy_warning jy_warning_message_view_member_id ">필수 입력 항목입니다.</div>
						<div class="jy_warning jy_warning_message_view_member_id_same ">사용중인 별명입니다.</div>
					</div>
					<div class="jy_input_tl_tl">
						<label class="jy_top_input_title">이메일</label>
						<label class="jy_email_input_out_tl">
							<input class="jy_email_input_tl jy_size_check_email" type="text" id="input_email" name="email" placeholder="이메일">
							<span class="jy_gol">@</span>
							<select class="jy_pick_email">
								<option selected disabled>선택해주세요.</option>
								<option value="naver.com">naver.com</option>
								<option value="hanmail.net">hanmail.net</option>
								<option value="daum.net">daum.net</option>
								<option value="gmail.com">gmail.com</option>
								<option value="nate.com">nate.com</option>
								<option value="hotmail.com">hotmail.com</option>
								<option value="outlook.com">outlook.com</option>
								<option value="icloud.com">icloud.com</option>
								<option value="">직접입력</option>
							</select>
						</label>
						<div class="jy_warning jy_warning_message_view_email">필수 입력 항목입니다.</div>
						<div class="jy_warning jy_warning_message_view_email_same">이미 가입한 이메일입니다. '이메일 로그인'으로 로그인해주세요.</div>
						<div class="jy_warning jy_warning_message_view_email_wrong">이메일형식이 올바르지 않습니다.</div>
					</div>
					<div class="jy_email_submit_tl">
						<button class="jy_email_submit" type="button" name="email_submit_button">이메일 인증하기</button>
						<div class="jy_fine jy_checked_authentication_code_correct">이메일이 인증되었습니다.</div>
					</div>
					<div class="jy_email_code_tl">
						<div class="jy_email_code6">
							<div class="jy_email_comment">이메일로 전송된 인증코드를 입력해주세요.</div>
							<div class="jy_email_code6_input_tl">
								<div class="jy_email_code6_input">
									<input type="text" name="authentication_code" placeholder="인증코드 6자리 입력" maxlength="6">
									<span id="min">00</span>:<span id="sec"	>00</span>
									<button class="disabled" type="button">확인</button>
								</div>
							</div>
							<div class="jy_recall_email">
								이메일을 받지 못하셨나요?<a class="jy_reEmail_submit">이메일 재전송하기</a>
							</div>
							<div class="jy_warning jy_warning_message_authentication_code_check">인증번호가 틀렸습니다.</div>
							<div class="jy_warning jy_warning_message_authentication_code_timeout">인증시간이 만료되었습니다.</div>
						</div>
					</div>	
					<div class="jy_all_input_tl">
						<label class="jy_top_input_title">비밀번호</label>
						<div class="jy_input_infomation_text">영문, 숫자를 포함한 8자 이상의 비밀번호를 입력해주세요.</div>
						<label>
							<input class="jy_ca_input_size jy_size_check_pw" type="password" id="input_pw" name="pw" placeholder="비밀번호">
						</label>
						<div class="jy_warning jy_warning_message_view_pw">필수 입력 항목입니다.</div>
						<div class="jy_warning jy_warning_message_view_pw_form1">비밀번호는 영문, 숫자를 포함하여 8자 이상이어야합니다.</div>
					</div>
					<div class="jy_all_input_tl">
						<label class="jy_top_input_title">비밀번호 확인</label>
						<label>
							<input class="jy_ca_input_size jy_size_check_pw_check" type="password" id="input_pw_check" name="pwCheck" placeholder="비밀번호 확인">
						</label>
						<div class="jy_warning jy_warning_message_view_pw_check">확인을 위해 비밀번호를 한 번 더 입력해주세요.</div>
						<div class="jy_warning jy_warning_message_view_pw_form2">비밀번호가 일치하지 않습니다.</div>
					</div>
					<div class="jy_all_input_tl">
						<label class="jy_top_input_title">약관동의</label>
						<!-- 약관동의 바깥틀 -->
						<div class="jy_checkbox_tl">
							<div class="jy_div_agree_all_tl">
								<label class="jy_label_agree_all_tl">
										<input type="checkbox" value="false" name="agree_all" class="jy_input_check_argee_all">	
									<span class="jy_agree_font_style1">전체 동의<span class="jy_agree_font_style2">선택항목에 대한 동의 포함</span></span>
								</label>
							</div>
							<hr class="jy_line">
							<div class="jy_div_agree_list_tl">
								<label class="jy_label_agree_tl">
									<input type="checkbox" value="1" name="agree1" class="jy_agree_li">
									<span class="jy_agree_font_style3 jy_essential">만 14세 이상입니다.</span>
								</label>
							</div>
							<div class="jy_div_agree_list_tl jy_topmargin">
								<label class="jy_label_agree_tl">
									<input type="checkbox" value="1" name="agree2" class="jy_agree_li">
									<span class="jy_agree_font_style3 jy_essential">이용약관</span>
								</label>
							</div>
							<div class="jy_div_agree_list_tl jy_topmargin">
								<label class="jy_label_agree_tl">
									<input type="checkbox" value="1" name="agree3" class="jy_agree_li">
									<span class="jy_agree_font_style3 jy_essential">개인정보수집 및 이용동의</span>
								</label>
							</div>
							<div class="jy_div_agree_list_tl jy_topmargin">
								<label class="jy_label_agree_tl">
									<input type="checkbox" value="1" name="agree4" class="jy_agree_li">
									<span class="jy_agree_font_style3 jy_notessential">개인정보 마케딩 활용 동의</span>
								</label>
							</div>
							<div class="jy_div_agree_list_tl jy_topmargin">
								<label class="jy_label_agree_tl">
									<input type="checkbox" value="1" name="agree5" class="jy_agree_li">
									<span class="jy_agree_font_style3 jy_notessential">이벤트, 쿠폰, 특가 알림 메일 및 SMS 등 수신</span>
								</label>
							</div>
						</div>
						<div class="jy_warning jy_warning_message_view_checkbox">필수 항목에 동의해주세요.</div>
					</div>
					<div class="jy_reCAPCHA">
						<!-- reCAPCHA 들어갈 곳 -->
						<img src="images/리캡차.PNG">
					</div>
					<button type="submit" class="jy_ca_submit_btn jy_new_btn_style">회원가입하기</button>
					<p class="jy_already_ca">이미 아이디가 있으신가요?<a href="Controller?command=login_form">로그인</a></p>
				</form>
			</div>
		</section>
	</div>
</body>
</html>