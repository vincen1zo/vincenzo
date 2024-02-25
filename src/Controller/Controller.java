package Controller;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import action.*;

@WebServlet("/Controller")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String command = request.getParameter("command");
		Action action = null;
		switch(command) {
		//김종윤
		case "create_account_form" : action = new CreateAccountFormAction();  break;
		case "ca_form_email_Authentication" : action = new AjaxCaFormEmailAuthenticationAction(); break;
		case "create_account" : action = new CreateAccountAction(); break;	
		case "ajax_email_authenticationCode" : action = new AjaxEmailAuthenticationCodeAction(); break;
		case "ca_re_form_email_Authentication" : action = new AjaxCaReFormEmailAuthenticationAction(); break;
		case "login_form" : action = new LoginFormAction(); break;		
		case "login_action" : action = new LoginAction(); break;
		case "ajax_kakao_id_check" : action = new AjaxKakaoIdCheckAction(); break;
		case "ajax_member_id_check" : action = new AjaxMemberIdCheckAction(); break;
		case "ajax_email_check" : action = new AjaxEmailCheckAction(); break;
		case "create_account_sns_form" : action = new CreateAccountSnsFormAction(); break;
		case "create_account_sns" : action = new CreateAccountSnsAction(); break;
		case "login_kakao_result" : action = new LoginKakaoResultAction(); break;
		case "logout" : action = new LogoutAction(); break;
		case "QA" : action = new QAAction(); break;			
		case "Notice_main" : action = new NoticeMainAction(); break;
		case "Notice_detail" : action = new NoticeDetailAction(); break;
		case "Ozip_main" : action = new OzipMainAction(); break;
		case "Ozip_detail" : action = new OzipDetailAction(); break;
		case "Ozip_write_form" : action = new OzipWriteFormAction(); break;
		case "Ozip_write" : action = new OzipWriteAction(); break;
		case "Ozip_write_upload" : action = new OzipWriteUploadAction(); break;
		case "Ozip_modify_form" : action = new OzipModifyFormAction(); break;
		case "Ozip_modify" : action = new OzipModifyAction(); break;
		case "Ozip_delete" : action = new OzipDeleteAction(); break;
		case "ajax_ozip_reply_write" : action = new AjaxOzipReplyWriteAction(); break;
		case "ajax_ozip_reply_delete" : action = new AjaxOzipReplyDeleteAction(); break; 
		case "Mypage_setting_change_pw_form": action = new MypageSettingChangePwFormAction(); break;
		case "Mypage_setting_change_pw" : action = new MypageSettingChangePwAction(); break;
		case "Mypage_setting_edit_user_info_form" : action = new MypageSettingEditUserInfoFormAction(); break;
		case "Mypage_setting_edit_user_info" : action = new MypageSettingEditUserInfoAction(); break;
		case "Mypage_shopping_list_form" : action = new MypageShoppingFormAction(); break;
		case "ajax_mypage_inquiry_delete" : action= new AjaxMypageInquiryDeleteAction(); break;
		case "Mypage_profile_with_ozip" : action = new MypageProfileWithOzipAction(); break;
		
		//권민희
		case "community_main": action = new CommunityMainAction(); break;   
		case "shopping_main": action = new ShoppingMainAction(); break;
		case "product_detail": action = new ProductDetailAction(); break;
		case "houseparty": action = new HousepartyAction(); break;
		case "houseparty_detail": action = new HousepartyDetailAction(); break;
		case "o_deal": action = new ODealAction(); break;
//		case "user_search": action = new UserSearchAction(); break; // 작업중. 
		case "ajax_houseparty_likey": action = new AjaxHousepartyLikey(); break;
		case "ajax_houseparty_follow": action = new AjaxHousepartyFollowAction(); break; 
		case "houseparty_comment_write": action = new HousepartyCommentWriteAction(); break;
		case "houseparty_comment_delete": action = new HousepartyCommentDeleteAction(); break;
		case "houseparty_comment_modify": action = new HousepartyCommentModifyAction(); break;
		case "likey_book" : action = new LikeyAction(); break;
		
		//김진아
//		인테리어
		case "interior_main": action = new InteriorMainAction(); break;
		case "interior_detail": action = new InteriorDetailAction(); break;
		case "interior_review_form" : action = new InteriorReviewFormAction(); break; 
		case "interior_review_action": action = new InteriorReviewAction(); break;
		case "ajax_review_like": action = new AjaxReviewLikeAction(); break;
//		아파트
		case "apt_main" : action = new AptMainAction(); break;
		case "apt_detail" : action = new AptDetailAction(); break;
		case "apt_review_detail" : action = new AptReviewDetailAction(); break;
//	    헤더
		case "basket" : action = new BascketAction(); break;
		case "new" : action = new NewAction(); break;
//		마이페이지 리뷰
		case "mypage_review_form" : action = new MypageReviewFormAction(); break;
		case "mypage_review" : action = new MypageReviewAction(); break;
		case "mypage_review_delete" : action = new MypageReviewDeleteAction(); break;    
		case "mypage_review_modify_form" : action = new MypageReviewModifyFormAction(); break;
		case "mypage_review_modify_action" : action = new MypageReviewModifyAction(); break;
		}
		action.execute(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
