package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDao;

public class MypageSettingEditUserInfoAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String memberId = request.getParameter("member_id");
		System.out.println("memberId : " + memberId + "email" + email);
		String homepage = request.getParameter("homepage");
		int gender = Integer.parseInt(request.getParameter("gender"));
		String birthday = request.getParameter("birthday");
		String profileImg = request.getParameter("profile_img");
		String oneLiner = request.getParameter("one_liner");
		
		MemberDao mDao = new MemberDao();
		mDao.updateMemberInfo(email, memberId, homepage, gender, birthday, profileImg, oneLiner);
		
		request.setAttribute("msg", "회원정보 수정이 완료되었습니다.");
		request.getRequestDispatcher("Controller?command=community_main").forward(request, response);
	}

}
