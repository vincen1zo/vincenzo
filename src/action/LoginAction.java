package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDao;

public class LoginAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		String email = request.getParameter("email");
		String pw = request.getParameter("pw");

		MemberDao memberDao = new MemberDao();
		
		boolean result = memberDao.loginCheck(email, pw);
		String memberId = memberDao.getMemberId(email);
		
		
		session.setAttribute("loginEmail", email);
		request.setAttribute("result", result);
		request.getRequestDispatcher("LoginResult.jsp").forward(request, response);
	}

}
