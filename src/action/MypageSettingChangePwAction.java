package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDao;

public class MypageSettingChangePwAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberDao mDao = new MemberDao();
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("loginEmail");
		String memberId = mDao.getMemberId(email);
		String pw = request.getParameter("newPw1");
		mDao.updatePw(memberId, pw);
		
		request.getRequestDispatcher("MypageSettingChangePwResult.jsp").forward(request, response);
	}
	
}
