package action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import dao.MemberDao;
import vo.MemberVo;

public class AjaxKakaoIdCheckAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		long kakaoId = Long.parseLong(request.getParameter("kakao_id"));
		String profileNickname = request.getParameter("profile_nickname");
		String profileImage = request.getParameter("profile_image");
		String accountEmail = request.getParameter("account_email");
		System.out.println("kakao_id : " + kakaoId);
		System.out.println("account_email : " + accountEmail);
		
		MemberDao mDao = new MemberDao();
		MemberVo mVo = mDao.getMemberVoFromKakaoId(kakaoId, accountEmail);
		
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();
		if(mVo!=null) {
			session.setAttribute("loginEmail", mVo.getEmail());
			obj.put("result", "OKAY");
		} else {
			session.setAttribute("kakao_id", kakaoId);
			session.setAttribute("profile_nickname", profileNickname);
			session.setAttribute("profile_image", profileImage);
			session.setAttribute("account_email", accountEmail);
			obj.put("result", "FAIL");
		}
		out.println(obj);
	}
	
}
