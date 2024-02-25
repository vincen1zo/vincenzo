package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDao;
import vo.MemberEditVo;
import vo.MemberVo;

public class MypageSettingEditUserInfoFormAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("loginEmail");
		MemberDao mDao = new MemberDao();
		String memberId = mDao.getMemberId(email);
		System.out.println("memberId : " + memberId);
		MemberEditVo mVo = mDao.getMapageMemberInfo(memberId);
		
		request.setAttribute("mVo", mVo);
		request.getRequestDispatcher("Mypage_setting_edit_user_info.jsp").forward(request, response);
	}
	
}
